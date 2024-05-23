import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

@reflector
class RelayGroupDB extends DBObject {
  String id; //<relay>'<group-id>
  String relay;
  String relayPubkey;
  String groupId;
  bool private;
  int lastUpdatedTime;
  bool mute;
  List<GroupAdmin>? admins;
  String name;
  String about;
  String picture;
  List<String>? pinned;
  List<String>? members;
  int level; // group level
  int point; // group point

  RelayGroupDB(
      {this.id = '',
      this.relay = '',
      this.relayPubkey = '',
      this.groupId = '',
      this.private = false,
      this.lastUpdatedTime = 0,
      this.mute = false,
      this.admins,
      this.name = '',
      this.about = '',
      this.picture = '',
      this.pinned,
      this.members,
      this.level = 0,
      this.point = 0});

  @override
  Map<String, Object?> toMap() {
    return _groupInfoToMap(this);
  }

  static RelayGroupDB fromMap(Map<String, Object?> map) {
    return _groupInfoFromMap(map);
  }

  static String? tableName() {
    return "RelayGroupDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['id'];
  }

  static String groupAdminsToString(List<GroupAdmin> admins) {
    List<List<dynamic>> adminsString =
        admins.map((admin) => admin.toJson()).toList();
    return jsonEncode(adminsString);
  }

  static List<GroupAdmin> stringToGroupAdmins(String json) {
    List<dynamic> groupAdminsJson = jsonDecode(json);
    List<GroupAdmin> admins =
        groupAdminsJson.map((json) => GroupAdmin.fromJson(json)).toList();
    return admins;
  }
}

Map<String, dynamic> _groupInfoToMap(RelayGroupDB instance) =>
    <String, dynamic>{
      'id': instance.id,
      'relay': instance.relay,
      'relayPubkey': instance.relayPubkey,
      'groupId': instance.groupId,
      'private': instance.private,
      'lastUpdatedTime': instance.lastUpdatedTime,
      'mute': instance.mute,
      'admins': instance.admins == null
          ? null
          : RelayGroupDB.groupAdminsToString(instance.admins!),
      'name': instance.name,
      'about': instance.about,
      'picture': instance.picture,
      'pinned': instance.pinned == null ? null : jsonEncode(instance.pinned),
      'members': instance.members == null ? null : jsonEncode(instance.members),
      'level': instance.level,
      'point': instance.point,
    };

RelayGroupDB _groupInfoFromMap(Map<String, dynamic> map) {
  return RelayGroupDB(
    id: map['id'].toString(),
    relay: map['relay'].toString(),
    relayPubkey: map['relayPubkey'].toString(),
    groupId: map['groupId'].toString(),
    private: map['private'] > 0 ? true : false,
    lastUpdatedTime: map['lastUpdatedTime'],
    mute: map['mute'] > 0 ? true : false,
    admins: RelayGroupDB.stringToGroupAdmins(map['admins'].toString()),
    name: map['name'].toString(),
    about: map['about'].toString(),
    picture: map['picture'].toString(),
    pinned: UserDB.decodeStringList(map['pinned'].toString()),
    members: UserDB.decodeStringList(map['members'].toString()),
    level: map['level'],
    point: map['point'],
  );
}