import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension EInfo on RelayGroup {
  Future<RelayGroupDB?> getGroupMetadataFromRelay(String groupId,
      {String? relay, String? author}) async {
    if(groupId.isEmpty) return null;
    RelayGroupDB? groupDB = groups[groupId];
    groupDB ??= RelayGroupDB(
        groupId: groupId, relay: relay ?? '', author: author ?? '');
    Completer<RelayGroupDB?> completer = Completer<RelayGroupDB?>();
    Filter f = Filter(
        kinds: [39000, 39001, 39002],
        d: [groupId],
        since: groupDB.lastUpdatedTime + 1);
    Map<String, List<Filter>> subscriptions = {};
    subscriptions[groupDB.relay] = [f];
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
      if (groupDB!.lastUpdatedTime > event.createdAt && event.createdAt != 0) return;
      groupDB.lastUpdatedTime = event.createdAt;
      switch (event.kind) {
        case 39000:
          Group group = Nip29.decodeMetadata(event, relay);
          groupDB.name = group.name;
          groupDB.picture = group.picture;
          groupDB.about = group.about;
          groupDB.private = group.private;
          break;
        case 39001:
          List<GroupAdmin> admins = Nip29.decodeGroupAdmins(event, groupId);
          groupDB.admins = admins;
          break;
        case 39002:
          List<String> members = Nip29.decodeGroupMembers(event, groupId);
          groupDB.members = members;
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty && !completer.isCompleted) {
        if (groupDB != null) await syncGroupToDB(groupDB);
        completer.complete(groupDB);
      }
    });
    return completer.future;
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
