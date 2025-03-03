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
      throw Exception("error: group_id does not exit");
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
    await RustLib.init();
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

  void _initKeypackages() {
    // TODO: use keypackage relays
    List<String> keypackageRelays =
        Account.sharedInstance.me!.outboxRelayList ?? Relays.sharedInstance.recommendDMRelays;
    Map<String, bool> keypackageUpdated = {};
    Connect.sharedInstance.addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        if (keypackageRelays.contains(relay) && keypackageUpdated[relay] != true) {
          keypackageUpdated[relay] = true;
          // create different key packages for different relays
          await _createNewKeyPackage([relay]);
        }
      }
    });
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

  Future<Future<OKEvent>> _createNewKeyPackage(List<String> relays) async {
    String encodedKeyPackage = await createKeyPackageForEvent(publicKey: pubkey);
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

  Future<Map<String, String>> _getKeyPackageFromRelay(List<String> pubkeys) async {
    Completer<Map<String, String>> completer = Completer<Map<String, String>>();
    Map<String, String> result = {};
    for (var pubkey in pubkeys) {
      UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
      if (user != null && user.encodedKeyPackage != null) {
        result[pubkey] = user.encodedKeyPackage!;
      }
    }
    Filter f = Filter(kinds: [443], limit: 1, authors: pubkeys);
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) async {
      KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);
      if (result[keyPackageEvent.pubkey] == null && _checkValidKeypackage(keyPackageEvent)) {
        result[keyPackageEvent.pubkey] = keyPackageEvent.encoded_key_package;
        UserDBISAR? user = await Account.sharedInstance.getUserInfo(keyPackageEvent.pubkey);
        if (user != null) {
          user.encodedKeyPackage = keyPackageEvent.encoded_key_package;
          Account.saveUserToDB(user);
        }
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  bool _checkValidKeypackage(KeyPackageEvent keyPackageEvent) {
    /// TODO: check valid key package
    return true;
  }

  Future<GroupDBISAR?> createMLSGroup(String groupName, String groupDescription,
      List<String> members, List<String> admins, List<String> relays) async {
    Map<String, String> membersKeyPackages = await _getKeyPackageFromRelay(members);
    String createGroupResult = await createGroup(
        groupName: groupName,
        groupDescription: groupDescription,
        groupMembersKeyPackages: membersKeyPackages.values.toList(),
        groupCreatorPublicKey: pubkey,
        groupAdminPublicKeys: admins,
        relays: relays);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(createGroupResult));
    //send welcome & invite members
    sendWelcomeMessages(mlsGroup.serializedWelcomeMessage, mlsGroup.groupMembers, relays);
    GroupDBISAR groupDBISAR = GroupDBISAR(
        groupId: mlsGroup.nostrGroupData.nostrGroupId,
        owner: pubkey,
        updateTime: currentUnixTimestampSeconds(),
        name: mlsGroup.nostrGroupData.name,
        about: mlsGroup.nostrGroupData.description,
        members: mlsGroup.groupMembers,
        mlsGroupId: mlsGroup.groupId,
        adminPubkeys: mlsGroup.nostrGroupData.adminPubkeys,
        serializedWelcomeMessage: mlsGroup.serializedWelcomeMessage);
    groups[groupDBISAR.groupId] = ValueNotifier(groupDBISAR);
    myGroups[groupDBISAR.groupId] = ValueNotifier(groupDBISAR);
    await syncGroupToDB(groupDBISAR);
    return groupDBISAR;
  }

  Future<void> sendWelcomeMessages(
      List<int> serializedWelcomeMessage, List<String> members, List<String> relays) async {
    Event welcomeEvent =
        await Nip104.encodeWelcomeEvent(serializedWelcomeMessage, relays, pubkey, privkey);
    // gift-wrapped welcome message and send to each members.
    for (var member in members) {
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
    GroupDBISAR groupDBISAR = await joinMLSGroup(welcomeEvent);
    sendGroupMessage(groupDBISAR.groupId, MessageType.system, 'Joined MLS group', local: true);
  }

  Future<GroupDBISAR> joinMLSGroup(WelcomeEvent welcomeEvent) async {
    /// TODO: handle exception
    String joinGroupResult =
        await joinGroupFromWelcome(serializedWelcomeMessage: welcomeEvent.serializedWelcomeMessage);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(joinGroupResult));
    GroupDBISAR groupDBISAR = GroupDBISAR(
        groupId: mlsGroup.nostrGroupData.nostrGroupId,
        owner: pubkey,
        updateTime: currentUnixTimestampSeconds(),
        name: mlsGroup.nostrGroupData.name,
        about: mlsGroup.nostrGroupData.description,
        members: mlsGroup.groupMembers,
        mlsGroupId: mlsGroup.groupId,
        adminPubkeys: mlsGroup.nostrGroupData.adminPubkeys,
        serializedWelcomeMessage: mlsGroup.serializedWelcomeMessage);
    groups[groupDBISAR.groupId] = ValueNotifier(groupDBISAR);
    myGroups[groupDBISAR.groupId] = ValueNotifier(groupDBISAR);
    await syncGroupToDB(groupDBISAR);
    return groupDBISAR;
  }

  Future<OKEvent> sendMessageToMLSGroup(GroupDBISAR group, Event messageEvent) async {
    if (group.mlsGroupId == null) return OKEvent('', false, 'invalid mls group');
    List<int> serializedMessage = await createMessageForGroup(
        groupId: group.mlsGroupId!, messageEvent: jsonEncode(messageEvent.toJson()));
    var secretKey = await getGroupKeyChain(group.groupId);
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
    var secretKey = await getGroupKeyChain(groupEvent.groupId);
    if (secretKey == null) return;
    String messageString = await Nip44.decryptContent(
        groupEvent.message, groupEvent.pubkey, secretKey.public, secretKey.private);
    List<int> serializedMessageJsonString = await processMessageForGroup(
        groupId: groupValueNotifier.value.mlsGroupId!,
        serializedMessage: hexToBytes(messageString));
    Event innerEvent = await Event.fromJson(
        jsonDecode(bytesToHex(Uint8List.fromList(serializedMessageJsonString))),
        verify: false);
    GroupMessage groupMessage = Nip29.decodeGroupMessage(innerEvent);
    MessageDBISAR messageDB = MessageDBISAR(
        messageId: event.id,
        sender: groupMessage.pubkey,
        receiver: '',
        groupId: groupMessage.groupId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: groupMessage.content,
        replyId: groupMessage.thread.root.eventId ?? '',
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

  Future<Keychain?> getGroupKeyChain(String groupId) async {
    ValueNotifier<GroupDBISAR>? groupValueNotifier = groups[groupId];
    if (groupValueNotifier == null) return null;
    Keychain secretKey;
    GroupKeysDBISAR? groupKeysDBISAR = await GroupKeysDBISAR.getGroupKeysFromDB(
        groupValueNotifier.value.groupId, groupValueNotifier.value.epoch);
    if (groupKeysDBISAR == null && groupValueNotifier.value.mlsGroupId != null) {
      //try get epoch from open_nostrmls
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
    } else {
      secretKey = Keychain(groupKeysDBISAR!.secretKey);
    }
    return secretKey;
  }

  /// TODO: proposal & commit
}
