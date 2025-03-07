import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chatcore/chat-core.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:nostr_mls_package/nostr_mls_package.dart';

String toHexString(List<int> bytes) {
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
}

class MlsGroup {
  final List<int> groupId;
  final List<String> groupMembers;
  final List<int> serializedWelcomeMessage;
  final NostrGroupData nostrGroupData;

  MlsGroup({
    required this.groupId,
    required this.groupMembers,
    required this.serializedWelcomeMessage,
    required this.nostrGroupData,
  });

  static MlsGroup fromJson(Map<String, dynamic> json) {
    if (json['group_id'] == null) {
      throw Exception("error: group_id does not exit, ${jsonEncode(json)}");
    }

    List<dynamic> groupIdVec = json['group_id']['value']['vec'];
    List<int> groupId = groupIdVec.map((e) => e as int).toList();

    List<String> members = [];
    if (json['members'] != null) {
      members = List<String>.from(json['members']);
    }

    List<int> serializedWelcomeMessage = List<int>.from(json['serialized_welcome_message']);

    NostrGroupData nostrGroupData = NostrGroupData.fromJson(json['nostr_group_data']);

    return MlsGroup(
      groupId: groupId,
      groupMembers: members,
      serializedWelcomeMessage: serializedWelcomeMessage,
      nostrGroupData: nostrGroupData,
    );
  }
}

class NostrGroupData {
  final String nostrGroupId;
  final String name;
  final String description;
  final List<String> adminPubkeys;
  final List<String> relays;

  NostrGroupData({
    required this.nostrGroupId,
    required this.name,
    required this.description,
    required this.adminPubkeys,
    required this.relays,
  });

  static NostrGroupData? fromPreviewWelcome(String previewWelcomeData) {
    NostrGroupData nostrGroupData =
        NostrGroupData.fromJson(jsonDecode(previewWelcomeData)['nostr_group_data']);
    return nostrGroupData;
  }

  static NostrGroupData fromJson(Map<String, dynamic> json) {
    List<int> nostrGroupIdInts = List<int>.from(json['nostr_group_id']);
    String nostrGroupId = toHexString(nostrGroupIdInts);

    List<int> nameInts = List<int>.from(json['name']);
    String name = utf8.decode(nameInts);

    List<int> descriptionInts = List<int>.from(json['description']);
    String description = utf8.decode(descriptionInts);

    List<String> adminPubkeys =
        (json['admin_pubkeys'] as List).map((item) => utf8.decode(List<int>.from(item))).toList();

    List<String> relays =
        (json['relays'] as List).map((item) => utf8.decode(List<int>.from(item))).toList();

    return NostrGroupData(
      nostrGroupId: nostrGroupId,
      name: name,
      description: description,
      adminPubkeys: adminPubkeys,
      relays: relays,
    );
  }
}

