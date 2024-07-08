import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension Member on Groups {
  // Future<OKEvent> inviteGroup(
  //     String groupId, List<String> inviteUsers, String content) async {
  //   if (groups.containsKey(groupId)) {
  //     OKEvent okEvent = await sendGroupMessage(
  //         groupId, MessageType.system, content,
  //         actionsType: 'invite', inviteUsers: inviteUsers);
  //     return okEvent;
  //   }
  //   return OKEvent(groupId, false, 'group not found');
  // }

  Future<OKEvent> requestGroup(String groupId, String groupOwner,
      String groupName, String content) async {
    content = "${Account.sharedInstance.me?.name} request to join the group";
    GroupDB? groupDB = groups[groupId];
    groupDB ??= GroupDB(groupId: groupId, owner: groupOwner, name: groupName);
    if (groupDB.owner.isEmpty) groupDB.owner = groupOwner;
    if (groupDB.name.isEmpty) groupDB.name = groupName;
    await DB.sharedInstance
        .insertBatch<GroupDB>(groupDB, conflictAlgorithm: ConflictAlgorithm.ignore);
    OKEvent? okEvent;
    if (!checkInGroup(groupId)) {
      groups[groupId] = groupDB;
      myGroups[groupId] = groupDB;
      okEvent = await sendGroupMessage(groupId, MessageType.system, content,
          actionsType: 'request');
      okEvent = await syncMyGroupListToRelay();
    } else {
      okEvent = OKEvent(groupId, false, 'already in group');
    }
    return okEvent;
  }

  Future<OKEvent> joinGroup(String groupId, String content) async {
    if (groups.containsKey(groupId) &&
        groups[groupId]?.members?.contains(pubkey) == true) {
      myGroups[groupId] = groups[groupId]!;
      OKEvent ok = await syncMyGroupListToRelay();
      if (ok.status) {
        sendGroupMessage(groupId, MessageType.system, content,
            actionsType: 'join');
      }
      return ok;
    }
    return OKEvent(groupId, false, 'group not found');
  }

  Future<OKEvent> leaveGroup(String groupId, String content) async {
    myGroups.remove(groupId);
    OKEvent ok = await syncMyGroupListToRelay();
    if (ok.status) {
      sendGroupMessage(groupId, MessageType.system, content,
          actionsType: 'leave');
    }
    return ok;
  }

  Future<void> deleteGroup(String groupId) async {
    await DB.sharedInstance
        .delete<GroupDB>(where: 'groupId = ?', whereArgs: [groupId]);
  }

  Future<void> muteGroup(String groupId) async {
    _setMuteGroup(groupId, true);
  }

  Future<void> unMuteGroup(String groupId) async {
    _setMuteGroup(groupId, false);
  }

  Future<void> _setMuteGroup(String groupId, bool mute) async {
    if (myGroups.containsKey(groupId)) {
      GroupDB groupDB = myGroups[groupId]!;
      groupDB.mute = mute;
      await syncGroupToDB(groupDB);
    }
  }

  Future<List<UserDB>> getAllGroupMembers(String groupId) async {
    GroupDB? groupDB = groups[groupId];
    List<UserDB> result = [];
    if (groupDB != null && groupDB.members != null) {
      await Future.forEach(groupDB.members!, (member) async {
        UserDB? userDB = await Account.sharedInstance.getUserInfo(member);
        if (userDB != null) {
          if (groupDB.owner == member) {
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
