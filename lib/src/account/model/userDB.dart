import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

@reflector
class UserDB extends DBObject {
  String? pubKey;
  String? encryptedPrivKey;
  String? privkey;
  String? defaultPassword;

  String? name;
  String? mainRelay;

  /// dns, example@0xchat.com
  String? dns;

  /// zap url
  String? lnurl;

  /// profile badges
  String? badges;

  /// metadata infos
  String? gender;
  String? area;
  String? about;
  String? picture;

  /// private chat
  String? aliasPubkey;
  String? toAliasPubkey;
  String? toAliasPrivkey;

  /// lists for me
  String? friendsList;
  String? channelsList;
  String? groupsList;
  String? badgesList;

  /// last event timestamps

  UserDB({
    this.pubKey = '',
    this.encryptedPrivKey = '',
    this.privkey = '',
    this.defaultPassword = '',
    this.name = '',
    this.mainRelay = '',
    this.dns = '',
    this.lnurl = '',
    this.badges = '',
    this.gender = '',
    this.area = '',
    this.about = '',
    this.picture = '',
    this.aliasPubkey = '',
    this.toAliasPubkey = '',
    this.toAliasPrivkey = '',
    this.friendsList = '',
    this.channelsList = '',
    this.groupsList = '',
    this.badgesList = '',
  });

  @override
  //Map
  Map<String, Object?> toMap() {
    return _userInfoToMap(this);
  }

  static UserDB fromMap(Map<String, Object?> map) {
    return _userInfoFromMap(map);
  }

  static String? tableName() {
    return "userDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['pubKey'];
  }

  static String decodePubkey(String pubkey) {
    return Nip19.decodePubkey(pubkey);
  }

  static String decodePrivkey(String privkey) {
    return Nip19.decodePrivkey(privkey);
  }

  /// nip19 encode
  String get encodedPubkey {
    return Nip19.encodePubkey(pubKey!);
  }

  String get encodedPrivkey {
    return Nip19.encodePrivkey(privkey!);
  }
}

UserDB _userInfoFromMap(Map<String, dynamic> map) {
  return UserDB(
    pubKey: map['pubKey'].toString(),
    encryptedPrivKey: map['encryptedPrivKey'].toString(),
    defaultPassword: map['defaultPassword'].toString(),
    name: map['name'].toString(),
    mainRelay: map['mainRelay'].toString(),
    dns: map['dns'].toString(),
    lnurl: map['lnurl'].toString(),
    badges: map['badges'].toString(),
    gender: map['gender'].toString(),
    area: map['area'].toString(),
    about: map['about'].toString(),
    picture: map['picture'].toString(),
    friendsList: map['friendsList'].toString(),
    channelsList: map['channelsList'].toString(),
    groupsList: map['groupsList'].toString(),
    badgesList: map['badgesList'].toString(),
  );
}

Map<String, dynamic> _userInfoToMap(UserDB instance) => <String, dynamic>{
      'pubKey': instance.pubKey,
      'encryptedPrivKey': instance.encryptedPrivKey,
      'defaultPassword': instance.defaultPassword,
      'name': instance.name,
      'mainRelay': instance.mainRelay,
      'dns': instance.dns,
      'lnurl': instance.lnurl,
      'badges': instance.badges,
      'gender': instance.gender,
      'area': instance.area,
      'about': instance.about,
      'picture': instance.picture,
      'friendsList': instance.friendsList,
      'channelsList': instance.channelsList,
      'groupsList': instance.groupsList,
      'badgesList': instance.badgesList,
    };
