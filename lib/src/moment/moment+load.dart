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
    return result.isEmpty ? null : result[0];
  }

  Future<NoteDB?> loadNoteWithNoteId(String noteId,
      {bool private = false}) async {
    NoteDB? note = await _loadNoteFromDB(noteId);
    if (!private) note ??= await loadPublicNoteFromRelay(noteId);
    return note;
  }

  Future<void> saveNoteToDB(NoteDB noteDB,
      {ConflictAlgorithm? conflictAlgorithm}) async {
    notesCache[noteDB.noteId] = noteDB;
    await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: conflictAlgorithm);
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
      await saveNoteToDB(result!, conflictAlgorithm: ConflictAlgorithm.ignore);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty && !completer.isCompleted) completer.complete(null);
    });
    return completer.future;
  }

  Future<void> loadPublicNoteActionsFromRelay(String noteId) async {
    List<Event> result = [];
    Filter f = Filter(kinds: [1, 6, 7, 9735], e: [noteId]);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      result.add(event);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        for (var event in result) {
          switch (event.kind) {
            case 1:
              Nip18.hasQTag(event)
                  ? await addQuoteRepostToNote(event, noteId)
                  : await addReplyToNote(event, noteId);
              break;
            case 6:
              await addRepostToNote(event, noteId);
              break;
            case 7:
              await addReactionToNote(event, noteId);
              break;
            case 9735:
              await addZapRecordToNote(event, noteId);
              break;
          }
        }
      }
    });
  }

  Future<void> addZapRecordToNote(Event zapEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if(noteDB == null) return;
    noteDB.zapEventIds ??= [];
    ZapReceipt zapReceipt = await Nip57.getZapReceipt(
        zapEvent,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    ZapRecordsDB zapRecordsDB =
        ZapRecordsDB.zapReceiptToZapRecordsDB(zapReceipt);
    if (noteDB.zapEventIds?.contains(zapRecordsDB.bolt11) == true) return;
    await DB.sharedInstance.insert<ZapRecordsDB>(zapRecordsDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    noteDB.zapEventIds?.add(zapRecordsDB.bolt11);
    noteDB.zapCount++;
    noteDB.zapAmount += ZapRecordsDB.getZapAmount(zapRecordsDB.bolt11);
    await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addReplyToNote(Event replyEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if(noteDB == null) return;
    noteDB.replyEventIds ??= [];
    if (noteDB.replyEventIds?.contains(replyEvent.id) == true) return;

    Note replyNote = Nip1.decodeNote(replyEvent);
    NoteDB replyNoteDB = NoteDB.noteDBFromNote(replyNote);
    await DB.sharedInstance.insert<NoteDB>(replyNoteDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    noteDB.replyEventIds?.add(replyNoteDB.noteId);
    noteDB.replyCount++;
    await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addRepostToNote(Event repostEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if(noteDB == null) return;
    noteDB.repostEventIds ??= [];
    if (noteDB.repostEventIds?.contains(repostEvent.id) == true) return;

    Reposts reposts = Nip18.decodeReposts(repostEvent);
    NoteDB repostDB = NoteDB.noteDBFromReposts(reposts);
    await DB.sharedInstance
        .insert<NoteDB>(repostDB, conflictAlgorithm: ConflictAlgorithm.ignore);
    noteDB.repostEventIds?.add(repostDB.noteId);
    noteDB.repostCount++;
    await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addQuoteRepostToNote(
      Event quoteRepostEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if(noteDB == null) return;
    noteDB.quoteRepostEventIds ??= [];
    if (noteDB.quoteRepostEventIds?.contains(quoteRepostEvent.id) == true)
      return;

    QuoteReposts quoteReposts = Nip18.decodeQuoteReposts(quoteRepostEvent);
    NoteDB quoteRepostDB = NoteDB.noteDBFromQuoteReposts(quoteReposts);
    await DB.sharedInstance.insert<NoteDB>(quoteRepostDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    noteDB.quoteRepostEventIds?.add(quoteRepostDB.noteId);
    noteDB.quoteRepostCount++;
    await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addReactionToNote(Event reactionEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if(noteDB == null) return;
    noteDB.reactionEventIds ??= [];
    if (noteDB.reactionEventIds?.contains(reactionEvent.id) == true) return;

    Reactions reactions = Nip25.decode(reactionEvent);
    NoteDB reactionDB = NoteDB.noteDBFromReactions(reactions);
    await DB.sharedInstance.insert<NoteDB>(reactionDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    noteDB.reactionEventIds?.add(reactionDB.noteId);
    noteDB.reactionCount++;
    await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<NoteDB>?> loadNewNotesFromRelay(
      {int limit = 50, List<String>? authors, int? until}) async {
    Completer<List<NoteDB>?> completer = Completer<List<NoteDB>?>();
    authors ??= Contacts.sharedInstance.allContacts.keys.toList();
    authors.add(pubkey);
    Filter f = Filter(kinds: [1], authors: authors, limit: limit, until: until);
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

  Future<List<NoteDB>?> loadHashTagsFromRelay(List<String> hashTags,
      {int limit = 50, int? until}) async {
    Completer<List<NoteDB>?> completer = Completer<List<NoteDB>?>();
    Filter f = Filter(kinds: [1], t: hashTags, until: until, limit: limit);
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

  Future<List<NoteDB>> _loadNoteIdsToNoteDBs(
      List<String> noteIds, bool private) async {
    List<NoteDB> result = [];
    for (var noteId in noteIds) {
      NoteDB? noteDB = await _loadNoteFromDB(noteId);
      if (!private) {
        noteDB ??= await loadPublicNoteFromRelay(noteId);
      }
      if (noteDB != null) result.add(noteDB);
    }
    return result;
  }

  Future<List<ZapRecordsDB>> _loadInvoicesToZapRecords(
      List<String> invoices, bool private) async {
    List<ZapRecordsDB> result = [];
    for (var invoice in invoices) {
      List<ZapRecordsDB> zapRecords =
          await Zaps.getZapReceipt('', invoice: invoice);
      if (zapRecords.isNotEmpty) result.add(zapRecords.first);
    }
    return result;
  }

  Future<Map<String, List<dynamic>>> loadNoteActions(String noteId) async {
    Map<String, List<dynamic>> result = {
      'reply': [],
      'repost': [],
      'quoteRepost': [],
      'reaction': [],
      'zap': []
    };
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if(noteDB != null){
      if (!noteDB.private) {
        await loadPublicNoteActionsFromRelay(noteId);
      }
      result['reply'] =
      await _loadNoteIdsToNoteDBs(noteDB.replyEventIds!, noteDB.private);
      result['repost'] =
      await _loadNoteIdsToNoteDBs(noteDB.repostEventIds!, noteDB.private);
      result['quoteRepost'] = await _loadNoteIdsToNoteDBs(
          noteDB.quoteRepostEventIds!, noteDB.private);
      result['reaction'] =
      await _loadNoteIdsToNoteDBs(noteDB.reactionEventIds!, noteDB.private);
      result['zap'] =
      await _loadInvoicesToZapRecords(noteDB.zapEventIds!, noteDB.private);
    }
    return result;
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
    updateContactsNotesTime(event.createdAt, relay);
    Note note = Nip1.decodeNote(event);
    NoteDB noteDB = NoteDB.noteDBFromNote(note);
    noteDB.private = private;
    handleNewNotes(noteDB);
  }

  Future<void> handleRepostsEvent(
      Event event, String relay, bool private) async {
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

  Future<void> handleReactionEvent(
      Event event, String relay, bool private) async {
    updateContactsNotesTime(event.createdAt, relay);
    Reactions reactions = Nip25.decode(event);
    NoteDB reactionsNoteDB = NoteDB.noteDBFromReactions(reactions);
    reactionsNoteDB.private = private;
    handleNewNotes(reactionsNoteDB);
  }
}
