import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:chatcore/chat-core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef SecretChatRequestCallBack = void Function(SecretSessionDBISAR);
typedef SecretChatAcceptCallBack = void Function(SecretSessionDBISAR);
typedef SecretChatRejectCallBack = void Function(SecretSessionDBISAR);
typedef SecretChatUpdateCallBack = void Function(SecretSessionDBISAR);
typedef SecretChatCloseCallBack = void Function(SecretSessionDBISAR);
typedef PrivateChatMessageCallBack = void Function(MessageDBISAR);
typedef PrivateChatMessageUpdateCallBack = void Function(MessageDBISAR, String);
typedef SecretChatMessageCallBack = void Function(MessageDBISAR);
typedef SecretChatMessageUpdateCallBack = void Function(MessageDBISAR, String);
typedef ContactUpdatedCallBack = void Function();
typedef OfflinePrivateMessageFinishCallBack = void Function();

enum CallMessageState {
  disconnect,
  offer,
  answer,
  reject,
  timeout,
  cancel,
  inCalling
}

class CallMessage {
  String callId;
  String sender;
  String receiver;
  CallMessageState state;
  int start;
  int end;
  String media;

  CallMessage(this.callId, this.sender, this.receiver, this.state, this.start,
      this.end, this.media);
}

class Contacts {
  static final String identifier = 'Chat-Friends';
  static final String blockListidentifier = 'Chat-Block';

  /// singleton
  Contacts._internal();
  factory Contacts() => sharedInstance;
  static final Contacts sharedInstance = Contacts._internal();

  /// memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, UserDBISAR> allContacts = {};
  Map<String, SecretSessionDBISAR> secretSessionMap = {};
  String secretSessionSubscription = '';
  String friendMessageSubscription = '';
  int lastFriendListUpdateTime = 0;
  List<String>? blockList;
  Map<String, CallMessage> callMessages = {};
  int maxLimit = 2048;
  int offset2 = 24 * 60 * 60 * 2;

  /// callbacks
  SecretChatRequestCallBack? secretChatRequestCallBack;
  SecretChatAcceptCallBack? secretChatAcceptCallBack;
  SecretChatRejectCallBack? secretChatRejectCallBack;
  SecretChatUpdateCallBack? secretChatUpdateCallBack;
  SecretChatCloseCallBack? secretChatCloseCallBack;
  SecretChatMessageCallBack? secretChatMessageCallBack;
  SecretChatMessageUpdateCallBack? secretChatMessageUpdateCallBack;
  PrivateChatMessageCallBack? privateChatMessageCallBack;
  PrivateChatMessageUpdateCallBack? privateChatMessageUpdateCallBack;
  ContactUpdatedCallBack? contactUpdatedCallBack;
  OfflinePrivateMessageFinishCallBack? offlinePrivateMessageFinishCallBack;
  OfflinePrivateMessageFinishCallBack? offlineSecretMessageFinishCallBack;
  Map<String, bool> offlinePrivateMessageFinish = {};
  Map<String, bool> offlineSecretMessageFinish = {};

  void Function(
          String friend, SignalingState state, String data, String? offerId)?
      onCallStateChange;

  Future<void> initContacts(ContactUpdatedCallBack? callBack) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    contactUpdatedCallBack = callBack;

