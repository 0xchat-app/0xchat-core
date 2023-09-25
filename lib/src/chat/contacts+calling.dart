import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension Calling on Contacts {
  Future<OKEvent> sendDisconnect(
      String offerId, String friendPubkey, String content) async {
    isCalling = false;
    callingPubkey = '';
    return await _sendSignaling(
        offerId, friendPubkey, SignalingState.disconnect, content);
  }

  Future<OKEvent> sendReject(
      String offerId, String friendPubkey, String content) async {
    return await _sendSignaling(
        offerId, friendPubkey, SignalingState.disconnect, content);
  }

  Future<OKEvent> sendOffer(String friendPubkey, String content) async {
    isCalling = true;
    callingPubkey = friendPubkey;
    return await _sendSignaling(
        '', friendPubkey, SignalingState.offer, content);
  }

  Future<OKEvent> sendAnswer(
      String offerId, String friendPubkey, String content) async {
    isCalling = true;
    callingPubkey = friendPubkey;
    return await _sendSignaling(
        offerId, friendPubkey, SignalingState.answer, content);
  }

  Future<OKEvent> sendCandidate(
      String offerId, String friendPubkey, String content) async {
    isCalling = true;
    callingPubkey = friendPubkey;
    return await _sendSignaling(
        offerId, friendPubkey, SignalingState.candidate, content);
  }

  Future<OKEvent> _sendSignaling(String offerId, String toPubkey,
      SignalingState state, String content) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event? event;
    int kind = 25051;
    switch (state) {
      case SignalingState.disconnect:
        event = Nip100.close(toPubkey, content, offerId, privkey);
        break;
      case SignalingState.offer:
        kind = 25050;
        event = Nip100.offer(toPubkey, content, privkey);
        break;
      case SignalingState.answer:
        event = Nip100.answer(toPubkey, content, offerId, privkey);
        break;
      case SignalingState.candidate:
        event = Nip100.candidate(toPubkey, content, offerId, privkey);
        break;
      default:
        throw Exception('error state');
    }

    /// 60s timeout for calling event
    Event encodeEvent = await Nip24.encode(event, toPubkey, privkey,
        expiration: currentUnixTimestampSeconds() + 60, kind: kind);
    Connect.sharedInstance.sendEvent(encodeEvent,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event!.id, ok.status, ok.message));
      }
    });
    return completer.future;
  }

  Future<void> handleCallEvent(Event event, String relay) async {
    if (isCalling && event.pubkey != callingPubkey) {
      /// on calling, reject the request
      sendReject(event.pubkey, 'on calling', event.id);
    } else {
      Signaling signaling = Nip100.decode(event, privkey);
      onCallStateChange?.call(event.pubkey, signaling.state, signaling.content);
      if (signaling.state == SignalingState.disconnect) {
        isCalling = false;
        callingPubkey = '';
      }
    }
  }
}
