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
  Future<void> sendReply(
      List<String> toPubkeys, String content, String eventId) async {}
  Future<void> sendReaction(
      List<String> toPubkeys, bool like, String eventId) async {}
  Future<void> sendZapNote(List<String> relays, int sats, String lnurl,
      String recipient, String eventId, bool private) async {}
  Future<void> sendRepost(List<String> toPubkeys, String eventId) async {}
  Future<void> sendQuoteRepost(
      List<String> toPubkeys, String content, String eventId) async {}
}
