import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension Member on Groups {
  Future<OKEvent> inviteGroup(
      String groupId, List<String> inviteUsers, String content) async {
    if (groups.containsKey(groupId)) {
      OKEvent okEvent = await sendGroupMessage(
          groupId, MessageType.text, content,
          actionsType: 'invite', inviteUsers: inviteUsers);
      return okEvent;
    }
    return OKEvent(groupId, false, 'group not found');
  }

  Future<OKEvent> requestGroup(String groupId, String content) async {
    if (groups.containsKey(groupId)) {
      OKEvent okEvent = await sendGroupMessage(
          groupId, MessageType.text, content,
          actionsType: 'request');
      myGroups[groupId] = groups[groupId]!;
      okEvent = await syncMyGroupListToRelay();
      return okEvent;
    }
    return OKEvent(groupId, false, 'group not found');
  }

  Future<OKEvent> joinGroup(String groupId, String content) async {
    if (groups.containsKey(groupId) &&
        groups[groupId]?.members?.contains(pubkey) == true) {
      myGroups[groupId] = groups[groupId]!;
      OKEvent ok = await syncMyGroupListToRelay();
      if (ok.status) {
        sendGroupMessage(groupId, MessageType.text, content,
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
      sendGroupMessage(groupId, MessageType.text, content,
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
      for (String member in groupDB.members!) {
        UserDB? userDB = await Account.sharedInstance.getUserInfo(member);
        if (userDB != null) result.add(userDB);
      }
    }
    return result;
  }
}
