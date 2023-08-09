import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension SecretChat on Friends {
  Future<OKEvent> request(String friendPubkey) async {
    Keychain randomKey = Keychain.generate();
    OKEvent okEvent = await _sendRequestEvent(friendPubkey, randomKey.public);
    if (okEvent.status) {
      SecretSessionDB secretSessionDB = SecretSessionDB(
          sessionId: okEvent.eventId,
          fromPubkey: pubkey,
          fromAliasPubkey: randomKey.public,
          fromAliasPrivkey: randomKey.private,
          toPubkey: friendPubkey,
          lastUpdateTime: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          status: 1);
      await DB.sharedInstance.insert<SecretSessionDB>(secretSessionDB);
    }
    return okEvent;
  }

  Future<OKEvent> _sendRequestEvent(
      String friendPubkey, String aliasPubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip101.request(aliasPubkey, friendPubkey, privkey);
    Event sealedEvent =
        await Nip24.encode(event, friendPubkey, kind: event.kind);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay, unRelays) {
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
      Keychain randomKey = Keychain.generate();
      OKEvent okEvent =
          await _sendAcceptEvent(randomKey.public, db.fromPubkey!, sessionId);
      if (okEvent.status) {
        db.toAliasPubkey = randomKey.public;
        db.toAliasPrivkey = randomKey.private;
        db.shareSecretKey = bytesToHex(
            Nip44.shareSecret(randomKey.private, db.fromAliasPubkey!));
        db.status = 2;
        db.lastUpdateTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await DB.sharedInstance.update<SecretSessionDB>(db);
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendAcceptEvent(
      String myAliasPubkey, String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = Nip101.accept(myAliasPubkey, toPubkey, sessionId, privkey);
    Event sealedEvent = await Nip24.encode(event, toPubkey, kind: event.kind);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay, unRelays) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> reject(String sessionId) async {
    SecretSessionDB? db = await _getSecretSessionFromDB(sessionId);
    if (db != null) {
      OKEvent okEvent = await _sendRejectEvent(db.fromPubkey!, sessionId);
      if (okEvent.status) {
        await DB.sharedInstance.delete<SecretSessionDB>(
            where: 'sessionId = ?', whereArgs: [sessionId]);
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendRejectEvent(String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = Nip101.reject(toPubkey, sessionId, privkey);
    Event sealedEvent = await Nip24.encode(event, toPubkey, kind: event.kind);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay, unRelays) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> close(String sessionId) async {
    SecretSessionDB? db = await _getSecretSessionFromDB(sessionId);
    if (db != null) {
      OKEvent okEvent = await _sendCloseEvent(db.fromPubkey!, sessionId);
      if (okEvent.status) {
        db.status = 4;
        db.lastUpdateTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await DB.sharedInstance.update<SecretSessionDB>(db);
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendCloseEvent(String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = Nip101.close(toPubkey, sessionId, privkey);
    Event sealedEvent = await Nip24.encode(event, toPubkey, kind: event.kind);
    Connect.sharedInstance.sendEvent(sealedEvent,
        sendCallBack: (ok, relay, unRelays) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  SecretSessionDB _aliasToSessionDB(Alias alias) {
    int status = 0;
    switch (alias.kind) {
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
    }
    return SecretSessionDB(
        sessionId: alias.sessionId,
        fromPubkey: alias.fromPubkey,
        fromAliasPubkey: alias.fromAliasPubkey,
        toPubkey: alias.toPubkey,
        toAliasPubkey: alias.toAliasPubkey,
        lastUpdateTime: alias.createTime,
        status: status);
  }

  Future<void> _handleRequest(Event event, String relay) async {
    /// get alias
    Event decodeEvent = await Nip24.decode(event, privkey);
    Alias alias = Nip101.getRequest(decodeEvent);
    SecretSessionDB secretSessionDB = _aliasToSessionDB(alias);
    await DB.sharedInstance.insert<SecretSessionDB>(secretSessionDB);

    /// callback
    secretChatRequestCallBack?.call(secretSessionDB);
  }

  Future<void> _handleAccept(Event event, String relay) async {
    /// get alias
    Event decodeEvent = await Nip24.decode(event, privkey);
    Alias alias = Nip101.getAccept(decodeEvent);
    SecretSessionDB? secretSessionDB =
        await _getSecretSessionFromDB(alias.sessionId);
    if (secretSessionDB != null) {
      secretSessionDB.toAliasPubkey = alias.toAliasPubkey;
      secretSessionDB.shareSecretKey = bytesToHex(Nip44.shareSecret(
          secretSessionDB.fromAliasPrivkey!, secretSessionDB.toAliasPubkey!));
      secretSessionDB.status = 2;
      secretSessionDB.lastUpdateTime = alias.createTime;
      await DB.sharedInstance.update<SecretSessionDB>(secretSessionDB);

      /// callback
      secretChatAcceptCallBack?.call(secretSessionDB);
    }
  }

  Future<void> _handleReject(Event event, String relay) async {
    /// get alias
    Event decodeEvent = await Nip24.decode(event, privkey);
    Alias alias = Nip101.getReject(decodeEvent);
    SecretSessionDB? secretSessionDB =
        await _getSecretSessionFromDB(alias.sessionId);
    if (secretSessionDB != null) {
      await DB.sharedInstance.delete<SecretSessionDB>(
          where: 'sessionId = ?', whereArgs: [alias.sessionId]);

      /// callback
      secretChatRejectCallBack?.call(secretSessionDB);
    }
  }

  Future<void> _handleClose(Event event, String relay) async {
    /// get alias
    Event decodeEvent = await Nip24.decode(event, privkey);
    String sessionId = Nip101.getE(decodeEvent.tags);
    SecretSessionDB? secretSessionDB = await _getSecretSessionFromDB(sessionId);
    if (secretSessionDB != null) {
      /// callback
      secretChatCloseCallBack?.call(secretSessionDB);
    }
  }

  Future<void> _handleSecretMessage(Event event) async {
    Event decodeEvent = await Nip24.decode(event, privkey);
    MessageDB? messageDB =
        await MessageDB.fromPrivateMessage(decodeEvent, privkey);
    if (messageDB != null) {
      await Messages.saveMessagesToDB([messageDB]);
      secretChatMessageCallBack?.call(messageDB);
    }
  }

  Future<OKEvent> sendSecretMessage(
      String toPubkey, String replayId, MessageType type, String content,
      {Event? event}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    UserDB? toUserDB = allFriends[toPubkey];
    if (toUserDB != null) {
      event ??= await Nip44.encode(toUserDB.pubKey!,
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
          status: 0);
      Messages.saveMessagesToDB([messageDB]);

      Event encodeEvent = await Nip24.encode(event, privkey);
      Connect.sharedInstance.sendEvent(encodeEvent,
          sendCallBack: (ok, relay, unRelays) async {
        messageDB.status = ok.status ? 1 : 2;
        Messages.saveMessagesToDB([messageDB],
            conflictAlgorithm: ConflictAlgorithm.replace);
        if (!completer.isCompleted) completer.complete(ok);
      });
      return completer.future;
    }
    return completer.future;
  }
}
