import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension ENote on RelayGroup {
  Future<void> handleGroupNotes(Event event, String relay) async {
    GroupNote groupNote = Nip29.decodeGroupNote(event);
    NoteDB noteDB = NoteDB.noteDBFromNote(groupNote.note);
    noteDB.groupId = groupNote.groupId;
    int status = await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.ignore);
    if (status != 0) {
      noteCallBack?.call(noteDB);
    }
  }

  Future<OKEvent> sendGroupNotes(String groupId, String content, String pubkey,
      String privkey, List<String> previous,
      {String? rootEvent,
      String? replyEvent,
      List<String>? replyUsers,
      List<String>? hashTags}) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event;
    List<String> previous = await getPrevious(groupId);
    if (rootEvent == null) {
      event = await Nip29.encodeGroupNote(
          groupId, content, pubkey, privkey, previous);
    } else {
      event = await Nip29.encodeGroupNoteReply(
          groupId, content, pubkey, privkey, previous,
          rootEvent: rootEvent,
          replyEvent: replyEvent,
          replyUsers: replyUsers,
          hashTags: hashTags);
    }
    Connect.sharedInstance.sendEvent(event, relay: groupDB.relay,
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

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
