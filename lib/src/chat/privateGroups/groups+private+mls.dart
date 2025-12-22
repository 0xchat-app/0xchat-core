import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chatcore/chat-core.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:nostr_mls_package/nostr_mls_package.dart';
import 'package:isar/isar.dart' hide Filter;

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
  final List<int> mlsGroupId;
  final List<String> groupMembers;
  final List<int> serializedWelcomeMessage;
  final NostrGroupData nostrGroupData;

  MlsGroup({
    required this.mlsGroupId,
    required this.groupMembers,
    required this.serializedWelcomeMessage,
    required this.nostrGroupData,
  });

  static MlsGroup fromJson(Map<String, dynamic> json) {
    if (json['mls_group_id'] == null) {
      throw Exception("error: group_id does not exit, ${jsonEncode(json)}");
    }

    List<dynamic> groupIdVec = json['mls_group_id']['value']['vec'];
    List<int> mlsGroupId = groupIdVec.map((e) => e as int).toList();

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
      mlsGroupId: mlsGroupId,
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
  // In-memory storage for staged messages
  static final List<StagedMessageDBISAR> _stagedMessages = [];

  /// Initialize MLS with specified path, identity and password
  ///
  /// [mlsPath] Required path for MLS database directory
  /// [mlsIdentity] Required identity for MLS (typically pubkey or pubkey-circleId)
  /// [password] Required password for MLS encryption
  Future<void> initMLS({
    String? mlsPath,
    String? mlsIdentity,
    String? password,
  }) async {
    mlsPath ??= await () async {
      bool isIOS = Platform.isIOS || Platform.isMacOS;
      Directory directory =
          isIOS ? await getLibraryDirectory() : await getApplicationDocumentsDirectory();
      return directory.path;
    }();
    mlsIdentity ??= pubkey;
    password ??= () {
      String? defaultPassword = Account.sharedInstance.me!.defaultPassword;
      if (defaultPassword == null || defaultPassword.isEmpty) {
        defaultPassword = generateStrongPassword(16);
        Account.sharedInstance.me!.defaultPassword = defaultPassword;
        Account.sharedInstance.syncMe();
      }
      return defaultPassword;
    }();

    await initNostrMls(path: mlsPath, identity: mlsIdentity, password: password);

    // Load staged messages from database to memory
    await _loadStagedMessagesFromDB();

    Connect.sharedInstance.addConnectStatusListener((relay, ConnectStatus status, relayKinds) async {
      if (status == ConnectStatus.open &&
          Account.sharedInstance.me != null &&
          relayKinds.contains(RelayKind.circleRelay)) {
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
    for (var g in myGroups.values) {
      groupList.add(g.value.groupId);
    }
    if (groupList.isEmpty) return;
    relay ??= Account.sharedInstance.getCurrentCircleRelay().first;
    int groupMessageUntil = Relays.sharedInstance.getMLSGroupMessageUntil(relay);
    Filter f = Filter(h: groupList, kinds: [445], since: (groupMessageUntil + 1));
    subscriptions[relay] = [f];

    // Collect all message processing Futures
    List<Future<void>> messageFutures = [];

    groupMessageSubscription = Connect.sharedInstance.addSubscriptions(subscriptions,
        closeSubscription: false, eventCallBack: (event, relay) async {
      _updateGroupMessageTime(event.createdAt, relay);
      // Add each message processing to the Future list
      messageFutures.add(receiveMLSGroupMessage(event, relay));
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      offlineGroupMessageFinish[relay] = true;

      // Wait for all messages to be processed before handling staged messages
      if (messageFutures.isNotEmpty) {
        await Future.wait(messageFutures);
      }
      await processStagedMessages();

      if (ok.status) {
        _updateGroupMessageTime(currentUnixTimestampSeconds() - 1, relay);
      }
      if (unCompletedRelays.isEmpty) {
        offlineGroupMessageFinishCallBack?.call();
        if (!Messages.sharedInstance.mlsGroupMessageCompleter.isCompleted) {
          Messages.sharedInstance.mlsGroupMessageCompleter.complete();
        }
      }
    });
  }

  void loadGroupHistoryMessagesFromRelay(GroupDBISAR group) {
    Map<String, List<Filter>> subscriptions = {};
    String relayURL =
        group.relay ?? Connect.sharedInstance.relays(relayKinds: [RelayKind.circleRelay]).first;

    Filter f = Filter(h: [group.groupId], kinds: [445], until: currentUnixTimestampSeconds());
    subscriptions[relayURL] = [f];

    // Collect all message processing Futures
    List<Future<void>> messageFutures = [];

    groupMessageSubscription = Connect.sharedInstance.addSubscriptions(subscriptions,
        closeSubscription: true, eventCallBack: (event, relay) async {
      // Add each message processing to the Future list
      messageFutures.add(receiveMLSGroupMessage(event, relay));
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      // Wait for all messages to be processed before handling staged messages
      if (messageFutures.isNotEmpty) {
        await Future.wait(messageFutures);
      }
      await processStagedMessages();
    });
  }

  /// Load staged messages from database to memory
  Future<void> _loadStagedMessagesFromDB() async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      List<StagedMessageDBISAR> stagedMessages = isar.stagedMessageDBISARs.where().findAll();
      _stagedMessages.clear();
      _stagedMessages.addAll(stagedMessages);
    } catch (e) {
      print('_loadStagedMessagesFromDB error: $e');
    }
  }

  /// Get count of staged messages in memory
  int get stagedMessagesCount => _stagedMessages.length;

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

  Future<GroupDBISAR?> createMLSGroup(
    String groupName,
    String groupDescription,
    List<String> members,
    List<String> admins,
    List<String> relays, {
    Future<KeyPackageSelectionResult?> Function(
            String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
  }) async {
    members.remove(pubkey);
    Map<String, String> membersKeyPackages =
        await getMembersKeyPackages(members, onKeyPackageSelection: onKeyPackageSelection);
    if (membersKeyPackages.keys.length < members.length) return null;
    String createGroupResult = await createGroup(
        groupName: groupName,
        groupDescription: groupDescription,
        groupMembersSerializedKeyPackages: membersKeyPackages.values.toList(),
        groupMembersPubkeys: members,
        groupCreatorPublicKey: pubkey,
        groupAdminPublicKeys: admins,
        relays: relays);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(createGroupResult));

    ///send welcome & invite members
    await sendWelcomeMessages(mlsGroup.serializedWelcomeMessage, mlsGroup.groupMembers, relays);
    GroupDBISAR groupDBISAR = GroupDBISAR(
        groupId: mlsGroup.nostrGroupData.nostrGroupId,
        owner: pubkey,
        isMLSGroup: true,
        isDirectMessage: members.length <= 1,
        updateTime: currentUnixTimestampSeconds(),
        name: mlsGroup.nostrGroupData.name,
        about: mlsGroup.nostrGroupData.description,
        members: mlsGroup.groupMembers.toSet().toList(),
        mlsGroupId: mlsGroup.mlsGroupId,
        relay: relays.firstOrNull,
        adminPubkeys: mlsGroup.nostrGroupData.adminPubkeys);
    updateOrCreateGroupNotifier(groupDBISAR.privateGroupId, groupDBISAR);
    updateOrCreateMyGroupNotifier(groupDBISAR.privateGroupId, groupDBISAR);
    await syncGroupToDB(groupDBISAR);
    await syncMyGroupListToDB();
    updateMLSGroupSubscription();
    String inviteMessage =
        groupDBISAR.isDirectMessage ? 'Private chat created!' : 'Private group created!';
    sendGroupMessage(groupDBISAR.privateGroupId, MessageType.system, inviteMessage, local: true);
    sendKeyPackageEventToMLSGroup(groupDBISAR);
    // Track keypackage usage for one-time keypackages
    await trackOneTimeKeyPackageUsage(membersKeyPackages, groupDBISAR.privateGroupId);

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
      Connect.sharedInstance
          .sendEvent(giftWrappedEvent, toRelays: relays, sendCallBack: (ok, relay) {});
    }
    NotificationHelper.sharedInstance.sendNotification(members, relays.first);
  }

  Future<MlsGroup?> previewWelcomeMessageEvent(String wrapperEventId, Event event) async {
    String previewWelcomeData = await previewGroupFromWelcome(
        wrapperEventId: hexStringToBytes(wrapperEventId),
        rumorEventString: jsonEncode(event.toJson()));
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(previewWelcomeData));
    return mlsGroup;
  }

  Future<void> handleWelcomeMessageEvent(String wrapperEventId, Event event, String relay) async {
    WelcomeEvent welcomeEvent = Nip104.decodeWelcomeEvent(event);

    /// ignore non-contact user's welcome messages
    // if (!Contacts.sharedInstance.allContacts.containsKey(welcomeEvent.pubkey)) return;
    MlsGroup? mlsGroup = await previewWelcomeMessageEvent(wrapperEventId, event);
    if (mlsGroup == null) return;
    String privateGroupId = toHexString(mlsGroup.mlsGroupId);
    GroupDBISAR? groupDBISAR = groups[privateGroupId]?.value;
    if (groupDBISAR == null) {
      groupDBISAR = GroupDBISAR(
          groupId: mlsGroup.nostrGroupData.nostrGroupId,
          isMLSGroup: true,
          relay: relay,
          mlsGroupId: mlsGroup.mlsGroupId,
          updateTime: event.createdAt,
          name: mlsGroup.nostrGroupData.name,
          about: mlsGroup.nostrGroupData.description,
          members: mlsGroup.groupMembers,
          welcomeWrapperEventId: wrapperEventId,
          welcomeEventString: jsonEncode(event.toJson()),
          isDirectMessage: mlsGroup.groupMembers.length <= 2);
    } else if (groupDBISAR.updateTime < event.createdAt) {
      groupDBISAR.groupId = mlsGroup.nostrGroupData.nostrGroupId;
      groupDBISAR.name = mlsGroup.nostrGroupData.name;
      groupDBISAR.about = mlsGroup.nostrGroupData.description;
      groupDBISAR.isMLSGroup = true;
      groupDBISAR.mlsGroupId = mlsGroup.mlsGroupId;
      groupDBISAR.relay = relay;
      groupDBISAR.updateTime = event.createdAt;
      groupDBISAR.welcomeEventString = jsonEncode(event.toJson());
      groupDBISAR.welcomeWrapperEventId = wrapperEventId;
      groupDBISAR.members = mlsGroup.groupMembers;
      groupDBISAR.isDirectMessage = mlsGroup.groupMembers.length <= 2;
    } else {
      // old welcome event, ignore
      return;
    }

    // Track keypackage usage when processing welcome message
    bool shouldAcceptWelcome =
        await trackKeyPackageUsageForWelcome(groupDBISAR, wrapperEventId, welcomeEvent.pubkey);

    if (!shouldAcceptWelcome) {
      // Reject the welcome message - keypackage already used by another user
      return;
    }

    updateOrCreateGroupNotifier(groupDBISAR.privateGroupId, groupDBISAR);
    syncGroupToDB(groupDBISAR);
    UserDBISAR? userDBISAR = await Account.sharedInstance.getUserInfo(welcomeEvent.pubkey);
    String inviteMessage = groupDBISAR.isDirectMessage
        ? '${userDBISAR?.name} invite you to join the private chat'
        : '${userDBISAR?.name} invite you to join the private group';
    sendGroupMessage(groupDBISAR.privateGroupId, MessageType.system, inviteMessage, local: true);

    if (checkInMyGroupList(groupDBISAR.privateGroupId)) {
      await joinMLSGroup(groupDBISAR);
    }
  }

  Future<OKEvent> joinMLSGroup(GroupDBISAR group) async {
    if (group.welcomeEventString == null || group.welcomeWrapperEventId == null) {
      return OKEvent(group.privateGroupId, false, 'no welcome messages');
    }
    String joinGroupResult = await joinGroupFromWelcome(
        wrapperEventId: hexStringToBytes(group.welcomeWrapperEventId!),
        rumorEventString: group.welcomeEventString!);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(joinGroupResult));
    String membersString = await getMembers(groupId: mlsGroup.mlsGroupId);
    List<String> members = (jsonDecode(membersString)['members'] as List).cast<String>();
    group.updateTime = currentUnixTimestampSeconds();
    group.members = members;
    group.mlsGroupId = mlsGroup.mlsGroupId;
    group.adminPubkeys = mlsGroup.nostrGroupData.adminPubkeys;
    updateOrCreateGroupNotifier(group.privateGroupId, group);
    updateOrCreateMyGroupNotifier(group.privateGroupId, group);
    await syncGroupToDB(group);
    await syncMyGroupListToDB();
    updateMLSGroupSubscription();
    loadGroupHistoryMessagesFromRelay(group);
    return OKEvent(group.privateGroupId, true, '');
  }

  Future<OKEvent> sendMessageToMLSGroup(GroupDBISAR group, Event messageEvent, {String? expiration, String? k}) async {
    if (group.mlsGroupId == null) return OKEvent('', false, 'invalid mls group');
    String eventString = await createMessageForGroup(
        groupId: group.mlsGroupId!, 
        rumorEventString: jsonEncode(messageEvent.toJson()),
        expiration: expiration,
        k: k);
    Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);
    await Connect.sharedInstance.connectRelays(Account.sharedInstance.getCurrentCircleRelay(), relayKind: RelayKind.circleRelay);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(groupEvent, toRelays: Account.sharedInstance.getCurrentCircleRelay(), sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        if (ok.status) {
          List<String> members =
              group.members?.where((element) => element != pubkey).toList() ?? [];
          if (members.isNotEmpty) {
            NotificationHelper.sharedInstance.sendNotification(members, relay);
          }
        }
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<OKEvent> sendGroupEventToMLSGroup(GroupDBISAR group, Event groupEvent) async {
    if (group.mlsGroupId == null) return OKEvent('', false, 'invalid mls group');
    await Connect.sharedInstance.connectRelays(Account.sharedInstance.getCurrentCircleRelay(), relayKind: RelayKind.circleRelay);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(groupEvent, toRelays: Account.sharedInstance.getCurrentCircleRelay(), sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        if (ok.status) {
          List<String> members =
              group.members?.where((element) => element != pubkey).toList() ?? [];
          if (members.isNotEmpty) {
            NotificationHelper.sharedInstance.sendNotification(members, relay);
          }
        }
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  /// Process staged messages that were queued for later processing
  Future<void> processStagedMessages() async {
    try {
      // Get staged messages from memory
      List<StagedMessageDBISAR> stagedMessages = List.from(_stagedMessages);

      if (stagedMessages.isEmpty) {
        return;
      }

      for (var stagedMessage in stagedMessages) {
        await _processSingleStagedMessage(stagedMessage);
      }
      // delete staged message from database and clear memory
      await _deleteStagedMessagesFromDB(stagedMessages);
      _stagedMessages.clear();
    } catch (e) {
      print('processStagedMessages error: $e');
    }
  }

  /// Process a single staged message
  Future<void> _processSingleStagedMessage(StagedMessageDBISAR stagedMessage) async {
    try {
      // Find the corresponding group
      ValueNotifier<GroupDBISAR>? groupValueNotifier =
          _findGroupByNostrId(stagedMessage.nostrGroupId);
      if (groupValueNotifier == null) {
        return;
      }

      // Process the commit message
      String result = await processCommitMessageForGroup(
        groupId: groupValueNotifier.value.mlsGroupId!,
        messageBytes: stagedMessage.messageBytes,
      );

      // Parse the result
      final Map<String, dynamic> resultData = jsonDecode(result);
      final addedMembers = resultData['added_members'];
      final removedMembers = resultData['removed_members'];

      // Handle added members
      if (addedMembers is List && addedMembers.isNotEmpty) {
        await _handleAddedMembers(groupValueNotifier.value, addedMembers);
      }

      // Handle removed members
      if (removedMembers is List && removedMembers.isNotEmpty) {
        await _handleRemovedMembers(groupValueNotifier.value, removedMembers);
      }

      // Update group info after processing
      updateMLSGroupInfo(groupValueNotifier.value);
    } catch (e) {
      print('Error processing staged message ${stagedMessage.eventId}: $e');
    }
  }

  /// Find group by Nostr group ID
  ValueNotifier<GroupDBISAR>? _findGroupByNostrId(String nostrGroupId) {
    for (var group in groups.values) {
      if (group.value.groupId == nostrGroupId) {
        return group;
      }
    }
    return null;
  }

  /// Delete staged messages from database
  static Future<void> _deleteStagedMessagesFromDB(List<StagedMessageDBISAR> stagedMessages) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      await isar.writeAsync((isar) {
        for (var stagedMessage in stagedMessages) {
          isar.stagedMessageDBISARs.where().eventIdEqualTo(stagedMessage.eventId).deleteAll();
        }
      });
    } catch (e) {
      print('Failed to delete staged messages from database: $e');
    }
  }

  /// Handle added members to the group
  Future<void> _handleAddedMembers(GroupDBISAR group, List<dynamic> addedMembers) async {
    String content = '';

    for (var member in addedMembers) {
      UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
      content = '${user?.name} $content ';
      content = '${content}joined the group';
    }

    sendGroupMessage(group.privateGroupId, MessageType.system, content, local: true);
  }

  /// Handle removed members from the group
  Future<void> _handleRemovedMembers(GroupDBISAR group, List<dynamic> removedMembers) async {
    String content = '';

    for (var member in removedMembers) {
      if (member == pubkey) {
        content = 'You have been removed from the group';
        break;
      }

      UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
      if (group.adminPubkeys?.contains(user?.pubKey) == true || group.isDirectMessage == true) {
        await deleteMLSGroup(group);
        return;
      } else {
        content = '${user?.name} $content ';
        content = '${content}left the group';
      }
    }

    sendGroupMessage(group.privateGroupId, MessageType.system, content, local: true);
  }

  Future<void> receiveMLSGroupMessage(Event event, String relay) async {
    EventCache.sharedInstance.receiveEvent(event, relay);
    GroupEvent groupEvent = Nip104.decodeGroupEvent(event);
    ValueNotifier<GroupDBISAR>? groupValueNotifier;
    for (var group in groups.values) {
      if (group.value.groupId == groupEvent.groupId) {
        groupValueNotifier = group;
        break;
      }
    }
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
      final staged_message_bytes = jsonDecode(result)['staged_message_bytes'];

      if (staged_message_bytes != null) {
        // staged commit message, cache for late merge commit
        var stagedMessageBytes = List<int>.from(staged_message_bytes);
        StagedMessageDBISAR stagedMessage = StagedMessageDBISAR(
            eventId: event.id,
            nostrGroupId: groupValueNotifier.value.groupId,
            mlsGroupId: groupValueNotifier.value.mlsGroupId!,
            messageBytes: stagedMessageBytes,
            senderPubkey: event.pubkey,
            createTime: event.createdAt);
        if(offlineGroupMessageFinish[relay] == true){
          _processSingleStagedMessage(stagedMessage);
        }
        else{
          await DBISAR.sharedInstance.saveToDB(stagedMessage);
          _stagedMessages.add(stagedMessage);
        }
      }

      if (commit != null) {
        var commit_message = List<int>.from(commit);
        String eventString = await createCommitMessageForGroup(
            nostrGroupId: groupValueNotifier.value.groupId,
            serializedCommit: commit_message,
            secretKey: preSecret);
        Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);
        sendGroupEventToMLSGroup(groupValueNotifier.value, groupEvent);
      }

      if (message != null) {
        innerEvent = await Event.fromJson(message, verify: false);
      }

      String content = '';
      if (added_members is List && added_members.isNotEmpty) {
        for (var member in added_members) {
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
          content = '${user?.name} $content ';
          content = '${content}joined the group';
        }
        sendGroupMessage(groupValueNotifier.value.privateGroupId, MessageType.system, content,
            local: true);
        updateMLSGroupInfo(groupValueNotifier.value);
      }
      if (removed_members is List && removed_members.isNotEmpty) {
        for (var member in removed_members) {
          if (member == pubkey) {
            content = 'You have been removed from the group';
            break;
          }
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
          if (groupValueNotifier.value.adminPubkeys?.contains(user?.pubKey) == true ||
              groupValueNotifier.value.isDirectMessage == true) {
            await deleteMLSGroup(groupValueNotifier.value);
            return;
          } else {
            content = '${user?.name} $content ';
            content = '${content}left the group';
          }
        }
        sendGroupMessage(groupValueNotifier.value.privateGroupId, MessageType.system, content,
            local: true);
        updateMLSGroupInfo(groupValueNotifier.value);
      }
    } catch (e) {
      print('receiveMLSGroupMessage error: $e');
    }
    if (innerEvent == null || Contacts.sharedInstance.inBlockList(innerEvent.pubkey)) return;
    _handleMLSGroupMessage(innerEvent, groupValueNotifier.value.privateGroupId, relay);
  }

  Future<void> _handleMLSGroupMessage(Event innerEvent, String privateGroupId, String relay) async {
    switch (innerEvent.kind) {
      // group message
      case 9:
        _handleKind9MLSGroupMessage(innerEvent, privateGroupId);
        break;
      // delete message
      case 5:
        _handleKind5MLSGroupMessage(innerEvent);
        break;
      // media message
      case 15:
        _handleKind15MLSGroupMessage(innerEvent, privateGroupId);
        break;
      case 443:
        handleKeyPackageEvent(innerEvent, relay);
        break;
      case 25050:
        Contacts.sharedInstance.handleCallEvent(innerEvent, relay, privateGroupId: privateGroupId);
        break;
      default:
        break;
    }
  }

  Future<void> _handleKind9MLSGroupMessage(Event innerEvent, String privateGroupId) async {
    GroupMessage groupMessage = Nip29.decodeGroupMessage(innerEvent);
    if (groupMessage.pubkey == pubkey) return;
    MessageDBISAR messageDB = MessageDBISAR(
        messageId: innerEvent.id,
        sender: groupMessage.pubkey,
        receiver: '',
        groupId: privateGroupId,
        kind: innerEvent.kind,
        tags: jsonEncode(innerEvent.tags),
        content: groupMessage.content,
        replyId: groupMessage.replyId ?? '',
        createTime: innerEvent.createdAt,
        plaintEvent: jsonEncode(innerEvent),
        chatType: 1);
    var map = await MessageDBISAR.decodeContent(groupMessage.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    messageDB.decryptSecret = map['decryptSecret'];
    await Messages.saveMessageToDB(messageDB);
    groupMessageCallBack?.call(messageDB);
  }

  Future<void> _handleKind5MLSGroupMessage(Event innerEvent) async {
    List<String> eventIds = Nip9.tagsToList(innerEvent.tags);
    await Messages.deleteMessagesFromDB(messageIds: eventIds);
  }

  Future<void> _handleKind15MLSGroupMessage(Event innerEvent, String privateGroupId) async {
    EDMessage? message = await Contacts.sharedInstance.decodeKind14Event(innerEvent, pubkey);
    if (message == null) return;
    MessageDBISAR messageDB = MessageDBISAR(
        messageId: innerEvent.id,
        sender: message.sender,
        receiver: message.receiver,
        groupId: privateGroupId,
        kind: innerEvent.kind,
        tags: jsonEncode(innerEvent.tags),
        content: message.content,
        createTime: innerEvent.createdAt,
        replyId: message.replyId,
        plaintEvent: jsonEncode(innerEvent),
        chatType: 1,
        expiration: message.expiration == null ? null : int.parse(message.expiration!),
        decryptAlgo: message.algorithm,
        decryptNonce: message.nonce,
        decryptSecret: message.secret);
    var map = await MessageDBISAR.decodeContent(message.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    if (map['decryptSecret'] != null) {
      messageDB.decryptSecret = map['decryptSecret'];
    }
    if (message.mimeType != null) {
      messageDB.type = MessageDBISAR.mimeTypeToTpyeString(message.mimeType!);
    }
    await Messages.saveMessageToDB(messageDB);
    groupMessageCallBack?.call(messageDB);
  }

  Future<void> deleteMLSGroupMessages(List<String> messageIds, GroupDBISAR group,
      {bool requestDeleteForAll = false}) async {
    if (!requestDeleteForAll) {
      await Messages.deleteMessagesFromDB(messageIds: messageIds);
      return;
    }
    Event messageEvent = await Nip9.encode(messageIds, '', pubkey, privkey);
    OKEvent okEvent = await sendMessageToMLSGroup(group, messageEvent);
    if (okEvent.status) {
      await Messages.deleteMessagesFromDB(messageIds: messageIds);
    }
  }

  Future<GroupDBISAR> addMembersToMLSGroup(
    GroupDBISAR group,
    List<String> members, {
    Future<KeyPackageSelectionResult?> Function(
            String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
  }) async {
    if (group.mlsGroupId == null) return group;
    Map<String, String> membersKeyPackages =
        await getMembersKeyPackages(members, onKeyPackageSelection: onKeyPackageSelection);
    if (membersKeyPackages.keys.length < members.length) return group;
    String exportSecretResult = await exportSecret(groupId: group.mlsGroupId!);
    U8Array32 preSecret =
        U8Array32(Uint8List.fromList((jsonDecode(exportSecretResult)['secret']).cast<int>()));
    String result = await addMembers(
        groupId: group.mlsGroupId!, serializedKeyPackages: membersKeyPackages.values.toList());
    List<int> commit_message = List<int>.from(jsonDecode(result)['commit_message']);
    List<int> welcome_message = List<int>.from(jsonDecode(result)['welcome_message']);
    String eventString = await createCommitMessageForGroup(
        nostrGroupId: group.groupId, serializedCommit: commit_message, secretKey: preSecret);
    Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);
    OKEvent okEvent = await sendGroupEventToMLSGroup(group, groupEvent);
    if (okEvent.status) {
      await sendWelcomeMessages(
          welcome_message, members, Account.sharedInstance.getCurrentCircleRelay());
      updateMLSGroupInfo(group);

      // Track keypackage usage for one-time keypackages
      trackOneTimeKeyPackageUsage(membersKeyPackages, group.privateGroupId);

      String content = '';
      for (var member in members) {
        UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
        content = '${user?.name} $content ';
        content = '${content}joined the group';
      }
      sendGroupMessage(group.privateGroupId, MessageType.system, content, local: true);
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
        nostrGroupId: group.groupId, serializedCommit: commit_message, secretKey: preSecret);
    Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);

    OKEvent okEvent = await sendGroupEventToMLSGroup(group, groupEvent);
    if (okEvent.status) {
      updateMLSGroupInfo(group);
      String content = '';
      for (var member in members) {
        UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
        content = '${user?.name} $content ';
        content = '${content}left the group';
      }
      sendGroupMessage(group.privateGroupId, MessageType.system, content, local: true);
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
        nostrGroupId: group.groupId, serializedCommit: leave_message, secretKey: preSecret);
    Event groupEvent = await Event.fromJson(jsonDecode(eventString)['event']);

    OKEvent okEvent = await sendGroupEventToMLSGroup(group, groupEvent);
    if (okEvent.status) {
      await deleteMLSGroup(group);
    }
    return okEvent;
  }

  Future<void> deleteMLSGroup(GroupDBISAR group) async {
    if (group.mlsGroupId == null) return;
    final privateGroupId = group.privateGroupId;
    myGroups.remove(privateGroupId);
    groups.remove(privateGroupId);
    await Messages.deleteGroupMessagesFromDB(privateGroupId);
    await deleteGroup(group.groupId);
    updateMLSGroupSubscription();
    await syncMyGroupListToDB();
    groupDeleteCallBack?.call(privateGroupId);
  }

  Future<GroupDBISAR?> updateMLSGroupInfo(GroupDBISAR group) async {
    if (group.mlsGroupId == null) return null;
    String oldGroupId = group.groupId;

    String result = await getGroup(groupId: group.mlsGroupId!);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(result));

    group.members = mlsGroup.groupMembers;
    // group.name = mlsGroup.nostrGroupData.name; // use local name
    group.about = mlsGroup.nostrGroupData.description;
    group.adminPubkeys = mlsGroup.nostrGroupData.adminPubkeys;
    group.groupId = mlsGroup.nostrGroupData.nostrGroupId;

    await syncGroupToDB(group);
    if (group.groupId != oldGroupId) {
      loadGroupHistoryMessagesFromRelay(group);
      updateMLSGroupSubscription();
    }
    return group;
  }
}
