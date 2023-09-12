import 'dart:convert';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

@reflector
class UserDB extends DBObject {
  String pubKey;
  String? encryptedPrivKey;
  String? privkey;
  String? defaultPassword;

  String? name;
  String? nickName;
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
  List<String>? channelsList;
  List<String>? groupsList;
  List<String>? badgesList;

  List<String>? blockedList; // blocked users list
  bool? mute;

  int lastUpdatedTime;

  // banner, website, display_name
  String? otherField;

  UserDB(
      {this.pubKey = '',
      this.encryptedPrivKey = '',
      this.privkey = '',
      this.defaultPassword = '',
      this.name = '',
      this.nickName = '',
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
      this.friendsList,
      this.channelsList,
      this.groupsList,
      this.badgesList,
      this.blockedList,
      this.mute = false,
      this.lastUpdatedTime = 0,
      this.otherField = '{}'});

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

  //'ALTER TABLE Company ADD description TEXT'
  static Map<String, String?> updateTable() {
    return {"1": '''alter table userDB add otherField TEXT;'''};
  }

  static String? decodePubkey(String pubkey) {
    try {
      return Nip19.decodePubkey(pubkey);
    } catch (e) {
      return null;
    }
  }

  static String? decodePrivkey(String privkey) {
    try {
      return Nip19.decodePrivkey(privkey);
    } catch (e) {
      return null;
    }
  }

  /// nip19 encode
  String get encodedPubkey {
    return Nip19.encodePubkey(pubKey);
  }

  String get encodedPrivkey {
    if (pubKey == Account.sharedInstance.currentPubkey) {
      return Nip19.encodePrivkey(Account.sharedInstance.currentPrivkey);
    }
    return '';
  }

  String get shortEncodedPubkey {
    String k = encodedPubkey;
    final String start = k.substring(0, 6);
    final String end = k.substring(k.length - 6);

    return '$start:$end';
  }

  static List<String> decodeStringList(String list) {
    try {
      List<dynamic> result = jsonDecode(list);
      return result.map((e) => e.toString()).toList();
    } catch (e) {
      return [];
    }
  }
}

UserDB _userInfoFromMap(Map<String, dynamic> map) {
  return UserDB(
    pubKey: map['pubKey'].toString(),
    encryptedPrivKey: map['encryptedPrivKey'].toString(),
    defaultPassword: map['defaultPassword'].toString(),
    name: map['name'].toString(),
    nickName: map['nickName'].toString(),
    mainRelay: map['mainRelay'].toString(),
    dns: map['dns'].toString(),
    lnurl: map['lnurl'].toString(),
    badges: map['badges'].toString(),
    gender: map['gender'].toString(),
    area: map['area'].toString(),
    about: map['about'].toString(),
    picture: map['picture'].toString(),
    friendsList: map['friendsList'].toString(),
    channelsList: UserDB.decodeStringList(map['channelsList'].toString()),
    groupsList: UserDB.decodeStringList(map['groupsList'].toString()),
    badgesList: UserDB.decodeStringList(map['badgesList'].toString()),
    blockedList: UserDB.decodeStringList(map['blockedList'].toString()),
    aliasPubkey: map['aliasPubkey'],
    mute: map['mute'] > 0 ? true : false,
    lastUpdatedTime: map['lastUpdatedTime'],
    otherField: map['otherField'].toString(),
  );
}

Map<String, dynamic> _userInfoToMap(UserDB instance) => <String, dynamic>{
      'pubKey': instance.pubKey,
      'encryptedPrivKey': instance.encryptedPrivKey,
      'defaultPassword': instance.defaultPassword,
      'name': instance.name,
      'nickName': instance.nickName,
      'mainRelay': instance.mainRelay,
      'dns': instance.dns,
      'lnurl': instance.lnurl,
      'badges': instance.badges,
      'gender': instance.gender,
      'area': instance.area,
      'about': instance.about,
      'picture': instance.picture,
      'friendsList': instance.friendsList,
      'channelsList': jsonEncode(instance.channelsList),
      'groupsList': jsonEncode(instance.groupsList),
      'badgesList': jsonEncode(instance.badgesList),
      'blockedList': jsonEncode(instance.blockedList),
      'aliasPubkey': instance.aliasPubkey,
      'mute': instance.mute,
      'lastUpdatedTime': instance.lastUpdatedTime,
      'otherField': instance.otherField
    };
