import 'dart:async';
import 'dart:convert';
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
      if (status == 1) {
        _loadMyGroupsFromRelay(relay: relay);
      }
    });
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
    if (!groups.containsKey(event.id)) {
      Channel group = Nip28.getChannelCreation(event);
      GroupDB groupDB = _channelToGroupDB(group);
      await _syncGroupToDB(groupDB);
    }
  }

  Future<void> _handleGroupMetadata(event) async {
    Channel group = Nip28.getChannelMetadata(event);
    if (groups.containsKey(group.channelId)) {
      GroupDB groupDB = _channelToGroupDB(group);
      await _syncGroupToDB(groupDB);
    }
  }

  Future<void> _handleGroupMessage(event) async {
    ChannelMessage groupMessage = Nip28.getChannelMessage(event);
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
        plaintEvent: jsonEncode(event));
    var map = MessageDB.decodeContent(messageDB.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];

    int status = await Messages.saveMessageToDB(messageDB);
    if (status != 0) {
      groupMessageCallBack?.call(messageDB);
    }
  }

  Future<void> receiveGroupEvents(Event event, String relay) async {
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

  Future<void> _syncGroupToDB(GroupDB groupDB) async {
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

  Future<void> _syncMyGroupListToRelay({OKCallBack? callBack}) async {
    List<String> list = myGroups.keys.toList();
    Event event = await Nip51.createCategorizedBookmarks(
        identifier, list, [], privkey, pubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: callBack);
    _syncMyGroupListToDB();
  }

  Future<GroupDB?> createGroup(String name, List<String> members,
      {String? about,
      String? picture,
      String? relay,
      OKCallBack? callBack}) async {
    Completer<GroupDB?> completer = Completer<GroupDB?>();
    Event event =
        Nip28.createChannel(name, about ?? '', picture ?? '', {}, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      if (ok.status == true) {
        // update channel
        GroupDB groupDB = GroupDB(
            groupId: event.id,
            updateTime: event.createdAt,
            owner: pubkey,
            name: name,
            about: about,
            picture: picture,
            relay: relay,
            members: members);

        await updateGroup(groupDB, callBack: (OKEvent ok, String relay) async {
          if (ok.status == true) {
            myGroups[groupDB.groupId] = groupDB;
            // update my channel list
            await _syncMyGroupListToRelay();
            myGroupsUpdatedCallBack?.call();
            if (!completer.isCompleted) completer.complete(groupDB);
          } else {
            if (!completer.isCompleted) completer.complete(null);
          }
        });
      } else {
        if (!completer.isCompleted) completer.complete(null);
      }
    });

    return completer.future;
  }

  Future<OKEvent> updateGroup(GroupDB groupDB, {OKCallBack? callBack}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip28.setChannelMetaData(
        groupDB.name,
        groupDB.about!,
        groupDB.picture!,
        groupDB.pinned,
        groupDB.members,
        null,
        groupDB.groupId,
        groupDB.relay ?? '',
        privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      if (ok.status) {
        await _syncGroupToDB(groupDB);
      }
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
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
      bool local = false}) async {
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
        plaintEvent: jsonEncode(event));
    groupMessageCallBack?.call(messageDB);
    await Messages.saveMessageToDB(messageDB);

    if (local) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
        messageDB.status = ok.status ? 1 : 2;
        await Messages.saveMessageToDB(messageDB,
            conflictAlgorithm: ConflictAlgorithm.replace);
        if (!completer.isCompleted) completer.complete(ok);
      });
    }

    return completer.future;
  }

  Future<OKEvent> joinGroup(String groupId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (groups.containsKey(groupId)) {
      myGroups[groupId] = groups[groupId]!;
      _syncMyGroupListToRelay(callBack: (ok, relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
    } else {
      OKEvent okEvent = OKEvent(groupId, false, 'group not found');
      if (!completer.isCompleted) completer.complete(okEvent);
    }
    return completer.future;
  }

  Future<OKEvent> leaveGroup(String groupId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    myGroups.remove(groupId);
    _syncMyGroupListToRelay(callBack: (ok, relay) {
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

  Future<void> muteGroup(String groupId) async {
    _setMuteGroup(groupId, true);
  }

  Future<void> unMuteGroup(String groupId) async {
    _setMuteGroup(groupId, false);
  }

  List<String> getAllUnMuteGroups() {
    return myGroups.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.key)
        .toList();
  }

  Future<void> _setMuteGroup(String groupId, bool mute) async {
    if (myGroups.containsKey(groupId)) {
      GroupDB groupDB = myGroups[groupId]!;
      groupDB.mute = mute;
      await _syncGroupToDB(groupDB);
    }
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