    Account.sharedInstance.contactListUpdateCallback = () async {
      await _syncContactsFromDB();
      _subscriptMoment();
    };
    // subscript friend requests
    Connect.sharedInstance
        .addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 &&
          Account.sharedInstance.me != null &&
          (relayKinds.contains(RelayKind.general) ||
              relayKinds.contains(RelayKind.dm))) {
        _subscriptMessages(relay: relay);
        _updateSubscriptions(relay: relay);
      }
    });
    _subscriptMessages();
    // sync friend list from DB & relays
    await syncBlockListFromDB();
    await _syncContactsFromDB();
    await syncSecretSessionFromDB();

    _updateSubscriptions();
  }

  Future<void> _updateSubscriptions({String? relay}) async {
    _subscriptMoment(relay: relay);
    subscriptSecretChat(relay: relay);
  }

  /// contact list
  Future<void> _syncContactsToDB(String list) async {
    Account.sharedInstance.me?.friendsList = list;
    await Account.sharedInstance.syncMe();
  }

  Future<void> _syncContactsToRelay({OKCallBack? okCallBack}) async {
    List<People> friendList = [];
    for (UserDBISAR user in allContacts.values) {
      People p =
          People(user.pubKey, user.mainRelay, user.nickName, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = await Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    if (event.content.isNotEmpty) {
      Connect.sharedInstance.sendEvent(event,
          sendCallBack: (OKEvent ok, String relay) async {
        if (ok.status) {
          Account.sharedInstance.me!.lastFriendsListUpdatedTime =
              event.createdAt;
          await _syncContactsToDB(event.content);
        }
        okCallBack?.call(ok, relay);
      });
    } else {
      throw Exception('_syncFriendsToRelay error content!, $friendList');
    }
  }

  Future<void> syncContactsProfiles(List<People> peoples) async {
    await _syncContactsProfilesFromDB(peoples);
    List<People> friendList = [];
    for (UserDBISAR user in allContacts.values) {
      People p =
          People(user.pubKey, user.mainRelay, user.nickName, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = await Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    if (event.content.isNotEmpty) {
      _syncContactsToDB(event.content);
    } else {
      throw Exception('_syncFriendsToDB error content!, $friendList');
    }
  }

  Future<void> _syncContactsProfilesFromDB(List<People> peoples) async {
    allContacts.clear();
    await Future.forEach(peoples, (p) async {
      UserDBISAR? user = await Account.sharedInstance.getUserInfo(p.pubkey);
      if (user != null) {
        user.nickName = p.petName;
        allContacts[user.pubKey] = user;
      }
    });
  }

  Future<OKEvent> addToContact(List<String> pubkeys) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    await Future.forEach(pubkeys, (friendPubkey) async {
      UserDBISAR? friend =
          await Account.sharedInstance.getUserInfo(friendPubkey);
      friend ??= UserDBISAR(pubKey: friendPubkey);
      allContacts[friendPubkey] = friend;
    });
    _syncContactsToRelay(okCallBack: (OKEvent ok, String relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    _preloadKind4Messages(pubkeys, currentUnixTimestampSeconds());
    _subscriptMoment();
    contactUpdatedCallBack?.call();
    return completer.future;
  }

  Future<OKEvent> removeContact(String friendPubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDBISAR? friend = allContacts.remove(friendPubkey);
    if (friend != null) {
      _syncContactsToRelay(okCallBack: (OKEvent ok, String relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
      _subscriptMoment();
      contactUpdatedCallBack?.call();
    }
    return completer.future;
  }

  Future<OKEvent> updateContactNickName(
      String friendPubkey, String nickName) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDBISAR? friend = allContacts[friendPubkey];
    if (friend != null) {
      friend.nickName = nickName;
      await Account.saveUserToDB(friend);
      _syncContactsToRelay(okCallBack: (ok, relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
    } else if (!completer.isCompleted) {
      completer.complete(OKEvent(friendPubkey, false, ''));
    }
    return completer.future;
  }

  List<UserDBISAR>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<UserDBISAR> filteredFriends = allContacts.values
          .where((person) =>
              regex.hasMatch(person.name ?? '') ||
              regex.hasMatch(person.dns ?? '') ||
              regex.hasMatch(person.nickName ?? ''))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  Future<Event?> getSendMessageEvent(
      String friendPubkey, String replayId, MessageType type, String content,
      {String? source,
      int? kind,
      int? expiration,
      String? decryptSecret,
      String? sealedReceiver}) async {
    Event? event;
    expiration = expiration != null
        ? (expiration + currentUnixTimestampSeconds())
        : null;
    event ??= await Nip17.encodeSealedGossipDM(
        friendPubkey,
        MessageDBISAR.getContent(type, content, source),
        replayId,
        pubkey,
        privkey,
        sealedReceiver: sealedReceiver,
        subContent: MessageDBISAR.getSubContent(type, content,
            decryptSecret: decryptSecret),
        expiration: expiration);
    return event;
  }

  Future<void> muteFriend(String friendPubkey) async {
    _setMuteFriend(friendPubkey, true);
  }

  Future<void> unMuteFriend(String friendPubkey) async {
    _setMuteFriend(friendPubkey, false);
  }

  List<String> getAllUnMuteContacts() {
    return allContacts.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.value.pubKey)
        .toList();
  }

  Future<void> _setMuteFriend(String friendPubkey, bool mute) async {
    if (allContacts.containsKey(friendPubkey)) {
      UserDBISAR friend = allContacts[friendPubkey]!;
      friend.mute = mute;
      await Account.saveUserToDB(friend);
    }
  }

  Uint8List? getFriendSharedSecret(String friendPubkey) {
    return Nip44.shareSecret(privkey, friendPubkey);
  }

  /// sync contacts
  Future<void> _syncContactsFromDB() async {
    String? list = Account.sharedInstance.me?.friendsList;
    if (list != null && list.isNotEmpty && list != 'null') {
      Map? map = await Nip51.fromContent(list, privkey, pubkey);
      if (map != null) {
        List<People> friendsList = map['people'];
        for (var p in friendsList) {
          UserDBISAR userDB = UserDBISAR(pubKey: p.pubkey);
          userDB.name = userDB.shortEncodedPubkey;
          allContacts[p.pubkey] = userDB;
        }
        contactUpdatedCallBack?.call();
        await Future.forEach(friendsList, (p) async {
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(p.pubkey);
          if (user != null) {
            user.nickName = p.petName;
            allContacts[user.pubKey] = user;
          }
        });
        contactUpdatedCallBack?.call();
      }
    }
  }

  Future<void> _preloadKind4Messages(List<String> pubkeys, int until) async {
    Filter f1 = Filter(
        kinds: [4],
        authors: [pubkey],
        p: pubkeys,
        until: until,
        limit: pubkeys.length * 20);
    Filter f2 = Filter(
        kinds: [4],
        authors: pubkeys,
        p: [pubkey],
        until: until,
        limit: pubkeys.length * 20);
    Connect.sharedInstance.addSubscription([f1, f2],
        eventCallBack: (event, relay) async {
      if (event.kind == 4 || event.kind == 44) {
        if (!inBlockList(event.pubkey)) _handlePrivateMessage(event, relay);
      }
    }, eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
    });
  }

  static Future<void> decodeNip24InIsolate(Map<String, dynamic> params) async {
    String privkey = params['privkey'] ?? '';
    BackgroundIsolateBinaryMessenger.ensureInitialized(params['token']);
    Event event = await Event.fromJson(params['event'], verify: false);
    Event? innerEvent =
        await Nip17.decode(event, params['pubkey'] ?? '', privkey);
    params['sendPort'].send(innerEvent?.toJson());
  }

  Future<Event?> decodeNip24Event(Event event) async {
    Completer<Event?> completer = Completer<Event?>();
    final receivePort = ReceivePort();
    receivePort.listen((message) {
      if (!completer.isCompleted) {
        if (message != null) {
          completer.complete(Event.fromJson(message, verify: false));
        } else {
          completer.complete(null);
        }
      }
      receivePort.close(); // Close the receive port to avoid memory leaks
    });

    var rootToken = RootIsolateToken.instance!;
    Map<String, dynamic> map = {
      'event': event.toJson(),
      'privkey': privkey,
      'pubkey': pubkey,
      'sendPort': receivePort.sendPort,
      'token': rootToken
    };

    await Isolate.spawn(decodeNip24InIsolate, map);
    return completer.future;
  }

  Future<void> _subscriptMoment({String? relay}) async {
    // await Moment.sharedInstance.updateSubscriptions(relay: relay);
  }

  Future<void> _subscriptMessages({String? relay}) async {
    if (friendMessageSubscription.isNotEmpty) {
      await Connect.sharedInstance
          .closeRequests(friendMessageSubscription, relay: relay);
    }

    Map<String, List<Filter>> subscriptions = {};
    if (relay == null) {
      List<String> relays =
          Connect.sharedInstance.relays(relayKind: RelayKind.general);
      relays.addAll(Connect.sharedInstance.relays(relayKind: RelayKind.dm));
      for (String relayURL in relays) {
        int friendMessageUntil =
            Relays.sharedInstance.getFriendMessageUntil(relayURL);

        /// all messages, contacts & unknown contacts
        Filter f1 = Filter(
            kinds: [4, 1059],
            p: [pubkey],
            since: friendMessageUntil > offset2
                ? (friendMessageUntil - offset2 + 1)
                : 1,
            limit: maxLimit);
        Filter f2 = Filter(
            kinds: [4],
            authors: [pubkey],
            since: (friendMessageUntil + 1),
            limit: maxLimit);
        subscriptions[relayURL] = [f1, f2];
      }
    } else {
      int friendMessageUntil =
          Relays.sharedInstance.getFriendMessageUntil(relay);

      /// all messages, contacts & unknown contacts
      Filter f1 = Filter(
          kinds: [4, 1059],
          p: [pubkey],
          since: friendMessageUntil > offset2
              ? (friendMessageUntil - offset2 + 1)
              : 1,
          limit: maxLimit);
      Filter f2 = Filter(
          kinds: [4],
          authors: [pubkey],
          since: (friendMessageUntil + 1),
          limit: maxLimit);
      subscriptions[relay] = [f1, f2];
    }
    friendMessageSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
      if (event.kind == 4) {
        updateFriendMessageTime(event.createdAt, relay);
        if (!inBlockList(event.pubkey)) _handlePrivateMessage(event, relay);
      } else if (event.kind == 1059) {
        Event? innerEvent = await decodeNip24Event(event);
        if (innerEvent != null && !inBlockList(innerEvent.pubkey)) {
          updateFriendMessageTime(innerEvent.createdAt, relay);
          switch (innerEvent.kind) {
            case 14:
              _handlePrivateMessage(innerEvent, relay, giftWrappedId: event.id);
              break;
            case 10100:
            case 10101:
            case 10102:
            case 10103:
            case 10104:
              handleSecretSession(innerEvent, relay, event.id);
              break;
            case 25050:
              handleCallEvent(innerEvent, relay);
              break;
            case 1:
              Moment.sharedInstance.handleNoteEvent(innerEvent, relay, true);
              break;
            case 6:
              Moment.sharedInstance.handleRepostsEvent(innerEvent, relay, true);
              break;
            case 7:
              Moment.sharedInstance
                  .handleReactionEvent(innerEvent, relay, true);
              break;
            default:
              LogUtils.v(() =>
                  'contacts unhandled message ${innerEvent.toJson()}');
              break;
          }
        }
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) {
      offlinePrivateMessageFinish[relay] = true;
      Relays.sharedInstance.syncRelaysToDB(r: relay);
      if (unCompletedRelays.isEmpty) {
        offlinePrivateMessageFinishCallBack?.call();
        if (!Messages.sharedInstance.contactMessageCompleter.isCompleted) {
          Messages.sharedInstance.contactMessageCompleter.complete();
        }
      }
    });
  }

  Future<void> _handlePrivateMessage(Event event, String relay,
      {String? giftWrappedId}) async {
    MessageDBISAR? messageDB =
        await MessageDBISAR.fromPrivateMessage(event, pubkey, privkey);
    if (messageDB != null) {
      if (giftWrappedId != null) messageDB.giftWrappedId = giftWrappedId;
      await Messages.saveMessageToDB(messageDB);
      if (messageDB.groupId.isNotEmpty) {
        // private group
        Groups.sharedInstance.groupMessageCallBack?.call(messageDB);
      } else {
        // private chat
        privateChatMessageCallBack?.call(messageDB);
      }
    }
  }

  Future<OKEvent> sendPrivateMessage(
      String toPubkey, String replyId, MessageType type, String content,
      {Event? event,
      int? kind,
      String? subContent,
      int? expiration,
      bool local = false,
      String? source,
      String? decryptSecret,
      String? replaceMessageId}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    event ??= await getSendMessageEvent(toPubkey, replyId, type, content,
        kind: kind,
        expiration: expiration,
        decryptSecret: decryptSecret,
        source: source);
    expiration = expiration != null
        ? (expiration + currentUnixTimestampSeconds())
        : null;
    late MessageDBISAR messageDB;
    if (replaceMessageId != null) {
      messageDB =
          await Messages.sharedInstance.loadMessageDBFromDB(replaceMessageId) ??
              MessageDBISAR();
      messageDB.messageId = event?.innerEvent?.id ?? event!.id;
      privateChatMessageUpdateCallBack?.call(messageDB, replaceMessageId);
    } else {
      messageDB = MessageDBISAR(
          messageId: event?.innerEvent?.id ?? event!.id,
          sender: pubkey,
          receiver: toPubkey,
          groupId: '',
          kind: event!.kind,
          tags: jsonEncode(event.tags),
          content: event.content,
          replyId: replyId,
          createTime: currentUnixTimestampSeconds(),
          decryptContent: content,
          type: MessageDBISAR.messageTypeToString(type),
          status: 0,
          plaintEvent: jsonEncode(event),
          chatType: 0,
          expiration: expiration,
          decryptSecret: decryptSecret,
          giftWrappedId: event.id);
      privateChatMessageCallBack?.call(messageDB);
    }
    await Messages.saveMessageToDB(messageDB);

    if (local) {
      if (!completer.isCompleted) {
        completer
            .complete(OKEvent(event!.innerEvent?.id ?? event.id, true, ''));
      }
    } else {
      UserDBISAR? toUser = await Account.sharedInstance.getUserInfo(toPubkey);
      List<String>? dmRelays = toUser?.dmRelayList;
      Connect.sharedInstance.sendEvent(event!, toRelays: dmRelays,
          sendCallBack: (ok, relay) async {
        messageDB.status = ok.status ? 1 : 2;
        await Messages.saveMessageToDB(messageDB,
            conflictAlgorithm: ConflictAlgorithm.replace);
        if (!completer.isCompleted) {
          completer.complete(OKEvent(
              event!.innerEvent?.id ?? event.id, ok.status, ok.message));
        }
        if (kind != 4 && kind != 44) {
          await sendPrivateMessageToSelf(toPubkey, replyId, type, content,
              kind: kind,
              subContent: subContent,
              expiration: expiration,
              local: local,
              source: source,
              decryptSecret: decryptSecret,
              innerEvent: event?.innerEvent);
        }
      });
    }
    return completer.future;
  }

  Future<OKEvent> sendPrivateMessageToSelf(
      String toPubkey, String replyId, MessageType type, String content,
      {Event? event,
      int? kind,
      String? subContent,
      int? expiration,
      bool local = false,
      String? source,
      String? decryptSecret,
      Event? innerEvent}) async {
    if (innerEvent == null) return OKEvent('', false, 'innerEvent == null');
    Completer<OKEvent> completer = Completer<OKEvent>();
    event ??= await Nip17.encodeSealedGossipDM(
        toPubkey,
        MessageDBISAR.getContent(type, content, source),
        replyId,
        pubkey,
        privkey,
        sealedReceiver: pubkey,
        subContent: MessageDBISAR.getSubContent(type, content,
            decryptSecret: decryptSecret),
        expiration: expiration,
        innerEvent: innerEvent);
    expiration = expiration != null
        ? (expiration + currentUnixTimestampSeconds())
        : null;
    if (local) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(innerEvent.id, true, ''));
      }
    } else {
      UserDBISAR? toUser = await Account.sharedInstance.getUserInfo(pubkey);
      List<String>? dmRelays = toUser?.dmRelayList;
      Connect.sharedInstance.sendEvent(event, toRelays: dmRelays,
          sendCallBack: (ok, relay) async {
        if (!completer.isCompleted) completer.complete(ok);
      });
    }
    return completer.future;
  }

  Future<bool> connectUserDMRelays(String pubkey) async {
    UserDBISAR? toUser = await Account.sharedInstance.getUserInfo(pubkey);
    List<String>? relays = toUser?.dmRelayList;
    if (relays?.isNotEmpty == true) {
      return await Connect.sharedInstance
          .connectRelays(relays!, relayKind: RelayKind.temp);
    }
    return true;
  }

  Future<void> closeUserDMRelays(String pubkey) async {
    UserDBISAR? toUser = await Account.sharedInstance.getUserInfo(pubkey);
    List<String>? relays = toUser?.dmRelayList;
    if (relays?.isNotEmpty == true) {
      await Connect.sharedInstance.closeTempConnects(relays!);
    }
  }

  void updateFriendMessageTime(int eventTime, String relay) {
    /// set friendMessageUntil friendMessageSince
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setFriendMessageUntil(eventTime, relay);
      Relays.sharedInstance.setFriendMessageSince(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDBISAR(
          url: relay,
          friendMessageUntilString: jsonEncode({relay: eventTime}),
          friendMessageSinceString: jsonEncode({relay: eventTime}));
    }
    if (offlinePrivateMessageFinish[relay] == true &&
        offlineSecretMessageFinish[relay] == true) {
      Relays.sharedInstance.syncRelaysToDB(r: relay);
    }
  }
}
