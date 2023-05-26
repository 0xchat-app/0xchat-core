import 'package:chatcore/chat-core.dart';

@reflector
class BadgeDB extends DBObject {

  String? id;
  String? d;
  String? name;
  String? description;
  String? image;
  String? thumb;
  String? creator;
  int? createTime;

  BadgeDB({
    this.id = '',
    this.d = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.thumb = '',
  });

  @override
  //Map 转换
  Map<String, Object?> toMap() {
    return _badgeInfoToMap(this);
  }

  static BadgeDB fromMap(Map<String, Object?> map) {
    return _badgeInfoFromMap(map);
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['id'];
  }
}

BadgeDB _badgeInfoFromMap(Map<String, dynamic> map) {
  return BadgeDB(
    id: map['id'].toString(),
    d: map['d'].toString(),
    name: map['name'].toString(),
    description: map['description'].toString(),
    image: map['image'].toString(),
    thumb: map['thumb'].toString(),
  );
}

Map<String, dynamic> _badgeInfoToMap(BadgeDB instance) => <String, dynamic>{
  'id': instance.id,
  'd': instance.d,
  'name': instance.name,
  'description': instance.description,
  'image': instance.image,
  'thumb': instance.thumb,
};