import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

typedef NewNotesCallBack = void Function(List<NoteDB>);
typedef NewNotificationCallBack = void Function(List<NotificationDB>);

class Moment {
  /// singleton
  Moment._internal();
  factory Moment() => sharedInstance;
  static final Moment sharedInstance = Moment._internal();

  /// memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, NoteDB> notesCache = {};
  List<NoteDB> newNotes = [];
  List<NotificationDB> newNotifications = [];
  NewNotesCallBack? newNotesCallBack;
  NewNotificationCallBack? newNotificationCallBack;
  NewNotificationCallBack? myZapNotificationCallBack;

  String notesSubscription = '';

  Future<void> init() async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    await EventCache.sharedInstance.loadAllEventIDFromDB();
    _updateSubscriptions();
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1) {
        _updateSubscriptions(relay: relay);
      }
    });
  }

  Future<void> _updateSubscriptions({String? relay}) async {
    if (notesSubscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(notesSubscription, relay: relay);
    }

    List<String> authors = Contacts.sharedInstance.allContacts.keys.toList();
    authors.addAll(Account.sharedInstance.me?.followingList ?? []);
    authors.add(pubkey); // add self
    if (authors.isNotEmpty) {
      Map<String, List<Filter>> subscriptions = {};
      if (relay == null) {
        for (String relayURL in Connect.sharedInstance.relays()) {
          int contactsNotesUntil =
              Relays.sharedInstance.getContactsNotesUntil(relayURL);
          Filter f1 = Filter(
              authors: authors,
              kinds: [1, 6],
              since: contactsNotesUntil,
              limit: 1000);
          Filter f2 = Filter(
              p: [pubkey],
              kinds: [1, 6, 7],
              since: contactsNotesUntil,
              limit: 1000);
          subscriptions[relayURL] = [f1, f2];
        }
      } else {
        int contactsNotesUntil =
            Relays.sharedInstance.getContactsNotesUntil(relay);
        Filter f1 =
            Filter(authors: authors, kinds: [1, 6], since: contactsNotesUntil);
        Filter f2 =
            Filter(p: [pubkey], kinds: [1, 6, 7], since: contactsNotesUntil);
        subscriptions[relay] = [f1, f2];
      }

      notesSubscription = Connect.sharedInstance.addSubscriptions(subscriptions,
          eventCallBack: (event, relay) async {
        if (EventCache.sharedInstance.isLoaded(event.id)) {
          return;
        } else {
          await EventCache.sharedInstance.addToLoaded(event.id);
        }
        switch (event.kind) {
          case 1:
            handleNoteEvent(event, relay, false);
            break;
          case 6:
            handleRepostsEvent(event, relay, false);
            break;
          case 7:
            handleReactionEvent(event, relay, false);
            break;
          default:
            print('unhandled message $event');
            break;
        }
      });
    }
  }

  void updateContactsNotesTime(int eventTime, String relay) {
    /// set setContactsNotesSince setContactsNotesUntil
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setContactsNotesSince(eventTime, relay);
      Relays.sharedInstance.setContactsNotesUntil(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDB(
          url: relay,
          contactsNotesSince: {relay: eventTime},
          contactsNotesUntil: {relay: eventTime});
    }
    Relays.sharedInstance.syncRelaysToDB();
  }

  void clearNewNotes() {
    newNotes.clear();
  }

  void clearNewNotifications() {
    newNotifications.clear();
  }
}
