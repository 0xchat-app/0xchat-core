import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension Load on Moment {
  Future<List<NoteDB>?> loadAllNotesFromDB(
      {int limit = 50, int? until, NewNotesCallBack? callBack}) async {
    newPrivateNotesCallBack = callBack;
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'createAt < ?',
        whereArgs: [until],
        orderBy: 'createAt desc',
        limit: limit);
    return notes;
  }

  Future<List<NoteDB>?> loadMyNotesFromDB(
      {int limit = 50, int? until, NewNotesCallBack? callBack}) async {
    return await loadUserNotesFromDB(pubkey,
        limit: limit, until: until, callBack: callBack);
  }

  Future<List<NoteDB>?> loadUserNotesFromDB(String userPubkey,
      {int limit = 50, int? until, NewNotesCallBack? callBack}) async {
    newPrivateNotesCallBack = callBack;
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'author = ? AND createAt < ?',
        whereArgs: [userPubkey, until],
        orderBy: 'createAt desc',
        limit: limit);
    return notes;
  }

  Future<List<NoteDB>?> loadPrivateNotesFromDB(
      {int limit = 50,
      int? until,
      NewNotesCallBack? callBack,
      bool? read}) async {
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

  Future<List<NoteDB>?> loadContactsNotesFromDB(
      {int limit = 50,
      int? until,
      NewNotesCallBack? callBack,
      bool? read}) async {
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

  Future<NoteDB?> _loadPrivateNoteWithNoteId(String noteId) async {
    List<NoteDB>? result =
    await _loadNotesFromDB(where: 'noteId = ?', whereArgs: [noteId]);
    return result[0];
  }

  Future<NoteDB?> loadNoteWithNoteId(String noteId) async {
    NoteDB? note = notesCache[noteId];
    note ??= await _loadPrivateNoteWithNoteId(noteId);
    note ??= await loadPublicNoteFromRelay(noteId);
    return note;
  }

  Future<NoteDB?> loadPublicNoteFromRelay(String noteId) async {
    Completer<NoteDB?> completer = Completer<NoteDB?>();

    Filter f = Filter(ids: [noteId]);
    NoteDB? result;
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      Note note = Nip1.decodeNote(event);
      result = NoteDB.noteDBFromNote(note);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(result);
        if (result != null) {
          await DB.sharedInstance.insert<NoteDB>(result!,
              conflictAlgorithm: ConflictAlgorithm.ignore);
          notesCache[result!.noteId] = result!;
        }
      }
    });
    return completer.future;
  }

  Future<List<String>> loadPublicNoteRepliesFromRelay(String noteId) async {
    Completer<List<String>> completer = Completer<List<String>>();

    Filter f = Filter(kinds: [1], e: [noteId]);
    List<String> result = [];
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (!notesCache.containsKey(event.id)) {
        Note note = Nip1.decodeNote(event);
        NoteDB noteDB = NoteDB.noteDBFromNote(note);
        result.add(noteDB.noteId);
        notesCache[noteDB.noteId] = noteDB;
        DB.sharedInstance.insert<NoteDB>(noteDB,
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  Future<List<NoteDB>?> loadNewNotesFromRelay({int limit = 50, List<String>? authors}) async {
    Completer<List<NoteDB>?> completer = Completer<List<NoteDB>?>();
    authors ??= Contacts.sharedInstance.allContacts.keys.toList();
    authors.add(pubkey);
    Filter f = Filter(kinds: [1], authors: authors, limit: limit);
    List<NoteDB> result = [];
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (!notesCache.containsKey(event.id)) {
        Note note = Nip1.decodeNote(event);
        NoteDB noteDB = NoteDB.noteDBFromNote(note);
        result.add(noteDB);
        notesCache[noteDB.noteId] = noteDB;
        DB.sharedInstance.insert<NoteDB>(noteDB,
            conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  Future<void> loadOldNotes() async {}

  Future<List<NoteDB>?> loadNoteIdToNoteDB(List<String> noteIds) async {
    List<NoteDB> result = [];
    for (var noteId in noteIds) {
      NoteDB? noteDB = notesCache[noteId];
      noteDB ??= await loadPublicNoteFromRelay(noteId);
      if (noteDB != null) result.add(noteDB);
    }
    return result;
  }

  Future<List<NoteDB>?> loadNoteReplies(String noteId) async {
    NoteDB? noteDB = notesCache[noteId];
    noteDB ??= await loadPublicNoteFromRelay(noteId);
    noteDB?.replyEventIds = await loadPublicNoteRepliesFromRelay(noteId);
    if (noteDB?.replyEventIds?.isNotEmpty == true) {
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
