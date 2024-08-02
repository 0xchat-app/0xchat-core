import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef NoteCallBack = void Function(NoteDBISAR);
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

  Future<List<NoteDBISAR>?> loadAllNotesFromDB(
      {int limit = 50, int? until, bool? private}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    authors.addAll(Account.sharedInstance.me?.followingList ?? []);
    authors.add(pubkey);
    return await loadUserNotesFromDB(authors,
        limit: limit, until: until, private: private);
  }

  Future<List<NoteDBISAR>?> loadContactsNotesFromDB(
      {int limit = 50, int? until, bool? private = false}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    return await loadUserNotesFromDB(authors,
        limit: limit, until: until, private: private);
  }

  Future<List<NoteDBISAR>?> loadFollowsNotesFromDB(
      {int limit = 50, int? until, bool? private = false}) async {
    List<String> authors = Account.sharedInstance.me?.followingList ?? [];
    return await loadUserNotesFromDB(authors,
        limit: limit, until: until, private: private);
  }

  Future<List<NoteDBISAR>?> loadMyReactedNotesFromDB(
      {int limit = 50, int? until, bool? private = false}) async {
    List<String> authors = [pubkey];
    List<NoteDBISAR>? reactedNotes = await loadUserNotesFromDB(authors,
        limit: limit, until: until, private: private, isReacted: true);
    List<ZapRecordsDBISAR?> zapRecords =
        await Zaps.searchZapRecordsFromDB(sender: pubkey);
    List<String> reactedIds = [];
    for (NoteDBISAR note in reactedNotes ?? []) {
      if (note.reactedId != null) reactedIds.add(note.reactedId!);
    }
    for (ZapRecordsDBISAR? zapRecordsDB in zapRecords) {
      if (zapRecordsDB != null && zapRecordsDB.eventId.isNotEmpty) {
        reactedIds.add(zapRecordsDB.eventId);
      }
    }
    List<NoteDBISAR> result = [];
    await Future.forEach(reactedIds, (noteId) async {
      NoteDBISAR? n = await loadNoteWithNoteId(noteId, reload: false);
      if (n != null) result.add(n);
    });
    result.sort((a, b) => b.createAt.compareTo(a.createAt));
    return result;
  }

  Future<List<NoteDBISAR>?> loadMyNotesFromDB(
      {int limit = 50, int? until}) async {
    return await loadUserNotesFromDB([pubkey], limit: limit, until: until);
  }

  Future<List<NoteDBISAR>?> loadUserNotesFromDB(List<String> userPubkeys,
      {int limit = 50, int? until, bool? private, bool? isReacted}) async {
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

    whereClause += " AND (groupId = '' OR groupId IS NULL)";

    if (isReacted != null) {
      whereClause += " AND reactedId IS NOT NULL AND reactedId != ''";
    }

    List<NoteDBISAR>? notes = await loadNotesFromDB(
        where: whereClause,
        whereArgs: whereArgs,
        orderBy: 'createAt desc',
        limit: limit);

    for (var note in notes) {
      notesCache[note.noteId] = note;
      latestNoteTime =
          note.createAt > latestNoteTime ? note.createAt : latestNoteTime;
      if (!Connect.sharedInstance.eventCache.contains(note.noteId)) {
        Connect.sharedInstance.eventCache.add(note.noteId);
      }
    }
    return notes;
  }

  Future<NoteDBISAR?> loadNoteFromDBWithNoteId(String noteId) async {
    List<NoteDBISAR>? result =
        await loadNotesFromDB(where: 'noteId = ?', whereArgs: [noteId]);
    return result.isEmpty ? null : result[0];
  }

  Future<NoteDBISAR?> loadNoteWithNoteId(String noteId,
      {bool private = false, bool reload = true, List<String>? relays}) async {
    if (notesCache.containsKey(noteId)) return notesCache[noteId];
    NoteDBISAR? note = await loadNoteFromDBWithNoteId(noteId);
    if (note == null && !private && reload) {
      await Connect.sharedInstance
          .connectRelays(relays ?? [], relayKind: RelayKind.temp);
      note = await loadPublicNoteFromRelay(noteId, relays: relays);
      await Connect.sharedInstance.closeTempConnects(relays ?? []);
    }
    if (note != null) notesCache[noteId] = note;
    return note;
  }

  Future<NoteDBISAR?> loadNoteWithNevent(String nevent,
      {bool private = false, bool reload = true}) async {
    String? noteId;
    List<String>? relays;
    if (nevent.startsWith('nostr:')) {
      nevent = Nip21.decode(nevent)!;
    }
    Map result = Nip19.decodeShareableEntity(nevent);
    if (result['prefix'] == 'nevent') {
      noteId = result['special'];
      relays = result['relays'];
      if (noteId != null) {
        return await loadNoteWithNoteId(noteId,
            private: private, reload: reload, relays: relays);
      }
    }
    return null;
  }

  Future<void> saveNoteToDB(
      NoteDBISAR noteDB, ConflictAlgorithm? conflictAlgorithm) async {
    if (!notesCache.containsKey(noteDB.noteId) ||
        conflictAlgorithm != ConflictAlgorithm.ignore) {
      notesCache[noteDB.noteId] = noteDB;
    }
    final isar = DBISAR.sharedInstance.isar;
    await isar.writeTxn(() async {
      await isar.noteDBISARs.put(noteDB);
    });
    notesCache[noteDB.noteId] = noteDB;
  }

  Future<NoteDBISAR?> loadPublicNoteFromRelay(String noteId,
      {List<String>? relays}) async {
    if (noteId.isEmpty) return null;
    List<String> tempRelays = [];
    for (var relay in relays ?? []) {
      if (relay.isNotEmpty &&
          !Connect.sharedInstance.webSockets.keys.contains(relay)) {
        await Connect.sharedInstance
            .connectRelays([relay], relayKind: RelayKind.temp);
        tempRelays.add(relay);
      }
    }
    Completer<NoteDBISAR?> completer = Completer<NoteDBISAR?>();
    Filter f = Filter(ids: [noteId]);
    Connect.sharedInstance.addSubscription([f], relays: relays,
        eventCallBack: (event, relay) async {
      NoteDBISAR? noteDB;
      switch (event.kind) {
        case 1:
          if (Nip18.hasQTag(event)) {
            QuoteReposts quoteReposts = Nip18.decodeQuoteReposts(event);
            noteDB = NoteDBISAR.noteDBFromQuoteReposts(quoteReposts);
          } else {
            Note note = Nip1.decodeNote(event);
            noteDB = NoteDBISAR.noteDBFromNote(note);
          }
          break;
        case 6:
          Reposts reposts = await Nip18.decodeReposts(event);
          noteDB = NoteDBISAR.noteDBFromReposts(reposts);
          break;
        case 7:
          Reactions reactions = Nip25.decode(event);
          noteDB = NoteDBISAR.noteDBFromReactions(reactions);
          break;
      }
      if (!completer.isCompleted) completer.complete(noteDB);
      if (noteDB != null) saveNoteToDB(noteDB, ConflictAlgorithm.ignore);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) {
          NoteDBISAR? note = await loadNoteWithNoteId(noteId, reload: false);
          Connect.sharedInstance.closeConnects(tempRelays, RelayKind.temp);
          completer.complete(note);
        }
      }
    });
    return completer.future;
  }

  Future<NoteDBISAR> loadPublicNoteActionsFromDB(NoteDBISAR noteDB,
      {NoteCallBack? noteCallBack}) async {
    String whereClause =
        'root = ? OR reply = ? OR repostId = ? OR quoteRepostId = ? OR reactedId = ?';
    List<Object?> whereArgs = [
      noteDB.noteId,
      noteDB.noteId,
      noteDB.noteId,
      noteDB.noteId,
      noteDB.noteId
    ];

    List<NoteDBISAR> notes = await loadNotesFromDB(
      where: whereClause,
      whereArgs: whereArgs,
    );

    noteDB.replyEventIds ??= [];
    noteDB.repostEventIds ??= [];
    noteDB.quoteRepostEventIds ??= [];
    noteDB.reactionEventIds ??= [];

    for (var note in notes) {
      // check reply
      if (note.reply == noteDB.noteId &&
          !noteDB.replyEventIds!.contains(note.noteId)) {
        noteDB.replyEventIds!.add(note.noteId);
        noteDB.replyCount++;
        if (note.author == pubkey) noteDB.replyCountByMe++;
      } else if ((note.root == noteDB.noteId &&
              (note.reply == null || note.reply!.isEmpty)) &&
          !noteDB.replyEventIds!.contains(note.noteId)) {
        noteDB.replyEventIds!.add(note.noteId);
        noteDB.replyCount++;
        if (note.author == pubkey) noteDB.replyCountByMe++;
      }
      // check repost
      if (note.repostId == noteDB.noteId &&
          !noteDB.repostEventIds!.contains(note.noteId)) {
        noteDB.repostEventIds!.add(note.noteId);
        noteDB.repostCount++;
        if (note.author == pubkey) noteDB.repostCountByMe++;
      }
      // check quote repost
      if (note.quoteRepostId == noteDB.noteId &&
          !noteDB.quoteRepostEventIds!.contains(note.noteId)) {
        noteDB.quoteRepostEventIds!.add(note.noteId);
        noteDB.quoteRepostCount++;
        if (note.author == pubkey) noteDB.quoteRepostCountByMe++;
      }
      // check reaction
      if (note.reactedId == noteDB.noteId &&
          !noteDB.reactionEventIds!.contains(note.noteId)) {
        noteDB.reactionEventIds!.add(note.noteId);
        noteDB.reactionCount++;
        if (note.author == pubkey) noteDB.reactionCountByMe++;
      }
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
    return noteDB;
  }

  Future<NoteDBISAR> loadPublicNoteActionsFromRelay(NoteDBISAR noteDB,
      {NoteCallBack? noteCallBack}) async {
    String noteId = noteDB.noteId;
    Completer<NoteDBISAR> completer = Completer<NoteDBISAR>();

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
      if (Contacts.sharedInstance.inBlockList(event.pubkey)) return;
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
        NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId);
        noteCallBack?.call(noteDB!);
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (ok.status) {
        NoteDBISAR? noteDB = notesCache[noteId];
        noteDB?.lastUpdatedTime?[relay] = currentUnixTimestampSeconds();
      }
      if (unRelays.isEmpty) {
        NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId);
        if (!completer.isCompleted) completer.complete(noteDB);
      }
    });
    return completer.future;
  }

  Future<void> addZapRecordToNote(Event zapEvent, String noteId) async {
    NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId, reload: false);
    if (noteDB == null) return;
    noteDB.zapEventIds ??= [];
    ZapReceipt zapReceipt = await Nip57.getZapReceipt(
        zapEvent,
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    ZapRecordsDBISAR zapRecordsDB =
        ZapRecordsDBISAR.zapReceiptToZapRecordsDB(zapReceipt);
    if (noteDB.zapEventIds?.contains(zapRecordsDB.bolt11) == true) return;
    Zaps.saveZapRecordToDB(zapRecordsDB);
    noteDB.zapEventIds?.add(zapRecordsDB.bolt11);
    noteDB.zapCount++;
    noteDB.zapAmount += ZapRecordsDBISAR.getZapAmount(zapRecordsDB.bolt11);
    if (zapRecordsDB.sender == pubkey) {
      noteDB.zapCountByMe++;
      noteDB.zapAmountByMe +=
          ZapRecordsDBISAR.getZapAmount(zapRecordsDB.bolt11);
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
  }

  Future<void> addReplyToNote(Event replyEvent, String replyId) async {
    Note replyNote = Nip1.decodeNote(replyEvent);
    NoteDBISAR replyNoteDB = NoteDBISAR.noteDBFromNote(replyNote);
    String noteId = replyNoteDB.reply ?? '';
    if (noteId.isEmpty) noteId = replyNoteDB.root ?? '';
    if (noteId.isEmpty) noteId = replyId;
    NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId);
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
    NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId);
    if (noteDB == null) return;
    noteDB.repostEventIds ??= [];
    if (noteDB.repostEventIds?.contains(repostEvent.id) == true) return;

    Reposts reposts = await Nip18.decodeReposts(repostEvent);
    NoteDBISAR repostDB = NoteDBISAR.noteDBFromReposts(reposts);
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
    NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId);
    if (noteDB == null) return;
    noteDB.quoteRepostEventIds ??= [];
    if (noteDB.quoteRepostEventIds?.contains(quoteRepostEvent.id) == true) {
      return;
    }

    QuoteReposts quoteReposts = Nip18.decodeQuoteReposts(quoteRepostEvent);
    NoteDBISAR quoteRepostDB = NoteDBISAR.noteDBFromQuoteReposts(quoteReposts);
    saveNoteToDB(quoteRepostDB, ConflictAlgorithm.ignore);
    noteDB.quoteRepostEventIds?.add(quoteRepostDB.noteId);
    noteDB.quoteRepostCount++;
    if (quoteReposts.pubkey == pubkey) {
      noteDB.quoteRepostCountByMe++;
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
  }

  Future<void> addReactionToNote(Event reactionEvent, String noteId) async {
    NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId);
    if (noteDB == null) return;
    noteDB.reactionEventIds ??= [];
    if (noteDB.reactionEventIds?.contains(reactionEvent.id) == true) return;

    Reactions reactions = Nip25.decode(reactionEvent);
    NoteDBISAR reactionDB = NoteDBISAR.noteDBFromReactions(reactions);
    saveNoteToDB(reactionDB, ConflictAlgorithm.ignore);
    noteDB.reactionEventIds?.add(reactionDB.noteId);
    noteDB.reactionCount++;
    if (reactions.pubkey == pubkey) {
      noteDB.reactionCountByMe++;
    }
    saveNoteToDB(noteDB, ConflictAlgorithm.replace);
  }

  Future<List<NoteDBISAR>?> loadAllNewNotesFromRelay(
      {int? until, int? since, int? limit}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    authors.addAll(Account.sharedInstance.me?.followingList ?? []);
    authors.add(pubkey);
    return await loadNewNotesFromRelay(
        limit: limit, authors: authors, until: until, since: since);
  }

  Future<List<NoteDBISAR>?> loadContactsNewNotesFromRelay(
      {int? until, int? since, int? limit}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    authors.add(pubkey);
    return await loadNewNotesFromRelay(
        limit: limit, authors: authors, until: until, since: since);
  }

  Future<List<NoteDBISAR>?> loadFollowsNewNotesFromRelay(
      {int? until, int? since, int? limit}) async {
    List<String> authors = Account.sharedInstance.me?.followingList ?? [];
    authors.add(pubkey);
    return await loadNewNotesFromRelay(
        limit: limit, authors: authors, until: until, since: since);
  }

  Future<List<NoteDBISAR>?> loadNewNotesFromRelay(
      {int? limit = 50, List<String>? authors, int? until, int? since}) async {
    Completer<List<NoteDBISAR>?> completer = Completer<List<NoteDBISAR>?>();
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
        List<NoteDBISAR> r = [];
        List<Event> values = List.from(result.values);
        for (Event event in values) {
          NoteDBISAR? noteDB;
          Note note = Nip1.decodeNote(event);
          noteDB = NoteDBISAR.noteDBFromNote(note);
          await saveNoteToDB(noteDB, ConflictAlgorithm.ignore);
          r.add(noteDB);
        }
        if (!completer.isCompleted) completer.complete(r);
      }
    });
    return completer.future;
  }

  Future<List<NoteDBISAR>?> loadHashTagsFromRelay(List<String> hashTags,
      {int limit = 30, int? until}) async {
    Completer<List<NoteDBISAR>?> completer = Completer<List<NoteDBISAR>?>();
    Filter f = Filter(kinds: [1], t: hashTags, until: until, limit: limit);
    Map<String, Event> result = {};
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      result[event.id] = event;
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        List<NoteDBISAR> r = [];
        for (Event event in result.values) {
          NoteDBISAR? noteDB;
          Note note = Nip1.decodeNote(event);
          noteDB = NoteDBISAR.noteDBFromNote(note);
          saveNoteToDB(noteDB, ConflictAlgorithm.ignore);
          r.add(noteDB);
        }
        if (!completer.isCompleted) completer.complete(r);
      }
    });
    return completer.future;
  }

  Future<void> loadOldNotes() async {}

  Future<List<NoteDBISAR>> loadNoteIdsToNoteDBs(
      List<String> noteIds, bool private, bool reload) async {
    List<NoteDBISAR> result = [];
    List<String> copiedNoteIds = List.from(noteIds);
    for (var noteId in copiedNoteIds) {
      NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId);
      if (!private && reload) {
        noteDB ??= await loadPublicNoteFromRelay(noteId);
      }
      if (noteDB != null) result.add(noteDB);
    }
    return result;
  }

  static Future<List<ZapRecordsDBISAR>> loadInvoicesToZapRecords(
      List<String> invoices, bool private) async {
    List<ZapRecordsDBISAR> result = [];
    for (var invoice in invoices) {
      List<ZapRecordsDBISAR> zapRecords =
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
    NoteDBISAR? noteDB = await loadNoteWithNoteId(noteId, reload: reload);
    if (noteDB != null) {
      noteDB = await loadPublicNoteActionsFromDB(noteDB);
      result['reply'] = await loadNoteIdsToNoteDBs(
          noteDB.replyEventIds ?? [], noteDB.private, reload);
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

  Future<List<NoteDBISAR>> loadNotesFromDB({
    String? where,
    List<Object?>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return [];
    // return await DB.sharedInstance.objects<NoteDBISAR>(
    //     where: where,
    //     whereArgs: whereArgs,
    //     orderBy: orderBy,
    //     limit: limit,
    //     offset: offset);
  }

  Future<void> handleNewNotes(NoteDBISAR noteDB) async {
    await saveNoteToDB(noteDB, ConflictAlgorithm.ignore);
    if (noteDB.createAt > latestNoteTime) {
      newNotes.add(noteDB);
      newNotesCallBack?.call(newNotes);
    }
    if (noteDB.pTags?.contains(pubkey) == true) {
      NotificationDB notificationDB =
          NotificationDB.notificationDBFromNoteDB(noteDB);
      await DB.sharedInstance.insertBatch<NotificationDB>(notificationDB,
          conflictAlgorithm: ConflictAlgorithm.ignore);
      if (notificationDB.author != pubkey &&
          notificationDB.createAt > latestNotificationTime) {
        newNotifications.add(notificationDB);
        newNotificationCallBack?.call(newNotifications);
      }
    }
  }

  Future<void> handleNoteEvent(Event event, String relay, bool private) async {
    Note note = Nip1.decodeNote(event);
    NoteDBISAR noteDB = NoteDBISAR.noteDBFromNote(note);
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
      NoteDBISAR repostNoteDB = NoteDBISAR.noteDBFromNote(repost.repostNote!);
      saveNoteToDB(repostNoteDB, ConflictAlgorithm.ignore);
    }

    NoteDBISAR noteDB = NoteDBISAR.noteDBFromReposts(repost);
    noteDB.private = private;
    await addRepostToNote(event, noteDB.repostId!);
    handleNewNotes(noteDB);
  }

  Future<void> handleReactionEvent(
      Event event, String relay, bool private) async {
    Reactions reactions = Nip25.decode(event);
    NoteDBISAR reactionsNoteDB = NoteDBISAR.noteDBFromReactions(reactions);
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
