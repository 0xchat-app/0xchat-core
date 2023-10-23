import 'dart:convert';

import 'package:chatcore/chat-core.dart';

@reflector
class GroupDB extends DBObject {
  String groupId; //group pubkey
  String owner; // pubkey
  int updateTime;
  bool mute;
  String name;
  List<String>? members;
  List<String>? pinned;
  String? about;
  String? picture;
  String? relay;

  GroupDB(
      {this.groupId = '',
      this.owner = '',
      this.updateTime = 0,
      this.mute = false,
      this.name = '',
      this.members,
      this.pinned,
      this.about,
      this.picture,
      this.relay});

  @override
  Map<String, Object?> toMap() {
    return _groupInfoToMap(this);
  }

  static GroupDB fromMap(Map<String, Object?> map) {
    return _groupInfoFromMap(map);
  }

  static String? tableName() {
    return "GroupDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['groupId'];
  }
}

Map<String, dynamic> _groupInfoToMap(GroupDB instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'owner': instance.owner,
      'updateTime': instance.updateTime,
      'mute': instance.mute,
      'name': instance.name,
      'members': instance.members == null ? null : jsonEncode(instance.members),
      'pinned': instance.pinned == null ? null : jsonEncode(instance.pinned),
      'about': instance.about ?? '',
      'picture': instance.picture ?? '',
      'relay': instance.relay ?? '',
    };

GroupDB _groupInfoFromMap(Map<String, dynamic> map) {
  return GroupDB(
    groupId: map['groupId'].toString(),
    owner: map['owner'],
    updateTime: map['updateTime'],
    mute: map['mute'] > 0 ? true : false,
    name: map['name'].toString(),
    members: UserDB.decodeStringList(map['members'].toString()),
    pinned: UserDB.decodeStringList(map['pinned'].toString()),
    about: map['about'].toString(),
    picture: map['picture'].toString(),
    relay: map['relay'].toString(),
  );
}
