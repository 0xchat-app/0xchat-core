import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef GroupsUpdatedCallBack = void Function();
typedef GroupMessageCallBack = void Function(MessageDB);

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
  Map<String, GroupDB> groups = {};
  Map<String, GroupDB> myGroups = {};

  GroupsUpdatedCallBack? myGroupsUpdatedCallBack;
  GroupMessageCallBack? groupMessageCallBack;

  Future<void> init({GroupsUpdatedCallBack? callBack}) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    myGroupsUpdatedCallBack = callBack;
    await _loadAllGroupsFromDB();
    _loadMyGroupsFromRelay();

    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        _loadMyGroupsFromRelay(relay: relay);
      }
    });
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
    return groups[groupId]?.members?.contains(pubkey) == true;
  }

  bool checkInMyGroupList(String groupId) {
    return myGroups.containsKey(groupId);
  }

  Future<void> _loadAllGroupsFromDB() async {
    List<Object?> maps = await DB.sharedInstance.objects<GroupDB>();
    groups = {for (var groupDb in maps) (groupDb as GroupDB).groupId: groupDb};
    myGroups = _myGroups();
  }

  Map<String, GroupDB> _myGroups() {
    Map<String, GroupDB> result = {};
    UserDB? me = Account.sharedInstance.me;
    if (me != null && me.groupsList != null && me.groupsList!.isNotEmpty) {
      List<String> groupList = me.groupsList!;
      for (String groupId in groupList) {
        if (!groups.containsKey(groupId)) {
          groups[groupId] = GroupDB(groupId: groupId);
        }
        result[groupId] = groups[groupId]!;
      }
    }
    return result;
  }

  Future<void> _handleGroupCreation(event) async {
    if (!groups.containsKey(event.id) ||
        (groups.containsKey(event.id) &&
            groups[event.id]?.owner != event.pubkey)) {
      Channel group = Nip28.getChannelCreation(event);
      GroupDB groupDB = _channelToGroupDB(group);
      await syncGroupToDB(groupDB);
    }
  }

  Future<void> _handleGroupMetadata(event) async {
    Channel group = Nip28.getChannelMetadata(event);
    if (groups.containsKey(group.channelId) &&
        groups[group.channelId]?.owner != group.owner) {
      /// fake event
      return;
    }
    GroupDB groupDB = _channelToGroupDB(group);
    await syncGroupToDB(groupDB);
  }

  Future<void> _handleGroupMessage(Event event) async {
    ChannelMessage groupMessage = Nip28.getChannelMessage(event);
    String subType = groupMessage.actionsType != null
        ? Nip28.actionToType(groupMessage.actionsType!)
        : '';
    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: groupMessage.sender,
        receiver: '',
        groupId: groupMessage.channelId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: event.content,
        replyId: groupMessage.thread.reply?.eventId ?? '',
        createTime: event.createdAt,
        plaintEvent: jsonEncode(event),
        chatType: 1,
        subType: subType);
    var map = MessageDB.decodeContent(groupMessage.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];

    int status = await Messages.saveMessageToDB(messageDB);
    if (status != 0 &&
        myGroups.containsKey(groupMessage.channelId) &&
        messageDB.subType != 'request') {
      groupMessageCallBack?.call(messageDB);
    }
  }

  Future<void> receiveGroupEvents(
      Event event, String relay, String giftWrappedEventId) async {
    MessageDB messageDB = MessageDB(messageId: giftWrappedEventId);
    int result = await DB.sharedInstance.insert<MessageDB>(messageDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (result != 0) {
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
          print('unknown event: ${event.kind}');
          break;
      }
    }
  }

  Future<void> _loadMyGroupsFromRelay({String? relay}) async {
    Completer<void> completer = Completer<void>();
    Filter f = Filter(
        kinds: [30001],
        d: [identifier],
        authors: [pubkey],
        limit: 1,
        since: Account.sharedInstance.me!.lastGroupsListUpdatedTime + 1);

    Map<String, List<Filter>> subscriptions = {};
    if (relay == null) {
      for (var r in Connect.sharedInstance.relays()) {
        subscriptions[r] = [f];
      }
    } else {
      subscriptions[relay] = [f];
    }

    Event? lastEvent;
    int lastEventTime = 0;
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
      if (event.content.isNotEmpty && lastEventTime < event.createdAt) {
        lastEventTime = event.createdAt;
        lastEvent = event;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty) {
        if (lastEvent != null) {
          Lists result = await Nip51.getLists(lastEvent!, privkey);
          UserDB? me = Account.sharedInstance.me;
          me!.lastGroupsListUpdatedTime = lastEvent!.createdAt;
          me.groupsList = result.bookmarks;
          await Account.sharedInstance.syncMe();
          myGroups = _myGroups();
        }
        if (!completer.isCompleted) completer.complete();
        myGroupsUpdatedCallBack?.call();
      }
    });
    return completer.future;
  }

  GroupDB _channelToGroupDB(Channel group) {
    GroupDB? groupDB = groups[group.channelId];
    if (groupDB != null) {
      groupDB.name = group.name;
      groupDB.about = group.about;
      groupDB.picture = group.picture;
      groupDB.pinned = [group.pinned ?? ''];
      groupDB.owner = group.owner;
      groupDB.relay = group.relay;
      groupDB.members = group.members;
    } else {
      groupDB = GroupDB(
          groupId: group.channelId,
          owner: group.owner,
          name: group.name,
          members: group.members,
          pinned: [group.pinned ?? ''],
          about: group.about,
          picture: group.picture,
          relay: group.relay);
    }
    return groupDB;
  }

  Future<void> syncGroupToDB(GroupDB groupDB) async {
    await DB.sharedInstance.insert<GroupDB>(groupDB);
    groups[groupDB.groupId] = groupDB;
    if (myGroups.containsKey(groupDB.groupId)) {
      myGroups[groupDB.groupId] = groupDB;
    }
  }

  Future<void> _syncMyGroupListToDB() async {
    List<String> list = myGroups.keys.toList();
    UserDB? me = Account.sharedInstance.me;
    me!.groupsList = list;
    await DB.sharedInstance.insert<UserDB>(me);
  }

  Future<OKEvent> syncMyGroupListToRelay() async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<String> list = myGroups.keys.toList();
    Event event = await Nip51.createCategorizedBookmarks(
        identifier, list, [], privkey, pubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (ok.status) _syncMyGroupListToDB();
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  List<GroupDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<GroupDB> filteredFriends = myGroups.values
          .where((channel) =>
              regex.hasMatch(channel.name) || regex.hasMatch(channel.about!))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  List<String> getAllUnMuteGroups() {
    return myGroups.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.key)
        .toList();
  }

  Event? getSendGroupMessageEvent(
      String groupId, MessageType type, String content,
      {String? groupRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay,
      String? actionsType}) {
    Event event = Nip28.sendChannelMessage(
        groupId, MessageDB.getContent(type, content), privkey,
        channelRelay: groupRelay,
        replyMessage: replyMessage,
        replyMessageRelay: replyMessageRelay,
        replyUser: replyUser,
        replyUserRelay: replyUserRelay,
        subContent: MessageDB.getSubContent(type, content),
        actionsType: actionsType);
    return event;
  }

  Future<OKEvent> sendGroupMessage(
      String groupId, MessageType type, String content,
      {String? groupRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay,
      Event? event,
      String? actionsType,
      bool local = false,
      List<String>? inviteUsers}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    event ??= Nip28.sendChannelMessage(
        groupId, MessageDB.getContent(type, content), privkey,
        channelRelay: groupRelay,
        replyMessage: replyMessage,
        replyMessageRelay: replyMessageRelay,
        replyUser: replyUser,
        replyUserRelay: replyUserRelay,
        subContent: MessageDB.getSubContent(type, content),
        actionsType: actionsType);

    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: event.pubkey,
        receiver: '',
        groupId: groupId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        replyId: replyMessage ?? '',
        content: event.content,
        decryptContent: content,
        type: MessageDB.messageTypeToString(type),
        createTime: event.createdAt,
        status: 0,
        plaintEvent: jsonEncode(event),
        chatType: 1,
        subType: actionsType ?? '');
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
          ok = await sendToOwner(groupId, event);
          break;
        case 'join':
        case 'add':
        case 'leave':
        case 'remove':
        case 'updateName':
        case 'updatePinned':
        default:
          ok = await sendToGroup(groupId, event);
      }
      messageDB.status = ok.status ? 1 : 2;
      await Messages.saveMessageToDB(messageDB,
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (!completer.isCompleted) completer.complete(ok);
    }

    return completer.future;
  }

  Future<OKEvent> sendToGroup(String groupId, Event event) async {
    GroupDB? groupDB = groups[groupId];
    if (groupDB != null) {
      return await sendMessageEvent(groupDB.members, event);
    } else {
      return OKEvent(event.id, false, 'group not found');
    }
  }

  Future<OKEvent> sendToOwner(String groupId, Event event) async {
    GroupDB? groupDB = groups[groupId];
    if (groupDB != null) {
      return await sendMessageEvent([groupDB.owner], event);
    } else {
      return OKEvent(event.id, false, 'group not found');
    }
  }

  Future<OKEvent> sendMessageEvent(List<String>? receivers, Event event) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (receivers != null) {
      final receivePort = ReceivePort();
      receivePort.listen((message) {
        Connect.sharedInstance.sendEvent(Event.fromJson(message));
      });
      for (var receiver in receivers) {
        Map<String, dynamic> map = {
          'event': event.toJson(),
          'receiver': receiver,
          'privkey': privkey,
          'sendPort': receivePort.sendPort
        };
        Isolate.spawn(encodeNip24InIsolate, map);
      }
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, false, 'no members in the group'));
      }
    }
    return completer.future;
  }

  static Future<void> encodeNip24InIsolate(Map<String, dynamic> params) async {
    Event event = Event.fromJson(params['event']);
    String receiver = params['receiver'] ?? '';
    Event sealedEvent =
        await Nip24.encode(event, receiver, params['privkey'] ?? '');
    params['sendPort'].send(sealedEvent.toJson());
  }

  static String encodeGroup(
      String groupId, List<String>? relays, String? author) {
    String nevent =
        Nip19.encodeShareableEntity('nevent', groupId, relays, author, null);
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
      return {
        'groupId': Nip19.decodeNote(encodedGroup),
        'relays': [],
        'author': null
      };
    }
    return null;
  }
}
