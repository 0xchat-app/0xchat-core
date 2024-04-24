import 'dart:async';

import 'package:chatcore/chat-core.dart';
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

  Future<void> sendNoteContacts(String content) async {}
  Future<void> sendNoteCloseFriends(
      List<String> toPubkeys, String content) async {}
  Future<void> sendNoteJustMe(String content) async {}

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
