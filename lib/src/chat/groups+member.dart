import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension Member on Groups {
  Future<OKEvent> requestGroup(String groupId, String content) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (groups.containsKey(groupId)) {
      OKEvent okEvent = await sendGroupMessage(groupId, MessageType.text, content, actionsType: 'request');
      if (!completer.isCompleted) completer.complete(okEvent);
    } else {
      OKEvent okEvent = OKEvent(groupId, false, 'group not found');
      if (!completer.isCompleted) completer.complete(okEvent);
    }
    return completer.future;
  }

  Future<OKEvent> joinGroup(String groupId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (groups.containsKey(groupId)) {
      myGroups[groupId] = groups[groupId]!;
      syncMyGroupListToRelay(callBack: (ok, relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
    } else {
      OKEvent okEvent = OKEvent(groupId, false, 'group not found');
      if (!completer.isCompleted) completer.complete(okEvent);
    }
    return completer.future;
  }

  Future<OKEvent> leaveGroup(String groupId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    myGroups.remove(groupId);
    syncMyGroupListToRelay(callBack: (ok, relay) {
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

  Event? getSendGroupMessageEvent(
      String groupId, MessageType type, String content,
      {String? groupRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay,
      String? actionsType}) {
    Event event = Nip28.sendChannelMessage(
        groupId, MessageDB.getContent(type, content), privkey,
        channelRelay: groupRelay,
        replyMessage: replyMessage,
        replyMessageRelay: replyMessageRelay,
        replyUser: replyUser,
        replyUserRelay: replyUserRelay,
        subContent: MessageDB.getSubContent(type, content),
        actionsType: actionsType);
    return event;
  }

  Future<OKEvent> sendGroupMessage(
      String groupId, MessageType type, String content,
      {String? groupRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay,
      Event? event,
      String? actionsType,
      bool local = false}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    event ??= Nip28.sendChannelMessage(
        groupId, MessageDB.getContent(type, content), privkey,
        channelRelay: groupRelay,
        replyMessage: replyMessage,
        replyMessageRelay: replyMessageRelay,
        replyUser: replyUser,
        replyUserRelay: replyUserRelay,
        subContent: MessageDB.getSubContent(type, content),
        actionsType: actionsType);

    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: event.pubkey,
        receiver: '',
        groupId: groupId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        replyId: replyMessage ?? '',
        content: event.content,
        decryptContent: content,
        type: MessageDB.messageTypeToString(type),
        createTime: event.createdAt,
        status: 0,
        plaintEvent: jsonEncode(event));
    groupMessageCallBack?.call(messageDB);
    await Messages.saveMessageToDB(messageDB);

    if (local) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
        messageDB.status = ok.status ? 1 : 2;
        await Messages.saveMessageToDB(messageDB,
            conflictAlgorithm: ConflictAlgorithm.replace);
        if (!completer.isCompleted) completer.complete(ok);
      });
    }

    return completer.future;
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
