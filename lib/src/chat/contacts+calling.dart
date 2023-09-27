import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension Calling on Contacts {
  Future<OKEvent> sendDisconnect(
      String offerId, String friendPubkey, String content) async {
    return await _sendSignaling(
        offerId, friendPubkey, SignalingState.disconnect, content);
  }

  Future<OKEvent> sendReject(
      String offerId, String friendPubkey, String content) async {
    return await _sendSignaling(
        offerId, friendPubkey, SignalingState.reject, content);
  }

  Future<OKEvent> sendOffer(String friendPubkey, String content) async {
    return await _sendSignaling(
        '', friendPubkey, SignalingState.offer, content);
  }

  Future<OKEvent> sendAnswer(
      String offerId, String friendPubkey, String content) async {
    return await _sendSignaling(
        offerId, friendPubkey, SignalingState.answer, content);
  }

  Future<OKEvent> sendCandidate(
      String offerId, String friendPubkey, String content) async {
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
        offerId = event.id;
        break;
      case SignalingState.answer:
        event = Nip100.answer(toPubkey, content, offerId, privkey);
        break;
      case SignalingState.candidate:
        event = Nip100.candidate(toPubkey, content, offerId, privkey);
        break;
      case SignalingState.reject:
        event = Nip100.reject(toPubkey, content, offerId, privkey);
        break;
      default:
        throw Exception('error state');
    }
    Signaling signaling =
        Signaling(event.pubkey, toPubkey, content, state, offerId);
    if (state != SignalingState.candidate) {
      await handleSignalingEvent(event, signaling);
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
    Signaling signaling = Nip100.decode(event, privkey);
    bool result = await handleSignalingEvent(event, signaling);
    if(result){
      onCallStateChange?.call(
          event.pubkey, signaling.state, signaling.content, signaling.offerId);
    }
  }

  Future<bool> handleSignalingEvent(Event event, Signaling signaling) async {
    /// receive offer
    if (signaling.state == SignalingState.offer) {
      CallMessage? callMessage = callMessages[event.id];
      Map map = jsonDecode(signaling.content);
      if (callMessage != null) {
        /// outdated request
        callMessage.media = map['media'];
        callMessage.start = event.createdAt * 1000;
        MessageDB callMessageDB = callMessageToDB(callMessage);
        await Messages.saveMessageToDB(callMessageDB,
            conflictAlgorithm: ConflictAlgorithm.replace);
        privateChatMessageCallBack?.call(callMessageDB);
        return false;
      } else {
        callMessage = CallMessage(
            event.id,
            signaling.sender,
            signaling.receiver,
            callMessage?.state ?? CallMessageState.offer,
            event.createdAt * 1000,
            callMessage?.end ?? event.createdAt * 1000,
            map['media']);
        callMessages[event.id] = callMessage;
      }
    }

    /// receive disconnect & reject
    else if (signaling.state == SignalingState.disconnect ||
        signaling.state == SignalingState.reject) {
      int currentTime = event.createdAt * 1000;
      CallMessageState state = signaling.state == SignalingState.disconnect
          ? CallMessageState.disconnect
          : CallMessageState.reject;

      CallMessage? callMessage = callMessages[signaling.offerId];
      callMessage ??= CallMessage(event.id, signaling.sender,
          signaling.receiver, state, currentTime, currentTime, '');
      callMessage.end = currentTime;
      callMessage.state = state;
      MessageDB callMessageDB = callMessageToDB(callMessage);
      await Messages.saveMessageToDB(callMessageDB,
          conflictAlgorithm: ConflictAlgorithm.replace);
      privateChatMessageCallBack?.call(callMessageDB);
    }

    return true;
  }

  MessageDB callMessageToDB(CallMessage callMessage) {
    String content = jsonEncode({
      'contentType': 'call',
      'content': jsonEncode({
        'state': callMessage.state.toString(),
        'duration': (callMessage.end - callMessage.start),
        'media': callMessage.media
      })
    });
    return MessageDB(
        messageId: callMessage.callId,
        sender: callMessage.sender,
        receiver: callMessage.receiver,
        content: content,
        kind: 25050,
        type: 'call',
        decryptContent: jsonEncode({
          'state': callMessage.state.toString(),
          'duration': (callMessage.end - callMessage.start),
          'media': callMessage.media
        }),
        createTime: currentUnixTimestampSeconds());
  }
}
