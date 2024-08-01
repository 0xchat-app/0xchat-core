import 'package:isar/isar.dart';

part 'badgeDB_isar.g.dart';

@collection
class BadgeDBISAR  {
  Id idISAR = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String id;

  String d;
  String name;
  String description;
  String image;
  String thumb;
  String creator;
  int createTime;

  BadgeDBISAR({
    this.id = '',
    this.d = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.thumb = '',
    this.creator = '',
    this.createTime = 0
  });

  static BadgeDBISAR fromMap(Map<String, Object?> map) {
    return _badgeInfoFromMap(map);
  }
}

BadgeDBISAR _badgeInfoFromMap(Map<String, dynamic> map) {
  return BadgeDBISAR(
    id: map['id'].toString(),
    d: map['d'].toString(),
    name: map['name'].toString(),
    description: map['description'].toString(),
    image: map['image'].toString(),
    thumb: map['thumb'].toString(),
    creator: map['creator'].toString(),
    createTime: map['createTime'],
  );
}