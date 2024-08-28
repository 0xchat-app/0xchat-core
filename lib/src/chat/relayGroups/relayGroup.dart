import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:nostr_core_dart/nostr.dart';

typedef GroupsJoinRequestCallBack = void Function(JoinRequestDBISAR);
typedef GroupsModerationCallBack = void Function(ModerationDBISAR);
typedef GroupsNoteCallBack = void Function(NoteDBISAR);
typedef GroupMetadataUpdatedCallBack = void Function(RelayGroupDBISAR);
typedef OfflineGroupMessageFinishCallBack = void Function();
typedef GroupSearchCallBack = void Function(List<RelayGroupDBISAR>);

class RelayGroup {
  /// singleton
  RelayGroup._internal();
  factory RelayGroup() => sharedInstance;
  static final RelayGroup sharedInstance = RelayGroup._internal();

  String groupMessageSubscription = '';

  // memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, RelayGroupDBISAR> groups = {};
  Map<String, RelayGroupDBISAR> myGroups = {};
  Map<String, bool> offlineGroupMessageFinish = {};
  List<String> groupRelays = [];

  GroupsUpdatedCallBack? myGroupsUpdatedCallBack;
  GroupMetadataUpdatedCallBack? groupMetadataUpdatedCallBack;
  GroupMessageCallBack? groupMessageCallBack;
  GroupMessageUpdateCallBack? groupMessageUpdateCallBack;
  GroupsJoinRequestCallBack? joinRequestCallBack;
  GroupsModerationCallBack? moderationCallBack;
  GroupsNoteCallBack? noteCallBack;
  OfflineGroupMessageFinishCallBack? offlineGroupMessageFinishCallBack;

  Future<void> init({GroupsUpdatedCallBack? callBack}) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    myGroupsUpdatedCallBack = callBack;

