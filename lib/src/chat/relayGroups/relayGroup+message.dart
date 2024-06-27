import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension EMessage on RelayGroup {
  Future<void> handleGroupMessage(Event event, String relay) async {
    GroupMessage groupMessage = Nip29.decodeGroupMessage(event);
    RelayGroupDB? groupDB = myGroups[groupMessage.groupId];
    if (groupDB == null) return;

    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: groupMessage.pubkey,
        receiver: '',
        groupId: groupMessage.groupId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: groupMessage.content,
        replyId: groupMessage.thread.reply?.eventId ?? '',
        createTime: event.createdAt,
        plaintEvent: jsonEncode(event),
        chatType: 4);
    var map = MessageDB.decodeContent(groupMessage.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    messageDB.decryptSecret = map['decryptSecret'];
    int status = await Messages.saveMessageToDB(messageDB);
    if (status != 0) {
      groupMessageCallBack?.call(messageDB);
    }
  }

  Future<void> handleGroupReaction(Event event, String relay) async {}
  Future<void> handleGroupZaps(Event event, String relay) async {}

  Future<Event?> getSendGroupMessageEvent(
      String id, MessageType type, String content, List<String> previous,
      {String? source,
      String? rootEvent,
      String? replyEvent,
      List<String>? replyUsers,
      Event? event,
      bool local = false,
      String? decryptSecret}) async {
    Event event = await Nip29.encodeGroupMessageReply(id,
        MessageDB.getContent(type, content, source), previous, pubkey, privkey,
        rootEvent: rootEvent,
        replyEvent: replyEvent,
        replyUsers: replyUsers,
        subContent: MessageDB.getSubContent(type, content,
            decryptSecret: decryptSecret));
    return event;
  }

  Future<OKEvent> sendGroupMessage(
      String groupId, MessageType type, String content, List<String> previous,
      {String? source,
      String? rootEvent,
      String? replyEvent,
      List<String>? replyUsers,
      Event? event,
      bool local = false,
      String? decryptSecret}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    event ??= await Nip29.encodeGroupMessageReply(groupId,
        MessageDB.getContent(type, content, source), previous, pubkey, privkey,
        rootEvent: rootEvent,
        replyEvent: replyEvent,
        replyUsers: replyUsers,
        subContent: MessageDB.getSubContent(type, content,
            decryptSecret: decryptSecret));

    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: event.pubkey,
        receiver: '',
        groupId: groupId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        replyId: replyEvent ?? rootEvent ?? '',
        content: event.content,
        decryptContent: content,
        type: MessageDB.messageTypeToString(type),
        createTime: event.createdAt,
        status: 0,
        plaintEvent: jsonEncode(event),
        chatType: 4,
        decryptSecret: decryptSecret);
    groupMessageCallBack?.call(messageDB);
    await Messages.saveMessageToDB(messageDB);

    if (local) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      Connect.sharedInstance.sendEvent(event, toRelays: [groupDB.relay],
          sendCallBack: (ok, relay) async {
        messageDB.status = ok.status ? 1 : 2;
        await Messages.saveMessageToDB(messageDB,
            conflictAlgorithm: ConflictAlgorithm.replace);
        if (!completer.isCompleted) completer.complete(ok);
      });
    }
    return completer.future;
  }
}
