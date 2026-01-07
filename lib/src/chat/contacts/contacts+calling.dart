import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

extension Calling on Contacts {
  Future<OKEvent> sendDisconnect(String offerId, String friendPubkey,
      String privateGroupId, String content) async {
    return await _sendSignaling(offerId, friendPubkey, privateGroupId,
        SignalingState.disconnect, content);
  }

  Future<OKEvent> sendOffer(String offerId, String friendPubkey,
      String privateGroupId, String content) async {
    return await _sendSignaling(
        offerId, friendPubkey, privateGroupId, SignalingState.offer, content);
  }

  Future<OKEvent> sendAnswer(String offerId, String friendPubkey,
      String privateGroupId, String content) async {
    return await _sendSignaling(
        offerId, friendPubkey, privateGroupId, SignalingState.answer, content);
  }

  Future<OKEvent> sendCandidate(String offerId, String friendPubkey,
      String privateGroupId, String content) async {
    return await _sendSignaling(offerId, friendPubkey, privateGroupId,
        SignalingState.candidate, content);
  }

  Future<OKEvent> _sendSignaling(String offerId, String toPubkey,
      String privateGroupId, SignalingState state, String content) async {
    GroupDBISAR? groupDB =
        Groups.sharedInstance.myGroups[privateGroupId]?.value;
    if (groupDB == null || !groupDB.isMLSGroup){
      return OKEvent('', false, 'group not found');
    }

    Event? event;
    String? reason;
    int kind = 25051;
    switch (state) {
      case SignalingState.disconnect:
        event = await Nip100.close(toPubkey, content, offerId, pubkey, privkey,
            groupid: privateGroupId);
        try {
          Map map = jsonDecode(content);
          reason = map['reason'];
        } catch (_) {}
        break;
      case SignalingState.offer:
        kind = 25050;
        event = await Nip100.offer(toPubkey, content, offerId, pubkey, privkey,
            groupid: privateGroupId);
        break;
      case SignalingState.answer:
        event = await Nip100.answer(toPubkey, content, offerId, pubkey, privkey,
            groupid: privateGroupId);
        break;
      case SignalingState.candidate:
        event = await Nip100.candidate(
            toPubkey, content, offerId, pubkey, privkey,
            groupid: privateGroupId);
        break;
    }
    Signaling signaling = Signaling(
        event.pubkey, toPubkey, content, state, offerId, privateGroupId);
    if (state != SignalingState.candidate) {
      await handleSignalingEvent(event, signaling, reason,
          privateGroupId: privateGroupId);
    }

    final expiration = (currentUnixTimestampSeconds() + 60).toString();

    final shouldSendPush = state == SignalingState.offer;

    return Groups.sharedInstance.sendMessageToMLSGroup(
      groupDB,
      event,
      expiration: expiration,
      k: kind.toString(),
      sendPushNotification: shouldSendPush,
    );
  }

  Future<void> handleCallEvent(Event event, String relay,
      {String? privateGroupId}) async {
    Signaling signaling = Nip100.decode(event, pubkey);
    String? reason;
    if (signaling.state == SignalingState.disconnect) {
      try {
        Map map = jsonDecode(signaling.content);
        reason = map['reason'];
      } catch (_) {}
    }
    bool result = await handleSignalingEvent(event, signaling, reason,
        privateGroupId: privateGroupId);
    if (result) {
      onCallStateChange?.call(
          event.pubkey, signaling.state, signaling.content, signaling.offerId, privateGroupId);
    }
  }

  Future<bool> handleSignalingEvent(
      Event event, Signaling signaling, String? reason,
      {String? privateGroupId}) async {
    /// receive offer
    int eventTime = event.createdAt * 1000;
    final offerId = signaling.offerId ?? event.id;
    if (signaling.state == SignalingState.offer) {
      CallMessage? callMessage = callMessages[offerId];
      Map map = jsonDecode(signaling.content);
      if (callMessage != null) {
        /// outdated request
        callMessage.media = map['media'];
        callMessage.start = eventTime;
        MessageDBISAR callMessageDB =
            callMessageToDB(callMessage, event, privateGroupId);
        await Messages.saveMessageToDB(callMessageDB,
            conflictAlgorithm: ConflictAlgorithm.replace);
        privateChatMessageCallBack?.call(callMessageDB);
        return false;
      } else {
        callMessage = CallMessage(
          offerId,
          signaling.sender,
          signaling.receiver,
          callMessage?.state ?? CallMessageState.offer,
          eventTime,
          callMessage?.end ?? eventTime,
          map['media'],
          answered: callMessage?.answered ?? false,
        );
        callMessages[offerId] = callMessage;
      }
    }

    /// receive answer
    else if (signaling.state == SignalingState.answer) {
      CallMessage? callMessage = callMessages[offerId];
      if (callMessage != null) {
        callMessage.start = eventTime;
        callMessage.answered = true;
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
      CallMessage? callMessage = callMessages[offerId];
      callMessage ??= CallMessage(
        offerId,
        signaling.sender,
        signaling.receiver,
        state,
        eventTime,
        eventTime,
        '',
        answered: false,
      );
      callMessage.end = eventTime;
      callMessage.state = state;
      callMessages[offerId] = callMessage;
      MessageDBISAR callMessageDB =
          callMessageToDB(callMessage, event, privateGroupId);
      await Messages.saveMessageToDB(callMessageDB,
          conflictAlgorithm: ConflictAlgorithm.replace);
      privateChatMessageCallBack?.call(callMessageDB);
    }

    return true;
  }

  MessageDBISAR callMessageToDB(
      CallMessage callMessage, Event event, String? privateGroupId) {
    int? duration;
    if (callMessage.answered && callMessage.end > callMessage.start) {
      duration = callMessage.end - callMessage.start;
    }
    String content = jsonEncode({
      'contentType': 'call',
      'content': jsonEncode({
        'state': callMessage.state.value,
        if (duration != null) 'duration': duration,
        'media': callMessage.media
      })
    });
    return MessageDBISAR(
      messageId: callMessage.callId,
      sender: callMessage.sender,
      receiver: callMessage.receiver,
      groupId: privateGroupId ?? '',
      kind: event.kind,
      tags: jsonEncode(event.tags),
      content: content,
      type: 'call',
      decryptContent: jsonEncode({
        'state': callMessage.state.value,
        if (duration != null) 'duration': duration,
        'media': callMessage.media
      }),
      createTime: event.createdAt,
      plaintEvent: jsonEncode(event),
      chatType: 1,
    );
  }
}
