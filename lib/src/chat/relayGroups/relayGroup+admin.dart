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
      await DB.sharedInstance.insertBatch<JoinRequestDB>(joinRequestDB,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      joinRequestCallBack?.call(joinRequestDB);
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
        await DB.sharedInstance.insertBatch<ModerationDB>(moderationDB,
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    });
    return completer.future;
  }

  Future<OKEvent> addUser(
      String groupId, List<String> addUsers, String reason) async {
    RelayGroupDB? groupDB = myGroups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    GroupModeration moderation =
        GroupModeration.addUser(groupId, addUsers, reason);
    OKEvent ok = await sendModeration(moderation);
    if (ok.status) {
      groupDB.members ??= [];
      groupDB.members!.addAll(addUsers);
      syncGroupToDB(groupDB);
    }
    return ok;
  }

  Future<OKEvent> removeUser(
      String groupId, List<String> removeUsers, String reason) async {
    RelayGroupDB? groupDB = myGroups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    GroupModeration moderation =
        GroupModeration.removeUser(groupId, removeUsers, reason);
    OKEvent ok = await sendModeration(moderation);
    if (ok.status) {
      groupDB.members?.removeWhere((e) => removeUsers.contains(e));
      syncGroupToDB(groupDB);
    }
    return ok;
  }

  Future<OKEvent> editMetadata(String groupId, String name, String about,
      String picture, String reason) async {
    RelayGroupDB? groupDB = myGroups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    GroupModeration moderation =
        GroupModeration.editMetadata(groupId, name, about, picture, reason);
    OKEvent ok = await sendModeration(moderation);
    if (ok.status) {
      groupDB.name = name;
      groupDB.about = about;
      groupDB.picture = picture;
      syncGroupToDB(groupDB);
    }
    return ok;
  }

  Future<OKEvent> addPermission(
      String groupId, String user, String permission, String reason) async {
    RelayGroupDB? groupDB = myGroups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    GroupModeration moderation =
        GroupModeration.addPermission(groupId, [user], permission, reason);
    OKEvent ok = await sendModeration(moderation);
    if (ok.status) {
      bool exit = false;
      for (GroupAdmin admin in groupDB.admins ?? []) {
        if (admin.pubkey == user) {
          exit = true;
          admin.permissions.add(GroupActionKind.fromString(permission));
        }
      }
      if (!exit) {
        GroupAdmin admin =
            GroupAdmin(user, 'admin', [GroupActionKind.fromString(permission)]);
        groupDB.admins ??= [];
        groupDB.admins?.add(admin);
      }
      syncGroupToDB(groupDB);
    }
    return ok;
  }

  Future<OKEvent> removePermission(
      String groupId, String user, String permission, String reason) async {
    RelayGroupDB? groupDB = myGroups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    GroupModeration moderation =
        GroupModeration.removePermission(groupId, [user], permission, reason);
    OKEvent ok = await sendModeration(moderation);
    if (ok.status) {
      for (GroupAdmin admin in groupDB.admins ?? []) {
        if (admin.pubkey == user) {
          admin.permissions.remove(GroupActionKind.fromString(permission));
          if (admin.permissions.isEmpty) {
            groupDB.admins?.remove(admin);
            break;
          }
        }
      }
      syncGroupToDB(groupDB);
    }
    return ok;
  }

  Future<OKEvent> deleteMessageFromRelay(
      String groupId, String messageId, String reason) async {
    OKEvent ok = await deleteEvent(groupId, messageId, reason);
    if (ok.status) {
      ok = await deleteMessageFromLocal(messageId);
    }
    return ok;
  }

  Future<OKEvent> deleteMessageFromLocal(String messageId) async {
    await Messages.deleteMessagesFromDB(messageIds: [messageId]);
    return OKEvent(messageId, true, '');
  }

  Future<OKEvent> deleteNoteFromRelay(
      String groupId, String noteId, String reason) async {
    OKEvent ok = await deleteEvent(groupId, noteId, reason);
    if (ok.status) {
      ok = await deleteNoteFromLocal(noteId);
    }
    return ok;
  }

  Future<OKEvent> deleteNoteFromLocal(String noteId) async {
    await deleteNotesFromDB(noteIds: [noteId]);
    return OKEvent(noteId, true, '');
  }

  Future<OKEvent> deleteEvent(
      String groupId, String eventId, String reason) async {
    GroupModeration moderation =
        GroupModeration.deleteEvent(groupId, eventId, reason);
    return sendModeration(moderation);
  }

  Future<OKEvent> editGroupStatus(
      String groupId, bool closed, bool private, String reason) async {
    RelayGroupDB? groupDB = myGroups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    GroupModeration moderation =
        GroupModeration.editGroupStatus(groupId, private, reason);
    OKEvent ok = await sendModeration(moderation);
    if (ok.status) {
      groupDB.private = private;
      groupDB.closed = closed;
      syncGroupToDB(groupDB);
    }
    return ok;
  }
}
