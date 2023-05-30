import 'package:chatcore/chat-core.dart';

@reflector
class BadgeAwardDB extends DBObject {
  String? awardId; // event id
  int? awardTime;
  String? identifies;
  String? creator;
  String? relay;
  String? badgeOwner;

  BadgeAwardDB({
    this.awardId = '',
    this.awardTime = 0,
    this.identifies = '',
    this.creator = '',
    this.relay = '',
    this.badgeOwner = '',
  });

  @override
  //Map 转换
  Map<String, Object?> toMap() {
    return _badgeAwardInfoToMap(this);
  }

  static BadgeAwardDB fromMap(Map<String, Object?> map) {
    return _badgeAwardInfoFromMap(map);
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['awardId'];
  }
}

BadgeAwardDB _badgeAwardInfoFromMap(Map<String, dynamic> map) {
  return BadgeAwardDB(
    awardId: map['awardId'].toString(),
    awardTime: map['awardTime'],
    identifies: map['identifies'].toString(),
    creator: map['creator'].toString(),
    relay: map['relay'].toString(),
    badgeOwner: map['badgeOwner'].toString(),
  );
}

Map<String, dynamic> _badgeAwardInfoToMap(BadgeAwardDB instance) =>
    <String, dynamic>{
      'awardId': instance.awardId,
      'awardTime': instance.awardTime,
      'identifies': instance.identifies,
      'creator': instance.creator,
      'relay': instance.relay,
      'badgeOwner': instance.badgeOwner,
    };