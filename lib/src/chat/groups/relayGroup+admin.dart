import 'dart:async';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension EAdmin on RelayGroup {
  bool hasPermissions(
      List<GroupAdmin> admins, String user, List<GroupActionKind> permissions) {
    if (admins.isNotEmpty && admins.any((admin) => admin.pubkey == user)) {
      var admin = admins.firstWhere((admin) => admin.pubkey == user);
      return permissions
          .every((permission) => admin.permissions.contains(permission));
    }
    return false;
  }

  Future<void> handleJoinRequest(Event event, String relay) async {
    GroupJoinRequest joinRequest = Nip29.decodeJoinRequest(event);
    RelayGroupDB? groupDB = groups[joinRequest.groupId];
    if (groupDB == null || !groupDB.private || groupDB.admins == null) return;
    if (hasPermissions(groupDB.admins!, pubkey, [GroupActionKind.addUser])) {
      JoinRequestDB joinRequestDB = JoinRequestDB.toJoinRequestDB(joinRequest);
      int result = await DB.sharedInstance.insert<JoinRequestDB>(joinRequestDB,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      if (result > 0) joinRequestCallBack?.call(joinRequestDB);
    }
  }

  Future<OKEvent> sendModeration(GroupModeration moderation, String relay) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<String> previous = await getPrevious(moderation.groupId);
    moderation.previous = previous;
    Event event = await Nip29.encodeGroupModeration(moderation, pubkey, privkey);
    Connect.sharedInstance.sendEvent(event, relay: relay,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
      if (ok.status == true) {
        ModerationDB moderationDB = ModerationDB.toModerationDB(moderation);
        await DB.sharedInstance.insert<ModerationDB>(moderationDB,
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    });
    return completer.future;
  }

  Future<OKEvent> addUser(String groupId, String addUser, String reason) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    if (groupDB.admins == null) {
      return OKEvent(groupId, false, 'group admins not exit');
    }
    if (!hasPermissions(groupDB.admins!, pubkey, [GroupActionKind.addUser])) {
      return OKEvent(groupId, false, 'permission not met');
    }
    // GroupModeration moderation = GroupModeration();
    //
    // return sendModeration(
    //     groupId, groupDB.relay, GroupActionKind.addUser, reason, previous);
    return OKEvent(groupId, false, '');
  }

  Future<void> removeUser(String groupId, String removeUser) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null || groupDB.admins == null) return;
    if (hasPermissions(
        groupDB.admins!, pubkey, [GroupActionKind.removeUser])) {}
  }

  Future<void> editMetadata(
      String groupId, String name, String about, String picture) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null || groupDB.admins == null) return;
    if (hasPermissions(
        groupDB.admins!, pubkey, [GroupActionKind.editMetadata])) {}
  }

  Future<void> addPermission(
      Event groupId, String user, GroupActionKind permission) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null || groupDB.admins == null) return;
    if (hasPermissions(
        groupDB.admins!, pubkey, [GroupActionKind.addPermission])) {}
  }

  Future<void> removePermission(
      Event groupId, String user, GroupActionKind permission) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null || groupDB.admins == null) return;
    if (hasPermissions(
        groupDB.admins!, pubkey, [GroupActionKind.removePermission])) {}
  }

  Future<void> deleteEvent(Event groupId, String eventId) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null || groupDB.admins == null) return;
    if (hasPermissions(
        groupDB.admins!, pubkey, [GroupActionKind.deleteEvent])) {}
  }

  Future<void> editGroupStatus(Event groupId, bool private) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null || groupDB.admins == null) return;
    if (hasPermissions(
        groupDB.admins!, pubkey, [GroupActionKind.editGroupStatus])) {}
  }
}
