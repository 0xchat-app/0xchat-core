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
    String? reason;
    int kind = 25051;
    switch (state) {
      case SignalingState.disconnect:
        event = Nip100.close(toPubkey, content, offerId, privkey);
        try {
          Map map = jsonDecode(content);
          reason = map['reason'];
        } catch (_) {}
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
      default:
        throw Exception('error state');
    }
    Signaling signaling =
        Signaling(event.pubkey, toPubkey, content, state, offerId);
    if (state != SignalingState.candidate) {
      await handleSignalingEvent(event, signaling, reason);
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
    String? reason;
    if (signaling.state == SignalingState.disconnect) {
      try {
        Map map = jsonDecode(signaling.content);
        reason = map['reason'];
      } catch (_) {}
    }
    bool result = await handleSignalingEvent(event, signaling, reason);
    if (result) {
      onCallStateChange?.call(
          event.pubkey, signaling.state, signaling.content, signaling.offerId);
    }
  }

  Future<bool> handleSignalingEvent(
      Event event, Signaling signaling, String? reason) async {
    /// receive offer
    int eventTime = event.createdAt * 1000;
    if (signaling.state == SignalingState.offer) {
      CallMessage? callMessage = callMessages[event.id];
      Map map = jsonDecode(signaling.content);
      if (callMessage != null) {
        /// outdated request
        callMessage.media = map['media'];
        callMessage.start = eventTime;
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
            eventTime,
            callMessage?.end ?? eventTime,
            map['media']);
        callMessages[event.id] = callMessage;
      }
    }

    /// receive answer
    else if (signaling.state == SignalingState.answer) {
      CallMessage? callMessage = callMessages[event.id];
      if (callMessage != null) {
        callMessage.start = eventTime;
      }
    }

    /// receive disconnect & reject
    else if (signaling.state == SignalingState.disconnect) {
      CallMessageState state = CallMessageState.disconnect;
      switch (reason) {
        case 'hangUp':
          state = CallMessageState.cancel;
          break;
        case 'timeout':
          state = CallMessageState.timeout;
          break;
        case 'reject':
          state = CallMessageState.reject;
          break;
        case 'inCalling':
          state = CallMessageState.inCalling;
          break;
      }
      CallMessage? callMessage = callMessages[signaling.offerId];
      callMessage ??= CallMessage(
          signaling.offerId ?? event.id,
          signaling.sender,
          signaling.receiver,
          state,
          eventTime,
          eventTime,
          '');
      callMessage.end = eventTime;
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
