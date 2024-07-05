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

  Future<List<JoinRequestDB>> getRequestList(String groupId) async {
    List<Object?> maps = await DB.sharedInstance
        .objects<JoinRequestDB>(whereArgs: [groupId], where: 'groupId = ?');
    return maps.map((e) => e as JoinRequestDB).toList();
  }

  Future<OKEvent> acceptJoinRequest(JoinRequestDB joinRequest) async {
    RelayGroupDB? groupDB = groups[joinRequest.groupId];
    if (groupDB == null || !groupDB.private || groupDB.admins == null) {
      return OKEvent(joinRequest.groupId, false, 'group not exit');
    }
    if (hasPermissions(groupDB.admins!, pubkey, [GroupActionKind.addUser])) {
      return await addUser(groupDB.groupId, [joinRequest.author], '');
    } else {
      return OKEvent(joinRequest.groupId, false, 'no permissions');
    }
  }

  Future<int> ignoreJoinRequest(JoinRequestDB joinRequest) async {
    return await DB.sharedInstance.delete<JoinRequestDB>(
        where: 'requestId = ?', whereArgs: [joinRequest.requestId]);
  }

  Future<OKEvent> sendModeration(GroupModeration moderation) async {
    String groupId = moderation.groupId;
    RelayGroupDB? groupDB = myGroups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    if (groupDB.admins == null) {
      return OKEvent(groupId, false, 'group admins not exit');
    }
    if (!hasPermissions(groupDB.admins!, pubkey, [moderation.actionKind])) {
      return OKEvent(groupId, false, 'permission not met');
    }

    Completer<OKEvent> completer = Completer<OKEvent>();
    List<String> previous = await getPrevious(moderation.groupId);
    moderation.previous = previous;
    Event event =
        await Nip29.encodeGroupModeration(moderation, pubkey, privkey);
    Connect.sharedInstance.sendEvent(event, toRelays: [groupDB.relay],
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

  Future<OKEvent> addUser(String groupId, List<String> addUsers, String reason) async {
    GroupModeration moderation =
        GroupModeration.addUser(groupId, addUsers.first, reason);
    return sendModeration(moderation);
  }

  Future<OKEvent> removeUser(
      String groupId, List<String> removeUsers, String reason) async {
    GroupModeration moderation =
        GroupModeration.removeUser(groupId, removeUsers.first, reason);
    return sendModeration(moderation);
  }

  Future<OKEvent> editMetadata(String groupId, String name, String about,
      String picture, String reason) async {
    GroupModeration moderation =
        GroupModeration.editMetadata(groupId, name, about, picture, reason);
    return sendModeration(moderation);
  }

  Future<OKEvent> addPermission(
      String groupId, String user, String permission, String reason) async {
    GroupModeration moderation =
        GroupModeration.addPermission(groupId, user, permission, reason);
    return sendModeration(moderation);
  }

  Future<OKEvent> removePermission(
      String groupId, String user, String permission, String reason) async {
    GroupModeration moderation =
        GroupModeration.removePermission(groupId, user, permission, reason);
    return sendModeration(moderation);
  }

  Future<OKEvent> deleteEvent(
      String groupId, String eventId, String reason) async {
    GroupModeration moderation =
        GroupModeration.deleteEvent(groupId, eventId, reason);
    return sendModeration(moderation);
  }

  Future<OKEvent> editGroupStatus(
      String groupId, bool private, String reason) async {
    GroupModeration moderation =
        GroupModeration.editGroupStatus(groupId, private, reason);
    return sendModeration(moderation);
  }
}
