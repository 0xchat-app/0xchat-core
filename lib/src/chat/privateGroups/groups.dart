import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bitchat_core/bitchat_core.dart' as bitchat;
import 'package:chatcore/chat-core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart' hide Filter;
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

typedef GroupsUpdatedCallBack = void Function();
typedef GroupMessageCallBack = void Function(MessageDBISAR);
typedef GroupMessageUpdateCallBack = void Function(MessageDBISAR, String);
typedef SendMessageCallBack = void Function();

class Groups {
  /// singleton
  Groups._internal();
  factory Groups() => sharedInstance;
  static final Groups sharedInstance = Groups._internal();

  static final String identifier = 'Chat-Groups';
  // {relay1:subscriptionID1, relay2:subscriptionID2, ...}
  String groupMessageSubscription = '';

  // memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, ValueNotifier<GroupDBISAR>> groups = {};
  Map<String, ValueNotifier<GroupDBISAR>> myGroups = {};

  List<Event> mlsGroupEventCache = [];

  Map<String, List<String>> currentGroupRelays = {};
  Map<String, bool> offlineGroupMessageFinish = {};
  OfflineGroupMessageFinishCallBack? offlineGroupMessageFinishCallBack;

  GroupsUpdatedCallBack? myGroupsUpdatedCallBack;
  GroupMessageCallBack? groupMessageCallBack;
  GroupMessageUpdateCallBack? groupMessageUpdateCallBack;

  /// Helper method to update or create ValueNotifier for groups
  void updateOrCreateGroupNotifier(String groupId, GroupDBISAR groupDB) {
    if (groups.containsKey(groupId)) {
      groups[groupId]!.value = groupDB;
    } else {
      groups[groupId] = ValueNotifier(groupDB);
    }
  }

  /// Helper method to update or create ValueNotifier for myGroups
  void updateOrCreateMyGroupNotifier(String groupId, GroupDBISAR groupDB) {
    if (myGroups.containsKey(groupId)) {
      myGroups[groupId]!.value = groupDB;
    } else {
      myGroups[groupId] = ValueNotifier(groupDB);
    }
  }

  /// Initialize Groups with configuration (recommended)
  ///
  /// [config] Configuration containing all necessary initialization parameters
  Future<void> initWithConfig(ChatCoreInitConfig config) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    myGroupsUpdatedCallBack = config.groupsUpdatedCallBack;

    Account.sharedInstance.groupListUpdateCallback = () async {
      myGroups = _myGroups();
      myGroupsUpdatedCallBack?.call();
    };

    await _loadAllGroupsFromDB();
    
    // Initialize MLS with configuration parameters
    await initMLS(
      mlsPath: config.mlsPath,
      mlsIdentity: config.mlsIdentity,
      password: config.encryptionPassword,
    );

    // Initialize bitchat service, for testing
    await bitchat.BitchatService().initialize();
    
