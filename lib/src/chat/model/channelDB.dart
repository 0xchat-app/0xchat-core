import 'package:chatcore/chat-core.dart';

@reflector
class ChannelDB extends DBObject {
  String channelId; //event id
  int? createTime;
  String? creator; // pubkey
  String? name;
  String? about;
  String? picture;
  String? badges; // string list
  String? relayURL;
  bool? mute;

  ChannelDB({
    this.channelId = '',
    this.createTime = 0,
    this.creator = '',
    this.name = '',
    this.about = '',
    this.picture = '',
    this.badges = '',
    this.relayURL = '',
    this.mute = false,
  });

  @override
  Map<String, Object?> toMap() {
    return _channelInfoToMap(this);
  }

  static ChannelDB fromMap(Map<String, Object?> map) {
    return _channelInfoFromMap(map);
  }

  static String? tableName() {
    return "ChannelDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['channelId'];
  }
}

Map<String, dynamic> _channelInfoToMap(ChannelDB instance) => <String, dynamic>{
      'channelId': instance.channelId,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'name': instance.name,
      'about': instance.about,
      'picture': instance.picture,
      'badges': instance.badges,
      'relayURL': instance.relayURL,
      'mute': instance.mute,
    };

ChannelDB _channelInfoFromMap(Map<String, dynamic> map) {
  return ChannelDB(
    channelId: map['channelId'].toString(),
    createTime: map['createTime'],
    creator: map['creator'].toString(),
    name: map['name'].toString(),
    about: map['about'],
    picture: map['picture'].toString(),
    badges: map['badges'].toString(),
    relayURL: map['relayURL'].toString(),
    mute: map['mute'] > 0 ? true : false,
  );
}
