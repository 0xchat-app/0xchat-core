import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class Calling {
  /// singleton
  Calling._internal();
  factory Calling() => sharedInstance;
  static final Calling sharedInstance = Calling._internal();

  String pubkey = '';
  String privkey = '';
  Function(String friend, SignalingState state, String data)? onCallStateChange;

  Future<void> initWithPrivkey(String key) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
  }

  Future<void> handleCallEvent(Event event, String relay) async {
    UserDB? friend = _getFriendFromEvent(event);
    if (friend == null) return;
    Signaling signaling = Nip100.decode(event, friend.toAliasPrivkey!);
    onCallStateChange?.call(friend.pubKey!, signaling.state, signaling.content);
  }

  Future<OKEvent> sendDisconnect(String friendPubkey, String content) async {
    return await _sendSignaling(
        friendPubkey, SignalingState.disconnect, content);
  }

  Future<OKEvent> sendOffer(String friendPubkey, String content) async {
    return await _sendSignaling(friendPubkey, SignalingState.offer, content);
  }

  Future<OKEvent> sendAnswer(String friendPubkey, String content) async {
    return await _sendSignaling(friendPubkey, SignalingState.answer, content);
  }

  Future<OKEvent> sendCandidate(String friendPubkey, String content) async {
    return await _sendSignaling(
        friendPubkey, SignalingState.candidate, content);
  }

  Future<OKEvent> _sendSignaling(
      String friendPubkey, SignalingState state, String content) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    UserDB? friend = _getFriendFromPubkey(friendPubkey);
    if (friend != null) {
      Event? event;
      switch (state) {
        case SignalingState.disconnect:
          event = Nip100.close(
              friend.aliasPubkey!, content, friend.toAliasPrivkey!);
          break;
        case SignalingState.offer:
          event = Nip100.offer(
              friend.aliasPubkey!, content, friend.toAliasPrivkey!);
          break;
        case SignalingState.answer:
          event = Nip100.answer(
              friend.aliasPubkey!, content, friend.toAliasPrivkey!);
          break;
        case SignalingState.candidate:
          event = Nip100.candidate(
              friend.aliasPubkey!, content, friend.toAliasPrivkey!);
          break;
        default:
          throw Exception('error state');
      }
      Connect.sharedInstance.sendEvent(event,
          sendCallBack: (ok, relay, unRelays) async {
        if (!completer.isCompleted) completer.complete(ok);
      });
    } else {
      OKEvent ok = OKEvent(friendPubkey, false, 'no friend');
      if (!completer.isCompleted) completer.complete(ok);
    }
    return completer.future;
  }

  UserDB? _getFriendFromEvent(Event event) {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB friend in Friends.sharedInstance.friends.values) {
      if (friend.toAliasPubkey != null) {
        if (friend.toAliasPubkey == toAliasPubkey) {
          return friend;
        }
      }
    }
    return null;
  }

  UserDB? _getFriendFromPubkey(String pubkey) {
    return Friends.sharedInstance.friends[pubkey];
  }
}
