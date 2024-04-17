import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension Send on Moment {
  Future<void> sendNote(List<String> toPubkeys, String content) async{}
  Future<void> sendNotePublic(String content) async{}
  Future<void> sendNoteContacts(String content) async{}
  Future<void> sendNoteCloseFriends(String content) async{}
  Future<void> sendReply(List<String> toPubkeys, String content, String eventId) async{}
  Future<void> sendReaction(List<String> toPubkeys, bool like, String eventId) async{}
  Future<void> sendZapNote(List<String> relays, int sats, String lnurl, String recipient, String eventId, bool private) async{}
  Future<void> sendRepost(List<String> toPubkeys, String eventId) async{}
  Future<void> sendQuoteRepost(List<String> toPubkeys, String content, String eventId) async{}
}