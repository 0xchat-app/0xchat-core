import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension Load on Moment {
  Future<List<NoteDB>?> loadPrivateNotes(
      {int limit = 50, int? until, NewNotesCallBack? callBack}) async {
    newPrivateNotesCallBack = callBack;
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'private = ? AND createAt < ?',
        whereArgs: [true, until],
        orderBy: 'createAt desc',
        limit: limit);
    List<NoteDB>? result = notes
        .where((n) => Contacts.sharedInstance.allContacts.containsKey(n.author))
        .toList();
    return result;
  }

  Future<List<NoteDB>?> loadContactsNotes(
      {int limit = 50, int? until, NewNotesCallBack? callBack}) async {
    newContactsNotesCallBack = callBack;
    until ??= currentUnixTimestampSeconds() + 1;
    List<NoteDB>? notes = await _loadNotesFromDB(
        where: 'private = ? AND createAt < ?',
        whereArgs: [false, until],
        orderBy: 'createAt desc',
        limit: limit);
    List<NoteDB>? result = notes
        .where((n) => Contacts.sharedInstance.allContacts.containsKey(n.author))
        .toList();
    return result;
  }

  Future<List<NoteDB>?> loadNotes(
      {List<String>? noteIds, bool? private, String? author}) async {
    return null;
  }

  Future<void> loadNewNotes() async {}
  Future<void> loadOldNotes() async {}

  Future<void> loadNoteReplies() async {}
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

  Future<void> subscribeContactsNotesFromRelay({String? relay}) async {
    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    if (authors.isNotEmpty) {
      Map<String, List<Filter>> subscriptions = {};
      if (relay == null) {
        for (String relayURL in Connect.sharedInstance.relays()) {
          int contactsNotesUntil =
              Relays.sharedInstance.getContactsNotesUntil(relayURL);
          Filter f =
              Filter(authors: authors, kinds: [1], since: contactsNotesUntil);
          subscriptions[relayURL] = [f];
        }
      } else {
        int contactsNotesUntil =
            Relays.sharedInstance.getContactsNotesUntil(relay);
        Filter f =
            Filter(authors: authors, kinds: [1], since: contactsNotesUntil);
        subscriptions[relay] = [f];
      }

      Connect.sharedInstance.addSubscriptions(subscriptions,
          eventCallBack: (event, relay) async {
        switch (event.kind) {
          case 1:
            handleNoteEvent(event, relay, false);
            break;
          default:
            print('unhandled message $event');
            break;
        }
      }, eoseCallBack: (String requestId, OKEvent ok, String relay,
              List<String> unCompletedRelays) {
        if (unCompletedRelays.isEmpty) {
          Connect.sharedInstance.closeRequests(requestId);
        }
      });
    }
  }

  Future<void> handleNoteEvent(Event event, String relay, bool private) async {
    if (!notesCache.containsKey(event.id)) {
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
