import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

enum CallState {
  newCall,
  ringing,
  invite,
  connected,
  bye,
}

class Calling {
  /// singleton
  Calling._internal();
  factory Calling() => sharedInstance;
  static final Calling sharedInstance = Calling._internal();

  String pubkey = '';
  String privkey = '';
  Function(String friend, CallState state, String data)? onCallStateChange;

  Future<void> initWithPrivkey(String key) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
  }

  Future<void> handleCallEvent(Event event, String relay) async {
    UserDB? friend = _getFriendFromEvent(event);
    if (friend == null) return;
    Signaling signaling = Nip100.decode(event, friend.toAliasPrivkey!);
    switch (signaling.state) {
      case SignalingState.disconnect:
        _handleDisconnect(friend.pubKey!, signaling.content);
        break;
      case SignalingState.offer:
        _handleOffer(friend.pubKey!, signaling.content);
        break;
      case SignalingState.answer:
        _handleAnswer(friend.pubKey!, signaling.content);
        break;
      case SignalingState.candidate:
        _handleCandidate(friend.pubKey!, signaling.content);
        break;
      default:
        print('unknown state');
        break;
    }
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

  Future<void> _handleDisconnect(String friendPubkey, String content) async {
    onCallStateChange?.call(friendPubkey, CallState.bye, content);
  }

  Future<void> _handleOffer(String friendPubkey, String content) async {
    onCallStateChange?.call(friendPubkey, CallState.newCall, content);
    onCallStateChange?.call(friendPubkey, CallState.invite, content);
  }

  Future<void> _handleAnswer(String friendPubkey, String content) async {}
  Future<void> _handleCandidate(String friendPubkey, String content) async {}
}
