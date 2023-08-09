import 'dart:async';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

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
    Connect.sharedInstance.sendEvent(event,
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
        await DB.sharedInstance.insert<SecretSessionDB>(db);
      }
      return okEvent;
    }
    return OKEvent(sessionId, false, 'sessionId not found');
  }

  Future<OKEvent> _sendAcceptEvent(
      String myAliasPubkey, String toPubkey, String sessionId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    Event event = Nip101.accept(myAliasPubkey, toPubkey, sessionId, privkey);
    Connect.sharedInstance.sendEvent(event,
        sendCallBack: (ok, relay, unRelays) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> rejectFriend(
    String friendPubkey,
    String friendAliasPubkey,
  ) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.reject(
        pubkey, privkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event,
        sendCallBack: (ok, relay, unRelays) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> removeFriend(String friendPubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allFriends[friendPubkey];
    if (friend != null && friend.aliasPubkey!.isNotEmpty) {
      Event event = Nip101.remove(pubkey, privkey, friend.toAliasPubkey!,
          friend.toAliasPrivkey!, friend.aliasPubkey!);
      Connect.sharedInstance.sendEvent(event,
          sendCallBack: (ok, relay, unRelays) {
        if (!completer.isCompleted) completer.complete(ok);
      });
    }
    _deleteFriend(friendPubkey);
    return completer.future;
  }

  void _handleFriendRequest(Event event, String relay) {
    /// get alias
    Alias alias = Nip101.getRequest(event, pubkey, privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(alias.toPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    alias.fromAliasPubkey = aliasPubkey;

    /// get requestDB
    FriendRequestDB requestDB = FriendRequestDB(
        friendPubkey: alias.toPubkey,
        friendAliasPubkey: alias.toAliasPubkey,
        myAliasPubkey: aliasPubkey,
        myAliasPrivkey: aliasPrivkey,
        status: 1,
        requestContent: [
          [alias.createTime.toString(), alias.content]
        ],
        lastUpdateTime: alias.createTime);
    friendRequestMap[requestDB.friendPubkey!] = requestDB;

    _updateFriendRequestTime(event.createdAt, relay);

    /// callback
    friendRequestCallBack?.call(alias);
  }

  Future<void> _handleFriendAccept(Event event) async {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB user in allFriends.values) {
      if (user.toAliasPubkey != null && user.toAliasPubkey == toAliasPubkey) {
        Alias alias = Nip101.getAccept(
            event, pubkey, user.toAliasPubkey!, user.toAliasPrivkey!);
        user.aliasPubkey = alias.toAliasPubkey;
        await DB.sharedInstance.insert<UserDB>(user);
        if (event.createdAt > lastFriendListUpdateTime) {
          await _addFriend(user.pubKey!, user.aliasPubkey!);
        }
        friendAcceptCallBack?.call(alias);
        return;
      }
    }
  }

  void _handleFriendReject(Event event) {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB user in allFriends.values) {
      if (user.toAliasPubkey != null && user.toAliasPubkey == toAliasPubkey) {
        Alias alias = Nip101.getReject(
            event, pubkey, user.toAliasPubkey!, user.toAliasPrivkey!);
        if (event.createdAt > lastFriendListUpdateTime) {
          // removeFriend(user.pubKey!);
        }
        friendRejectCallBack?.call(alias);
        return;
      }
    }
  }

  void _handleFriendRemove(Event event) {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB user in allFriends.values) {
      if (user.toAliasPubkey != null && user.toAliasPubkey == toAliasPubkey) {
        Alias alias = Nip101.getRemove(
            event, pubkey, user.toAliasPubkey!, user.toAliasPrivkey!);
        // check is real friend(aliasPubkey can't not be null)
        if (user.aliasPubkey != null && user.aliasPubkey!.isNotEmpty) {
          if (event.createdAt > lastFriendListUpdateTime) {
            removeFriend(user.pubKey!);
          }
          friendRemoveCallBack?.call(alias);
        }
        return;
      }
    }
  }
}
