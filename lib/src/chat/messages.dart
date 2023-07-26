import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class Messages {
  /// singleton
  Messages._internal();
  factory Messages() => sharedInstance;
  static final Messages sharedInstance = Messages._internal();

  static final int maxReportCount = 3;

  String pubkey = '';
  String privkey = '';
  String messageRequestsId = '';

  Future<void> initWithPrivkey(String key) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);

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
      await saveMessagesToDB([messageDB]);
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
        await deleteMessagesFromDB([message.messageId!]);
      }
    }
  }

  Future<List<DeleteEvent>> _loadDeleteMessagesFromDB() async {
    Map result = await loadMessagesFromDB(where: 'kind = ?', whereArgs: [5]);
    List<MessageDB> messages = result['messages'];
    List<DeleteEvent> deleteEvents = [];
    for (MessageDB message in messages) {
      if (message.kind == 5) {
        List<dynamic> tags = jsonDecode(message.tags!);
        List<String> deleteEventIds = Nip9.tagsToList(tags.map((item) {
          return List<String>.from(item.cast<String>());
        }).toList());
        if (deleteEventIds.isNotEmpty) {
          DeleteEvent deleteEvent = DeleteEvent(message.sender!, deleteEventIds,
              message.content!, message.createTime!);
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
    await saveMessagesToDB([messageDB]);
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
        await deleteMessagesFromDB([message.messageId!]);
      } else {
        // hide by others, add to report list
        List<String>? reportList = message.reportList;
        if (reportList != null && reportList.isNotEmpty) {
          if (reportList.length >= maxReportCount) {
            await deleteMessagesFromDB([messageId]);
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
      List<dynamic> tags = jsonDecode(message.tags!);
      String? hiddenMessageId = Nip28.tagsToMessageId(tags.map((item) {
        return List<String>.from(item.cast<String>());
      }).toList());
      ChannelMessageHidden hidden = ChannelMessageHidden(message.sender!,
          hiddenMessageId!, message.content!, message.createTime!);
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
      await saveMessagesToDB([messageDB]);
      await Channels.sharedInstance.handleMuteUser(userMuted.userPubkey);
    }
  }

  static Future<Map> loadMessagesFromDB(
      {String? where, List<Object?>? whereArgs, String? orderBy}) async {
    int theLastTime = 0;
    List<MessageDB> messages = await DB.sharedInstance.objects<MessageDB>(
        where: where, whereArgs: whereArgs, orderBy: orderBy);
    for (MessageDB message in messages) {
      theLastTime =
          message.createTime! > theLastTime ? message.createTime! : theLastTime;
      if (message.decryptContent == null || message.decryptContent!.isEmpty) {
        message.decryptContent =
            MessageDB.decodeContent(message.content!)['content'];
        message.type = MessageDB.decodeContent(message.content!)['contentType'];
      }
    }
    return {'theLastTime': theLastTime, 'messages': messages};
  }

  static Future<void> updateMessagesReadStatus(String where, List<Object?> whereArgs, bool read) async {
    await DB.sharedInstance
        .rawUpdate('UPDATE MessageDB SET read = $read WHERE $where', whereArgs);
  }

  static Future<void> saveMessagesToDB(List<MessageDB> messages,
      {ConflictAlgorithm? conflictAlgorithm}) async {
    for (var message in messages) {
      await DB.sharedInstance.insert<MessageDB>(message,
          conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.ignore);
    }
  }

  static deleteMessagesFromDB(List<String> messageIds) async {
    await DB.sharedInstance
        .delete<MessageDB>(where: 'messageId = ?', whereArgs: messageIds);
  }

  static Future<OKEvent> deleteMessageFromRelay(
      List<String> messageIds, String reason, String privkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    /// delete frome DB
    deleteMessagesFromDB(messageIds);

    /// send delete event to relay
    Event event = Nip9.encode(messageIds, reason, privkey);
    Connect.sharedInstance.sendEvent(event,
        sendCallBack: (ok, relay, unRelays) {
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
