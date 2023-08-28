import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension SecretChat on Contacts {
  Future<OKEvent> request(String toPubkey, String chatRelay,
      {int? interval, int? expiration}) async {
    Keychain randomKey = Keychain.generate();
    OKEvent okEvent = await _sendRequestEvent(toPubkey, randomKey.public);
    if (okEvent.status) {
      // connect the chat relay
      if (chatRelay.isNotEmpty &&
          !Connect.sharedInstance.relays().contains(chatRelay)) {
        Connect.sharedInstance.connect(chatRelay);
      }
      SecretSessionDB secretSessionDB = SecretSessionDB(
          sessionId: okEvent.eventId,
          myPubkey: pubkey,
          myAliasPubkey: randomKey.public,
          myAliasPrivkey: randomKey.private,
          toPubkey: toPubkey,
          lastUpdateTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          status: 1,
          relay: chatRelay,
          interval: interval,
          expiration: expiration);
      await DB.sharedInstance.insert<SecretSessionDB>(secretSessionDB);
      secretSessionMap[secretSessionDB.sessionId] = secretSessionDB;
    }
    return okEvent;
  }

  Future<OKEvent> _sendRequestEvent(
      String friendPubkey, String aliasPubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip101.request(aliasPubkey, friendPubkey, privkey);

    /// expired 24 hours later
    Event sealedEvent = await Nip24.encode(event, friendPubkey,
        expiration: currentUnixTimestampSeconds() + 24 * 60 * 60);
    Connect.sharedInstance.sendEvent(sealedEvent, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
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
    SecretSessionDB? db = await _getSecretSessionFromDB(sessionId);
    if (db != null) {
      // connect the chat relay
      if (db.relay != null && db.relay!.isNotEmpty) {
        Connect.sharedInstance.connect(db.relay!);
      }
      Keychain randomKey = Keychain.generate();
      OKEvent okEvent =
          await _sendAcceptEvent(randomKey.public, db.toPubkey!, sessionId);
      if (okEvent.status) {
        db.myAliasPubkey = '';
        db.myAliasPrivkey = '';
        db.shareSecretKey =
            bytesToHex(Nip44.shareSecret(randomKey.private, db.toAliasPubkey!));
        db.sharePubkey = Keychain.getPublicKey(db.shareSecretKey!);
        db.status = 2;
        db.lastUpdateTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await DB.sharedInstance.update<SecretSessionDB>(db);
        secretSessionMap[db.sessionId] = db;
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendAcceptEvent(
      String myAliasPubkey, String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = Nip101.accept(myAliasPubkey, toPubkey, sessionId, privkey);
    Event sealedEvent = await Nip24.encode(event, toPubkey);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> reject(String sessionId) async {
    SecretSessionDB? db = await _getSecretSessionFromDB(sessionId);
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

    Event event = Nip101.reject(toPubkey, sessionId, privkey);
    Event sealedEvent = await Nip24.encode(event, toPubkey);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> update(String sessionId) async {
    SecretSessionDB? db = await _getSecretSessionFromDB(sessionId);
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
          secretSessionMap[db.sessionId] = db;
          await subscriptSecretChat();
        } else {
          db.status = 5;
        }
        db.lastUpdateTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await DB.sharedInstance.update<SecretSessionDB>(db);
        secretSessionMap[db.sessionId] = db;
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found or in update status');
  }

  Future<OKEvent> _sendUpdateEvent(
      String myAliasPubkey, String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = Nip101.update(myAliasPubkey, toPubkey, sessionId, privkey);
    Event sealedEvent = await Nip24.encode(event, toPubkey);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> close(String sessionId) async {
    SecretSessionDB? db = await _getSecretSessionFromDB(sessionId);
    if (db != null) {
      OKEvent okEvent = await _sendCloseEvent(db.toPubkey!, sessionId);
      if (okEvent.status) {
        db.status = 4;
        db.lastUpdateTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await DB.sharedInstance.update<SecretSessionDB>(db);
        secretSessionMap[db.sessionId] = db;
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendCloseEvent(String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = Nip101.close(toPubkey, sessionId, privkey);
    Event sealedEvent = await Nip24.encode(event, toPubkey);
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

  Future<void> handleRequest(Event event, String relay) async {
    /// get keyExchangeSession
    KeyExchangeSession keyExchangeSession = Nip101.getRequest(event);
    SecretSessionDB secretSessionDB =
        _exchangeSessionToSessionDB(keyExchangeSession);

    secretSessionDB.myPubkey = pubkey;
    secretSessionDB.toPubkey = keyExchangeSession.fromPubkey;
    secretSessionDB.toAliasPubkey = keyExchangeSession.fromAliasPubkey;

    await DB.sharedInstance.insert<SecretSessionDB>(secretSessionDB);

    /// add to secretSessionMap
    secretSessionMap[secretSessionDB.sessionId] = secretSessionDB;

    /// callback
    secretChatRequestCallBack?.call(secretSessionDB);
  }

  Future<void> handleAccept(Event event, String relay) async {
    /// get alias
    KeyExchangeSession session = Nip101.getAccept(event);
    SecretSessionDB? secretSessionDB =
        await _getSecretSessionFromDB(session.sessionId);
    if (secretSessionDB != null &&
        session.fromPubkey == secretSessionDB.toPubkey) {
      secretSessionDB.toAliasPubkey = session.fromAliasPubkey;
      secretSessionDB.shareSecretKey = bytesToHex(Nip44.shareSecret(
          secretSessionDB.myAliasPrivkey!, secretSessionDB.toAliasPubkey!));
      secretSessionDB.status = 2;
      secretSessionDB.lastUpdateTime = session.createTime;
      await DB.sharedInstance.insert<SecretSessionDB>(secretSessionDB);

      /// add to secretSessionMap
      secretSessionMap[secretSessionDB.sessionId] = secretSessionDB;
      subscriptSecretChat();

      /// callback
      secretChatAcceptCallBack?.call(secretSessionDB);
    }
  }

  Future<void> handleReject(Event event, String relay) async {
    /// get alias
    KeyExchangeSession session = Nip101.getReject(event);
    SecretSessionDB? secretSessionDB =
        await _getSecretSessionFromDB(session.sessionId);
    if (secretSessionDB != null &&
        session.fromPubkey == secretSessionDB.toPubkey) {
      await DB.sharedInstance.delete<SecretSessionDB>(
          where: 'sessionId = ?', whereArgs: [session.sessionId]);

      /// remove from secretSessionMap
      secretSessionMap.remove(secretSessionDB.sessionId);

      /// callback
      secretChatRejectCallBack?.call(secretSessionDB);
    }
  }

  Future<void> handleUpdate(Event event, String relay) async {
    /// get alias
    KeyExchangeSession session = Nip101.getUpdate(event);
    SecretSessionDB? secretSessionDB =
        await _getSecretSessionFromDB(session.sessionId);

    if (secretSessionDB != null &&
        session.fromPubkey == secretSessionDB.toPubkey) {
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

      /// update secretSessionMap
      secretSessionMap[secretSessionDB.sessionId] = secretSessionDB;

      /// callback
      secretChatUpdateCallBack?.call(secretSessionDB);
    }
  }

  Future<void> handleClose(Event event, String relay) async {
    /// get alias
    KeyExchangeSession session = Nip101.getClose(event);
    SecretSessionDB? secretSessionDB =
        await _getSecretSessionFromDB(session.sessionId);
    if (secretSessionDB != null &&
        session.fromPubkey == secretSessionDB.toPubkey) {
      /// remove from secretSessionMap
      secretSessionMap.remove(secretSessionDB.sessionId);
      subscriptSecretChat();

      /// callback
      secretChatCloseCallBack?.call(secretSessionDB);
    }
  }

  Future<void> _handleSecretMessage(String sessionId, Event event) async {
    MessageDB? messageDB =
        await MessageDB.fromPrivateMessage(event, pubkey, privkey);
    if (messageDB != null) {
      await Messages.saveMessagesToDB([messageDB]);
      secretChatMessageCallBack?.call(sessionId, messageDB);
    }
  }

  Future<OKEvent> sendSecretMessage(String sessionId, String toPubkey,
      String replayId, MessageType type, String content, int expiration,
      {Event? event}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    SecretSessionDB? sessionDB = secretSessionMap[sessionId];
    if (sessionDB != null) {
      UserDB? toUserDB = allContacts[toPubkey];
      if (toUserDB != null) {
        event ??= await Nip44.encode(toUserDB.pubKey,
            MessageDB.encodeContent(type, content), replayId, privkey);

        MessageDB messageDB = MessageDB(
            messageId: event.id,
            sender: pubkey,
            receiver: toPubkey,
            groupId: '',
            kind: event.kind,
            tags: jsonEncode(event.tags),
            content: event.content,
            createTime: event.createdAt,
            decryptContent: content,
            type: MessageDB.messageTypeToString(type),
            status: 0,
            plaintEvent: jsonEncode(event));
        Event encodeEvent = await Nip24.encode(event, sessionDB.sharePubkey!,
            privkey: sessionDB.shareSecretKey);
        messageDB.plaintEvent = jsonEncode(encodeEvent);
        Messages.saveMessagesToDB([messageDB]);
        Connect.sharedInstance.sendEvent(encodeEvent, relay: sessionDB.relay,
            sendCallBack: (ok, relay) async {
          messageDB.status = ok.status ? 1 : 2;
          Messages.saveMessagesToDB([messageDB],
              conflictAlgorithm: ConflictAlgorithm.replace);
          if (!completer.isCompleted) completer.complete(ok);

          /// rotate shared key
          if (ok.status &&
              sessionDB.interval != null &&
              sessionDB.interval! > 0 &&
              messageDB.createTime! >
                  (sessionDB.interval! + sessionDB.lastUpdateTime!) &&
              sessionDB.status != 5) {
            await update(sessionDB.sessionId);
          }
        });
        return completer.future;
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
    if (secretSessions.isNotEmpty) {
      secretSessionMap = {
        for (SecretSessionDB item in secretSessions) item.sessionId: item
      };
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
      await Connect.sharedInstance.closeRequests(secretSessionSubscription);
    }

    List<String> pubkeys = [pubkey];
    secretSessionMap.forEach((key, value) {
      if (value.status == 2 || value.status == 4) {
        pubkeys.add(value.sharePubkey!);
      }
    });
    Filter f = Filter(kinds: [1059], authors: pubkeys);

    Map<String, List<Filter>> subscriptions = {};
    if (relay == null) {
      for (var r in Connect.sharedInstance.relays()) {
        subscriptions[r] = [f];
      }
    } else {
      subscriptions[relay] = [f];
    }

    secretSessionSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
      SecretSessionDB? session = _getSessionFromPubkey(event.pubkey);
      if (session != null) {
        event = await Nip24.decode(event, session.shareSecretKey!);
        switch (event.kind) {
          case 44:
            _handleSecretMessage(session.sessionId, event);
            break;
          default:
            print('unhandled message $event');
            break;
        }
      }
    });
  }
}
