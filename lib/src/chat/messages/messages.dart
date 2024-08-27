import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef MessageActionsCallBack = void Function(MessageDBISAR);
typedef MessagesDeleteCallBack = void Function(List<MessageDBISAR>);

class Messages {
  /// singleton
  Messages._internal();
  factory Messages() => sharedInstance;
  static final Messages sharedInstance = Messages._internal();

  static final int maxReportCount = 3;

  String pubkey = '';
  String privkey = '';
  String messageRequestsId = '';
  String messagesActionsRequestsId = '';
  MessageActionsCallBack? actionsCallBack;
  MessagesDeleteCallBack? deleteCallBack;

  final Completer<void> channelMessageCompleter = Completer<void>();
  final Completer<void> groupMessageCompleter = Completer<void>();
  final Completer<void> contactMessageCompleter = Completer<void>();
  final Completer<void> secretChatMessageCompleter = Completer<void>();

  Future<void> init() async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;

    refindActionsFromDB();

    Future.wait([
      channelMessageCompleter.future,
      groupMessageCompleter.future,
      contactMessageCompleter.future,
      secretChatMessageCompleter.future
    ]).then((value) {
      refindActionsFromDB();
    });
    return;
  }

  Future<void> refindActionsFromDB() async {
    final isar = DBISAR.sharedInstance.isar;
    List<NoteDBISAR> reactions = await isar.noteDBISARs
        .filter()
        .reactedIdIsNotEmpty()
        .findEventEqualTo(false)
        .findAll();
    for (var reaction in reactions) {
      String eventId = reaction.reactedId!;
      MessageDBISAR? message = await isar.messageDBISARs
          .filter()
          .messageIdEqualTo(eventId)
          .findFirst();
      if (message != null) {
        message = message.withGrowableLevels();
        message.reactionEventIds ??= [];
        if (!message.reactionEventIds!.contains(reaction.noteId)) {
          message.reactionEventIds!.add(reaction.noteId);
          await DBISAR.sharedInstance.saveToDB(message);
          actionsCallBack?.call(message);
        }
        reaction.findEvent = true;
        await DBISAR.sharedInstance.saveToDB(reaction);
      }
    }
    List<ZapRecordsDBISAR> zaps =
        await isar.zapRecordsDBISARs.filter().findEventEqualTo(false).findAll();
    for (var zap in zaps) {
      String eventId = zap.eventId;
      MessageDBISAR? message = await isar.messageDBISARs
          .filter()
          .messageIdEqualTo(eventId)
          .findFirst();
      if (message != null) {
        message = message.withGrowableLevels();
        message.reactionEventIds ??= [];
        if (!message.reactionEventIds!.contains(zap.bolt11)) {
          message.reactionEventIds!.add(zap.bolt11);
          await DBISAR.sharedInstance.saveToDB(message);
          actionsCallBack?.call(message);
        }
        zap.findEvent = true;
        await DBISAR.sharedInstance.saveToDB(zap);
      }
    }
  }

  void _initSubscription() {
    if (messageRequestsId.isNotEmpty) {
      Connect.sharedInstance.closeRequests(messageRequestsId);
    }

    Map<String, List<Filter>> subscriptions = {};
    for (String relayURL in Connect.sharedInstance.relays()) {
      int commonMessagesUntil =
          Relays.sharedInstance.getCommonMessageUntil(relayURL);
      Filter f = Filter(kinds: [43, 44], since: commonMessagesUntil + 1);
      subscriptions[relayURL] = [f];
    }

    messageRequestsId = Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) {
      Relays.sharedInstance.setCommonMessageUntil(event.createdAt, relay);
      Relays.sharedInstance.setCommonMessageSince(event.createdAt, relay);
      switch (event.kind) {
        case 5:
          _handleDeleteEvent(event);
          break;
        case 43:
          _handleHideMessageEvent(event);
          break;
        case 44:
          _handleMuteUserEvent(event);
          break;
        default:
          LogUtils.v(() => 'messages unhandled message ${event.toJson()}');
          break;
      }
    }, eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {
      Relays.sharedInstance.syncRelaysToDB();
    });
  }

  Future<void> closeMessagesActionsRequests() async {
    if (messagesActionsRequestsId.isNotEmpty) {
      await Connect.sharedInstance.closeRequests(messagesActionsRequestsId);
    }
  }

  Future<void> loadMessagesReactions(
      List<String> eventIds, int chatType) async {
    if (eventIds.isEmpty) return;
    await closeMessagesActionsRequests();
    late Filter f;
    switch (chatType) {
      case 2:
        f = Filter(kinds: [7, 9735], e: eventIds);
        break;
      default:
        return;
    }
    messagesActionsRequestsId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) {
      switch (event.kind) {
        case 7:
          handleReactionEvent(event);
          break;
        case 9735:
          handleZapRecordEvent(event);
          break;
        default:
          LogUtils.v(() => 'unhandled message $event');
          break;
      }
    },
        eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {});
  }

  Future<MessageDBISAR?> loadMessageDBFromDB(String messageId) async {
    final isar = DBISAR.sharedInstance.isar;
    var queryBuilder =
        isar.messageDBISARs.where().filter().messageIdEqualTo(messageId);
    final message = await queryBuilder.findFirst();
    return message?.withGrowableLevels();
  }

  Future<void> handleReactionEvent(Event event) async {
    Reactions reactions = Nip25.decode(event);
    NoteDBISAR reactionsNoteDB = NoteDBISAR.noteDBFromReactions(reactions);
    Moment.sharedInstance
        .saveNoteToDB(reactionsNoteDB, ConflictAlgorithm.ignore);
    final reactedMessageDB =
        await loadMessageDBFromDB(reactions.reactedEventId);
    if (reactedMessageDB == null) return;
    reactedMessageDB.reactionEventIds ??= [];
    if (!reactedMessageDB.reactionEventIds!.contains(reactions.id)) {
      reactedMessageDB.reactionEventIds!.add(reactions.id);
      await saveMessageToDB(reactedMessageDB);
      actionsCallBack?.call(reactedMessageDB);
    }
  }

  Future<void> handleZapRecordEvent(Event event) async {
    ZapReceipt zapReceipt = await Nip57.getZapReceipt(
        event,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    ZapRecordsDBISAR zapRecordsDB =
        ZapRecordsDBISAR.zapReceiptToZapRecordsDB(zapReceipt);
    //add to zap records
    await Zaps.saveZapRecordToDB(zapRecordsDB);
    Zaps.sharedInstance.zapRecords[zapRecordsDB.bolt11] = zapRecordsDB;

    final reactedMessageDB = await loadMessageDBFromDB(zapRecordsDB.eventId);
    if (reactedMessageDB == null) return;
    reactedMessageDB.zapEventIds ??= [];
    if (!reactedMessageDB.zapEventIds!.contains(zapRecordsDB.bolt11)) {
      reactedMessageDB.zapEventIds!.add(zapRecordsDB.bolt11);
      await saveMessageToDB(reactedMessageDB);
      actionsCallBack?.call(reactedMessageDB);
    }
  }

  Future<OKEvent> sendMessageReaction(String messageId, String content,
      {String? emojiShotCode, String? emojiURL, String? groupId}) async {
    MessageDBISAR? messageDB = await loadMessageDBFromDB(messageId);
    if (messageDB != null) {
      Completer<OKEvent> completer = Completer<OKEvent>();
      Event event = await Nip25.encode(messageId, [messageDB.sender],
          messageDB.kind.toString(), true, pubkey, privkey,
          content: content,
          emojiShotCode: emojiShotCode,
          emojiURL: emojiURL,
          relayGroupId: groupId);

      NoteDBISAR noteDB = NoteDBISAR.noteDBFromReactions(Nip25.decode(event));
      Moment.sharedInstance.saveNoteToDB(noteDB, null);

      // messageDB.reactionEventIds ??= [];
      // messageDB.reactionEventIds!.add(event.id);
      // saveMessageToDB(messageDB, conflictAlgorithm: ConflictAlgorithm.replace);
      switch (messageDB.chatType) {
        case 0:
        case 3:
          OKEvent ok = await Moment.sharedInstance
              .sendPrivateMessage([messageDB.sender, pubkey], event);
          if (!completer.isCompleted) completer.complete(ok);
          break;
        case 1:
          if (groupId != null) {
            OKEvent ok =
                await Groups.sharedInstance.sendToGroup(groupId, event);
            if (!completer.isCompleted) completer.complete(ok);
            break;
          }
        case 4:
          if (groupId != null) {
            OKEvent ok =
                await RelayGroup.sharedInstance.sendToGroup(groupId, event);
            if (!completer.isCompleted) completer.complete(ok);
            break;
          }
        default:
          Connect.sharedInstance.sendEvent(event,
              sendCallBack: (ok, relay) async {
            if (!completer.isCompleted) completer.complete(ok);
          });
      }
      return completer.future;
    } else {
      return OKEvent(messageId, false, 'reacted message DB == null');
    }
  }

  Future<void> _handleDeleteEvent(Event event) async {
    DeleteEvent? deleteEvent = Nip9.decode(event);
    if (deleteEvent != null) {
      MessageDBISAR messageDB = MessageDBISAR(
          messageId: event.id,
          sender: event.pubkey,
          kind: event.kind,
          tags: jsonEncode(event.tags),
          content: event.content,
          createTime: event.createdAt);
      await saveMessageToDB(messageDB);
      await _handleDeleteMessages(deleteEvent.deleteEvents, deleteEvent.pubkey);
    }
  }

  Future<void> _handleDeleteMessages(
      List<String> eventIds, String pubkey) async {
    MessageDBISAR? message = await loadMessageDBFromDB(eventIds.first);
    if (message != null && message.sender == pubkey) {
      await deleteMessagesFromDB(messageIds: [message.messageId]);
    }
  }

  Future<List<DeleteEvent>> _loadDeleteMessagesFromDB() async {
    final isar = DBISAR.sharedInstance.isar;
    var queryBuilder = isar.messageDBISARs.where().filter().kindEqualTo(5);
    final messages = await queryBuilder.sortByCreateTimeDesc().findAll();
    List<DeleteEvent> deleteEvents = [];
    if (messages.isNotEmpty) {
      var message = messages.first;
      List<dynamic> tags = jsonDecode(message.tags);
      List<String> deleteEventIds = Nip9.tagsToList(tags.map((item) {
        return List<String>.from(item.cast<String>());
      }).toList());
      if (deleteEventIds.isNotEmpty) {
        DeleteEvent deleteEvent = DeleteEvent(message.sender, deleteEventIds,
            message.content, message.createTime);
        deleteEvents.add(deleteEvent);
      }
    }
    return deleteEvents;
  }

  Future<void> _handleHideMessageEvent(Event event) async {
    ChannelMessageHidden messageHidden = Nip28.getMessageHidden(event);
    MessageDBISAR messageDB = MessageDBISAR(
        messageId: event.id,
        sender: event.pubkey,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: event.content,
        createTime: event.createdAt);
    await saveMessageToDB(messageDB);
    await _handleHideMessage(messageHidden.messageId, messageHidden.operator);
  }

  Future<void> _handleHideMessage(String messageId, String operator) async {
    MessageDBISAR? message = await loadMessageDBFromDB(messageId);
    if (message != null) {
      if (operator == pubkey) {
        // hide by me, delete
        await deleteMessagesFromDB(messageIds: [message.messageId]);
      } else {
        // hide by others, add to report list
        List<String>? reportList = message.reportList;
        if (reportList != null && reportList.isNotEmpty) {
          if (reportList.length >= maxReportCount) {
            await deleteMessagesFromDB(messageIds: [messageId]);
          } else {
            reportList.add(messageId);
            message.reportList = reportList;
          }
        }
      }
    }
  }

  Future<List<ChannelMessageHidden>> _loadHideMessagesFromDB() async {
    final isar = DBISAR.sharedInstance.isar;
    var queryBuilder = isar.messageDBISARs.where().filter().kindEqualTo(43);
    final messages = await queryBuilder.sortByCreateTimeDesc().findAll();
    List<ChannelMessageHidden> hiddenMessages = [];
    if (messages.isNotEmpty) {
      var message = messages.first;
      List<dynamic> tags = jsonDecode(message.tags);
      String? hiddenMessageId = Nip28.tagsToMessageId(tags.map((item) {
        return List<String>.from(item.cast<String>());
      }).toList());
      ChannelMessageHidden hidden = ChannelMessageHidden(message.sender,
          hiddenMessageId!, message.content, message.createTime);
      hiddenMessages.add(hidden);
    }
    return hiddenMessages;
  }

  Future<void> _handleMuteUserEvent(Event event) async {
    ChannelUserMuted userMuted = Nip28.getUserMuted(event);
    if (userMuted.operator == pubkey) {
      MessageDBISAR messageDB = MessageDBISAR(
          messageId: event.id,
          sender: event.pubkey,
          kind: event.kind,
          tags: jsonEncode(event.tags),
          content: event.content,
          createTime: event.createdAt);
      await saveMessageToDB(messageDB);
      await Channels.sharedInstance.handleMuteUser(userMuted.userPubkey);
    }
  }

  static List<MessageDBISAR> loadMessagesFromCache(
      {String? receiver, String? groupId, String? sessionId, int? until}) {
    final Map<Type, List<dynamic>> buffers = DBISAR.sharedInstance.getBuffers();
    List<MessageDBISAR> result = [];
    for (MessageDBISAR message in buffers[MessageDBISAR]?.toList() ?? []) {
      bool query = true;
      if (query && receiver != null) {
        query = (message.sender == receiver &&
                message.receiver == Account.sharedInstance.currentPubkey) ||
            (message.sender == Account.sharedInstance.currentPubkey &&
                message.receiver == receiver);
      }
      if (query && groupId != null) {
        query = message.groupId == groupId;
      }
      if (query && sessionId != null) {
        query = message.sessionId == sessionId;
      }
      if (query && until != null) {
        query = message.createTime < until;
      }
      if (query) result.add(message);
    }
    return result;
  }

  static Future<Map> loadMessagesFromDB(
      {String? receiver,
      String? groupId,
      String? sessionId,
      int? until,
      int? limit}) async {
    final isar = DBISAR.sharedInstance.isar;
    var queryBuilder = isar.messageDBISARs.filter().idLessThan(Isar.maxId);
    if (receiver != null) {
      queryBuilder = queryBuilder
          .group((q) => q
              .senderEqualTo(receiver)
              .and()
              .receiverEqualTo(Account.sharedInstance.currentPubkey)
              .and()
              .sessionIdIsEmpty())
          .or()
          .group((q) => q
              .senderEqualTo(Account.sharedInstance.currentPubkey)
              .and()
              .receiverEqualTo(receiver)
              .and()
              .sessionIdIsEmpty());
    }
    queryBuilder = sessionId != null
        ? queryBuilder.sessionIdEqualTo(sessionId)
        : queryBuilder.sessionIdIsEmpty();
    queryBuilder = groupId != null
        ? queryBuilder.groupIdEqualTo(groupId)
        : queryBuilder.groupIdIsEmpty();

    if (until != null) {
      queryBuilder = queryBuilder.createTimeLessThan(until);
    }
    final messages = limit == null
        ? await queryBuilder.sortByCreateTimeDesc().findAll()
        : await queryBuilder.sortByCreateTimeDesc().limit(limit).findAll();

    int theLastTime = 0;
    List<MessageDBISAR> result = loadMessagesFromCache(
        receiver: receiver,
        groupId: groupId,
        sessionId: sessionId,
        until: until);
    for (var message in messages) {
      message = message.withGrowableLevels();
      theLastTime =
          message.createTime > theLastTime ? message.createTime : theLastTime;
      if (message.content.isNotEmpty &&
          message.decryptContent.isEmpty &&
          message.type != 'text') {
        var map = await MessageDBISAR.decodeContent(message.content);
        message.decryptContent = map['content'];
        message.type = map['contentType'];
      }
      result.add(message);
    }
    return {'theLastTime': theLastTime, 'messages': result};
  }

  static Future<Map> searchGroupMessagesFromDB(
      String? groupId, String decryptContentLike) async {
    final isar = DBISAR.sharedInstance.isar;
    List<MessageDBISAR> messages;
    if (groupId != null) {
      messages = await isar.messageDBISARs
          .filter()
          .groupIdEqualTo(groupId)
          .decryptContentContains(decryptContentLike, caseSensitive: false)
          .sortByCreateTimeDesc()
          .findAll();
    } else {
      messages = await isar.messageDBISARs
          .filter()
          .groupIdIsNotEmpty()
          .decryptContentContains(decryptContentLike, caseSensitive: false)
          .sortByCreateTimeDesc()
          .findAll();
    }
    int theLastTime = 0;
    for (var message in messages) {
      theLastTime =
          message.createTime > theLastTime ? message.createTime : theLastTime;
      if (message.content.isNotEmpty &&
          message.decryptContent.isEmpty &&
          message.type != 'text') {
        var map = await MessageDBISAR.decodeContent(message.content);
        message.decryptContent = map['content'];
        message.type = map['contentType'];
      }
    }
    return {'theLastTime': theLastTime, 'messages': messages};
  }

  static Future<Map> searchPrivateMessagesFromDB(
      String? chatId, String orignalSearchTxt) async {
    final isar = DBISAR.sharedInstance.isar;
    List<MessageDBISAR> messages;
    if (chatId == null) {
      messages = await isar.messageDBISARs
          .filter()
          .senderIsNotEmpty()
          .receiverIsNotEmpty()
          .decryptContentContains(orignalSearchTxt, caseSensitive: false)
          .findAll();
    } else {
      messages = await isar.messageDBISARs
          .filter()
          .group((q) => q
              .senderEqualTo(chatId)
              .and()
              .receiverEqualTo(Account.sharedInstance.currentPubkey))
          .or()
          .group((q) => q
              .senderEqualTo(Account.sharedInstance.currentPubkey)
              .and()
              .receiverEqualTo(chatId))
          .and()
          .decryptContentContains(orignalSearchTxt, caseSensitive: false)
          .findAll();
    }
    int theLastTime = 0;
    for (var message in messages) {
      theLastTime =
          message.createTime > theLastTime ? message.createTime : theLastTime;
      if (message.content.isNotEmpty &&
          message.decryptContent.isEmpty &&
          message.type != 'text') {
        var map = await MessageDBISAR.decodeContent(message.content);
        message.decryptContent = map['content'];
        message.type = map['contentType'];
      }
    }
    return {'theLastTime': theLastTime, 'messages': messages};
  }

  static Future<void> saveMessageToDB(MessageDBISAR message,
      {ConflictAlgorithm? conflictAlgorithm}) async {
    await DBISAR.sharedInstance.saveToDB(message);
  }

  static deleteMessagesFromDB({List<String>? messageIds}) async {
    if (messageIds != null) {
      final isar = DBISAR.sharedInstance.isar;
      var queryBuilder = isar.messageDBISARs.where();
      final messages = await queryBuilder
          .anyOf(messageIds, (q, messageId) => q.messageIdEqualTo(messageId))
          .findAll();
      await isar.writeTxn(() async {
        await isar.messageDBISARs
            .filter()
            .anyOf(messageIds, (q, messageId) => q.messageIdEqualTo(messageId))
            .deleteAll();
      });
      Messages.sharedInstance.deleteCallBack?.call(messages);
    }
  }

  static deleteGroupMessagesFromDB(String? groupId) async {
    if (groupId != null) {
      final isar = DBISAR.sharedInstance.isar;
      await isar.writeTxn(() async {
        await isar.messageDBISARs.filter().groupIdEqualTo(groupId).deleteAll();
      });
    }
  }

  static deleteSingleChatMessagesFromDB(String sender, String receiver) async {
    final isar = DBISAR.sharedInstance.isar;
    await isar.writeTxn(() async {
      await isar.messageDBISARs
          .filter()
          .senderEqualTo(sender)
          .receiverEqualTo(receiver)
          .chatTypeEqualTo(0)
          .deleteAll();
    });
  }

  static Future<OKEvent> deleteMessageFromRelay(
      String messageId, String reason) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    var message = await Messages.sharedInstance.loadMessageDBFromDB(messageId);
    if (message != null && message.chatType == 4) {
      // relay group
      return await RelayGroup.sharedInstance
          .deleteMessageFromRelay(message.groupId, messageId, '');
    }

    /// delete frome DB
    deleteMessagesFromDB(messageIds: [messageId]);

    /// send delete event to relay
    Event event = await Nip9.encode(
        [messageId],
        reason,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  static List<ProfileMention> decodeProfileMention(String content) {
    return Nip27.decodeProfileMention(content);
  }

  static String encodeProfileMention(
      List<ProfileMention> mentions, String content) {
    return Nip27.encodeProfileMention(mentions, content);
  }
}
