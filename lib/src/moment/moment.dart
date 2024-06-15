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
  Map<String, bool> offlineMomentFinish = {};

  int latestNoteTime = 0;

  Future<void> init() async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
  }

  Future<void> updateSubscriptions({String? relay}) async {
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
          int momentUntil = Relays.sharedInstance.getMomentUntil(relayURL);
          Filter f1 = Filter(
              authors: authors, kinds: [1, 6], since: momentUntil, limit: 100);
          Filter f2 = Filter(
              p: [pubkey], kinds: [1, 6, 7], since: momentUntil, limit: 100);
          subscriptions[relayURL] = [f1, f2];
        }
      } else {
        int momentUntil = Relays.sharedInstance.getMomentUntil(relay);
        Filter f1 = Filter(authors: authors, kinds: [1, 6], since: momentUntil);
        Filter f2 = Filter(p: [pubkey], kinds: [1, 6, 7], since: momentUntil);
        subscriptions[relay] = [f1, f2];
      }

      notesSubscription = Connect.sharedInstance.addSubscriptions(subscriptions,
          eventCallBack: (event, relay) async {
        updateMomentTime(event.createdAt, relay);
        if (Messages.isLoaded(event.id)) return;
        Messages.addToLoaded(event.id);
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
      }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) {
        offlineMomentFinish[relay] = true;
        Relays.sharedInstance.syncRelaysToDB(r: relay);
      });
    }
  }

  void updateMomentTime(int eventTime, String relay) {
    /// set setMomentSince setMomentUntil
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setMomentSince(eventTime, relay);
      Relays.sharedInstance.setMomentUntil(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDB(
          url: relay,
          momentSince: {relay: eventTime},
          momentUntil: {relay: eventTime});
    }
    if (offlineMomentFinish[relay] == true &&
        offlineMomentFinish[relay] == true) {
      Relays.sharedInstance.syncRelaysToDB(r: relay);
    }
  }

  void clearNewNotes() {
    newNotes.clear();
  }

  void clearNewNotifications() {
    newNotifications.clear();
  }
}
