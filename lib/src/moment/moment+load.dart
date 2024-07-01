import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef NoteCallBack = void Function(NoteDB);
typedef ActionsCallBack = void Function(Map<String, List<dynamic>>);

extension Load on Moment {
  // Future<List<NoteDB>?> loadAllNotesFromDB({int limit = 50, int? until}) async {
  //   until ??= currentUnixTimestampSeconds() + 1;
  //   List<NoteDB>? notes = await loadNotesFromDB(
  //       where: 'createAt < ?',
  //       whereArgs: [until],
  //       orderBy: 'createAt desc',
  //       limit: limit);
  //   for (var note in notes) {
  //     notesCache[note.noteId] = note;
  //     Messages.addToLoaded(note.noteId);
  //   }
  //   return notes;
  // }

  Future<List<NoteDB>?> loadAllNotesFromDB(
      {int limit = 50, int? until, bool? private}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    authors.addAll(Account.sharedInstance.me?.followingList ?? []);
    authors.add(pubkey);
    return await loadUserNotesFromDB(authors,
        limit: limit, until: until, private: private);
  }

  Future<List<NoteDB>?> loadContactsNotesFromDB(
      {int limit = 50, int? until, bool? private}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    authors.add(pubkey);
    return await loadUserNotesFromDB(authors,
        limit: limit, until: until, private: private);
  }

  Future<List<NoteDB>?> loadFollowsNotesFromDB(
      {int limit = 50, int? until, bool? private}) async {
    List<String> authors = Account.sharedInstance.me?.followingList ?? [];
    authors.add(pubkey);
    return await loadUserNotesFromDB(authors,
        limit: limit, until: until, private: private);
  }

  Future<List<NoteDB>?> loadMyNotesFromDB({int limit = 50, int? until}) async {
    return await loadUserNotesFromDB([pubkey], limit: limit, until: until);
  }

  Future<List<NoteDB>?> loadPrivateNotesFromDB(
      {int limit = 50, int? until, bool? read}) async {
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await loadNotesFromDB(
        where: 'private = ? AND createAt < ? AND read = ?',
        whereArgs: [true, until, read],
        orderBy: 'createAt desc',
        limit: limit);
    for (var note in notes) {
      notesCache[note.noteId] = note;
      Messages.addToLoaded(note.noteId);
    }
    List<NoteDB>? result = notes
        .where((n) => Contacts.sharedInstance.allContacts.containsKey(n.author))
        .toList();
    return result;
  }

  Future<List<NoteDB>?> loadUserNotesFromDB(List<String> userPubkeys,
      {int limit = 50, int? until, bool? private}) async {
    // remove blocklist pubkeys
    userPubkeys = userPubkeys
        .where((pubkey) => !Contacts.sharedInstance.inBlockList(pubkey))
        .toList();
    until ??= currentUnixTimestampSeconds() + 1;
    String inClause = List.filled(userPubkeys.length, '?').join(',');

    String whereClause = 'author IN ($inClause) AND createAt < ?';
    List<dynamic> whereArgs = [...userPubkeys, until];

    if (private != null) {
      whereClause += ' AND private = ?';
      whereArgs.add(private ? 1 : 0);
    }

    List<NoteDB>? notes = await loadNotesFromDB(
        where: whereClause,
        whereArgs: whereArgs,
        orderBy: 'createAt desc',
        limit: limit);

    for (var note in notes) {
      notesCache[note.noteId] = note;
      latestNoteTime =
          note.createAt > latestNoteTime ? note.createAt : latestNoteTime;
      Messages.addToLoaded(note.noteId);
      if (!Connect.sharedInstance.eventCache.contains(note.noteId)) {
        Connect.sharedInstance.eventCache.add(note.noteId);
      }
    }
    return notes;
  }

  Future<NoteDB?> loadNoteFromDBWithNoteId(String noteId) async {
    List<NoteDB>? result =
        await loadNotesFromDB(where: 'noteId = ?', whereArgs: [noteId]);
    return result.isEmpty ? null : result[0];
  }

