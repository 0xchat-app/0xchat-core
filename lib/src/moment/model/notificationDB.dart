import 'package:chatcore/chat-core.dart';

@reflector
class NotificationDB extends DBObject {
  String notificationId; //event id

  NotificationDB({
    this.notificationId = '',
  });

  @override
  Map<String, Object?> toMap() {
    return _notificationInfoToMap(this);
  }

  static NotificationDB fromMap(Map<String, Object?> map) {
    return _notificationInfoFromMap(map);
  }

  static String? tableName() {
    return "NotificationDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['notificationId'];
  }
}

Map<String, dynamic> _notificationInfoToMap(NotificationDB instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
    };

NotificationDB _notificationInfoFromMap(Map<String, dynamic> map) {
  return NotificationDB(
    notificationId: map['notificationId'].toString(),
  );
}
