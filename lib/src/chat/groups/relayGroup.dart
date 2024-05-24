import 'dart:async';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class RelayGroup {
  /// singleton
  RelayGroup._internal();
  factory RelayGroup() => sharedInstance;
  static final RelayGroup sharedInstance = RelayGroup._internal();

  static final String identifier = 'Chat-Relay-Groups';
  // {relay1:subscriptionID1, relay2:subscriptionID2, ...}
  String groupMessageSubscription = '';

  // memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, RelayGroupDB> groups = {};
  Map<String, RelayGroupDB> myGroups = {};
  Map<String, bool> offlineGroupMessageFinish = {};
  List<String> groupRelays = [];

  GroupsUpdatedCallBack? myGroupsUpdatedCallBack;
  GroupMessageCallBack? groupMessageCallBack;

  Future<void> init({GroupsUpdatedCallBack? callBack}) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    myGroupsUpdatedCallBack = callBack;
    await _loadAllGroupsFromDB();
    _updateGroupSubscription();
    _loadMyGroupsFromRelay();
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1 &&
          Account.sharedInstance.me != null &&
          groupRelays.contains(relay)) {
        await _loadMyGroupsFromRelay(relay: relay);
        _updateGroupSubscription(relay: relay);
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
    List<Object?> maps = await DB.sharedInstance.objects<RelayGroupDB>();
    for (var e in maps) {
      RelayGroupDB groupDB = e as RelayGroupDB;
      if (groupDB.name.isEmpty) groupDB.name = groupDB.groupId;
      groups[groupDB.groupId] = groupDB;
    }
    myGroups = _myGroups();
  }

  Map<String, RelayGroupDB> _myGroups() {
    Map<String, RelayGroupDB> result = {};
    UserDB? me = Account.sharedInstance.me;
    if (me != null &&
        me.relayGroupsList != null &&
        me.relayGroupsList!.isNotEmpty) {
      List<String> groupList = me.relayGroupsList!;
      groupRelays.clear();
      for (String id in groupList) {
        if (!groups.containsKey(id)) {
          groups[id] = RelayGroupDB(groupId: id);
        }
        result[id] = groups[id]!;
        groupRelays.add(groups[id]!.relay);
      }
      connectToRelays(groupRelays);
    }
    return result;
  }

  void connectToRelays(List<String> groupRelays) {
    for (var relay in groupRelays) {
      Connect.sharedInstance.connect(relay, type: 1);
    }
  }

  void _updateGroupSubscription({String? relay}) {
    if (myGroups.isEmpty) return;
    if (groupMessageSubscription.isNotEmpty) {
      Connect.sharedInstance
          .closeRequests(groupMessageSubscription, relay: relay);
    }

    Map<String, List<Filter>> subscriptions = {};

    if (relay == null) {
      for (String relayURL in groupRelays) {
        int groupMessageUntil =
            Relays.sharedInstance.getGroupMessageUntil(relayURL);
        Filter f = Filter(
            h: myGroups.keys.toList(),
            kinds: [
              7,
              9,
              10,
              11,
              12,
              9000,
              9001,
              9002,
              9003,
              9004,
              9005,
              9006,
              9021,
              9735
            ],
            limit: 1000,
            since: (groupMessageUntil + 1));
        subscriptions[relayURL] = [f];
      }
    } else {
      int groupMessageUntil = Relays.sharedInstance.getGroupMessageUntil(relay);
      Filter f = Filter(
          h: myGroups.keys.toList(),
          kinds: [
            7,
            9,
            10,
            11,
            12,
            9000,
            9001,
            9002,
            9003,
            9004,
            9005,
            9006,
            9021,
            9735
          ],
          limit: 1000,
          since: (groupMessageUntil + 1));
      subscriptions[relay] = [f];
    }

    groupMessageSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
      switch (event.kind) {
        case 7:
          handleGroupReaction(event, relay);
          break;
        case 9:
        case 10:
          handleGroupMessage(event, relay);
          break;
        case 11:
        case 12:
          handleGroupNotes(event, relay);
          break;
        case 9000:
          handleAddUser(event, relay);
          break;
        case 9001:
          handleRemoveUser(event, relay);
          break;
        case 9002:
          handleEditMetadata(event, relay);
          break;
        case 9003:
          handleAddPermission(event, relay);
          break;
        case 9004:
          handleRemovePermission(event, relay);
          break;
        case 9005:
          handleDeleteEvent(event, relay);
          break;
        case 9006:
          handleEditGroupStatus(event, relay);
          break;
        case 9021:
          handleJoinRequest(event, relay);
          break;
        case 9735:
          handleGroupZaps(event, relay);
          break;
        default:
          print('unhandled message $event');
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) {
      offlineGroupMessageFinish[relay] = true;
      _updateGroupMessageTime(currentUnixTimestampSeconds(), relay);
      if (unCompletedRelays.isEmpty) {}
    });
  }

  void _updateGroupMessageTime(int eventTime, String relay) {
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setGroupMessageUntil(eventTime, relay);
      Relays.sharedInstance.setGroupMessageSince(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDB(
          url: relay,
          groupMessageUntil: {relay: eventTime},
          groupMessageSince: {relay: eventTime});
    }
    if (offlineGroupMessageFinish[relay] == true) {
      Relays.sharedInstance.syncRelaysToDB(r: relay);
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
          Lists result = await Nip51.getLists(lastEvent!, pubkey, privkey);
          UserDB? me = Account.sharedInstance.me;
          me!.lastGroupsListUpdatedTime = lastEvent!.createdAt;
          me.relayGroupsList = result.bookmarks;
          await Account.sharedInstance.syncMe();
          myGroups = _myGroups();
          _updateGroupSubscription();
        }
        if (!completer.isCompleted) completer.complete();
        myGroupsUpdatedCallBack?.call();
      }
    });
    return completer.future;
  }

  Future<void> syncGroupToDB(RelayGroupDB groupDB) async {
    groups[groupDB.groupId] = groupDB;
    if (myGroups.containsKey(groupDB.groupId)) {
      myGroups[groupDB.groupId] = groupDB;
    }
    await DB.sharedInstance.insert<RelayGroupDB>(groupDB);
  }

  Future<void> _syncMyGroupListToDB() async {
    List<String> list = myGroups.keys.toList();
    UserDB? me = Account.sharedInstance.me;
    me!.relayGroupsList = list;
    await DB.sharedInstance.insert<UserDB>(me);
  }

  Future<OKEvent> syncMyGroupListToRelay() async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<String> list = myGroups.keys.toList();
    Event event = await Nip51.createCategorizedBookmarks(
        identifier, [], list, privkey, pubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (ok.status) {
        Account.sharedInstance.me!.lastGroupsListUpdatedTime = event.createdAt;
        _syncMyGroupListToDB();
      }
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  List<RelayGroupDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<RelayGroupDB> groups = myGroups.values
          .where((group) =>
              regex.hasMatch(group.name) || regex.hasMatch(group.about))
          .toList();
      return groups;
    }
    return null;
  }

  List<String> getAllUnMuteGroups() {
    return myGroups.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.key)
        .toList();
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