  Future<NoteDB?> loadNoteWithNoteId(String noteId,
      {bool private = false, bool reload = true, List<String>? relays}) async {
    if (notesCache.containsKey(noteId)) return notesCache[noteId];
    NoteDB? note = await loadNoteFromDBWithNoteId(noteId);
    if (note == null && !private && reload) {
      await Connect.sharedInstance.connectRelays(relays ?? [], type: 1);
      note = await loadPublicNoteFromRelay(noteId, relays: relays);
      await Connect.sharedInstance.closeConnects(relays ?? []);
    }
    if (note != null) notesCache[noteId] = note;
    return note;
  }

  Future<NoteDB?> loadNoteWithNevent(String nevent,
      {bool private = false, bool reload = true}) async {
    String? noteId;
    List<String>? relays;
    Map result = Nip19.decodeShareableEntity(nevent);
    if (result['prefix'] == 'nevent' && result['kind'] == 1) {
      noteId = result['special'];
      relays = result['relays'];
      if (noteId != null) {
        return loadNoteWithNoteId(noteId,
            private: private, reload: reload, relays: relays);
      }
    }
    return null;
  }

  Future<void> saveNoteToDB(
      NoteDB noteDB, ConflictAlgorithm? conflictAlgorithm) async {
    if (!notesCache.containsKey(noteDB.noteId) ||
        conflictAlgorithm == ConflictAlgorithm.replace) {
      notesCache[noteDB.noteId] = noteDB;
    }
    int result = await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: conflictAlgorithm);
    if (result > 0) notesCache[noteDB.noteId] = noteDB;
  }

  Future<NoteDB?> loadPublicNoteFromRelay(String noteId,
      {List<String>? relays}) async {
    if (noteId.isEmpty) return null;
    Completer<NoteDB?> completer = Completer<NoteDB?>();
    Filter f = Filter(ids: [noteId]);
    Connect.sharedInstance.addSubscription([f], relays: relays,
        eventCallBack: (event, relay) async {
      NoteDB? noteDB;
      switch (event.kind) {
        case 1:
          if (Nip18.hasQTag(event)) {
            QuoteReposts quoteReposts = Nip18.decodeQuoteReposts(event);
            noteDB = NoteDB.noteDBFromQuoteReposts(quoteReposts);
          } else {
            Note note = Nip1.decodeNote(event);
            noteDB = NoteDB.noteDBFromNote(note);
          }
          break;
        case 6:
          Reposts reposts = await Nip18.decodeReposts(event);
          noteDB = NoteDB.noteDBFromReposts(reposts);
          break;
        case 7:
          Reactions reactions = Nip25.decode(event);
          noteDB = NoteDB.noteDBFromReactions(reactions);
          break;
      }
      if (!completer.isCompleted) completer.complete(noteDB);
      if (noteDB != null) saveNoteToDB(noteDB, ConflictAlgorithm.ignore);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) {
          NoteDB? note = await loadNoteWithNoteId(noteId, reload: false);
          completer.complete(note);
        }
      }
    });
    return completer.future;
  }

  Future<NoteDB> loadPublicNoteActionsFromRelay(NoteDB noteDB,
      {NoteCallBack? noteCallBack}) async {
    String noteId = noteDB.noteId;
    Completer<NoteDB> completer = Completer<NoteDB>();

    Map<String, Event> result = {};
    Map<String, List<Filter>> subscriptions = {};
    for (String relayURL in Connect.sharedInstance.relays()) {
      int lastUpdatedTime = noteDB.getLastUpdatedTime(relayURL);
      Filter f = Filter(
          kinds: [1, 6, 7, 9735], e: [noteId], since: lastUpdatedTime + 1);
      subscriptions[relayURL] = [f];
    }
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
      if (!result.containsKey(event.id)) {
        result[event.id] = event;
        switch (event.kind) {
          case 1:
            Nip18.hasQTag(event)
                ? addQuoteRepostToNote(event, noteId)
                : addReplyToNote(event, noteId);
            break;
          case 6:
            addRepostToNote(event, noteId);
            break;
          case 7:
            addReactionToNote(event, noteId);
            break;
          case 9735:
            addZapRecordToNote(event, noteId);
            break;
        }
        NoteDB? noteDB = await loadNoteWithNoteId(noteId);
        noteCallBack?.call(noteDB!);
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (ok.status) {
        NoteDB? noteDB = notesCache[noteId];
        noteDB?.lastUpdatedTime?[relay] = currentUnixTimestampSeconds();
      }
      if (unRelays.isEmpty) {
        NoteDB? noteDB = await loadNoteWithNoteId(noteId);
        if (!completer.isCompleted) completer.complete(noteDB);
      }
    });
    return completer.future;
  }

  Future<void> addZapRecordToNote(Event zapEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId, reload: false);
    if (noteDB == null) return;
    noteDB.zapEventIds ??= [];
    ZapReceipt zapReceipt = await Nip57.getZapReceipt(
        zapEvent,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    ZapRecordsDB zapRecordsDB =
        ZapRecordsDB.zapReceiptToZapRecordsDB(zapReceipt);
    if (noteDB.zapEventIds?.contains(zapRecordsDB.bolt11) == true) return;
    DB.sharedInstance.insert<ZapRecordsDB>(zapRecordsDB,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    noteDB.zapEventIds?.add(zapRecordsDB.bolt11);
    noteDB.zapCount++;
    noteDB.zapAmount += ZapRecordsDB.getZapAmount(zapRecordsDB.bolt11);
    if (zapRecordsDB.sender == pubkey) {
      noteDB.zapCountByMe++;
      noteDB.zapAmountByMe += ZapRecordsDB.getZapAmount(zapRecordsDB.bolt11);
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
  }

  Future<void> addReplyToNote(Event replyEvent, String replyId) async {
    Note replyNote = Nip1.decodeNote(replyEvent);
    NoteDB replyNoteDB = NoteDB.noteDBFromNote(replyNote);
    String noteId = replyNoteDB.reply ?? '';
    if (noteId.isEmpty) noteId = replyNoteDB.root ?? '';
    if (noteId.isEmpty) noteId = replyId;
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if (noteDB == null) return;
    noteDB.replyEventIds ??= [];
    if (noteDB.replyEventIds?.contains(replyEvent.id) == true) return;
    saveNoteToDB(replyNoteDB, ConflictAlgorithm.ignore);
    noteDB.replyEventIds?.add(replyNoteDB.noteId);
    if (replyNoteDB.getReplyLevel(noteDB.noteId) == 1) noteDB.replyCount++;
    if (replyEvent.pubkey == pubkey) {
      noteDB.replyCountByMe++;
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
  }

  Future<void> addRepostToNote(Event repostEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if (noteDB == null) return;
    noteDB.repostEventIds ??= [];
    if (noteDB.repostEventIds?.contains(repostEvent.id) == true) return;

    Reposts reposts = await Nip18.decodeReposts(repostEvent);
    NoteDB repostDB = NoteDB.noteDBFromReposts(reposts);
    saveNoteToDB(repostDB, ConflictAlgorithm.ignore);
    noteDB.repostEventIds?.add(repostDB.noteId);
    noteDB.repostCount++;
    if (reposts.pubkey == pubkey) {
      noteDB.repostCountByMe++;
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
  }

  Future<void> addQuoteRepostToNote(
      Event quoteRepostEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if (noteDB == null) return;
    noteDB.quoteRepostEventIds ??= [];
    if (noteDB.quoteRepostEventIds?.contains(quoteRepostEvent.id) == true) {
      return;
    }

    QuoteReposts quoteReposts = Nip18.decodeQuoteReposts(quoteRepostEvent);
    NoteDB quoteRepostDB = NoteDB.noteDBFromQuoteReposts(quoteReposts);
    saveNoteToDB(quoteRepostDB, ConflictAlgorithm.ignore);
    noteDB.quoteRepostEventIds?.add(quoteRepostDB.noteId);
    noteDB.quoteRepostCount++;
    if (quoteReposts.pubkey == pubkey) {
      noteDB.quoteRepostCountByMe++;
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
  }

  Future<void> addReactionToNote(Event reactionEvent, String noteId) async {
    NoteDB? noteDB = await loadNoteWithNoteId(noteId);
    if (noteDB == null) return;
    noteDB.reactionEventIds ??= [];
    if (noteDB.reactionEventIds?.contains(reactionEvent.id) == true) return;

    Reactions reactions = Nip25.decode(reactionEvent);
    NoteDB reactionDB = NoteDB.noteDBFromReactions(reactions);
    saveNoteToDB(reactionDB, ConflictAlgorithm.ignore);
    noteDB.reactionEventIds?.add(reactionDB.noteId);
    noteDB.reactionCount++;
    if (reactions.pubkey == pubkey) {
      noteDB.reactionCountByMe++;
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
  }

  Future<List<NoteDB>?> loadAllNewNotesFromRelay(
      {int? until, int? since, int? limit}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    authors.addAll(Account.sharedInstance.me?.followingList ?? []);
    authors.add(pubkey);
    return await loadNewNotesFromRelay(
        limit: limit, authors: authors, until: until, since: since);
  }

  Future<List<NoteDB>?> loadContactsNewNotesFromRelay(
      {int? until, int? since, int? limit}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    authors.add(pubkey);
    return await loadNewNotesFromRelay(
        limit: limit, authors: authors, until: until, since: since);
  }

  Future<List<NoteDB>?> loadFollowsNewNotesFromRelay(
      {int? until, int? since, int? limit}) async {
    List<String> authors = Account.sharedInstance.me?.followingList ?? [];
    authors.add(pubkey);
    return await loadNewNotesFromRelay(
        limit: limit, authors: authors, until: until, since: since);
  }

  Future<List<NoteDB>?> loadNewNotesFromRelay(
      {int? limit = 50, List<String>? authors, int? until, int? since}) async {
    Completer<List<NoteDB>?> completer = Completer<List<NoteDB>?>();
    authors ??= [pubkey];
    Filter f = Filter(
        kinds: [1], authors: authors, limit: limit, until: until, since: since);
    Map<String, Event> result = {};
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      result[event.id] = event;
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        List<NoteDB> r = [];
        List<Event> values = List.from(result.values);
        for (Event event in values) {
          NoteDB? noteDB;
          if (Messages.isLoaded(event.id)) {
            noteDB = await loadNoteWithNoteId(event.id);
          } else {
            Messages.addToLoaded(event.id);
            Note note = Nip1.decodeNote(event);
            noteDB = NoteDB.noteDBFromNote(note);
            await saveNoteToDB(noteDB, ConflictAlgorithm.ignore);
          }
          if (noteDB != null) r.add(noteDB);
        }
        if (!completer.isCompleted) completer.complete(r);
      }
    });
    return completer.future;
  }

  Future<List<NoteDB>?> loadHashTagsFromRelay(List<String> hashTags,
      {int limit = 30, int? until}) async {
    Completer<List<NoteDB>?> completer = Completer<List<NoteDB>?>();
    Filter f = Filter(kinds: [1], t: hashTags, until: until, limit: limit);
    Map<String, Event> result = {};
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      result[event.id] = event;
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        List<NoteDB> r = [];
        for (Event event in result.values) {
          NoteDB? noteDB;
          if (Messages.isLoaded(event.id)) {
            noteDB = await loadNoteWithNoteId(event.id);
          } else {
            Messages.addToLoaded(event.id);
            Note note = Nip1.decodeNote(event);
            noteDB = NoteDB.noteDBFromNote(note);
            saveNoteToDB(noteDB, ConflictAlgorithm.ignore);
          }
          if (noteDB != null) r.add(noteDB);
        }
        if (!completer.isCompleted) completer.complete(r);
      }
    });
    return completer.future;
  }

  Future<void> loadOldNotes() async {}

  Future<List<NoteDB>> loadNoteIdsToNoteDBs(
      List<String> noteIds, bool private, bool reload) async {
    List<NoteDB> result = [];
    List<String> copiedNoteIds = List.from(noteIds);
    for (var noteId in copiedNoteIds) {
      NoteDB? noteDB = await loadNoteWithNoteId(noteId);
      if (!private && reload) {
        noteDB ??= await loadPublicNoteFromRelay(noteId);
      }
      if (noteDB != null) result.add(noteDB);
    }
    return result;
  }

  static Future<List<ZapRecordsDB>> loadInvoicesToZapRecords(
      List<String> invoices, bool private) async {
    List<ZapRecordsDB> result = [];
    for (var invoice in invoices) {
      List<ZapRecordsDB> zapRecords =
          await Zaps.getZapReceipt('', invoice: invoice);
      if (zapRecords.isNotEmpty) result.add(zapRecords.first);
    }
    return result;
  }

  Future<Map<String, List<dynamic>>> loadNoteActions(String noteId,
      {bool reload = true, ActionsCallBack? actionsCallBack}) async {
    Map<String, List<dynamic>> result = {
      'reply': [],
      'repost': [],
      'quoteRepost': [],
      'reaction': [],
      'zap': []
    };
    NoteDB? noteDB = await loadNoteWithNoteId(noteId, reload: reload);
    if (noteDB != null) {
      if (!noteDB.private && reload) {
        await loadPublicNoteActionsFromRelay(noteDB,
            noteCallBack: (noteDB) async {
          result['reply'] = await loadNoteIdsToNoteDBs(
              noteDB.replyEventIds ?? [], noteDB.private, reload);
          // result['repost'] = await _loadNoteIdsToNoteDBs(
          //     noteDB.repostEventIds ?? [], noteDB.private, reload);
          // result['quoteRepost'] = await _loadNoteIdsToNoteDBs(
          //     noteDB.quoteRepostEventIds ?? [], noteDB.private, reload);
          // result['reaction'] = await _loadNoteIdsToNoteDBs(
          //     noteDB.reactionEventIds ?? [], noteDB.private, reload);
          // result['zap'] = await loadInvoicesToZapRecords(
          //     noteDB.zapEventIds ?? [], noteDB.private);
          actionsCallBack?.call(result);
        });
      }
    }
    return result;
  }

  Future<List<NoteDB>> loadNotesFromDB({
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
    int result = await DB.sharedInstance
        .insert<NoteDB>(noteDB, conflictAlgorithm: ConflictAlgorithm.ignore);
    if (result > 0 &&
        noteDB.getReplyLevel(null) != 2 &&
        noteDB.createAt > latestNoteTime) {
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
    Note note = Nip1.decodeNote(event);
    NoteDB noteDB = NoteDB.noteDBFromNote(note);
    noteDB.private = private;
    // reply
    if (noteDB.getNoteKind() == 1) {
      await addReplyToNote(event, noteDB.reply ?? noteDB.root!);
    }
    // quote repost
    else if (noteDB.getNoteKind() == 2) {
      await addQuoteRepostToNote(event, noteDB.quoteRepostId!);
    }
    handleNewNotes(noteDB);
  }

  Future<void> handleRepostsEvent(
      Event event, String relay, bool private) async {
    Reposts repost = await Nip18.decodeReposts(event);
    // save repost event to DB
    if (repost.repostNote != null) {
      NoteDB repostNoteDB = NoteDB.noteDBFromNote(repost.repostNote!);
      saveNoteToDB(repostNoteDB, ConflictAlgorithm.ignore);
    }

    NoteDB noteDB = NoteDB.noteDBFromReposts(repost);
    noteDB.private = private;
    await addRepostToNote(event, noteDB.repostId!);
    handleNewNotes(noteDB);
  }

  Future<void> handleReactionEvent(
      Event event, String relay, bool private) async {
    Reactions reactions = Nip25.decode(event);
    NoteDB reactionsNoteDB = NoteDB.noteDBFromReactions(reactions);
    reactionsNoteDB.private = private;
    final reactedMessageDB = await Messages.sharedInstance
        .loadMessageDBFromDB(reactions.reactedEventId);
    if (reactedMessageDB != null) {
      await Messages.sharedInstance.handleReactionEvent(event);
    } else {
      await addReactionToNote(event, reactionsNoteDB.reactedId!);
      handleNewNotes(reactionsNoteDB);
    }
  }
}
