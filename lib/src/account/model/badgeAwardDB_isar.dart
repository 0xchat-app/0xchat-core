import 'package:isar/isar.dart' hide Filter;

part 'badgeAwardDB_isar.g.dart';

@collection
class BadgeAwardDBISAR {
  late int id;

  @Index(unique: true)
  String awardId; // event id

  int awardTime;
  String identifies;
  String creator;
  String relay;
  String badgeOwner;
  String badgeId;

  BadgeAwardDBISAR({
    this.awardId = '',
    this.awardTime = 0,
    this.identifies = '',
    this.creator = '',
    this.relay = '',
    this.badgeOwner = '',
    this.badgeId = '',
  });

  static BadgeAwardDBISAR fromMap(Map<String, Object?> map) {
    return _badgeAwardInfoFromMap(map);
  }

}

BadgeAwardDBISAR _badgeAwardInfoFromMap(Map<String, dynamic> map) {
  return BadgeAwardDBISAR(
    awardId: map['awardId'].toString(),
    awardTime: map['awardTime'],
    identifies: map['identifies'].toString(),
    creator: map['creator'].toString(),
    relay: map['relay'].toString(),
    badgeOwner: map['badgeOwner'].toString(),
    badgeId: map['badgeId'].toString(),
  );
}
