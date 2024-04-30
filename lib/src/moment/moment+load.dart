import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension Load on Moment {
  Future<List<NoteDB>?> loadAllNotesFromDB({int limit = 50, int? until}) async {
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'createAt < ?',
        whereArgs: [until],
        orderBy: 'createAt desc',
        limit: limit);
    for (var note in notes) {
      notesCache[note.noteId] = note;
    }
    return notes;
  }

  Future<List<NoteDB>?> loadMyNotesFromDB({int limit = 50, int? until}) async {
    return await loadUserNotesFromDB(pubkey, limit: limit, until: until);
  }

  Future<List<NoteDB>?> loadUserNotesFromDB(String userPubkey,
      {int limit = 50, int? until}) async {
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'author = ? AND createAt < ?',
        whereArgs: [userPubkey, until],
        orderBy: 'createAt desc',
        limit: limit);
    for (var note in notes) {
      notesCache[note.noteId] = note;
    }
    return notes;
  }

  Future<List<NoteDB>?> loadPrivateNotesFromDB(
      {int limit = 50, int? until, bool? read}) async {
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'private = ? AND createAt < ? AND read = ?',
        whereArgs: [true, until, read],
        orderBy: 'createAt desc',
        limit: limit);
    List<NoteDB>? result = notes
        .where((n) => Contacts.sharedInstance.allContacts.containsKey(n.author))
        .toList();
    for (var note in result) {
      notesCache[note.noteId] = note;
    }
    return result;
  }

  Future<List<NoteDB>?> loadContactsNotesFromDB(
      {int limit = 50, int? until, bool? read}) async {
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'private = ? AND createAt < ? AND read = ?',
        whereArgs: [false, until, read],
        orderBy: 'createAt desc',
        limit: limit);
    List<NoteDB>? result = notes
        .where((n) => Contacts.sharedInstance.allContacts.containsKey(n.author))
        .toList();
    for (var note in result) {
      notesCache[note.noteId] = note;
    }
    return result;
  }

  Future<NoteDB?> _loadNoteFromDB(String noteId) async {
    List<NoteDB>? result =
        await _loadNotesFromDB(where: 'noteId = ?', whereArgs: [noteId]);
    return result[0];
  }

  Future<NoteDB?> loadNoteWithNoteId(String noteId,
      {bool private = false}) async {
    NoteDB? note = notesCache[noteId];
    note ??= await _loadNoteFromDB(noteId);
    if (!private) note ??= await loadPublicNoteFromRelay(noteId);
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
      if (!completer.isCompleted) completer.complete(result);
      await DB.sharedInstance
          .insert<NoteDB>(result!, conflictAlgorithm: ConflictAlgorithm.ignore);
      notesCache[result!.noteId] = result!;
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty && !completer.isCompleted) completer.complete(null);
    });
    return completer.future;
  }

  Future<List<String>> loadPublicNoteActionsFromRelay(String noteId) async {
    Completer<List<String>> completer = Completer<List<String>>();

    Filter f = Filter(kinds: [1, 6, 7], e: [noteId]);
    List<String> result = [];
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (!notesCache.containsKey(event.id)) {
        NoteDB? noteDB = actionToNoteDB(event);
        if (noteDB != null) {
          result.add(noteDB.noteId);
          notesCache[noteDB.noteId] = noteDB;
          DB.sharedInstance.insert<NoteDB>(noteDB,
              conflictAlgorithm: ConflictAlgorithm.ignore);
        }
      } else {
        result.add(event.id);
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  NoteDB? actionToNoteDB(Event event) {
    NoteDB? result;
    if (event.kind == 1) {
      if (Nip18.hasQTag(event)) {
        QuoteReposts quoteReposts = Nip18.decodeQuoteReposts(event);
        result = NoteDB.noteDBFromQuoteReposts(quoteReposts);
      } else {
        Note note = Nip1.decodeNote(event);
        result = NoteDB.noteDBFromNote(note);
      }
    } else if (event.kind == 6) {
      Reposts reposts = Nip18.decodeReposts(event);
      result = NoteDB.noteDBFromReposts(reposts);
    } else if (event.kind == 7) {
      Reactions reactions = Nip25.decode(event);
      result = NoteDB.noteDBFromReactions(reactions);
    }
    return result;
  }

  Future<List<NoteDB>?> loadNewNotesFromRelay(
      {int limit = 50, List<String>? authors}) async {
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

  Future<List<NoteDB>?> _loadNoteIdToNoteDB(
      List<String> noteIds, bool private) async {
    List<NoteDB> result = [];
    for (var noteId in noteIds) {
      NoteDB? noteDB = notesCache[noteId];
      noteDB ??= await _loadNoteFromDB(noteId);
      if (!private) {
        noteDB ??= await loadPublicNoteFromRelay(noteId);
      }
      if (noteDB != null) result.add(noteDB);
    }
    return result;
  }

  Future<List<NoteDB>?> loadNoteActions(String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if (noteDB != null && noteDB.private) {
      return await _loadNoteIdToNoteDB(noteDB.replyEventIds!, true);
    }
    noteDB?.replyEventIds = await loadPublicNoteActionsFromRelay(noteId);
    if (noteDB?.replyEventIds?.isNotEmpty == true) {
      return await _loadNoteIdToNoteDB(noteDB!.replyEventIds!, false);
    }
    return null;
  }

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

  Future<void> handleNewNotes(NoteDB noteDB) async {
    notesCache[noteDB.noteId] = noteDB;
    int result = await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.ignore);
    if (result > 0) {
      newNotes.add(noteDB);
      newNotesCallBack?.call(newNotes);
    }
    if (noteDB.pTags?.contains(pubkey) == true) {
      NotificationDB notificationDB =
          NotificationDB.notificationDBFromNoteDB(noteDB);
      int result = await DB.sharedInstance.insert<NotificationDB>(
          notificationDB,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      if (result > 0) {
        newNotifications.add(notificationDB);
        newNotificationCallBack?.call(newNotifications);
      }
    }
  }

  Future<void> handleNoteEvent(Event event, String relay, bool private) async {
    if (!notesCache.containsKey(event.id)) {
      updateContactsNotesTime(event.createdAt, relay);
      Note note = Nip1.decodeNote(event);
      NoteDB noteDB = NoteDB.noteDBFromNote(note);
      noteDB.private = private;
      handleNewNotes(noteDB);
    }
  }

  Future<void> handleRepostsEvent(
      Event event, String relay, bool private) async {
    if (!notesCache.containsKey(event.id)) {
      updateContactsNotesTime(event.createdAt, relay);
      Reposts repost = Nip18.decodeReposts(event);
      // save repost event to DB
      if (repost.repostNote != null) {
        NoteDB repostNoteDB = NoteDB.noteDBFromNote(repost.repostNote!);
        await DB.sharedInstance.insert<NoteDB>(repostNoteDB,
            conflictAlgorithm: ConflictAlgorithm.ignore);
        notesCache[repostNoteDB.noteId] = repostNoteDB;
      }

      NoteDB noteDB = NoteDB.noteDBFromReposts(repost);
      noteDB.private = private;
      handleNewNotes(noteDB);
    }
  }

  Future<void> handleReactionEvent(
      Event event, String relay, bool private) async {
    if (!notesCache.containsKey(event.id)) {
      updateContactsNotesTime(event.createdAt, relay);
      Reactions reactions = Nip25.decode(event);
      NoteDB reactionsNoteDB = NoteDB.noteDBFromReactions(reactions);
      reactionsNoteDB.private = private;
      handleNewNotes(reactionsNoteDB);
    }
  }
}
