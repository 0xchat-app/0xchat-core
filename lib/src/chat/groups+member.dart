import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension Member on Groups {
  Future<OKEvent> inviteGroup(String groupId, List<String> inviteUsers, String content) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (groups.containsKey(groupId)) {
      OKEvent okEvent = await sendGroupMessage(
          groupId, MessageType.text, content,
          actionsType: 'invite', inviteUsers: inviteUsers);
      if (!completer.isCompleted) completer.complete(okEvent);
    } else {
      OKEvent okEvent = OKEvent(groupId, false, 'group not found');
      if (!completer.isCompleted) completer.complete(okEvent);
    }
    return completer.future;
  }

  Future<OKEvent> requestGroup(String groupId, String content) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (groups.containsKey(groupId)) {
      OKEvent okEvent = await sendGroupMessage(
          groupId, MessageType.text, content,
          actionsType: 'request');
      if (!completer.isCompleted) completer.complete(okEvent);
    } else {
      OKEvent okEvent = OKEvent(groupId, false, 'group not found');
      if (!completer.isCompleted) completer.complete(okEvent);
    }
    return completer.future;
  }

  Future<OKEvent> joinGroup(String groupId, String content) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (groups.containsKey(groupId)) {
      myGroups[groupId] = groups[groupId]!;
      syncMyGroupListToRelay(callBack: (ok, relay) {
        if (ok.status) {
          sendGroupMessage(groupId, MessageType.text, content,
              actionsType: 'join');
        }
        if (!completer.isCompleted) completer.complete(ok);
      });
    } else {
      OKEvent okEvent = OKEvent(groupId, false, 'group not found');
      if (!completer.isCompleted) completer.complete(okEvent);
    }
    return completer.future;
  }

  Future<OKEvent> leaveGroup(String groupId, String content) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    myGroups.remove(groupId);
    syncMyGroupListToRelay(callBack: (ok, relay) {
      if (ok.status) {
        sendGroupMessage(groupId, MessageType.text, content,
            actionsType: 'leave');
      }
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
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
