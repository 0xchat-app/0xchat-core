import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension SecretChat on Contacts {
  void _connectToRelay(String? relay) {
    if (relay != null &&
        relay.isNotEmpty &&
        !Connect.sharedInstance.relays(type: 1).contains(relay)) {
      Connect.sharedInstance.connect(relay, type: 1);
    }
  }

  Future<OKEvent> request(String toPubkey, String chatRelay,
      {int? interval, int? expiration}) async {
    Keychain randomKey = Keychain.generate();

    /// default 24 hours
    expiration ??= currentUnixTimestampSeconds() + 24 * 60 * 60;
    OKEvent okEvent = await _sendRequestEvent(toPubkey, randomKey.public,
        expiration: expiration, interval: interval, relay: chatRelay);
    if (okEvent.status) {
      // connect the chat relay
      _connectToRelay(chatRelay);
      SecretSessionDB secretSessionDB = SecretSessionDB(
          sessionId: okEvent.eventId,
          myPubkey: pubkey,
          myAliasPubkey: randomKey.public,
          myAliasPrivkey: randomKey.private,
          toPubkey: toPubkey,
          lastUpdateTime: currentUnixTimestampSeconds(),
          status: 0,
          relay: chatRelay,
          interval: interval,
          expiration: expiration);
      await DB.sharedInstance.insert<SecretSessionDB>(secretSessionDB);
      secretSessionMap[secretSessionDB.sessionId] = secretSessionDB;
    }
    return okEvent;
  }

  Future<OKEvent> _sendRequestEvent(String friendPubkey, String aliasPubkey,
      {int? expiration, int? interval, String? relay}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = await Nip101.request(
        aliasPubkey, friendPubkey, pubkey, privkey,
        expiration: expiration, interval: interval, relay: relay);

    /// expired 24 hours later
    Event sealedEvent = await Nip17.encode(event, friendPubkey, pubkey, privkey,
        expiration: expiration);
    Connect.sharedInstance.sendEvent(sealedEvent, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, ok.status, ok.message));
      }
    });
    return completer.future;
  }

  static Future<SecretSessionDB?> _getSecretSessionFromDB(
      String sessionId) async {
    List<Object?> maps = await DB.sharedInstance.objects<SecretSessionDB>(
        where: 'sessionId = ?', whereArgs: [sessionId]);
    SecretSessionDB? db;
    if (maps.isNotEmpty) {
      db = maps.first as SecretSessionDB?;
      if (db != null) {
        return db;
      }
    }
    return null;
  }

  Future<OKEvent> accept(String sessionId) async {
    SecretSessionDB? db = secretSessionMap[sessionId];
    if (db != null) {
      // connect the chat relay
      _connectToRelay(db.relay);
      Keychain randomKey = Keychain.generate();
      OKEvent okEvent =
          await _sendAcceptEvent(randomKey.public, db.toPubkey!, sessionId);
      if (okEvent.status) {
        db.shareSecretKey =
            bytesToHex(Nip44.shareSecret(randomKey.private, db.toAliasPubkey!));
        db.sharePubkey = Keychain.getPublicKey(db.shareSecretKey!);
        db.status = 2;
        db.lastUpdateTime = currentUnixTimestampSeconds();
        await DB.sharedInstance.update<SecretSessionDB>(db);
        subscriptSecretChat();
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendAcceptEvent(
      String myAliasPubkey, String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = await Nip101.accept(
        myAliasPubkey, toPubkey, sessionId, pubkey, privkey);
    Event sealedEvent = await Nip17.encode(event, toPubkey, pubkey, privkey);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> reject(String sessionId) async {
    SecretSessionDB? db = secretSessionMap[sessionId];
    if (db != null) {
      OKEvent okEvent = await _sendRejectEvent(db.toPubkey!, sessionId);
      if (okEvent.status) {
        await DB.sharedInstance.delete<SecretSessionDB>(
            where: 'sessionId = ?', whereArgs: [sessionId]);
        secretSessionMap.remove(sessionId);
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendRejectEvent(String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = await Nip101.reject(toPubkey, sessionId, pubkey, privkey);
    Event sealedEvent = await Nip17.encode(event, toPubkey, pubkey, privkey);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> update(String sessionId) async {
    SecretSessionDB? db = secretSessionMap[sessionId];
    if (db != null && db.status != 5) {
      Keychain randomKey = Keychain.generate();
      OKEvent okEvent =
          await _sendUpdateEvent(randomKey.public, db.toPubkey!, sessionId);
      if (okEvent.status) {
        db.myAliasPubkey = randomKey.public;
        db.myAliasPrivkey = randomKey.private;
        if (db.toAliasPubkey != null && db.toAliasPubkey!.isNotEmpty) {
          db.shareSecretKey = bytesToHex(
              Nip44.shareSecret(randomKey.private, db.toAliasPubkey!));
          db.sharePubkey = Keychain.getPublicKey(db.shareSecretKey!);
          db.status = 2;
          await subscriptSecretChat();
        } else {
          db.status = 5;
        }
        db.lastUpdateTime = currentUnixTimestampSeconds();
        await DB.sharedInstance.update<SecretSessionDB>(db);
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found or in update status');
  }

  Future<OKEvent> _sendUpdateEvent(
      String myAliasPubkey, String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = await Nip101.update(
        myAliasPubkey, toPubkey, sessionId, pubkey, privkey);
    Event sealedEvent = await Nip17.encode(event, toPubkey, pubkey, privkey);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> close(String sessionId) async {
    SecretSessionDB? db = secretSessionMap[sessionId];
    if (db != null) {
      OKEvent okEvent = await _sendCloseEvent(db.toPubkey!, sessionId);
      await DB.sharedInstance.delete<SecretSessionDB>(
          where: 'sessionId = ?', whereArgs: [sessionId]);
      secretSessionMap.remove(sessionId);
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendCloseEvent(String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = await Nip101.close(toPubkey, sessionId, pubkey, privkey);
    Event sealedEvent = await Nip17.encode(event, toPubkey, pubkey, privkey);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  SecretSessionDB _exchangeSessionToSessionDB(KeyExchangeSession session) {
    int status = 0;
    switch (session.kind) {
      case 10100:
        status = 1;
        break;
      case 10101:
        status = 2;
        break;
      case 10102:
        status = 3;
        break;
      case 10103:
        status = 4;
        break;
      case 10104:
        status = 5;
        break;
    }
    return SecretSessionDB(
        sessionId: session.sessionId,
        interval: session.interval,
        expiration: session.expiration,
        relay: session.relay,
        lastUpdateTime: session.createTime,
        status: status);
  }

  Future<void> handleSecretSession(
      Event event, String relay, String giftWrapEventId) async {
    MessageDB messageDB = MessageDB(messageId: giftWrapEventId);
    int result = await DB.sharedInstance.insert<MessageDB>(messageDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (result == 0) return;
    switch (event.kind) {
      case 10100:
        handleRequest(event, relay);
        break;
      case 10101:
        handleAccept(event, relay);
        break;
      case 10102:
        handleReject(event, relay);
        break;
      case 10103:
        handleClose(event, relay);
        break;
      case 10104:
        handleUpdate(event, relay);
        break;
    }
  }

  Future<void> handleRequest(Event event, String relay) async {
    /// get keyExchangeSession
    KeyExchangeSession keyExchangeSession = Nip101.getRequest(event);
    SecretSessionDB secretSessionDB =
        _exchangeSessionToSessionDB(keyExchangeSession);
    if (secretSessionMap.containsKey(secretSessionDB.sessionId)) {
      return;
    }
    secretSessionDB.myPubkey = pubkey;
    secretSessionDB.toPubkey = keyExchangeSession.fromPubkey;
    secretSessionDB.toAliasPubkey = keyExchangeSession.fromAliasPubkey;
    secretSessionDB.status = 1;
    secretSessionDB.lastUpdateTime = keyExchangeSession.createTime;
    await DB.sharedInstance.insert<SecretSessionDB>(secretSessionDB);

    /// add to secretSessionMap
    secretSessionMap[secretSessionDB.sessionId] = secretSessionDB;

    /// callback
    secretChatRequestCallBack?.call(secretSessionDB);
  }

  Future<void> handleAccept(Event event, String relay) async {
    /// get alias
    KeyExchangeSession session = Nip101.getAccept(event);
    SecretSessionDB? secretSessionDB = secretSessionMap[session.sessionId];
    if (secretSessionDB != null &&
        session.fromPubkey == secretSessionDB.toPubkey &&
        event.createdAt > secretSessionDB.lastUpdateTime) {
      secretSessionDB.toAliasPubkey = session.fromAliasPubkey;
      secretSessionDB.shareSecretKey = bytesToHex(Nip44.shareSecret(
          secretSessionDB.myAliasPrivkey!, secretSessionDB.toAliasPubkey!));
      secretSessionDB.sharePubkey =
          Keychain.getPublicKey(secretSessionDB.shareSecretKey!);
      secretSessionDB.status = 2;
      secretSessionDB.lastUpdateTime = session.createTime;
      await DB.sharedInstance.insert<SecretSessionDB>(secretSessionDB);

      subscriptSecretChat();

      /// callback
      secretChatAcceptCallBack?.call(secretSessionDB);
    }
  }

  Future<void> handleReject(Event event, String relay) async {
    /// get alias
    KeyExchangeSession session = Nip101.getReject(event);
    SecretSessionDB? secretSessionDB = secretSessionMap[session.sessionId];
    if (secretSessionDB != null &&
        session.fromPubkey == secretSessionDB.toPubkey &&
        event.createdAt > secretSessionDB.lastUpdateTime) {
      secretSessionDB.status = 3;
      secretSessionDB.lastUpdateTime = session.createTime;
      await DB.sharedInstance.update<SecretSessionDB>(secretSessionDB);

      /// callback
      secretChatRejectCallBack?.call(secretSessionDB);
    }
  }

  Future<void> handleUpdate(Event event, String relay) async {
    /// get alias
    KeyExchangeSession session = Nip101.getUpdate(event);
    SecretSessionDB? secretSessionDB = secretSessionMap[session.sessionId];

    if (secretSessionDB != null &&
        session.fromPubkey == secretSessionDB.toPubkey &&
        event.createdAt > secretSessionDB.lastUpdateTime) {
      secretSessionDB.toAliasPubkey = session.fromAliasPubkey;
      if (secretSessionDB.myAliasPrivkey != null &&
          secretSessionDB.myAliasPrivkey!.isNotEmpty) {
        secretSessionDB.shareSecretKey = bytesToHex(Nip44.shareSecret(
            secretSessionDB.myAliasPrivkey!, secretSessionDB.toAliasPubkey!));
        secretSessionDB.sharePubkey =
            Keychain.getPublicKey(secretSessionDB.shareSecretKey!);
        secretSessionDB.status = 2;
        secretSessionMap[secretSessionDB.sessionId] = secretSessionDB;
        await subscriptSecretChat();
      } else {
        await DB.sharedInstance.update<SecretSessionDB>(secretSessionDB);
        await update(secretSessionDB.sessionId);
      }
      secretSessionDB.lastUpdateTime = session.createTime;
      await DB.sharedInstance.update<SecretSessionDB>(secretSessionDB);

      /// callback
      secretChatUpdateCallBack?.call(secretSessionDB);
    }
  }

  Future<void> handleClose(Event event, String relay) async {
    /// get alias
    KeyExchangeSession session = Nip101.getClose(event);
    SecretSessionDB? secretSessionDB = secretSessionMap[session.sessionId];
    if (secretSessionDB != null &&
        session.fromPubkey == secretSessionDB.toPubkey &&
        event.createdAt > secretSessionDB.lastUpdateTime) {
      secretSessionDB.status = 4;
      secretSessionMap.remove(secretSessionDB.sessionId);
      subscriptSecretChat();

      /// callback
      secretChatCloseCallBack?.call(secretSessionDB);
    }
  }

  Future<void> _handleSecretMessage(
      String sessionId, Event event, String giftWrapEventId) async {
    if (Messages.addToLoaded(event.id)) {
      MessageDB? messageDB = await MessageDB.fromPrivateMessage(
          event, pubkey, privkey,
          chatType: 3);
      if (messageDB != null) {
        messageDB.sessionId = sessionId;
        messageDB.giftWrappedId = giftWrapEventId;
        int status = await Messages.saveMessageToDB(messageDB);
        if (status != 0) {
          secretChatMessageCallBack?.call(messageDB);
        }
      }
    }
  }

  Future<Event?> getSendSecretMessageEvent(String sessionId, String toPubkey,
      String replayId, MessageType type, String content, int? expiration,
      {String? source, String? decryptSecret}) async {
    expiration = expiration != null
        ? (expiration + currentUnixTimestampSeconds())
        : null;
    SecretSessionDB? sessionDB = secretSessionMap[sessionId];
    if (sessionDB != null &&
        sessionDB.shareSecretKey != null &&
        sessionDB.shareSecretKey!.isNotEmpty) {
      return await Nip17.encodeSealedGossipDM(
          toPubkey,
          MessageDB.getContent(type, content, source),
          replayId,
          pubkey,
          privkey,
          sealedPrivkey: sessionDB.shareSecretKey!,
          sealedReceiver: sessionDB.sharePubkey!,
          subContent: MessageDB.getSubContent(type, content,
              decryptSecret: decryptSecret),
          expiration: expiration);
    }
    return null;
  }

  Future<OKEvent> sendSecretMessage(String sessionId, String toPubkey,
      String replayId, MessageType type, String content,
      {Event? event,
      bool local = false,
      int? expiration,
      String? source,
      String? decryptSecret}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    SecretSessionDB? sessionDB = secretSessionMap[sessionId];
    if (sessionDB != null) {
      /// check chat relay
      _connectToRelay(sessionDB.relay);
      event ??= await getSendSecretMessageEvent(
          sessionId, toPubkey, replayId, type, content, expiration,
          decryptSecret: decryptSecret, source: source);
      expiration = expiration != null
          ? (expiration + currentUnixTimestampSeconds())
          : null;
      MessageDB messageDB = MessageDB(
          messageId: event?.innerEvent?.id ?? event!.id,
          sender: pubkey,
          receiver: toPubkey,
          groupId: '',
          sessionId: sessionId,
          kind: event!.kind,
          tags: jsonEncode(event.tags),
          content: event.content,
          createTime: currentUnixTimestampSeconds(),
          decryptContent: content,
          type: MessageDB.messageTypeToString(type),
          status: 0,
          plaintEvent: jsonEncode(event),
          chatType: 3,
          expiration: expiration,
          decryptSecret: decryptSecret,
          giftWrappedId: event.id);
      secretChatMessageCallBack?.call(messageDB);
      await Messages.saveMessageToDB(messageDB);

      if (local) {
        if (!completer.isCompleted) {
          completer.complete(OKEvent(event.id, true, ''));
        }
      } else {
        Connect.sharedInstance.sendEvent(event, toRelays: [sessionDB.relay ?? ''],
            sendCallBack: (ok, relay) async {
          messageDB.status = ok.status ? 1 : 2;
          await Messages.saveMessageToDB(messageDB,
              conflictAlgorithm: ConflictAlgorithm.replace);
          if (!completer.isCompleted) completer.complete(ok);

          /// rotate shared key
          if (ok.status &&
              sessionDB.interval != null &&
              sessionDB.interval! > 0 &&
              messageDB.createTime >
                  (sessionDB.interval! + sessionDB.lastUpdateTime) &&
              sessionDB.status != 5) {
            await update(sessionDB.sessionId);
          }
        });
      }
    } else {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(sessionId, false, 'unknown session'));
      }
    }
    return completer.future;
  }

  Future<void> syncSecretSessionFromDB() async {
    List<SecretSessionDB> secretSessions =
        await DB.sharedInstance.objects<SecretSessionDB>();
    for (var session in secretSessions) {
      secretSessionMap[session.sessionId] = session;

      /// connect to session relay
      _connectToRelay(session.relay);
    }
  }

  SecretSessionDB? _getSessionFromPubkey(String pubkey) {
    for (var value in secretSessionMap.values) {
      if (value.sharePubkey == pubkey) {
        return value;
      }
    }
    return null;
  }

  Future<void> subscriptSecretChat({String? relay}) async {
    if (secretSessionSubscription.isNotEmpty) {
      await Connect.sharedInstance
          .closeRequests(secretSessionSubscription, relay: relay);
    }

    List<String> pubkeys = [pubkey];
    secretSessionMap.forEach((key, value) {
      if (value.status == 2 || value.status == 5) {
        if (value.sharePubkey!.isNotEmpty) pubkeys.add(value.sharePubkey!);
      }
    });

    Map<String, List<Filter>> subscriptions = {};
    if (relay == null) {
      List<String> relays = Connect.sharedInstance.relays(type: 0);
      relays.addAll(Connect.sharedInstance.relays(type: 1));
      for (var r in relays) {
        int friendMessageUntil = Relays.sharedInstance.getFriendMessageUntil(r);
        Filter f = Filter(
            kinds: [1059], authors: pubkeys, since: friendMessageUntil + 1);
        subscriptions[r] = [f];
      }
    } else {
      int friendMessageUntil =
          Relays.sharedInstance.getFriendMessageUntil(relay);
      Filter f = Filter(
          kinds: [1059], authors: pubkeys, since: friendMessageUntil + 1);
      subscriptions[relay] = [f];
    }

    secretSessionSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
      SecretSessionDB? session = _getSessionFromPubkey(event.pubkey);
      if (session != null && Messages.addToLoaded(event.id)) {
        Event? innerEvent = await Nip17.decode(event, pubkey, privkey,
            sealedPrivkey: session.shareSecretKey!);
        if (innerEvent != null && !inBlockList(innerEvent.pubkey)) {
          updateFriendMessageTime(innerEvent.createdAt, relay);
          switch (innerEvent.kind) {
            case 14:
              _handleSecretMessage(session.sessionId, innerEvent, event.id);
              break;
            default:
              print('unhandled message $innerEvent');
              break;
          }
        }
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) {
      offlineSecretMessageFinish[relay] = true;
      Relays.sharedInstance.syncRelaysToDB(r: relay);
      if (unCompletedRelays.isEmpty) {
        offlineSecretMessageFinishCallBack?.call();
      }
    });
  }
}
