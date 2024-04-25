import 'dart:async';
import 'dart:isolate';

import 'package:chatcore/chat-core.dart';
import 'package:flutter/services.dart';
import 'package:nostr_core_dart/nostr.dart';

extension Send on Moment {
  Future<OKEvent> sendPublicNote(String content,
      {String? rootEvent,
      String? rootEventRelay,
      String? replyEvent,
      String? replyEventRelay,
      List<String>? replyUsers,
      List<String>? replyUserRelays}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = await Nip1.encodeNote(content, pubkey, privkey,
        rootEvent: rootEvent,
        rootEventRelay: rootEventRelay,
        replyEvent: replyEvent,
        replyEventRelay: replyEventRelay,
        replyUsers: replyUsers,
        replyUserRelays: replyUserRelays);

    // todo: save notedb

    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });

    return completer.future;
  }

  Future<OKEvent> _sendPrivateNote(String content, List<String> pubkeys,
      {String? rootEvent,
      String? rootEventRelay,
      String? replyEvent,
      String? replyEventRelay,
      List<String>? replyUsers,
      List<String>? replyUserRelays}) async {
    Event event = await Nip1.encodeNote(content, pubkey, privkey,
        rootEvent: rootEvent,
        rootEventRelay: rootEventRelay,
        replyEvent: replyEvent,
        replyEventRelay: replyEventRelay,
        replyUsers: replyUsers,
        replyUserRelays: replyUserRelays);
    return await sendMessageEvent(pubkeys, event);
  }

  Future<OKEvent> sendMessageEvent(List<String>? receivers, Event event) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (receivers != null) {
      final receivePort = ReceivePort();
      receivePort.listen((message) {
        Connect.sharedInstance.sendEvent(Event.fromJson(message));
      });
      for (var receiver in receivers) {
        if (receiver.isNotEmpty) {
          var rootToken = RootIsolateToken.instance!;
          Map<String, dynamic> map = {
            'event': event.toJson(),
            'receiver': receiver,
            'privkey': privkey,
            'pubkey': pubkey,
            'sendPort': receivePort.sendPort,
            'token': rootToken
          };
          Isolate.spawn(encodeNip17InIsolate, map);
        }
      }
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, false, 'no receivers'));
      }
    }
    return completer.future;
  }

  static Future<void> encodeNip17InIsolate(Map<String, dynamic> params) async {
    String privkey = params['privkey'] ?? '';
    if (SignerHelper.needSigner(privkey)) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(params['token']);
    }
    Event event = Event.fromJson(params['event']);
    String receiver = params['receiver'] ?? '';
    Event sealedEvent = await Nip17.encode(
        event, receiver, params['pubkey'] ?? '', params['privkey'] ?? '');
    params['sendPort'].send(sealedEvent.toJson());
  }

  Future<OKEvent> sendNoteContacts(String content,
      {String? rootEvent,
      String? rootEventRelay,
      String? replyEvent,
      String? replyEventRelay,
      List<String>? replyUsers,
      List<String>? replyUserRelays}) async {
    List<String> toPubkeys = Contacts.sharedInstance.allContacts.keys.toList();
    toPubkeys.add(pubkey);
    return await _sendPrivateNote(content, toPubkeys,
        rootEvent: rootEvent,
        rootEventRelay: rootEventRelay,
        replyEvent: replyEvent,
        replyEventRelay: replyEventRelay,
        replyUsers: replyUsers,
        replyUserRelays: replyUserRelays);
  }

  Future<OKEvent> sendNoteCloseFriends(List<String> toPubkeys, String content,
      {String? rootEvent,
      String? rootEventRelay,
      String? replyEvent,
      String? replyEventRelay,
      List<String>? replyUsers,
      List<String>? replyUserRelays}) async {
    toPubkeys.add(pubkey);
    return await _sendPrivateNote(content, toPubkeys,
        rootEvent: rootEvent,
        rootEventRelay: rootEventRelay,
        replyEvent: replyEvent,
        replyEventRelay: replyEventRelay,
        replyUsers: replyUsers,
        replyUserRelays: replyUserRelays);
  }

  Future<OKEvent> sendNoteJustMe(String content,
      {String? rootEvent,
      String? rootEventRelay,
      String? replyEvent,
      String? replyEventRelay,
      List<String>? replyUsers,
      List<String>? replyUserRelays}) async {
    return await _sendPrivateNote(content, [pubkey],
        rootEvent: rootEvent,
        rootEventRelay: rootEventRelay,
        replyEvent: replyEvent,
        replyEventRelay: replyEventRelay,
        replyUsers: replyUsers,
        replyUserRelays: replyUserRelays);
  }

  Future<OKEvent> sendReply(String replyNoteId, String content) async {
    NoteDB? note = notesCache[replyNoteId];
    if (note != null) {
      String? rootEventId = note.root;
      if (rootEventId == null || rootEventId.isEmpty) {
        return await sendPublicNote(content,
            rootEvent: replyNoteId, replyUsers: [note.author]);
      } else {
        NoteDB? rootNote = notesCache[rootEventId];
        return await sendPublicNote(content,
            rootEvent: replyNoteId,
            replyUsers: [rootNote?.author ?? '', note.author]);
      }
    } else {
      return OKEvent(replyNoteId, false, 'reply note DB == null');
    }
  }

  Future<void> sendReaction(
      List<String> toPubkeys, bool like, String eventId) async {}
  Future<void> sendZapNote(List<String> relays, int sats, String lnurl,
      String recipient, String eventId, bool private) async {}

  Future<OKEvent> sendRepost(
      String repostNoteId, String? repostNoteRelay) async {
    NoteDB? note = notesCache[repostNoteId];
    if (note != null) {
      Completer<OKEvent> completer = Completer<OKEvent>();
      Event event = await Nip18.encodeReposts(
          repostNoteId, repostNoteRelay, note.rawEvent, pubkey, privkey);
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
        if (!completer.isCompleted) completer.complete(ok);
      });
      return completer.future;
    } else {
      return OKEvent(repostNoteId, false, 'repost note DB == null');
    }
  }

  Future<OKEvent> sendQuoteRepost(
      String quoteRepostNoteId, String content) async {
    NoteDB? note = notesCache[quoteRepostNoteId];
    if (note != null) {
      Completer<OKEvent> completer = Completer<OKEvent>();
      Event event = await Nip18.encodeQuoteReposts(
          quoteRepostNoteId, content, pubkey, privkey);
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
        if (!completer.isCompleted) completer.complete(ok);
      });
      return completer.future;
    } else {
      return OKEvent(quoteRepostNoteId, false, 'quoteRepost note DB == null');
    }
  }
}
