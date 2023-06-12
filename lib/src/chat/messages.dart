import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class Messages {
  /// singleton
  Messages._internal();
  factory Messages() => sharedInstance;
  static final Messages sharedInstance = Messages._internal();

  static final int maxReportCount = 3;

  UserDB? me;
  String pubkey = '';
  String privkey = '';
  String messageSubscription = '';
  int lastUpdated = 0;

  Future<void> initWithPrivkey(String key) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
    me = await Account.getUserFromDB(privkey: key);
    me ??= UserDB(pubKey: pubkey, privkey: privkey);

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
  }

  void _initSubscription() {
    if (messageSubscription.isNotEmpty) {
      Connect.sharedInstance.closeSubscription(messageSubscription);
    }

    Filter f = Filter(kinds: [5, 43, 44], since: lastUpdated);
    messageSubscription =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
      lastUpdated =
          lastUpdated > event.createdAt ? lastUpdated : event.createdAt;
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
        List<String> deleteEventIds =
            Nip9.tagsToList(jsonDecode(message.tags!));
        if (deleteEventIds.isNotEmpty) {
          DeleteEvent deleteEvent = DeleteEvent(message.sender!, deleteEventIds,
              message.content!, message.createTime!);
          deleteEvents.add(deleteEvent);
          lastUpdated = lastUpdated > deleteEvent.deleteTime
              ? lastUpdated
              : deleteEvent.deleteTime;
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
      String? hiddenMessageId =
          Nip28.tagsToMessageId(jsonDecode(message.tags!));
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
      if (message.kind == 4) {
        // private message
        String sender = (message.sender == Friends.sharedInstance.pubkey)
            ? message.receiver!
            : message.sender!;
        UserDB? friend = Friends.sharedInstance.friends[sender];
        if (friend != null && friend.aliasPubkey!.isNotEmpty) {
          String content = Nip4.decryptContent(
            message.content!,
            friend.toAliasPrivkey!,
            friend.aliasPubkey!,
          );
          Map<String, dynamic> decodeContent = MessageDB.decodeContent(content);
          message.decryptContent = decodeContent['content'];
          message.type =
              MessageDB.stringtoMessageType(decodeContent['contentType']);
        }
      } else if (message.kind == 42) {
        // channel message
        Map<String, dynamic> decodeContent =
            MessageDB.decodeContent(message.content!);
        message.decryptContent = decodeContent['content'];
        message.type =
            MessageDB.stringtoMessageType(decodeContent['contentType']);
      }
    }
    return {'theLastTime': theLastTime, 'messages': messages};
  }

  static saveMessagesToDB(List<MessageDB> messages) async {
    for (var message in messages) {
      await DB.sharedInstance.insert<MessageDB>(message);
    }
  }

  static deleteMessagesFromDB(List<String> messageIds) async {
    await DB.sharedInstance
        .delete<MessageDB>(where: 'messageId = ?', whereArgs: messageIds);
  }

  static deleteMessageFromRelay(
      List<String> messageIds, String reason, String privkey) {
    /// delete frome DB
    deleteMessagesFromDB(messageIds);

    /// send delete event to relay
    Event event = Nip9.encode(messageIds, reason, privkey);
    Connect.sharedInstance.sendEvent(event);
  }

  static List<ProfileMention> decodeProfileMention(String content) {
    return Nip27.decodeProfileMention(content);
  }

  static String encodeProfileMention(
      List<ProfileMention> mentions, String content) {
    return Nip27.encodeProfileMention(mentions, content);
  }
}