extension MLSPrivateGroups on Groups {
  Future<void> initMLS() async {
    bool isIOS = Platform.isIOS || Platform.isMacOS;
    Directory directory =
        isIOS ? await getLibraryDirectory() : await getApplicationDocumentsDirectory();
    await initNostrMls(path: directory.path, identity: pubkey);
    _initKeypackages();
    Connect.sharedInstance.addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        updateMLSGroupSubscription(relay: relay);
      }
    });
    updateMLSGroupSubscription();
  }

  void updateMLSGroupSubscription({String? relay}) {
    if (groupMessageSubscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(groupMessageSubscription, relay: relay);
    }

    Map<String, List<Filter>> subscriptions = {};
    List<String> groupList = [];
    List<String> groupRelays = [];
    for (var g in myGroups.values) {
      groupList.add(g.value.groupId);
      if (g.value.relay != null && !groupRelays.contains(g.value.relay)) {
        groupRelays.add(g.value.relay!);
      }
    }
    if (groupList.isEmpty) return;
    if (relay == null) {
      for (String relayURL in groupRelays) {
        int groupMessageUntil = Relays.sharedInstance.getMLSGroupMessageUntil(relayURL);
        Filter f = Filter(h: groupList, kinds: [445], since: (groupMessageUntil + 1));
        subscriptions[relayURL] = [f];
      }
    } else {
      int groupMessageUntil = Relays.sharedInstance.getMLSGroupMessageUntil(relay);
      Filter f = Filter(h: groupList, kinds: [445], since: (groupMessageUntil + 1));
      subscriptions[relay] = [f];
    }

    groupMessageSubscription = Connect.sharedInstance.addSubscriptions(subscriptions,
        closeSubscription: false, eventCallBack: (event, relay) async {
      _updateGroupMessageTime(event.createdAt, relay);
      receiveMLSGroupMessage(event, relay);
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      offlineGroupMessageFinish[relay] = true;
      if (ok.status) {
        _updateGroupMessageTime(currentUnixTimestampSeconds() - 1, relay);
      }
      if (unCompletedRelays.isEmpty) {
        offlineGroupMessageFinishCallBack?.call();
        if (!Messages.sharedInstance.groupMessageCompleter.isCompleted) {
          Messages.sharedInstance.groupMessageCompleter.complete();
        }
      }
    });
  }

  void _updateGroupMessageTime(int eventTime, String relay) {
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setMLSGroupMessageUntil(eventTime, relay);
      Relays.sharedInstance.setMLSGroupMessageSince(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] =
          RelayDBISAR(url: relay, groupMessageUntil: eventTime, mlsGroupMessageSince: eventTime);
    }
    if (offlineGroupMessageFinish[relay] == true) {
      Relays.sharedInstance.syncRelaysToDB(r: relay);
    }
  }

  /// handle key packages
  /// init, create new, get, delete, rotate, check valid
  void _initKeypackages() {
    // TODO: use keypackage relays
    Map<String, bool> keypackageUpdated = {};
    Connect.sharedInstance.addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        if (keypackageUpdated[relay] != true) {
          keypackageUpdated[relay] = true;
          await _createNewKeyPackage([relay]);
        }
      }
    });
  }

  Future<Future<OKEvent>> _createNewKeyPackage(List<String> relays) async {
    String encodedKeyPackage;
    if (Account.sharedInstance.me!.encodedKeyPackage == null) {
      encodedKeyPackage = await createKeyPackageForEvent(publicKey: pubkey);
      Account.sharedInstance.me!.encodedKeyPackage = encodedKeyPackage;
      Account.sharedInstance.syncMe();
    } else {
      encodedKeyPackage = Account.sharedInstance.me!.encodedKeyPackage!;
    }
    Event event = await Nip104.encodeKeyPackageEvent(
        encodedKeyPackage, getCiphersuite(), getExtensions(), relays, pubkey, privkey);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(event, toRelays: relays, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<Map<String, String>> _getMembersKeyPackages(List<String> pubkeys) async {
    Map<String, String> result = {};
    for (var pubkey in pubkeys) {
      UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
      if (user != null && user.encodedKeyPackage != null) {
        result[pubkey] = user.encodedKeyPackage!;
      } else {
        String encodedKeyPackage = await _getKeyPackageFromRelay(pubkey);
        if (encodedKeyPackage.isNotEmpty) result[pubkey] = encodedKeyPackage;
      }
    }
    return result;
  }

  Future<String> _getKeyPackageFromRelay(String pubkey) async {
    Completer<String> completer = Completer<String>();
    Filter f = Filter(kinds: [443], limit: 1, authors: [pubkey]);
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) async {
      KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);
      if (_checkValidKeypackage(keyPackageEvent)) {
        UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
        user!.encodedKeyPackage = keyPackageEvent.encoded_key_package;
        Account.saveUserToDB(user);
        if (!completer.isCompleted) completer.complete(keyPackageEvent.encoded_key_package);
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete('');
      }
    });
    return completer.future;
  }

  Future<void> _deleteAllKeyPackagesFromRelay(List<String> relays) async {
    Completer<void> completer = Completer<void>();
    Filter f = Filter(kinds: [443], authors: [pubkey]);
    List<String> keypackageEvents = [];
    Connect.sharedInstance.addSubscription([f], relays: relays,
        eventCallBack: (event, relay) async {
      keypackageEvents.add(event.id);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      if (unRelays.isEmpty) {
        Event deleteEvent = await Nip9.encode(keypackageEvents, '', pubkey, privkey);
        Connect.sharedInstance.sendEvent(deleteEvent, toRelays: relays);
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<void> rotateKeyPackages(List<String> relays) async {
    await _deleteAllKeyPackagesFromRelay(relays);
    await _createNewKeyPackage(relays);
  }

  bool _areListsEqual(List<String> list1, List<String> list2) {
    return Set.from(list1).containsAll(list2) && Set.from(list2).containsAll(list1);
  }

  bool _checkValidKeypackage(KeyPackageEvent keyPackageEvent) {
    List<String> extensions = getExtensions();
    String ciphersuite = getCiphersuite();
    return _areListsEqual(keyPackageEvent.extensions, extensions) &&
        ciphersuite == keyPackageEvent.ciphersuite;
  }

  Future<GroupDBISAR?> createMLSGroup(String groupName, String groupDescription,
      List<String> members, List<String> admins, List<String> relays) async {
    Map<String, String> membersKeyPackages = await _getMembersKeyPackages(members);
    if (membersKeyPackages.keys.length < members.length) return null;
    String createGroupResult = await createGroup(
        groupName: groupName,
        groupDescription: groupDescription,
        groupMembersKeyPackages: membersKeyPackages.values.toList(),
        groupCreatorPublicKey: pubkey,
        groupAdminPublicKeys: admins,
        relays: relays);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(createGroupResult));

    ///send welcome & invite members
    sendWelcomeMessages(mlsGroup.serializedWelcomeMessage, mlsGroup.groupMembers, relays);
    GroupDBISAR groupDBISAR = GroupDBISAR(
        groupId: mlsGroup.nostrGroupData.nostrGroupId,
        owner: pubkey,
        updateTime: currentUnixTimestampSeconds(),
        name: mlsGroup.nostrGroupData.name,
        about: mlsGroup.nostrGroupData.description,
        members: mlsGroup.groupMembers.toSet().toList(),
        mlsGroupId: mlsGroup.groupId,
        relay: relays.firstOrNull,
        adminPubkeys: mlsGroup.nostrGroupData.adminPubkeys,
        serializedWelcomeMessage: mlsGroup.serializedWelcomeMessage);
    groups[groupDBISAR.groupId] = ValueNotifier(groupDBISAR);
    myGroups[groupDBISAR.groupId] = ValueNotifier(groupDBISAR);
    await syncGroupToDB(groupDBISAR);
    await syncMyGroupListToDB();
    updateMLSGroupSubscription();
    String inviteMessage = 'Private group created!';
    sendGroupMessage(groupDBISAR.groupId, MessageType.system, inviteMessage, local: true);
    return groupDBISAR;
  }

  Future<void> sendWelcomeMessages(
      List<int> serializedWelcomeMessage, List<String> members, List<String> relays) async {
    Event welcomeEvent =
        await Nip104.encodeWelcomeEvent(serializedWelcomeMessage, relays, pubkey, privkey);

    /// gift-wrapped welcome message and send to each members.
    for (var member in members) {
      if (member == pubkey) continue;
      Event giftWrappedEvent = await Nip59.encode(welcomeEvent, member);
      UserDBISAR? memberDB = await Account.sharedInstance.getUserInfo(member);
      List<String>? dmRelays = memberDB?.dmRelayList;
      List<String>? inboxRelays = memberDB?.inboxRelayList;
      List<String> userRelays = [...(dmRelays ?? []), ...(inboxRelays ?? []), ...relays];
      Connect.sharedInstance
          .sendEvent(giftWrappedEvent, toRelays: userRelays, sendCallBack: (ok, relay) {});
    }
  }

  Future<void> handleWelcomeMessageEvent(Event event, String relay) async {
    WelcomeEvent welcomeEvent = Nip104.decodeWelcomeEvent(event);
    // String previewWelcomeData =
    //     await previewWelcomeEvent(serializedWelcomeMessage: welcomeEvent.serializedWelcomeMessage);
    // NostrGroupData? groupData = NostrGroupData.fromPreviewWelcome(previewWelcomeData);

    /// ignore non-contact user's welcome messages
    if (!Contacts.sharedInstance.allContacts.containsKey(welcomeEvent.pubkey)) return;

    GroupDBISAR groupDBISAR = await joinMLSGroup(welcomeEvent, relay);
    UserDBISAR? userDBISAR = await Account.sharedInstance.getUserInfo(welcomeEvent.pubkey);
    String inviteMessage = '${userDBISAR?.name} invite you to join the private group';
    sendGroupMessage(groupDBISAR.groupId, MessageType.system, inviteMessage, local: true);
  }

  Future<GroupDBISAR> joinMLSGroup(WelcomeEvent welcomeEvent, String relay) async {
    String joinGroupResult =
        await joinGroupFromWelcome(serializedWelcomeMessage: welcomeEvent.serializedWelcomeMessage);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(joinGroupResult));
    GroupDBISAR groupDBISAR = GroupDBISAR(
        groupId: mlsGroup.nostrGroupData.nostrGroupId,
        relay: relay,
        owner: pubkey,
        updateTime: currentUnixTimestampSeconds(),
        name: mlsGroup.nostrGroupData.name,
        about: mlsGroup.nostrGroupData.description,
        members: mlsGroup.groupMembers.toSet().toList(),
        mlsGroupId: mlsGroup.groupId,
        adminPubkeys: mlsGroup.nostrGroupData.adminPubkeys,
        serializedWelcomeMessage: mlsGroup.serializedWelcomeMessage);
    groups[groupDBISAR.groupId] = ValueNotifier(groupDBISAR);
    myGroups[groupDBISAR.groupId] = ValueNotifier(groupDBISAR);
    await syncGroupToDB(groupDBISAR);
    await syncMyGroupListToDB();
    updateMLSGroupSubscription();
    return groupDBISAR;
  }

  Future<OKEvent> sendMessageToMLSGroup(GroupDBISAR group, Event messageEvent) async {
    if (group.mlsGroupId == null) return OKEvent('', false, 'invalid mls group');
    List<int> serializedMessage = await createMessageForGroup(
        groupId: group.mlsGroupId!, messageEvent: jsonEncode(messageEvent.toJson()));
    var secretKey = await _getGroupKeyChain(group.groupId);
    if (secretKey == null) return OKEvent(group.groupId, false, 'can not fetch group key');
    String content = await Nip44.encryptContent(
        bytesToHex(Uint8List.fromList(serializedMessage)), secretKey.public, pubkey, privkey);
    Event groupEvent = await Nip104.encodeGroupEvent(content, group.groupId, pubkey, privkey);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(groupEvent, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<void> receiveMLSGroupMessage(Event event, String relay) async {
    GroupEvent groupEvent = Nip104.decodeGroupEvent(event);
    ValueNotifier<GroupDBISAR>? groupValueNotifier = groups[groupEvent.groupId];
    if (groupValueNotifier == null) return;
    if (groupEvent.pubkey == pubkey) return;
    var secretKey = await _getGroupKeyChain(groupEvent.groupId);
    if (secretKey == null) {
      return;
    }
    String messageString = await Nip44.decryptContent(
        groupEvent.message, groupEvent.pubkey, secretKey.public, secretKey.private);
    List<int> serializedMessageJsonString = await processMessageForGroup(
        groupId: groupValueNotifier.value.mlsGroupId!,
        serializedMessage: hexToBytes(messageString));
    Event innerEvent =
        await Event.fromJson(jsonDecode(utf8.decode(serializedMessageJsonString)), verify: false);
    GroupMessage groupMessage = Nip29.decodeGroupMessage(innerEvent);
    MessageDBISAR messageDB = MessageDBISAR(
        messageId: event.id,
        sender: groupMessage.pubkey,
        receiver: '',
        groupId: groupMessage.groupId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: groupMessage.content,
        replyId: groupMessage.replyId ?? '',
        createTime: event.createdAt,
        plaintEvent: jsonEncode(event),
        chatType: 1);
    var map = await MessageDBISAR.decodeContent(groupMessage.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    messageDB.decryptSecret = map['decryptSecret'];
    await Messages.saveMessageToDB(messageDB);
    groupMessageCallBack?.call(messageDB);
  }

  Future<Keychain?> _getGroupKeyChain(String groupId) async {
    ValueNotifier<GroupDBISAR>? groupValueNotifier = groups[groupId];
    if (groupValueNotifier == null) return null;
    Keychain? secretKey;
    GroupKeysDBISAR? groupKeysDBISAR = await GroupKeysDBISAR.getGroupKeysFromDB(
        groupValueNotifier.value.groupId, groupValueNotifier.value.epoch);
    if (groupKeysDBISAR == null && groupValueNotifier.value.mlsGroupId != null) {
      ///try get epoch from open_nostrmls
      var (key, epoch) =
          await exportSecretAsHexSecretKeyAndEpoch(groupId: groupValueNotifier.value.mlsGroupId!);
      groupKeysDBISAR = GroupKeysDBISAR(
          groupId: groupId,
          epoch: epoch.toInt(),
          secretKey: key,
          mlsGroupId: groupValueNotifier.value.mlsGroupId);
      GroupKeysDBISAR.saveGroupKeysToDB(groupKeysDBISAR);
      // TODO: delete outdated group keys
      // GroupKeysDBISAR.deleteGroupKeysBeforeEpoch(groupEvent.groupId, epoch.toInt() - 3);
      secretKey = Keychain(key);
    } else if (groupKeysDBISAR != null) {
      secretKey = Keychain(groupKeysDBISAR.secretKey);
    }
    return secretKey;
  }

  /// TODO: proposal & commit
}
