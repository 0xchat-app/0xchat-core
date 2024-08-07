import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:isar/isar.dart';
import 'package:nostr_core_dart/nostr.dart';

extension EInfo on RelayGroup {
  Future<RelayGroupDBISAR?> getGroupMetadataFromRelay(String groupId,
      {String? relay, String? author}) async {
    if (groupId.isEmpty) return null;
    SimpleGroups simpleGroups = getHostAndGroupId(groupId);
    groupId = simpleGroups.groupId;
    relay ??= simpleGroups.relay;
    List<String> tempRelays = [];
    if (relay.isNotEmpty &&
        !Connect.sharedInstance.webSockets.keys.contains(relay)) {
      await Connect.sharedInstance
          .connectRelays([relay], relayKind: RelayKind.temp);
      tempRelays.add(relay);
    }
    RelayGroupDBISAR? groupDB = groups[groupId];
    groupDB ??= RelayGroupDBISAR(
        groupId: groupId,
        relay: relay,
        author: author ?? '',
        identifier: '$relay\'$groupId');
    Completer<RelayGroupDBISAR?> completer = Completer<RelayGroupDBISAR?>();
    Filter f = Filter(kinds: [39000, 39001, 39002], d: [groupId]);
    Map<String, List<Filter>> subscriptions = {};
    subscriptions[groupDB.relay] = [f];
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
      switch (event.kind) {
        case 39000:
          Group group = Nip29.decodeMetadata(event, relay);
          groupDB!.name = group.name;
          groupDB.picture = group.picture;
          groupDB.about = group.about;
          groupDB.private = group.private;
          groupDB.closed = group.closed;
          break;
        case 39001:
          List<GroupAdmin> admins = Nip29.decodeGroupAdmins(event);
          groupDB!.admins = admins;
          break;
        case 39002:
          List<String> members = Nip29.decodeGroupMembers(event);
          if ((!checkInGroup(groupId) && members.contains(pubkey)) ||
              (checkInGroup(groupId) && !members.contains(pubkey))) {
            groupDB!.members = members;
            await syncGroupToDB(groupDB);
            updateGroupSubscription();
          } else {
            groupDB!.members = members;
          }
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty && !completer.isCompleted) {
        if (groupDB != null) await syncGroupToDB(groupDB);
        Connect.sharedInstance.closeConnects(tempRelays, RelayKind.temp);
        completer.complete(groupDB);
      }
    });
    return completer.future;
  }

  RelayGroupDBISAR handleGroupMetadata(Event event, String relay) {
    Group group = Nip29.decodeMetadata(event, relay);
    RelayGroupDBISAR? groupDB = groups[group.groupId];
    groupDB ??= RelayGroupDBISAR(
        groupId: group.groupId,
        relay: relay,
        identifier: '$relay\'${group.groupId}');
    if (event.createdAt < groupDB.lastUpdatedTime) return groupDB;
    groupDB.name = group.name;
    groupDB.picture = group.picture;
    groupDB.about = group.about;
    groupDB.private = group.private;
    groupDB.closed = group.closed;
    groupDB.lastUpdatedTime = event.createdAt;
    groupMetadataUpdatedCallBack?.call(groupDB);
    syncGroupToDB(groupDB);
    return groupDB;
  }

  Future<void> handleGroupMetadataFromModeration(
      GroupModeration moderation, String relay) async {
    RelayGroupDBISAR? groupDB = groups[moderation.groupId];
    groupDB ??= RelayGroupDBISAR(
        groupId: moderation.groupId,
        relay: relay,
        identifier: '$relay\'${moderation.groupId}');
    if (moderation.createdAt < groupDB.lastUpdatedTime) return;
    groupDB.name = moderation.name;
    groupDB.picture = moderation.picture;
    groupDB.about = moderation.about;
    groupDB.lastUpdatedTime = moderation.createdAt;
    groupMetadataUpdatedCallBack?.call(groupDB);
    await syncGroupToDB(groupDB);
  }

  Future<void> handleGroupAdmins(Event event, String relay) async {
    String groupId = Nip29.getGroupIdFromEvent(event) ?? '';
    List<GroupAdmin> admins = Nip29.decodeGroupAdmins(event);
    RelayGroupDBISAR? groupDB = groups[groupId];
    groupDB ??= RelayGroupDBISAR(
        groupId: groupId, relay: relay, identifier: '$relay\'$groupId');
    if (event.createdAt < groupDB.lastUpdatedTime) return;
    groupDB.admins = admins;
    groupDB.lastUpdatedTime = event.createdAt;
    groupMetadataUpdatedCallBack?.call(groupDB);
    await syncGroupToDB(groupDB);
  }

  Future<void> handleGroupMembers(Event event, String relay) async {
    String groupId = Nip29.getGroupIdFromEvent(event) ?? '';
    List<String> members = Nip29.decodeGroupMembers(event);
    RelayGroupDBISAR? groupDB = groups[groupId];
    groupDB ??= RelayGroupDBISAR(
        groupId: groupId, relay: relay, identifier: '$relay\'$groupId');
    if (event.createdAt < groupDB.lastUpdatedTime) return;
    groupDB.members = members;
    groupDB.lastUpdatedTime = event.createdAt;
    groupMetadataUpdatedCallBack?.call(groupDB);
    await syncGroupToDB(groupDB);
  }

  List<GroupAdmin>? getGroupAdminsFromLocal(String groupId) {
    return myGroups[groupId]?.admins;
  }

  Future<List<UserDBISAR>> getGroupMembersFromLocal(String groupId) async {
    RelayGroupDBISAR? groupDB = myGroups[groupId];
    List<UserDBISAR> result = [];
    if (groupDB != null && groupDB.members != null) {
      await Future.forEach(groupDB.members!, (member) async {
        UserDBISAR? userDB = await Account.sharedInstance.getUserInfo(member);
        if (userDB != null) {
          if (groupDB.author == member) {
            result.insert(0, userDB);
          } else {
            result.add(userDB);
          }
        }
      });
    }
    return result;
  }

  Future<List<RelayGroupDBISAR>> searchGroupsFromDB(List<String> relays) async {
    return await DBISAR.sharedInstance.isar.relayGroupDBISARs
        .filter()
        .anyOf(relays, (q, relay) => q.relayEqualTo(relay))
        .findAll();
  }

  Future<List<RelayGroupDBISAR>> searchAllGroupsFromRelays(
      GroupMetadataUpdatedCallBack? groupCallback) async {
    Set<String> relays = Set.from(groupRelays);
    relays.addAll(Relays.sharedInstance.recommendGroupRelays);
    return await searchGroupsFromRelays(relays.toList(), groupCallback);
  }

  Future<List<RelayGroupDBISAR>> searchGroupsFromRelays(
      List<String> relays, GroupMetadataUpdatedCallBack? groupCallback) async {
    if (relays.isEmpty) return [];
    Map<String, RelayGroupDBISAR> result = {};
    List<RelayGroupDBISAR> resultFromDB = await searchGroupsFromDB(relays);
    for (var db in resultFromDB) {
      result[db.groupId] = db;
      groupCallback?.call(db);
    }
    await Connect.sharedInstance
        .connectRelays(relays, relayKind: RelayKind.temp);
    Completer<List<RelayGroupDBISAR>> completer =
        Completer<List<RelayGroupDBISAR>>();
    Filter f = Filter(kinds: [39000], limit: 100);
    Connect.sharedInstance.addSubscription([f], relays: relays,
        eventCallBack: (event, relay) async {
      RelayGroupDBISAR groupDB = handleGroupMetadata(event, relay);
      result[groupDB.groupId] = groupDB;
      groupCallback?.call(groupDB);
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty && !completer.isCompleted) {
        Connect.sharedInstance.closeConnects(relays, RelayKind.temp);
        completer.complete(result.values.toList());
      }
    });
    return completer.future;
  }
}
