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
        var cacheList = List.from(mlsGroupEventCache);
        for (var event in cacheList) {
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

  void loadGroupHistoryMessagesFromRelay(GroupDBISAR group) {
    Map<String, List<Filter>> subscriptions = {};
    String relayURL =
        group.relay ?? Connect.sharedInstance.relays(relayKinds: [RelayKind.circleRelay]).first;

    Filter f = Filter(h: [group.groupId], kinds: [445], until: currentUnixTimestampSeconds());
    subscriptions[relayURL] = [f];

    groupMessageSubscription = Connect.sharedInstance.addSubscriptions(subscriptions,
        closeSubscription: true, eventCallBack: (event, relay) async {
      mlsGroupEventCache.add(event);
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      if (unCompletedRelays.isEmpty) {
        mlsGroupEventCache.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        var eventCache = List.from(mlsGroupEventCache);
        for (var event in eventCache) {
          await receiveMLSGroupMessage(event, relay);
        }
        mlsGroupEventCache.clear();
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
    // Use the new getAllKeyPackagesFromRelay method
    Map<String, List<KeyPackageEvent>> categorizedKeyPackages =
        await getAllKeyPackagesFromRelay(pubkey);
    List<KeyPackageEvent> oxchatLiteKeyPackages = categorizedKeyPackages['0xchat-lite'] ?? [];

    if (oxchatLiteKeyPackages.isNotEmpty) {
      KeyPackageEvent keyPackageEvent = oxchatLiteKeyPackages.first;
      String encoded_key_package = keyPackageEvent.encoded_key_package;
      String result = await getKeyPackageFromStorage(serializedKeyPackage: encoded_key_package);
      bool found = jsonDecode(result)['found'];
      if (found) {
        Account.sharedInstance.me!.setSelectedKeyPackageEvent(keyPackageEvent);
        Account.sharedInstance.syncMe();
      } else {
        _createNewKeyPackage([]);
      }
    } else {
      // No 0xchat-lite key package found, create one automatically
      _createNewKeyPackage([]);
    }
  }

  Future<OKEvent> _createNewKeyPackage(List<String> relays) async {
    if (relays.isEmpty) {
      List<String> generalRelays = Account.sharedInstance.getCurrentCircleRelay();
      relays = generalRelays;
    }
    String result =
        await createKeyPackageForEvent(publicKey: pubkey, relay: relays, client: '0xchat-lite');
    ParsedKeyPackage parsedKeyPackage = parseKeyPackageString(result);
    Event event = await Nip104.encodeKeyPackageEvent(
        parsedKeyPackage.encodedKeyPackage, parsedKeyPackage.tags, pubkey, privkey);

    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(event, toRelays: relays, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        if (ok.status) {
          // Create KeyPackageEvent from the parsed data
          KeyPackageEvent keyPackageEvent = KeyPackageEvent(
            pubkey, 
            currentUnixTimestampSeconds(), 
            '', 
            '', 
            [], 
            relays, 
            '0xchat-lite', 
            parsedKeyPackage.encodedKeyPackage, 
            event.id
          );
          Account.sharedInstance.me!.setSelectedKeyPackageEvent(keyPackageEvent);
          Account.sharedInstance.syncMe();
        }
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<Map<String, String>> _getMembersKeyPackages(
    List<String> pubkeys, {
    Future<String?> Function(String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
    bool forceRefresh = false,
  }) async {
    Map<String, String> result = {};
    for (var pubkey in pubkeys) {
      // Get all key packages in one request
      Map<String, List<KeyPackageEvent>> categorizedKeyPackages =
          await getAllKeyPackagesFromRelay(pubkey, forceRefresh: forceRefresh);

      // First try to use 0xchat-lite key package
      List<KeyPackageEvent> oxchatLiteKeyPackages = categorizedKeyPackages['0xchat-lite'] ?? [];
      if (oxchatLiteKeyPackages.isNotEmpty) {
        result[pubkey] = oxchatLiteKeyPackages.first.encoded_key_package;
      } else {
        // No 0xchat-lite key package found, collect all other available key packages
        List<KeyPackageEvent> allOtherKeyPackages = [];
        for (var entry in categorizedKeyPackages.entries) {
          if (entry.key != '0xchat-lite') {
            allOtherKeyPackages.addAll(entry.value);
          }
        }
        
        if (allOtherKeyPackages.isNotEmpty) {
          // Found alternative key packages, use callback for selection
          String? selectedKeyPackage;
          if (onKeyPackageSelection != null) {
            selectedKeyPackage = await onKeyPackageSelection(pubkey, allOtherKeyPackages);
          } else {
            // Fallback to default selection (first available)
            selectedKeyPackage = allOtherKeyPackages.first.encoded_key_package;
          }

          if (selectedKeyPackage != null) {
            result[pubkey] = selectedKeyPackage;
          }
        } else {
          // No key package found at all
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
          if (user != null && user.selectedKeyPackageEvent != null) {
            result[pubkey] = user.selectedKeyPackageEvent!.encoded_key_package;
          }
        }
      }
    }
    return result;
  }

  /// Get all key packages from relay and return them categorized by client
  /// If forceRefresh is false and user has encodedKeyPackage, use cached data
  Future<Map<String, List<KeyPackageEvent>>> getAllKeyPackagesFromRelay(String pubkey,
      {bool forceRefresh = false}) async {
    Map<String, KeyPackageEvent> latestKeyPackages = {};

    // Get existing key packages from local storage first
    UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
    if (user != null && user.keyPackageEventList.isNotEmpty) {
      for (var keyPackageEvent in user.keyPackageEventList) {
        String client = (keyPackageEvent.client.isEmpty) ? 'unknown' : keyPackageEvent.client;
        if (!latestKeyPackages.containsKey(client) ||
            keyPackageEvent.createTime > latestKeyPackages[client]!.createTime) {
          latestKeyPackages[client] = keyPackageEvent;
        }
      }
    }

    // If forceRefresh is false and local data exists, return it directly
    if (!forceRefresh &&
        user != null &&
        user.selectedKeyPackageEvent != null) {
      String client = '0xchat-lite';
      if (!latestKeyPackages.containsKey(client)) {
        latestKeyPackages[client] = user.selectedKeyPackageEvent!;
      }
      // Convert to Map<String, List<KeyPackageEvent>>
      return latestKeyPackages.map((k, v) => MapEntry(k, [v]));
    }

    // Fetch from network
    Completer<Map<String, List<KeyPackageEvent>>> completer =
        Completer<Map<String, List<KeyPackageEvent>>>();
    List<Event> cachedEvents = [];
    Filter filter = Filter(kinds: [443], authors: [pubkey], limit: 30);
    
    Connect.sharedInstance.addSubscription([filter], eventCallBack: (event, relay) async {
      cachedEvents.add(event);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      for (Event event in cachedEvents) {
        try {
          KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);
          
          bool result = await _checkValidKeypackage(keyPackageEvent, client: null);
          
          if (result) {
            // Only keep the latest for each client
            String client = (keyPackageEvent.client.isEmpty) ? 'unknown' : keyPackageEvent.client;
            
            if (!latestKeyPackages.containsKey(client) ||
                keyPackageEvent.createTime > latestKeyPackages[client]!.createTime) {
              latestKeyPackages[client] = keyPackageEvent;
            }
            // Sync to local
            if (user != null && user.shouldUpdateKeyPackageEvent(keyPackageEvent)) {
              user.addKeyPackageEvent(keyPackageEvent);
              await Account.saveUserToDB(user);
            }
          }
          EventCache.sharedInstance.saveEventToDB(EventDBISAR(eventId: event.id));
        } catch (e) {
          continue;
        }
      }
      
      // Convert latestKeyPackages to the expected format
      Map<String, List<KeyPackageEvent>> result = {};
      for (var entry in latestKeyPackages.entries) {
        result[entry.key] = [entry.value];
      }
      
      completer.complete(result);
    });
    return completer.future;
  }

  /// Get key package from relay with optional client filter
  Future<String?> getKeyPackageFromRelay(String pubkey, {String? client}) async {
    // Use the new getAllKeyPackagesFromRelay method
    Map<String, List<KeyPackageEvent>> categorizedKeyPackages =
        await getAllKeyPackagesFromRelay(pubkey);

    String targetClient = client ?? '0xchat-lite';

    // First try to find a key package with the specified client
    List<KeyPackageEvent> targetClientKeyPackages = categorizedKeyPackages[targetClient] ?? [];
    if (targetClientKeyPackages.isNotEmpty) {
      return targetClientKeyPackages.first.encoded_key_package;
    }

    // If no matching client found, return null
    return null;
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

  Future<bool> _checkValidKeypackage(KeyPackageEvent keyPackageEvent, {String? client}) async {
    String extensions = jsonDecode(await getExtensions())['extensions'];
    String ciphersuite = jsonDecode(await getCiphersuite())['ciphersuite'];

    // Check basic validity (extensions and ciphersuite)
    bool basicValid = _areListsEqual(keyPackageEvent.extensions, [extensions]) &&
        ciphersuite == keyPackageEvent.ciphersuite;

    if (!basicValid) return false;

    // If client is specified, check if the key package has the correct client
    if (client != null) {
      return keyPackageEvent.client == client;
    }

    // If no client specified, accept any valid key package
    return true;
  }

  Future<GroupDBISAR?> createMLSGroup(
    String groupName,
    String groupDescription,
    List<String> members,
    List<String> admins,
    List<String> relays, {
    Future<String?> Function(String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
    bool forceRefresh = false,
  }) async {
    members.remove(pubkey);
    Map<String, String> membersKeyPackages = await _getMembersKeyPackages(members,
        onKeyPackageSelection: onKeyPackageSelection, forceRefresh: forceRefresh);
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
    sendWelcomeMessages(mlsGroup.serializedWelcomeMessage, mlsGroup.groupMembers, relays);
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
      List<String> userRelays = [...relays];
      if (!ChatCoreManager().isLite) {
        List<String>? dmRelays = memberDB?.dmRelayList;
        List<String>? inboxRelays = memberDB?.inboxRelayList;
        userRelays.addAll([...(dmRelays ?? []), ...(inboxRelays ?? [])]);
        await Connect.sharedInstance.connectRelays(userRelays, relayKind: RelayKind.temp);
      }
      Connect.sharedInstance
          .sendEvent(giftWrappedEvent, toRelays: userRelays, sendCallBack: (ok, relay) {});
    }
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

      if (commit != null) {
        var commit_message = List<int>.from(commit);
        String eventString = await createCommitMessageForGroup(
            nostrGroupId: groupValueNotifier.value.groupId,
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
        sendGroupMessage(groupValueNotifier.value.privateGroupId, MessageType.system, content,
            local: true);
        updateMLSGroupInfo(groupValueNotifier.value);
      }
      if (removed_members != null) {
        for (var member in removed_members) {
          if (member == pubkey) {
            content = 'You have been removed from the group';
            break;
          }
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(member);
          content = '${user?.name} $content ';
          content = '${content}left the group';
        }
        sendGroupMessage(groupValueNotifier.value.privateGroupId, MessageType.system, content,
            local: true);
        updateMLSGroupInfo(groupValueNotifier.value);
      }
    } catch (e) {
      print('receiveMLSGroupMessage error: $e');
    }
    if (innerEvent == null) return;
    _handleMLSGroupMessage(innerEvent, groupValueNotifier.value.privateGroupId, relay);
  }

  Future<void> _handleMLSGroupMessage(Event innerEvent, String privateGroupId, String relay) async {
    switch (innerEvent.kind) {
      case 9:
        _handleKind9MLSGroupMessage(innerEvent, privateGroupId);
        break;
      case 5:
        _handleKind5MLSGroupMessage(innerEvent);
        break;
      case 15:
      Contacts.sharedInstance
          .handlePrivateMessage(innerEvent, relay, privateGroupId: privateGroupId);
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

  Future<void> deleteMLSGroupMessages(List<String> messageIds, GroupDBISAR group) async {
    Event messageEvent = await Nip9.encode(messageIds, '', pubkey, privkey);
    OKEvent okEvent = await sendMessageToMLSGroup(group, messageEvent);
    if (okEvent.status) {
      await Messages.deleteMessagesFromDB(messageIds: messageIds);
    }
  }

  Future<GroupDBISAR> addMembersToMLSGroup(
    GroupDBISAR group,
    List<String> members, {
    Future<String?> Function(String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
    bool forceRefresh = false,
  }) async {
    if (group.mlsGroupId == null) return group;
    Map<String, String> membersKeyPackages = await _getMembersKeyPackages(members,
        onKeyPackageSelection: onKeyPackageSelection, forceRefresh: forceRefresh);
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
      await sendWelcomeMessages(welcome_message, members, []);
      updateMLSGroupInfo(group);
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
      myGroups.remove(group);
      groups.remove(group);
      updateMLSGroupSubscription();
      await syncMyGroupListToDB();
    }
    return okEvent;
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
