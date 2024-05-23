import 'package:chatcore/chat-core.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class EventCache {
  /// singleton
  EventCache._internal();

  factory EventCache() => sharedInstance;
  static final EventCache sharedInstance = EventCache._internal();

  List<String> eventCacheLoaded = [];

  Future<void> loadAllEventIDFromDB() async {
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
    eventCacheLoaded.add(eventId);
    int result = await DB.sharedInstance.insert<EventCacheDB>(
        EventCacheDB(id: eventId),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    if (result > 0) {
      return true;
    }
    return false;
  }
}
