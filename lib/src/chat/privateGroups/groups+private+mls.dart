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

List<int> hexStringToBytes(String hexString) {
  hexString = hexString.replaceAll(' ', '').replaceAll('0x', '');

  if (hexString.length % 2 != 0) {
    hexString = '0' + hexString;
  }

  List<int> bytes = [];
  for (int i = 0; i < hexString.length; i += 2) {
    String byteString = hexString.substring(i, i + 2);
    int byte = int.parse(byteString, radix: 16);
    bytes.add(byte);
  }

  return bytes;
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
    if (json['mls_group_id'] == null) {
      throw Exception("error: group_id does not exit, ${jsonEncode(json)}");
    }

    List<dynamic> groupIdVec = json['mls_group_id']['value']['vec'];
    List<int> groupId = groupIdVec.map((e) => e as int).toList();

    List<String> members = [];
    if (json['members'] != null) {
      members = List<String>.from(json['members']);
    }

    List<int> serializedWelcomeMessage = [];
    if (json['serialized_welcome_message'] != null) {
      serializedWelcomeMessage = List<int>.from(json['serialized_welcome_message']);
    }

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

    String name = json['name'];
    String description = json['description'];

    List<String> adminPubkeys = (json['admin_pubkeys'] as List).cast<String>();

    return NostrGroupData(
      nostrGroupId: nostrGroupId,
      name: name,
      description: description,
      adminPubkeys: adminPubkeys,
      relays: [],
    );
  }
}

class ParsedKeyPackage {
  final String encodedKeyPackage;
  final List<List<String>> tags;

  ParsedKeyPackage({required this.encodedKeyPackage, required this.tags});

  @override
  String toString() {
    return 'KeyPackage:\n  Encoded: $encodedKeyPackage\n  Tags: $tags';
  }
}

ParsedKeyPackage parseKeyPackageString(String jsonstring) {
  final result = jsonDecode(jsonstring);

  final encodedKeyPackage = result['encoded_key_package'];
  final tagsData = result['tags'];

  final List<List<String>> tags = [];

  if (tagsData is String) {
    final tagPattern = RegExp(r'Tag\(\[(.+?)\]\)');
    final matches = tagPattern.allMatches(tagsData);

    for (final match in matches) {
      if (match.group(1) != null) {
        final tagContent = match.group(1)!;

        final valuePattern = RegExp(r'"([^"]*)"');
        final valueMatches = valuePattern.allMatches(tagContent);

        final List<String> tagValues = [];
        for (final valueMatch in valueMatches) {
          if (valueMatch.group(1) != null) {
            tagValues.add(valueMatch.group(1)!);
          }
        }

        if (tagValues.isNotEmpty) {
          tags.add(tagValues);
        }
      }
    }
  } else if (tagsData is List) {
    for (final tag in tagsData) {
      if (tag is String) {
        final tagPattern = RegExp(r'Tag\(\[(.+?)\]\)');
        final match = tagPattern.firstMatch(tag);

        if (match != null && match.group(1) != null) {
          final tagContent = match.group(1)!;

          final valuePattern = RegExp(r'"([^"]*)"');
          final valueMatches = valuePattern.allMatches(tagContent);

          final List<String> tagValues = [];
          for (final valueMatch in valueMatches) {
            if (valueMatch.group(1) != null) {
              tagValues.add(valueMatch.group(1)!);
            }
          }

          if (tagValues.isNotEmpty) {
            tags.add(tagValues);
          }
        }
      } else if (tag is List) {
        final List<String> tagValues = [];
        for (final value in tag) {
          if (value is String) {
            tagValues.add(value);
          }
        }

        if (tagValues.isNotEmpty) {
          tags.add(tagValues);
        }
      }
    }
  }

  return ParsedKeyPackage(
    encodedKeyPackage: encodedKeyPackage,
    tags: tags,
  );
}

class MemberChanges {
  final List<String> addedMembers;
  final List<String> removedMembers;

  MemberChanges({
    required this.addedMembers,
    required this.removedMembers,
  });

  factory MemberChanges.fromMap(Map<String, dynamic> map) {
    return MemberChanges(
      addedMembers: List<String>.from(map['added_members'] ?? []),
      removedMembers: List<String>.from(map['removed_members'] ?? []),
    );
  }

  static MemberChanges fromString(String str) {
    final jsonLike = str.replaceFirst(RegExp(r'^[^{]+{'), '{').replaceFirst(RegExp(r'}\s*$'), '}');
    final parsed = jsonDecode(jsonLike);

    return MemberChanges.fromMap(parsed);
  }
}