    Account.sharedInstance.relayGroupListUpdateCallback = () {
      groupListUpdated();
    };
    Connect.sharedInstance
        .addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        if (groupRelays.contains(relay)) {
          _udpateGroupInfos(relay: relay);
          updateGroupSubscription(relay: relay);
        }
      }
    });
    await _loadAllGroupsFromDB();
    updateGroupSubscription();
  }

  /// 0, not in the group, 1, in the group & not joined, 2. joined
  int getInGroupStatus(String groupId) {
    SimpleGroups simpleGroups = getHostAndGroupId(groupId);
    groupId = simpleGroups.groupId;
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

  void groupListUpdated() {
    myGroups = _myGroups();
    updateGroupSubscription();
    myGroupsUpdatedCallBack?.call();
  }

  Future<void> _loadAllGroupsFromDB() async {
    final isar = DBISAR.sharedInstance.isar;
    List<RelayGroupDBISAR> maps =
        await isar.relayGroupDBISARs.where().findAll();
    for (RelayGroupDBISAR e in maps) {
      RelayGroupDBISAR groupDB = e.withGrowableLevels();
      if (groupDB.groupId.isNotEmpty) {
        if (groupDB.name.isEmpty) groupDB.name = groupDB.groupId;
        groups[groupDB.groupId] = groupDB;
      }
    }
    myGroups = _myGroups();
    _udpateGroupInfos();
    myGroupsUpdatedCallBack?.call();
  }

  SimpleGroups getHostAndGroupId(String input) {
    RegExp exp = RegExp(r"(.*?)'(.*)");
    Match? match = exp.firstMatch(input);

    if (match != null) {
      String? host = match.group(1);
      if (host?.isNotEmpty == true) {
        if (!host!.contains('wss://') && !host.contains('ws://')) {
          host = 'wss://$host';
        }
      }
      String? groupId = match.group(2);
      return SimpleGroups(groupId ?? '', host ?? '');
    } else {
      return SimpleGroups(input, '');
    }
  }

  Map<String, RelayGroupDBISAR> _myGroups() {
    Map<String, RelayGroupDBISAR> result = {};
    UserDBISAR? me = Account.sharedInstance.me;
    if (me != null &&
        me.relayGroupsList != null &&
        me.relayGroupsList!.isNotEmpty) {
      List<String> groupList = me.relayGroupsList!;
      groupRelays.clear();
      for (String id in groupList) {
        SimpleGroups simpleGroups = getHostAndGroupId(id);
        String groupId = simpleGroups.groupId;
        if (groupId.isEmpty) continue;
        if (!groups.containsKey(groupId)) {
          groups[groupId] =
              RelayGroupDBISAR(groupId: groupId, relay: simpleGroups.relay);
          getGroupMetadataFromRelay(groupId);
        }
        result[groupId] = groups[groupId]!;
        groupRelays.add(groups[groupId]!.relay);
      }
      connectToRelays(groupRelays);
    }
    return result;
  }

  void connectToRelays(List<String> groupRelays) {
    for (var relay in groupRelays) {
      Connect.sharedInstance.connect(relay, relayKind: RelayKind.relayGroup);
    }
  }

  Future<void> _udpateGroupInfos({String? relay}) async {
    if (myGroups.isEmpty) return;
    List<RelayGroupDBISAR> values = List.from(myGroups.values);
    for (var group in values) {
      if (group.lastUpdatedTime == 0 &&
          (relay == null || group.relay == relay)) {
        RelayGroupDBISAR? relayGroupDB =
            await getGroupMetadataFromRelay(group.groupId);
        if (relayGroupDB != null) myGroups[group.groupId] = relayGroupDB;
      }
    }
  }

  void updateGroupSubscription({String? relay}) {
    if (myGroups.isEmpty) return;
    if (groupMessageSubscription.isNotEmpty) {
      Connect.sharedInstance
          .closeRequests(groupMessageSubscription, relay: relay);
    }

    Map<String, List<Filter>> subscriptions = {};
    List<String> groupList = [];
    for (var g in myGroups.values) {
      if (g.members?.contains(pubkey) == true) groupList.add(g.groupId);
    }
    if (relay == null) {
      for (String relayURL in groupRelays) {
        int groupMessageUntil =
            Relays.sharedInstance.getGroupMessageUntil(relayURL);
        Filter f = Filter(
            h: groupList,
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
              9735,
              // 39000,
              // 39001,
              // 39002
            ],
            since: (groupMessageUntil + 1));
        subscriptions[relayURL] = [f];
      }
    } else {
      int groupMessageUntil = Relays.sharedInstance.getGroupMessageUntil(relay);
      Filter f = Filter(
          h: groupList,
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
            9735,
            // 39000,
            // 39001,
            // 39002
          ],
          since: (groupMessageUntil + 1));
      subscriptions[relay] = [f];
    }

    groupMessageSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
      _updateGroupMessageTime(event.createdAt, relay);
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
        case 9001:
        case 9002:
        case 9003:
        case 9004:
        case 9005:
        case 9006:
          handleModeration(event, relay);
          break;
        case 9021:
          handleJoinRequest(event, relay);
          break;
        case 9735:
          handleGroupZaps(event, relay);
          break;
        case 39000:
          handleGroupMetadata(event, relay);
          break;
        case 39001:
          handleGroupAdmins(event, relay);
          break;
        case 39002:
          handleGroupMembers(event, relay);
          break;
        default:
          LogUtils.v(() => 'relaygroup unhandled message ${event.toJson()}');
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      offlineGroupMessageFinish[relay] = true;
      if (ok.status) {
        _updateGroupMessageTime(currentUnixTimestampSeconds(), relay);
      } else if (Nip29.restricted(ok.message)) {
        await Future.forEach(groupList, (g) async {
          await getGroupMetadataFromRelay(g);
        });
        updateGroupSubscription(relay: relay);
      }
      if (unCompletedRelays.isEmpty) {
        offlineGroupMessageFinishCallBack?.call();
        if (!Messages.sharedInstance.groupMessageCompleter.isCompleted) {
          Messages.sharedInstance.groupMessageCompleter.complete();
        }
      }
    });
  }

  Future<void> preloadGroupMessages(String groupId, String relay) async {
    Filter f = Filter(h: [
      groupId
    ], kinds: [
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
      9735,
    ], limit: 1000);
    Connect.sharedInstance.addSubscription([f], relays: [relay],
        eventCallBack: (event, relay) async {
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
        case 9001:
        case 9002:
        case 9003:
        case 9004:
        case 9005:
        case 9006:
          handleModeration(event, relay);
          break;
        case 9021:
          handleJoinRequest(event, relay);
          break;
        case 9735:
          handleGroupZaps(event, relay);
          break;
        case 39000:
          handleGroupMetadata(event, relay);
          break;
        case 39001:
          handleGroupAdmins(event, relay);
          break;
        case 39002:
          handleGroupMembers(event, relay);
          break;
        default:
          LogUtils.v(() => 'relaygroup unhandled message ${event.toJson()}');
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      await Connect.sharedInstance.closeRequests(requestId);
    });
  }

  void _updateGroupMessageTime(int eventTime, String relay) {
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setGroupMessageUntil(eventTime, relay);
      Relays.sharedInstance.setGroupMessageSince(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDBISAR(
          url: relay,
          groupMessageUntil: eventTime,
          groupMessageSince: eventTime);
    }
    if (offlineGroupMessageFinish[relay] == true) {
      Relays.sharedInstance.syncRelaysToDB(r: relay);
    }
  }

  Future<void> saveGroupToDB(RelayGroupDBISAR groupDB) async {
    await DBISAR.sharedInstance.saveToDB(groupDB);
  }

  Future<void> deleteGroupFromDB(String groupId) async {
    await DBISAR.sharedInstance.isar.writeTxn(() async {
      await DBISAR.sharedInstance.isar.relayGroupDBISARs
          .where()
          .groupIdEqualTo(groupId)
          .deleteAll();
    });
  }

  Future<void> syncGroupToDB(RelayGroupDBISAR groupDB) async {
    groups[groupDB.groupId] = groupDB;
    if (myGroups.containsKey(groupDB.groupId)) {
      myGroups[groupDB.groupId] = groupDB;
    }
    await saveGroupToDB(groupDB);
  }

  Future<void> _syncMyGroupListToDB() async {
    UserDBISAR? me = Account.sharedInstance.me;
    me!.relayGroupsList =
        myGroups.values.map((e) => '${e.relay}\'${e.groupId}').toList();
    await Account.sharedInstance.syncMe();
    groupListUpdated();
  }

  Future<OKEvent> syncMyGroupListToRelay() async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<SimpleGroups> list = [];
    for (var group in myGroups.values) {
      list.add(SimpleGroups(group.groupId, group.relay));
    }
    Event event = await Nip51.createSimpleGroupList([], list, privkey, pubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (ok.status) {
        Account.sharedInstance.me!.lastGroupsListUpdatedTime = event.createdAt;
        _syncMyGroupListToDB();
      }
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  bool isWebSocketUrl(String url) {
    final regex = RegExp(r'^(ws|wss)://');
    return regex.hasMatch(url);
  }

  bool isGroupIdentifier(String url) {
    return url.contains('\'');
  }

  Future<List<RelayGroupDBISAR>?> fuzzySearch(String keyword) async {
    if (keyword.isNotEmpty) {
      if (isWebSocketUrl(keyword)) {
        return await searchGroupsMetadataFromRelays([keyword], null);
      }
      if (isGroupIdentifier(keyword)) {
        RelayGroupDBISAR? group =
            await searchGroupsMetadataWithGroupID(keyword, null);
        if (group != null) return [group];
      }
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<RelayGroupDBISAR> result = groups.values
          .where((group) =>
              regex.hasMatch(group.name) || regex.hasMatch(group.about))
          .toList();
      return result;
    }
    return null;
  }

  Future<List<String>> getPrevious(String groupId) async {
    List<String> previous = [];
    final isar = DBISAR.sharedInstance.isar;
    List<MessageDBISAR> messages = await isar.messageDBISARs
        .filter()
        .groupIdEqualTo(groupId)
        .sortByCreateTimeDesc()
        .limit(3)
        .findAll();
    for (var message in messages) {
      previous.add(message.messageId.substring(0, 8));
    }
    return previous;
  }

  List<String> getAllUnMuteGroups() {
    return myGroups.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.value.identifier)
        .toList();
  }

  String? encodeGroup(String groupId) {
    RelayGroupDBISAR? groupDB = groups[groupId];
    if (groupDB == null) return null;
    String nevent = Nip19.encodeShareableEntity(
        'naddr', groupId, [groupDB.relay], groupDB.author, 39000);
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
          'author': result['author'],
          'kind': result['kind']
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
