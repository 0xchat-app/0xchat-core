import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension EInfo on RelayGroup {
  Future<RelayGroupDB?> getGroupMetadataFromRelay(String id) async {
    RelayGroupDB? groupDB = groups[id];
    if (groupDB == null) return null;
    Completer<RelayGroupDB?> completer = Completer<RelayGroupDB?>();
    Filter f = Filter(
        kinds: [39000], d: [id], since: groupDB.lastUpdatedTime + 1);
    Map<String, List<Filter>> subscriptions = {};
    subscriptions[groupDB.relay] = [f];
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
          Group group = Nip29.decodeMetadata(event, relay);
          groupDB.lastUpdatedTime = event.createdAt;
          groupDB.name = group.name;
          groupDB.picture = group.picture;
          groupDB.about = group.about;
          groupDB.private = group.private;
          if (!completer.isCompleted) completer.complete(groupDB);
          await syncGroupToDB(groupDB);
        }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
          Connect.sharedInstance.closeSubscription(requestId, relay);
          if (unCompletedRelays.isEmpty && !completer.isCompleted) {
            completer.complete(groupDB);
          }
        });
    return completer.future;
  }

  Future<List<GroupAdmin>?> getGroupAdminsFromRelay(String id) async {
    RelayGroupDB? groupDB = groups[id];
    if (groupDB == null) return null;
    Completer<List<GroupAdmin>?> completer = Completer<List<GroupAdmin>?>();
    Filter f = Filter(
        kinds: [39001], d: [id], since: groupDB.lastUpdatedTime + 1);
    Map<String, List<Filter>> subscriptions = {};
    subscriptions[groupDB.relay] = [f];
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
          List<GroupAdmin> admins = Nip29.decodeGroupAdmins(event, id);
          groupDB.lastUpdatedTime = event.createdAt;
          groupDB.admins = admins;
          if (!completer.isCompleted) completer.complete(admins);
          await syncGroupToDB(groupDB);
        }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
          Connect.sharedInstance.closeSubscription(requestId, relay);
          if (unCompletedRelays.isEmpty && !completer.isCompleted) {
            completer.complete(null);
          }
        });
    return completer.future;
  }

  Future<List<String>?> getGroupMembersFromRelay(String id) async {
    RelayGroupDB? groupDB = groups[id];
    if (groupDB == null) return null;
    Completer<List<String>?> completer = Completer<List<String>?>();
    Filter f = Filter(
        kinds: [39002], d: [id], since: groupDB.lastUpdatedTime + 1);
    Map<String, List<Filter>> subscriptions = {};
    subscriptions[groupDB.relay] = [f];
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
          List<String> members = Nip29.decodeGroupMembers(event, id);
          groupDB.lastUpdatedTime = event.createdAt;
          groupDB.members = members;
          if (!completer.isCompleted) completer.complete(members);
          await syncGroupToDB(groupDB);
        }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
          Connect.sharedInstance.closeSubscription(requestId, relay);
          if (unCompletedRelays.isEmpty && !completer.isCompleted) {
            completer.complete(null);
          }
        });
    return completer.future;
  }
}