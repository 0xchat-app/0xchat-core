import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension Load on Moment {
  Future<List<NoteDB>?> loadNotes({int pageSize = 50}) async {

    return null;
  }
  Future<void> loadNewNotes() async {}
  Future<void> loadOldNotes() async {}

  Future<void> loadNoteReplies() async {}
  Future<void> loadNoteReactions() async {}
  Future<void> loadNoteZaps() async {}
  Future<void> loadNoteReposts() async {}
  Future<void> loadNoteQuoteReposts() async {}

  Future<void> _loadNotesFromDB() async{}
  Future<void> _loadNotesFromRelay() async{}
}