    // Simple bitchat test entry
    _initBitchatTest();
  }
  
  /// Generate Swift-compatible peer ID (4 random bytes as hex string)
  String _generateSwiftCompatiblePeerId() {
    final random = Random();
    final bytes = List<int>.generate(4, (_) => random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Initialize bitchat test functionality
  void _initBitchatTest() {
    print('🧪 Initializing Bitchat test...');
    
    final bitchatService = bitchat.BitchatService();
    final List<String> debugLogs = [];
    bool isConnected = false;
    
    // Helper function to add debug logs
    void addLog(String message) {
      final timestamp = DateTime.now().toString().substring(11, 19);
      final log = '[$timestamp] $message';
      debugLogs.add(log);
      print(log);
      if (debugLogs.length > 50) {
        debugLogs.removeAt(0);
      }
    }
    
    // Set up comprehensive bitchat monitoring
    bitchatService.messageStream.listen((message) {
      addLog('📨 Received message from ${message.senderNickname}: ${message.content}');
      addLog('   Type: ${message.type}, Channel: ${message.channel}, Private: ${message.isPrivateMessage}');
    });
    
    bitchatService.peerStream.listen((peer) {
      addLog('👥 Found peer: ${peer.nickname} (${peer.id})');
    });
    
    bitchatService.statusStream.listen((status) {
      isConnected = status == bitchat.BitchatStatus.running;
      addLog('📊 Status changed: $status');
    });
    
    bitchatService.logStream.listen((log) {
      addLog('🔧 $log');
    });
    
    // Start broadcasting after a short delay
    Future.delayed(Duration(seconds: 2), () async {
      try {
        addLog('🚀 Starting bitchat service...');
        await bitchatService.start(
          peerID: _generateSwiftCompatiblePeerId(),
          nickname: '0xChatUser',
        );
        addLog('✅ Service started successfully');
        
        // Test sending messages after delays
        _scheduleTestMessages(bitchatService, addLog);
        
      } catch (e) {
        addLog('❌ Failed to start service: $e');
      }
    });
    
    // Add periodic status check
    Timer.periodic(Duration(seconds: 10), (timer) {
      if (isConnected) {
        addLog('💓 Service heartbeat - Connected peers: ${bitchatService.discoveredPeers.length}');
        addLog('   Discovered channels: ${bitchatService.discoveredChannels.length}');
      }
    });
  }
  
  /// Schedule test messages with delays
  void _scheduleTestMessages(bitchat.BitchatService service, Function(String) addLog) {
    // Test channel message after 5 seconds
    Future.delayed(Duration(seconds: 5), () async {
      try {
        addLog('📢 Sending test channel message...');
        await service.sendChannelMessage('#test', 'Hello from 0xChat!');
        addLog('✅ Channel message sent successfully');
      } catch (e) {
        addLog('❌ Failed to send channel message: $e');
      }
    });
    
    // Test private message after 8 seconds
    Future.delayed(Duration(seconds: 8), () async {
      try {
        addLog('🔒 Sending test private message...');
        await service.sendPrivateMessage('fa9c7954', 'Hello from 0xChat private!');
        addLog('✅ Private message sent successfully');
      } catch (e) {
        addLog('❌ Failed to send private message: $e');
      }
    });
    
    // Test broadcast message after 10 seconds
    Future.delayed(Duration(seconds: 10), () async {
      try {
        addLog('📢 Sending test broadcast message...');
        await service.sendBroadcastMessage('Hello everyone from 0xChat!');
        addLog('✅ Broadcast message sent successfully');
      } catch (e) {
        addLog('❌ Failed to send broadcast message: $e');
      }
    });
    
    // Test announce message after 12 seconds
    Future.delayed(Duration(seconds: 12), () async {
      try {
        addLog('📢 Sending announce message...');
        await service.sendAnnounceMessage();
        addLog('✅ Announce message sent successfully');
      } catch (e) {
        addLog('❌ Failed to send announce message: $e');
      }
    });
    
    // Test joining channel after 15 seconds
    Future.delayed(Duration(seconds: 15), () async {
      try {
        addLog('➕ Joining test channel...');
        await service.joinChannel('#test');
        addLog('✅ Channel join successful');
      } catch (e) {
        addLog('❌ Failed to join channel: $e');
      }
    });
    
    // Test leaving channel after 18 seconds
    Future.delayed(Duration(seconds: 18), () async {
      try {
        addLog('➖ Leaving test channel...');
        await service.leaveChannel('#test');
        addLog('✅ Channel leave successful');
      } catch (e) {
        addLog('❌ Failed to leave channel: $e');
      }
    });
  }
  
  /// Manual trigger for bitchat testing
  /// Call this method to manually test bitchat functionality
  Future<void> testBitchatManually() async {
    print('🧪 Manual Bitchat Test Triggered');
    
    final bitchatService = bitchat.BitchatService();
    
    try {
      // Initialize service
      print('📋 Initializing bitchat service...');
      await bitchatService.initialize();
      print('✅ Initialization successful');
      
      // Start service
      print('🚀 Starting bitchat service...');
      await bitchatService.start(
        peerID: _generateSwiftCompatiblePeerId(),
        nickname: '0xChatUser',
      );
      print('✅ Service started successfully');
      
      // Wait a bit for connection
      await Future.delayed(Duration(seconds: 3));
      
      // Test sending messages
      print('📢 Testing channel message...');
      await bitchatService.sendChannelMessage('#test', 'Manual test from 0xChat!');
      print('✅ Channel message sent');
      
      print('🔒 Testing private message...');
      await bitchatService.sendPrivateMessage('fa9c7954', 'Manual private test from 0xChat!');
      print('✅ Private message sent');
      
      print('📢 Testing broadcast message...');
      await bitchatService.sendBroadcastMessage('Hello everyone from 0xChat!');
      print('✅ Broadcast message sent');
      
      print('📢 Testing announce message...');
      await bitchatService.sendAnnounceMessage();
      print('✅ Announce message sent');
      
      // Show current status
      print('📊 Current status:');
      print('   Connected peers: ${bitchatService.discoveredPeers.length}');
      print('   Discovered channels: ${bitchatService.discoveredChannels.length}');
      print('   Service running: ${bitchatService.isRunning}');
      
      print('🎉 Manual test completed successfully!');
      
    } catch (e) {
      print('❌ Manual test failed: $e');
    }
  }

  /// Initialize Groups (legacy method)
  ///
  /// [callBack] Groups update callback
  Future<void> init({GroupsUpdatedCallBack? callBack}) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    myGroupsUpdatedCallBack = callBack;

    Account.sharedInstance.groupListUpdateCallback = () async {
      myGroups = _myGroups();
      myGroupsUpdatedCallBack?.call();
    };

    await _loadAllGroupsFromDB();
    await initMLS();
  }

  /// 0, not in the group, 1, in the group & not joined, 2. joined
  int getInGroupStatus(String groupId) {
    return !checkInGroup(groupId)
        ? 0
        : !checkInMyGroupList(groupId)
            ? 1
            : 2;
  }

  bool checkInGroup(String groupId) {
    return groups[groupId]?.value.members?.contains(pubkey) == true;
  }

  bool checkInMyGroupList(String groupId) {
    return myGroups.containsKey(groupId);
  }

  String _shortGroupId(String groupId) {
    final String start = groupId.substring(0, 6);
    final String end = groupId.substring(groupId.length - 6);
    return '$start:$end';
  }

  Future<void> _loadAllGroupsFromDB() async {
    final isar = DBISAR.sharedInstance.isar;
    List<GroupDBISAR> maps = isar.groupDBISARs.where().findAll();
    for (GroupDBISAR e in maps) {
      GroupDBISAR groupDB = e.withGrowableLevels();
      if (groupDB.name.isEmpty) groupDB.name = _shortGroupId(groupDB.privateGroupId);
      updateOrCreateGroupNotifier(groupDB.privateGroupId, groupDB);
    }
    myGroups = _myGroups();
  }

  Map<String, ValueNotifier<GroupDBISAR>> _myGroups() {
    Map<String, ValueNotifier<GroupDBISAR>> result = {};
    UserDBISAR? me = Account.sharedInstance.me;
    if (me != null && me.groupsList != null && me.groupsList!.isNotEmpty) {
      List<String> groupList = me.groupsList!;
      for (String groupId in groupList) {
        if (!groups.containsKey(groupId)) {
          // Create new ValueNotifier for new group
          groups[groupId] = ValueNotifier(GroupDBISAR(groupId: groupId));
        }
        result[groupId] = groups[groupId]!;
      }
    }
    return result;
  }

  Future<void> _handleGroupCreation(Event event) async {
    if (!groups.containsKey(event.id) ||
        (groups.containsKey(event.id) && groups[event.id]?.value.owner != event.pubkey)) {
      Channel group = Nip28.getChannelCreation(event);
      GroupDBISAR groupDB = _channelToGroupDB(group, event.createdAt);
      await syncGroupToDB(groupDB);
    }
  }

  Future<void> _handleGroupMetadata(Event event) async {
    Channel group = Nip28.getChannelMetadata(event);
    if (groups.containsKey(group.channelId) &&
        groups[group.channelId]?.value.owner.isNotEmpty == true &&
        groups[group.channelId]?.value.owner != group.owner) {
      return;
    }
    GroupDBISAR groupDB = _channelToGroupDB(group, event.createdAt);
    await syncGroupToDB(groupDB);
  }

  Future<void> _handleGroupMessage(Event event) async {
    ChannelMessage groupMessage = Nip28.getChannelMessage(event);
    String subType =
        groupMessage.actionsType != null ? Nip28.actionToType(groupMessage.actionsType!) : '';
    GroupDBISAR? groupDB = myGroups[groupMessage.channelId]?.value;
    if (groupDB == null) return;
    switch (subType) {
      case 'invite':
        break;
      case 'request':
        if (groupDB.owner != pubkey && groupDB.members?.contains(groupMessage.sender) == false) {
          return;
        }
        break;
      case 'add':
      case 'remove':
      case 'updateName':
      case 'updatePinned':
        if (groupDB.owner != groupMessage.sender) return;
        break;
      case 'join':
      case 'leave':
      default:
        if (groupDB.members?.contains(groupMessage.sender) == false) return;
    }

    MessageDBISAR messageDB = MessageDBISAR(
        messageId: event.id,
        sender: groupMessage.sender,
        receiver: '',
        groupId: groupMessage.channelId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: groupMessage.content,
        replyId: groupMessage.thread.reply?.eventId ?? '',
        createTime: event.createdAt,
        plaintEvent: jsonEncode(event),
        chatType: 1,
        subType: subType);
    var map = await MessageDBISAR.decodeContent(groupMessage.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    messageDB.decryptSecret = map['decryptSecret'];
    await Messages.saveMessageToDB(messageDB);
    groupMessageCallBack?.call(messageDB);
  }

  Future<void> receiveGroupEvents(Event event, String relay, String giftWrappedEventId) async {
    MessageDBISAR messageDB = MessageDBISAR(messageId: giftWrappedEventId);
    await Messages.saveMessageToDB(messageDB);
    switch (event.kind) {
      case 40:
        _handleGroupCreation(event);
        break;
      case 41:
        _handleGroupMetadata(event);
        break;
      case 42:
        _handleGroupMessage(event);
        break;
      default:
        LogUtils.v(() => 'unknown event: ${event.kind}');
        break;
    }
  }

  GroupDBISAR _channelToGroupDB(Channel group, int updateTime) {
    GroupDBISAR? groupDB = groups[group.channelId]?.value;
    if (groupDB != null && groupDB.updateTime < updateTime) {
      groupDB.name = group.name;
      groupDB.about = group.about;
      groupDB.picture = group.picture;
      groupDB.pinned = [group.pinned ?? ''];
      groupDB.owner = group.owner;
      groupDB.relay = group.relay;
      groupDB.members = group.members;
      groupDB.updateTime = updateTime;
    }
    groupDB ??= GroupDBISAR(
        groupId: group.channelId,
        owner: group.owner,
        name: group.name,
        members: group.members,
        pinned: [group.pinned ?? ''],
        about: group.about,
        picture: group.picture,
        relay: group.relay,
        updateTime: updateTime);
    return groupDB;
  }

  Future<void> syncGroupToDB(GroupDBISAR groupDB) async {
    String groupId = groupDB.privateGroupId;

    groups[groupId]?.value = groupDB;
    groups[groupId]?.notifyListeners();
    groups.putIfAbsent(groupId, () => ValueNotifier(groupDB));

    if (myGroups.containsKey(groupId)) {
      myGroups[groupId]?.value = groupDB;
    }

    await saveGroupToDB(groupDB);
  }

  static Future<void> saveGroupToDB(GroupDBISAR groupDB) async {
    await DBISAR.sharedInstance.saveToDB(groupDB);
  }

  Future<void> syncMyGroupListToDB() async {
    List<String> list = myGroups.keys.toList();
    UserDBISAR? me = Account.sharedInstance.me;
    me!.groupsList = list;
    await Account.sharedInstance.syncMe();
  }

  ValueNotifier<GroupDBISAR> getPrivateGroupNotifier(String groupId) {
    if (groups.containsKey(groupId)) return groups[groupId]!;
    
    // Create new ValueNotifier for new group
    groups[groupId] = ValueNotifier(GroupDBISAR(groupId: groupId));
    return groups[groupId]!;
  }

  Future<OKEvent> syncMyGroupListToRelay() async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<String> list = myGroups.keys.toList();
    Event event = await Nip51.createCategorizedBookmarks(identifier, [], list, privkey, pubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (ok.status) {
        Account.sharedInstance.me!.lastGroupsListUpdatedTime = event.createdAt;
        syncMyGroupListToDB();
      }
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  List<GroupDBISAR>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<GroupDBISAR> filteredFriends = myGroups.values
          .where((channel) =>
              regex.hasMatch(channel.value.name) || regex.hasMatch(channel.value.about ?? ''))
          .map((e) => e.value)
          .toList();
      return filteredFriends;
    }
    return null;
  }

  List<String> getAllUnMuteGroups() {
    return myGroups.entries.where((e) => e.value.value.mute == false).map((e) => e.key).toList();
  }

  Future<Event?> getSendGroupMessageEvent(String groupId, MessageType type, String content,
      {String? source,
      String? groupRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay,
      String? actionsType,
      String? decryptSecret}) async {
    Event event = await Nip28.sendChannelMessage(
        groupId, MessageDBISAR.getContent(type, content, source), pubkey, privkey,
        channelRelay: groupRelay,
        replyMessage: replyMessage,
        replyMessageRelay: replyMessageRelay,
        replyUser: replyUser,
        replyUserRelay: replyUserRelay,
        subContent: MessageDBISAR.getSubContent(type, content),
        actionsType: actionsType);
    return event;
  }

  Future<OKEvent> sendGroupMessage(String privateGroupId, MessageType type, String content,
      {String? source,
      String? groupRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay,
      Event? event,
      String? actionsType,
      bool local = false,
      List<String>? inviteUsers,
      String? decryptSecret}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    GroupDBISAR? groupDB = groups[privateGroupId]?.value;
    if (groupDB == null) return OKEvent(privateGroupId, false, 'group not exit');
    event ??= await Nip28.sendChannelMessage(
        groupDB.groupId, MessageDBISAR.getContent(type, content, source), pubkey, privkey,
        channelRelay: groupRelay,
        replyMessage: replyMessage,
        replyMessageRelay: replyMessageRelay,
        replyUser: replyUser,
        replyUserRelay: replyUserRelay,
        subContent: MessageDBISAR.getSubContent(type, content),
        actionsType: actionsType);

    MessageDBISAR messageDB = MessageDBISAR(
        messageId: event.id,
        sender: event.pubkey,
        receiver: '',
        groupId: privateGroupId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        replyId: replyMessage ?? '',
        content: event.content,
        decryptContent: content,
        type: MessageDBISAR.messageTypeToString(type),
        createTime: event.createdAt,
        status: 0,
        plaintEvent: jsonEncode(event),
        chatType: 1,
        subType: actionsType ?? '',
        decryptSecret: decryptSecret);
    groupMessageCallBack?.call(messageDB);
    await Messages.saveMessageToDB(messageDB);

    if (local) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      OKEvent ok;
      switch (actionsType) {
        case 'invite':
          ok = await sendMessageEvent(inviteUsers, event);
          break;
        case 'request':
          ok = await sendToOwner(privateGroupId, event);
          break;
        case 'join':
        case 'add':
        case 'leave':
        case 'remove':
        case 'updateName':
        case 'updatePinned':
        default:
          ok = await sendToGroup(privateGroupId, event);
      }
      messageDB.status = ok.status ? 1 : 2;
      await Messages.saveMessageToDB(messageDB, conflictAlgorithm: ConflictAlgorithm.replace);
      if (!completer.isCompleted) completer.complete(ok);
    }

    return completer.future;
  }

  Future<OKEvent> sendToGroup(String privateGroupId, Event event) async {
    GroupDBISAR? groupDB = groups[privateGroupId]?.value;
    if (groupDB != null) {
      if (groupDB.isMLSGroup) {
        return await sendMessageToMLSGroup(groupDB, event);
      } else {
        return await sendMessageEvent(groupDB.members, event);
      }
    } else {
      return OKEvent(event.id, false, 'group not found');
    }
  }

  Future<OKEvent> sendToOwner(String groupId, Event event) async {
    GroupDBISAR? groupDB = groups[groupId]?.value;
    if (groupDB != null) {
      return await sendMessageEvent([groupDB.owner], event);
    } else {
      return OKEvent(event.id, false, 'group not found');
    }
  }

  Future<OKEvent> sendMessageEvent(List<String>? receivers, Event event,
      {SendMessageCallBack? sendMessageCallBack}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (receivers != null) {
      await Future.forEach(receivers, (receiver) async {
        if (receiver.isNotEmpty) {
          Event? e = await Contacts.sharedInstance.encodeNip17Event(event, receiver);
          if (e != null) {
            UserDBISAR? user = await Account.sharedInstance.getUserInfo(receiver);
            List<String> relays = [
              ...user?.inboxRelayList ?? [],
              ...user?.dmRelayList ?? [],
            ];
            bool hasConnected = false;
            for (var relay in relays) {
              if (Connect.sharedInstance.webSockets[relay]?.connectStatus == 1) {
                hasConnected = true;
                break;
              }
            }
            if (!hasConnected) {
              await Connect.sharedInstance.connectRelays(relays, relayKind: RelayKind.temp);
              for (var relay in relays) {
                if (Connect.sharedInstance.webSockets[relay]?.connectStatus == 1) {
                  hasConnected = true;
                  break;
                }
              }
              if (!hasConnected) {
                relays = [...(Account.sharedInstance.me?.relayList ?? [])];
              }
            }
            Connect.sharedInstance.sendEvent(e, toRelays: relays);
            sendMessageCallBack?.call();
          }
        }
      });
      if (!completer.isCompleted) {
        EventCache.sharedInstance.receiveEvent(event, '');
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, false, 'no receivers'));
      }
    }
    return completer.future;
  }

  static Future<void> encodeNip17InIsolate(Map<String, dynamic> params) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(params['token']);
    Event event = await Event.fromJson(params['event']);
    String receiver = params['receiver'] ?? '';
    Event sealedEvent =
        await Nip17.encode(event, receiver, params['pubkey'] ?? '', params['privkey'] ?? '');
    params['sendPort'].send({'receiver': receiver, 'event': sealedEvent.toJson()});
  }

  static String encodeGroup(String groupId, List<String>? relays, String? author) {
    String nevent = Nip19.encodeShareableEntity('nevent', groupId, relays, author, null);
    return Nip21.encode(nevent);
  }

  static Map<String, dynamic>? decodeGroup(String encodedGroup) {
    if (encodedGroup.startsWith('nostr:')) {
      encodedGroup = Nip21.decode(encodedGroup)!;
    }
    if (encodedGroup.startsWith('nevent')) {
      Map result = Nip19.decodeShareableEntity(encodedGroup);
      if (result['prefix'] == 'nevent') {
        return {
          'groupId': result['special'],
          'relays': result['relays'],
          'author': result['author']
        };
      }
    } else if (encodedGroup.startsWith('note')) {
      return {'groupId': Nip19.decodeNote(encodedGroup), 'relays': [], 'author': null};
    }
    return null;
  }
}
