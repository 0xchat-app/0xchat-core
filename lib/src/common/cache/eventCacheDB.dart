import 'package:chatcore/chat-core.dart';

@reflector
class EventCacheDB extends DBObject {
  String id;

  EventCacheDB({this.id = ''});

  @override
  //Map
  Map<String, Object?> toMap() {
    return _cacheDBInfoToMap(this);
  }

  static EventCacheDB fromMap(Map<String, Object?> map) {
    return _cacheInfoFromMap(map);
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['id'];
  }
}

EventCacheDB _cacheInfoFromMap(Map<String, dynamic> map) {
  return EventCacheDB(id: map['id'].toString());
}

Map<String, dynamic> _cacheDBInfoToMap(EventCacheDB instance) =>
    <String, dynamic>{'id': instance.id};
