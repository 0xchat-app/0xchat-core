import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension EMessage on RelayGroup {
  Future<void> handleGroupMessage(Event event, String relay) async {
    if (Contacts.sharedInstance.inBlockList(event.pubkey)) return;
    GroupMessage groupMessage = Nip29.decodeGroupMessage(event);
    RelayGroupDBISAR? groupDB = myGroups[groupMessage.groupId];
    if (groupDB == null) return;

    MessageDBISAR messageDB = MessageDBISAR(
        messageId: event.id,
        sender: groupMessage.pubkey,
        receiver: '',
        groupId: groupMessage.groupId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: groupMessage.content,
        replyId: groupMessage.thread.root.eventId ?? '',
        createTime: event.createdAt,
        plaintEvent: jsonEncode(event),
        chatType: 4);
    var map = await MessageDBISAR.decodeContent(groupMessage.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    messageDB.decryptSecret = map['decryptSecret'];
    await Messages.saveMessageToDB(messageDB);
    groupMessageCallBack?.call(messageDB);
  }

  Future<void> handleGroupReaction(Event event, String relay) async {
    await Messages.sharedInstance.handleReactionEvent(event);
  }

  Future<void> handleGroupZaps(Event event, String relay) async {
    await Messages.sharedInstance.handleZapRecordEvent(event);
  }

  Future<Event?> getSendGroupMessageEvent(
      String id, MessageType type, String content, List<String> previous,
      {String? source,
      String? rootEvent,
      String? replyEvent,
      List<String>? replyUsers,
      Event? event,
      bool local = false,
      String? decryptSecret}) async {
    Event event = await Nip29.encodeGroupMessageReply(
        id,
        MessageDBISAR.getContent(type, content, source),
        previous,
        pubkey,
        privkey,
        rootEvent: rootEvent,
        replyEvent: replyEvent,
        replyUsers: replyUsers,
        subContent: MessageDBISAR.getSubContent(type, content,
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
      String? decryptSecret,
      int createAt = 0,
      String? replaceMessageId}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    RelayGroupDBISAR? groupDB = groups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    event ??= await Nip29.encodeGroupMessageReply(
        groupId,
        MessageDBISAR.getContent(type, content, source),
        previous,
        pubkey,
        privkey,
        rootEvent: rootEvent,
        replyEvent: replyEvent,
        replyUsers: replyUsers,
        subContent: MessageDBISAR.getSubContent(type, content,
            decryptSecret: decryptSecret),
        createAt: createAt);

    late MessageDBISAR messageDB;
    if (replaceMessageId != null) {
      messageDB =
          await Messages.sharedInstance.loadMessageDBFromDB(replaceMessageId) ??
              MessageDBISAR();
      messageDB.messageId = event.id;
      groupMessageUpdateCallBack?.call(messageDB, replaceMessageId);
    } else {
      messageDB = MessageDBISAR(
          messageId: event.id,
          sender: event.pubkey,
          receiver: '',
          groupId: groupId,
          kind: event.kind,
          tags: jsonEncode(event.tags),
          replyId: rootEvent ?? '',
          content: event.content,
          decryptContent: content,
          type: MessageDBISAR.messageTypeToString(type),
          createTime: event.createdAt,
          status: 0,
          plaintEvent: jsonEncode(event),
          chatType: 4,
          decryptSecret: decryptSecret);
      groupMessageCallBack?.call(messageDB);
    }
    var map = await MessageDBISAR.decodeContent(MessageDBISAR.getSubContent(
            type, content,
            decryptSecret: decryptSecret) ??
        event.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    messageDB.decryptSecret = map['decryptSecret'];
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

  Future<OKEvent> sendToGroup(String groupId, Event event) async {
    RelayGroupDBISAR? groupDB = myGroups[groupId];
    if (groupDB != null) {
      Completer<OKEvent> completer = Completer<OKEvent>();
      Connect.sharedInstance.sendEvent(event, toRelays: [groupDB.relay],
          sendCallBack: (ok, relay) async {
        if (!completer.isCompleted) completer.complete(ok);
      });
      return completer.future;
    } else {
      return OKEvent(event.id, false, 'relay group not found');
    }
  }
}
