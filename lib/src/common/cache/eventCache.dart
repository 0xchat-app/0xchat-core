import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class EventCache {
  /// singleton
  EventCache._internal() {
    _loadAllEventIDFromDB();
  }

  factory EventCache() => sharedInstance;
  static final EventCache sharedInstance = EventCache._internal();

  List<String> eventCacheLoaded = [];

  Future<void> _loadAllEventIDFromDB() async {
    eventCacheLoaded.clear();
    List<EventCacheDB> eventCaches =
        await DB.sharedInstance.objects<EventCacheDB>();
    for (EventCacheDB eventCache in eventCaches) {
      eventCacheLoaded.add(eventCache.id);
    }
  }

  bool isLoaded(String eventId) {
    return eventCacheLoaded.contains(eventId);
  }

  Future<bool> addToLoaded(String eventId) async {
    if (isLoaded(eventId)) return false;
    int result =
        await DB.sharedInstance.insert<EventCacheDB>(EventCacheDB(id: eventId));
    if (result > 0) {
      eventCacheLoaded.add(eventId);
      return true;
    }
    return false;
  }
}
