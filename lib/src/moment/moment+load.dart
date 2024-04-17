import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension Load on Moment {
  Future<List<NoteDB>?> loadPrivateNotes(
      {int limit = 50, int? until, NewNotesCallBack? callBack, bool? read}) async {
    newPrivateNotesCallBack = callBack;
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'private = ? AND createAt < ? AND read = ?',
        whereArgs: [true, until, read],
        orderBy: 'createAt desc',
        limit: limit);
    List<NoteDB>? result = notes
        .where((n) => Contacts.sharedInstance.allContacts.containsKey(n.author))
        .toList();
    return result;
  }

  Future<List<NoteDB>?> loadContactsNotes(
      {int limit = 50, int? until, NewNotesCallBack? callBack, bool? read}) async {
    newContactsNotesCallBack = callBack;
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'private = ? AND createAt < ? AND read = ?',
        whereArgs: [false, until, read],
        orderBy: 'createAt desc',
        limit: limit);
    List<NoteDB>? result = notes
        .where((n) => Contacts.sharedInstance.allContacts.containsKey(n.author))
        .toList();
    return result;
  }

  Future<List<NoteDB>?> loadNoteFromRelay(String noteId) async {
    return null;
  }

  Future<List<NoteDB>?> loadNewNotes() async {
    return await loadContactsNotes(read: false);
  }

  Future<void> loadOldNotes() async {}

  Future<List<NoteDB>?> loadNoteIdToNoteDB(List<String> noteIds) async{}

  Future<List<NoteDB>?> loadNoteReplies(String noteId) async {
    NoteDB? noteDB = notesCache[noteId];
    if(noteDB == null){
      List<NoteDB>? notes = await loadNoteFromRelay(noteId);
      noteDB = notes?[0];
    }

    if(noteDB?.replyEventIds?.isNotEmpty == true){
      return await loadNoteIdToNoteDB(noteDB!.replyEventIds!);
    }
    return null;
  }
  Future<void> loadNoteReactions() async {}
  Future<void> loadNoteZaps() async {}
  Future<void> loadNoteReposts() async {}
  Future<void> loadNoteQuoteReposts() async {}

  Future<List<NoteDB>> _loadNotesFromDB({
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return await DB.sharedInstance.objects<NoteDB>(
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  Future<void> handleNoteEvent(Event event, String relay, bool private) async {
    if (!notesCache.containsKey(event.id)) {
      updateContactsNotesTime(event.createdAt, relay);
      Note note = Nip1.decodeNote(event);
      NoteDB noteDB = NoteDB.noteDBFromNote(note);
      await DB.sharedInstance
          .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.ignore);
      notesCache[noteDB.noteId] = noteDB;
      if (private) {
        newPrivateNotesCallBack?.call(noteDB);
      } else {
        newContactsNotesCallBack?.call(noteDB);
      }
    }
  }
}