extension MLSPrivateGroups on Groups {
  Future<void> initMLS() async {
    bool isIOS = Platform.isIOS || Platform.isMacOS;
    Directory directory =
        isIOS ? await getLibraryDirectory() : await getApplicationDocumentsDirectory();
    String? defaultPassword = Account.sharedInstance.me!.defaultPassword;
    if (defaultPassword == null || defaultPassword.isEmpty) {
      defaultPassword = generateStrongPassword(16);
      Account.sharedInstance.me!.defaultPassword = defaultPassword;
      Account.sharedInstance.syncMe();
    }
    await initNostrMls(path: directory.path, identity: pubkey, password: defaultPassword);
    _checkKeyPackage();
    Connect.sharedInstance.addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        updateMLSGroupSubscription(relay: relay);
        _checkKeyPackage();
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
      if (Messages.sharedInstance.mlsGroupMessageCompleter.isCompleted) {
        _updateGroupMessageTime(event.createdAt, relay);
        await receiveMLSGroupMessage(event, relay);
      } else {
        mlsGroupEventCache.add(event);
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      offlineGroupMessageFinish[relay] = true;
      if (ok.status) {
        _updateGroupMessageTime(currentUnixTimestampSeconds() - 1, relay);
      }
      if (unCompletedRelays.isEmpty) {
        mlsGroupEventCache.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        for (var event in mlsGroupEventCache) {
          await receiveMLSGroupMessage(event, relay);
        }
        mlsGroupEventCache.clear();
        offlineGroupMessageFinishCallBack?.call();
        if (!Messages.sharedInstance.mlsGroupMessageCompleter.isCompleted) {
          Messages.sharedInstance.mlsGroupMessageCompleter.complete();
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

  Future<void> _checkKeyPackage({List<String>? relays}) async {
    String encoded_key_package = await _getKeyPackageFromRelay(pubkey);
    if (encoded_key_package.isNotEmpty) {
      String result = await getKeyPackageFromStorage(serializedKeyPackage: encoded_key_package);
      bool found = jsonDecode(result)['found'];
      if (found) {
        Account.sharedInstance.me!.encodedKeyPackage = encoded_key_package;
        Account.sharedInstance.syncMe();
      } else {
        _createNewKeyPackage([]);
      }
    } else {
      _createNewKeyPackage([]);
    }
  }

  Future<OKEvent> _createNewKeyPackage(List<String> relays) async {
    if (relays.isEmpty) {
      List<String> generalRelays = Account.sharedInstance.me?.relayList ?? [];
      relays = generalRelays;
    }
    String result = await createKeyPackageForEvent(publicKey: pubkey);
    ParsedKeyPackage parsedKeyPackage = parseKeyPackageString(result);
    Event event = await Nip104.encodeKeyPackageEvent(
        parsedKeyPackage.encodedKeyPackage, parsedKeyPackage.tags, pubkey, privkey);

    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(event, toRelays: relays, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        if (ok.status) {
          Account.sharedInstance.me!.encodedKeyPackage = parsedKeyPackage.encodedKeyPackage;
          Account.sharedInstance.syncMe();
        }
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<Map<String, String>> _getMembersKeyPackages(List<String> pubkeys) async {
    Map<String, String> result = {};
    for (var pubkey in pubkeys) {
      String encodedKeyPackage = await _getKeyPackageFromRelay(pubkey);
      if (encodedKeyPackage.isNotEmpty) {
        result[pubkey] = encodedKeyPackage;
      } else {
        UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
        if (user != null && user.encodedKeyPackage != null) {
          result[pubkey] = user.encodedKeyPackage!;
        }
      }
      // UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
      // if (user != null && user.encodedKeyPackage != null) {
      //   result[pubkey] = user.encodedKeyPackage!;
      // } else {
      //   String encodedKeyPackage = await _getKeyPackageFromRelay(pubkey);
      //   if (encodedKeyPackage.isNotEmpty) result[pubkey] = encodedKeyPackage;
      // }
    }
    return result;
  }

  Future<String> _getKeyPackageFromRelay(String pubkey) async {
    Completer<String> completer = Completer<String>();
    Filter f = Filter(kinds: [443], limit: 1, authors: [pubkey]);
    Event? cachedEvent;
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) async {
      cachedEvent = event;
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      if (cachedEvent != null) {
        KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(cachedEvent!);
        bool result = await _checkValidKeypackage(keyPackageEvent);
        if (result) {
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
          user!.encodedKeyPackage = keyPackageEvent.encoded_key_package;
          Account.saveUserToDB(user);
          if (!completer.isCompleted) completer.complete(keyPackageEvent.encoded_key_package);
        }
      } else if (unRelays.isEmpty) {
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
    await _checkKeyPackage(relays: relays);
  }

  bool _areListsEqual(List<String> list1, List<String> list2) {
    return Set.from(list1).containsAll(list2) && Set.from(list2).containsAll(list1);
  }

  Future<bool> _checkValidKeypackage(KeyPackageEvent keyPackageEvent) async {
    String extensions = jsonDecode(await getExtensions())['extensions'];
    String ciphersuite = jsonDecode(await getCiphersuite())['ciphersuite'];

    return _areListsEqual(keyPackageEvent.extensions, [extensions]) &&
        ciphersuite == keyPackageEvent.ciphersuite;
  }

  Future<GroupDBISAR?> createMLSGroup(String groupName, String groupDescription,
      List<String> members, List<String> admins, List<String> relays) async {
    members.remove(pubkey);
    Map<String, String> membersKeyPackages = await _getMembersKeyPackages(members);
    if (membersKeyPackages.keys.length < members.length) return null;
    String createGroupResult = await createGroup(
        groupName: groupName,
        groupDescription: groupDescription,
        groupMembersSerializedKeyPackages: membersKeyPackages.values.toList(),
        groupMembersPubkeys: members,
        groupCreatorPublicKey: pubkey,
        groupAdminPublicKeys: admins,
        relays: relays);
    print(createGroupResult);
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

  Future<NostrGroupData?> previewWelcomeMessageEvent(Event event) async {
    String previewWelcomeData = await previewGroupFromWelcome(
        wrapperEventId: hexStringToBytes(event.id), rumorEventString: jsonEncode(event.toJson()));
    NostrGroupData? groupData = NostrGroupData.fromPreviewWelcome(previewWelcomeData);
    return groupData;
  }

  Future<void> handleWelcomeMessageEvent(String wrapperEventId, Event event, String relay) async {
    WelcomeEvent welcomeEvent = Nip104.decodeWelcomeEvent(event);

    /// ignore non-contact user's welcome messages
    if (!Contacts.sharedInstance.allContacts.containsKey(welcomeEvent.pubkey)) return;

    GroupDBISAR groupDBISAR = await joinMLSGroup(wrapperEventId, event, relay);
    UserDBISAR? userDBISAR = await Account.sharedInstance.getUserInfo(welcomeEvent.pubkey);
    String inviteMessage = '${userDBISAR?.name} invite you to join the private group';
    sendGroupMessage(groupDBISAR.groupId, MessageType.system, inviteMessage, local: true);
  }

  Future<GroupDBISAR> joinMLSGroup(String wrapperEventId, Event welcomeEvent, String relay) async {
    String joinGroupResult = await joinGroupFromWelcome(
        wrapperEventId: hexStringToBytes(wrapperEventId),
        rumorEventString: jsonEncode(welcomeEvent.toJson()));
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(joinGroupResult));
    String membersString = await getMembers(groupId: mlsGroup.groupId);
    List<String> members = (jsonDecode(membersString)['members'] as List).cast<String>();
    GroupDBISAR groupDBISAR = GroupDBISAR(
        groupId: mlsGroup.nostrGroupData.nostrGroupId,
        relay: relay,
        owner: pubkey,
        updateTime: currentUnixTimestampSeconds(),
        name: mlsGroup.nostrGroupData.name,
        about: mlsGroup.nostrGroupData.description,
        members: members,
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
    String eventString = await createMessageForGroup(
        groupId: group.mlsGroupId!, rumorEventString: jsonEncode(messageEvent.toJson()));
    Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(groupEvent, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<OKEvent> sendGroupEventToMLSGroup(GroupDBISAR group, Event groupEvent) async {
    if (group.mlsGroupId == null) return OKEvent('', false, 'invalid mls group');
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
    Event? innerEvent;
    try {
      String exportSecretResult = await exportSecret(groupId: groupValueNotifier.value.mlsGroupId!);
      U8Array32 preSecret =
          U8Array32(Uint8List.fromList((jsonDecode(exportSecretResult)['secret']).cast<int>()));
      String result = await processMessageForGroup(eventString: jsonEncode(event.toJson()));
      final message = jsonDecode(result)['message'];
      final added_members = jsonDecode(result)['added_members'];
      final removed_members = jsonDecode(result)['removed_members'];
      final commit = jsonDecode(result)['commit'];

      if (commit != null) {
        var commit_message = List<int>.from(commit);
        String eventString = await createCommitMessageForGroup(
            groupId: groupValueNotifier.value.mlsGroupId!,
            serializedCommit: commit_message,
            secretKey: preSecret);
        Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);
        await sendGroupEventToMLSGroup(groupValueNotifier.value, groupEvent);
      }

      if (message != null) {
        innerEvent = await Event.fromJson(message, verify: false);
      }

      String content = '';
      if (added_members != null) {
        for (var member in added_members) {
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
          content = '${user?.name} $content ';
          content = '${content}joined the group';
        }
        sendGroupMessage(groupValueNotifier.value.groupId, MessageType.system, content,
            local: true);
        updateGroup(groupValueNotifier.value);
      }
      if (removed_members != null) {
        for (var member in removed_members) {
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
          content = '${user?.name} $content ';
          content = '${content}left the group';
        }
        sendGroupMessage(groupValueNotifier.value.groupId, MessageType.system, content,
            local: true);
        updateGroup(groupValueNotifier.value);
      }
    } catch (e) {
      print('receiveMLSGroupMessage error: $e');
    }
    if (innerEvent == null) return;
    GroupMessage groupMessage = Nip29.decodeGroupMessage(innerEvent);
    if (groupMessage.pubkey == pubkey) return;
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

  Future<GroupDBISAR> addMembersToMLSGroup(GroupDBISAR group, List<String> members) async {
    if (group.mlsGroupId == null) return group;
    Map<String, String> membersKeyPackages = await _getMembersKeyPackages(members);
    if (membersKeyPackages.isEmpty) return group;
    String exportSecretResult = await exportSecret(groupId: group.mlsGroupId!);
    U8Array32 preSecret =
        U8Array32(Uint8List.fromList((jsonDecode(exportSecretResult)['secret']).cast<int>()));
    String result = await addMembers(
        groupId: group.mlsGroupId!, serializedKeyPackages: membersKeyPackages.values.toList());
    List<int> commit_message = List<int>.from(jsonDecode(result)['commit_message']);
    List<int> welcome_message = List<int>.from(jsonDecode(result)['welcome_message']);
    String eventString = await createCommitMessageForGroup(
        groupId: group.mlsGroupId!, serializedCommit: commit_message, secretKey: preSecret);
    Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);
    OKEvent okEvent = await sendGroupEventToMLSGroup(group, groupEvent);
    if (okEvent.status) {
      await sendWelcomeMessages(
          welcome_message, members, Account.sharedInstance.me?.relayList ?? []);
      group.members?.addAll(members);
      syncGroupToDB(group);
    }
    return group;
  }

  Future<GroupDBISAR> removeMembersFromMLSGroup(GroupDBISAR group, List<String> members) async {
    if (group.mlsGroupId == null) return group;
    String exportSecretResult = await exportSecret(groupId: group.mlsGroupId!);
    U8Array32 preSecret =
        U8Array32(Uint8List.fromList((jsonDecode(exportSecretResult)['secret']).cast<int>()));
    String result = await removeMembers(groupId: group.mlsGroupId!, memberPubkeys: members);
    List<int> commit_message = List<int>.from(jsonDecode(result)['serialized_commit']);
    String eventString = await createCommitMessageForGroup(
        groupId: group.mlsGroupId!, serializedCommit: commit_message, secretKey: preSecret);
    Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);

    OKEvent okEvent = await sendGroupEventToMLSGroup(group, groupEvent);
    if (okEvent.status) {
      group.members?.removeWhere((m) => members.contains(m));
      syncGroupToDB(group);
    }
    return group;
  }

  Future<OKEvent> leaveMLSGroup(GroupDBISAR group) async {
    if (group.mlsGroupId == null) return OKEvent('', false, 'invalid mls group');
    String exportSecretResult = await exportSecret(groupId: group.mlsGroupId!);
    U8Array32 preSecret =
        U8Array32(Uint8List.fromList((jsonDecode(exportSecretResult)['secret']).cast<int>()));
    String result = await leaveGroup(groupId: group.mlsGroupId!);
    List<int> leave_message = List<int>.from(jsonDecode(result)['serialized_leave']);

    String eventString = await createCommitMessageForGroup(
        groupId: group.mlsGroupId!, serializedCommit: leave_message, secretKey: preSecret);
    Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);

    OKEvent okEvent = await sendGroupEventToMLSGroup(group, groupEvent);
    if (okEvent.status) {
      myGroups.remove(group);
      groups.remove(group);
      updateMLSGroupSubscription();
      await syncMyGroupListToDB();
    }
    return okEvent;
  }

  Future<GroupDBISAR?> updateMLSGroupInfo(GroupDBISAR group) async {
    if (group.mlsGroupId == null) return null;
    String result = await getGroup(groupId: group.mlsGroupId!);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(result));

    group.members = mlsGroup.groupMembers;
    group.name = mlsGroup.nostrGroupData.name;
    group.about = mlsGroup.nostrGroupData.description;
    group.adminPubkeys = mlsGroup.nostrGroupData.adminPubkeys;

    await syncGroupToDB(group);
    return group;
  }
}
