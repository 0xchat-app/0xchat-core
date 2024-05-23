import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension ENote on RelayGroup {
  Future<void> handleGroupNotes(Event event, String relay) async {}

  Future<void> sendGroupNotes(Event event, String relay) async {}

  Future<List<NoteDB>?> loadGroupNotesFromDB(String id,
      {int limit = 50, int? until}) async {
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await Moment.sharedInstance.loadNotesFromDB(
        where: 'groupId = ? AND createAt < ?',
        whereArgs: [id, until],
        orderBy: 'createAt desc',
        limit: limit);
    for (var note in notes) {
      Moment.sharedInstance.notesCache[note.noteId] = note;
    }
    return notes;
  }
}
