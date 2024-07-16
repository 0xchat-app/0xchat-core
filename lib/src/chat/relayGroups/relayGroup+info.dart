import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension EInfo on RelayGroup {
  Future<RelayGroupDB?> getGroupMetadataFromRelay(String groupId,
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
    RelayGroupDB? groupDB = groups[groupId];
    groupDB ??= RelayGroupDB(
        groupId: groupId,
        relay: relay ?? '',
        author: author ?? '',
        id: '$relay\'$groupId');
    Completer<RelayGroupDB?> completer = Completer<RelayGroupDB?>();
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
          groupDB!.members = members;
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty && !completer.isCompleted) {
        if (groupDB != null) await syncGroupToDB(groupDB);
        Connect.sharedInstance.closeConnects(tempRelays, RelayKind.relayGroup);
        completer.complete(groupDB);
      }
    });
    return completer.future;
  }

  Future<void> handleGroupMetadata(Event event, String relay) async {
    Group group = Nip29.decodeMetadata(event, relay);
    RelayGroupDB? groupDB = groups[group.groupId];
    groupDB ??= RelayGroupDB(
        groupId: group.groupId,
        relay: relay ?? '',
        id: '$relay\'${group.groupId}');
    if (event.createdAt < groupDB.lastUpdatedTime) return;
    groupDB.name = group.name;
    groupDB.picture = group.picture;
    groupDB.about = group.about;
    groupDB.private = group.private;
    groupDB.closed = group.closed;
    groupDB.lastUpdatedTime = event.createdAt;
    groupMetadataUpdatedCallBack?.call(groupDB);
    await syncGroupToDB(groupDB);
  }

  Future<void> handleGroupAdmins(Event event, String relay) async {
    String groupId = Nip29.getGroupIdFromEvent(event) ?? '';
    List<GroupAdmin> admins = Nip29.decodeGroupAdmins(event);
    RelayGroupDB? groupDB = groups[groupId];
    groupDB ??= RelayGroupDB(
        groupId: groupId, relay: relay ?? '', id: '$relay\'$groupId');
    if (event.createdAt < groupDB.lastUpdatedTime) return;
    groupDB.admins = admins;
    groupDB.lastUpdatedTime = event.createdAt;
    groupMetadataUpdatedCallBack?.call(groupDB);
    await syncGroupToDB(groupDB);
  }

  Future<void> handleGroupMembers(Event event, String relay) async {
    String groupId = Nip29.getGroupIdFromEvent(event) ?? '';
    List<String> members = Nip29.decodeGroupMembers(event);
    RelayGroupDB? groupDB = groups[groupId];
    groupDB ??= RelayGroupDB(
        groupId: groupId, relay: relay ?? '', id: '$relay\'$groupId');
    if (event.createdAt < groupDB.lastUpdatedTime) return;
    groupDB.members = members;
    groupDB.lastUpdatedTime = event.createdAt;
    groupMetadataUpdatedCallBack?.call(groupDB);
    await syncGroupToDB(groupDB);
  }

  List<GroupAdmin>? getGroupAdminsFromLocal(String groupId) {
    return myGroups[groupId]?.admins;
  }

  Future<List<UserDB>> getGroupMembersFromLocal(String groupId) async {
    RelayGroupDB? groupDB = myGroups[groupId];
    List<UserDB> result = [];
    if (groupDB != null && groupDB.members != null) {
      await Future.forEach(groupDB.members!, (member) async {
        UserDB? userDB = await Account.sharedInstance.getUserInfo(member);
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
}
