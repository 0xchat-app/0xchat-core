import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef MessageActionsCallBack = void Function(MessageDB);

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

  List<String> messagesLoaded = [];

  Future<void> init() async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;

    return;

    // delete event
    List<DeleteEvent> deleteEvents = await _loadDeleteMessagesFromDB();
    for (DeleteEvent deleteEvent in deleteEvents) {
      await _handleDeleteMessages(deleteEvent.deleteEvents, deleteEvent.pubkey);
    }

    // hide message event
    List<ChannelMessageHidden> hiddenMessages = await _loadHideMessagesFromDB();
    for (ChannelMessageHidden hiddenMessage in hiddenMessages) {
      await _handleHideMessage(hiddenMessage.messageId, hiddenMessage.operator);
    }

    _initSubscription();

    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) {
      if (status == 1) {
        _initSubscription();
      }
    });
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
          print('unhandled message $event');
          break;
      }
    }, eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {
      Relays.sharedInstance.syncRelaysToDB();
    });
  }

  void loadMessagesReactions(List<String> eventIds) {
    if (messagesActionsRequestsId.isNotEmpty) {
      Connect.sharedInstance.closeRequests(messagesActionsRequestsId);
    }
    Filter f = Filter(kinds: [7, 9735], ids: eventIds);
    messageRequestsId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) {
      if (Messages.isLoaded(event.id)) return;
      Messages.addToLoaded(event.id);
      switch (event.kind) {
        case 7:
          handleReactionEvent(event);
          break;
        case 9735:
          handleZapRecordEvent(event);
          break;
        default:
          print('unhandled message $event');
          break;
      }
    },
        eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {});
  }

  Future<MessageDB?> loadMessageDBFromDB(String messageId) async {
    final result = await Messages.loadMessagesFromDB(
        where: 'messageId = ?', whereArgs: [messageId]);
    List<MessageDB> messages = result['messages'];
    return (messages.isNotEmpty ? messages.first : null);
  }

  Future<void> handleReactionEvent(Event event) async {
    Reactions reactions = Nip25.decode(event);
    NoteDB reactionsNoteDB = NoteDB.noteDBFromReactions(reactions);
    await DB.sharedInstance.insert<NoteDB>(reactionsNoteDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    final reactedMessageDB =
        await loadMessageDBFromDB(reactions.reactedEventId);
    if (reactedMessageDB == null) return;
    reactedMessageDB.reactionEventIds ??= [];
    if (!reactedMessageDB.reactionEventIds!
        .contains(reactions.reactedEventId)) {
      reactedMessageDB.reactionEventIds!.add(reactions.reactedEventId);
      await DB.sharedInstance.insert<MessageDB>(reactedMessageDB);
      actionsCallBack?.call(reactedMessageDB);
    }
  }

  Future<void> handleZapRecordEvent(Event event) async {
    ZapReceipt zapReceipt = await Nip57.getZapReceipt(
        event,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    ZapRecordsDB zapRecordsDB =
        ZapRecordsDB.zapReceiptToZapRecordsDB(zapReceipt);
    //add to zap records
    await DB.sharedInstance.insert<ZapRecordsDB>(zapRecordsDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    Zaps.sharedInstance.zapRecords[zapRecordsDB.bolt11] = zapRecordsDB;

    final reactedMessageDB = await loadMessageDBFromDB(zapRecordsDB.eventId);
    if (reactedMessageDB == null) return;
    if (!reactedMessageDB.zapEventIds!.contains(zapRecordsDB.eventId)) {
      reactedMessageDB.zapEventIds!.add(zapRecordsDB.eventId);
      await DB.sharedInstance.insert<MessageDB>(reactedMessageDB);
      actionsCallBack?.call(reactedMessageDB);
    }
  }

  Future<OKEvent> sendMessageReaction(String messageId, String content,
      {String? emojiShotCode, String? emojiURL}) async {
    MessageDB? messageDB = await loadMessageDBFromDB(messageId);
    if (messageDB != null) {
      Completer<OKEvent> completer = Completer<OKEvent>();
      Event event = await Nip25.encode(messageId, [messageDB.sender],
          messageDB.kind.toString(), true, pubkey, privkey,
          content: content, emojiShotCode: emojiShotCode, emojiURL: emojiURL);

      NoteDB noteDB = NoteDB.noteDBFromReactions(Nip25.decode(event));
      Moment.sharedInstance.saveNoteToDB(noteDB, null);

      messageDB.reactionEventIds ??= [];
      messageDB.reactionEventIds!.add(event.id);
      saveMessageToDB(messageDB, conflictAlgorithm: ConflictAlgorithm.replace);

      if (messageDB.chatType == 0 || messageDB.chatType == 3) {
        OKEvent ok = await Moment.sharedInstance
            .sendPrivateMessage([messageDB.sender, pubkey], event);
        if (!completer.isCompleted) completer.complete(ok);
      } else {
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
      MessageDB messageDB = MessageDB(
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
    Map result =
        await loadMessagesFromDB(where: 'messageId = ?', whereArgs: eventIds);
    List<MessageDB> messages = result['messages'];
    for (MessageDB message in messages) {
      // only message's owner can delete
      if (message.sender == pubkey) {
        await deleteMessagesFromDB(messageIds: [message.messageId]);
      }
    }
  }

  Future<List<DeleteEvent>> _loadDeleteMessagesFromDB() async {
    Map result = await loadMessagesFromDB(where: 'kind = ?', whereArgs: [5]);
    List<MessageDB> messages = result['messages'];
    List<DeleteEvent> deleteEvents = [];
    for (MessageDB message in messages) {
      if (message.kind == 5) {
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
    }
    return deleteEvents;
  }

  Future<void> _handleHideMessageEvent(Event event) async {
    ChannelMessageHidden messageHidden = Nip28.getMessageHidden(event);
    MessageDB messageDB = MessageDB(
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
    Map result = await loadMessagesFromDB(
        where: 'messageId = ?', whereArgs: [messageId]);
    List<MessageDB> messages = result['messages'];
    if (messages.isNotEmpty) {
      MessageDB message = messages.first;
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
    Map result = await loadMessagesFromDB(where: 'kind = ?', whereArgs: [43]);
    List<MessageDB> messages = result['messages'];
    List<ChannelMessageHidden> hiddenMessages = [];
    for (MessageDB message in messages) {
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
      MessageDB messageDB = MessageDB(
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

  static bool isLoaded(String messageId) {
    return Messages.sharedInstance.messagesLoaded.contains(messageId);
  }

  static bool addToLoaded(String messageId) {
    if (!isLoaded(messageId)) {
      Messages.sharedInstance.messagesLoaded.add(messageId);
      return true;
    }
    return false;
  }

  static Future<Map> loadMessagesFromDB(
      {String? where, List<Object?>? whereArgs, String? orderBy}) async {
    int theLastTime = 0;
    List<MessageDB> messages = await DB.sharedInstance.objects<MessageDB>(
        where: where, whereArgs: whereArgs, orderBy: orderBy);
    for (MessageDB message in messages) {
      theLastTime =
          message.createTime > theLastTime ? message.createTime : theLastTime;
      if (message.content.isNotEmpty &&
          message.decryptContent.isEmpty &&
          message.type != 'text') {
        var map = MessageDB.decodeContent(message.content);
        message.decryptContent = map['content'];
        message.type = map['contentType'];
      }
      Messages.addToLoaded(message.messageId);
      if (!Connect.sharedInstance.eventCache.contains(message.messageId)) {
        Connect.sharedInstance.eventCache.add(message.messageId);
      }
      if (message.giftWrappedId.isNotEmpty &&
          !Connect.sharedInstance.eventCache.contains(message.giftWrappedId)) {
        Connect.sharedInstance.eventCache.add(message.giftWrappedId);
      }
    }
    return {'theLastTime': theLastTime, 'messages': messages};
  }

  static Future<void> updateMessagesReadStatus(
      String where, List<Object?> whereArgs, bool read) async {
    await DB.sharedInstance
        .rawUpdate('UPDATE MessageDB SET read = $read WHERE $where', whereArgs);
  }

  static Future<void> updateMessageReadStatus(MessageDB message) async {
    await DB.sharedInstance.update(message);
  }

  static Future<int> saveMessageToDB(MessageDB message,
      {ConflictAlgorithm? conflictAlgorithm}) async {
    return await DB.sharedInstance.insert<MessageDB>(message,
        conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.ignore);
  }

  static deleteMessagesFromDB(
      {List<String>? messageIds,
      String? where,
      List<Object?>? whereArgs}) async {
    if (where != null) {
      await DB.sharedInstance
          .delete<MessageDB>(where: where, whereArgs: whereArgs);
    } else if (messageIds != null && messageIds.isNotEmpty) {
      await DB.sharedInstance
          .delete<MessageDB>(where: 'messageId = ?', whereArgs: messageIds);
    }
  }

  static Future<OKEvent> deleteMessageFromRelay(
      List<String> messageIds, String reason) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    /// delete frome DB
    deleteMessagesFromDB(messageIds: messageIds);

    /// send delete event to relay
    Event event = await Nip9.encode(
        messageIds,
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
