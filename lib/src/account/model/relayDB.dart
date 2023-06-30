import 'dart:convert';
import 'package:chatcore/chat-core.dart';

@reflector
class RelayDB extends DBObject {
  String url;
  String? name;
  String? pubkey;
  String? description;
  String? contact;
  String? supportedNips;
  String? supportedNipExtensions;
  String? software;
  String? version;
  String? limitation;
  String? paymentsUrl;
  String? fees;
  String? icon;

  // friend request, add, reject, delete
  int friendRequestSince;
  int friendRequestUntil;

  // private messages {friendPubkey1: time1, friendPubkey2: time2,...}
  Map<String, int>? friendMessageSince;
  Map<String, int>? friendMessageUntil;

  // channel list
  int channelListSince;
  int channelListUntil;

  // channel messages {channelID1: time1, channelID2: time2,...}
  Map<String, int>? channelMessageSince;
  Map<String, int>? channelMessageUntil;

  // delete message, hide message, mute user
  int commonMessagesSince;
  int commonMessagesUntil;

  // group list
  int groupListSince;
  int groupListUntil;

  // group messages {groupID1: time1, groupID2: time2,...}
  Map<String, int>? groupMessageSince;
  Map<String, int>? groupMessageUntil;

  RelayDB(
      {this.url = '',
      this.pubkey = '',
      this.description = '',
      this.contact = '',
      this.supportedNips = '',
      this.supportedNipExtensions = '',
      this.software = '',
      this.version = '',
      this.limitation = '',
      this.paymentsUrl = '',
      this.fees = '',
      this.icon = '',
      this.friendRequestSince = 0,
      this.friendRequestUntil = 0,
      this.friendMessageSince,
      this.friendMessageUntil,
      this.channelListSince = 0,
      this.channelListUntil = 0,
      this.channelMessageSince,
      this.channelMessageUntil,
      this.commonMessagesSince = 0,
      this.commonMessagesUntil = 0,
      this.groupListSince = 0,
      this.groupListUntil = 0,
      this.groupMessageSince,
      this.groupMessageUntil});

  @override
  //Map
  Map<String, Object?> toMap() {
    return _relayDBInfoToMap(this);
  }

  static RelayDB fromMap(Map<String, Object?> map) {
    return _relayDBInfoFromMap(map);
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['url'];
  }

  static Map<String, int>? decodeMap(String map) {
    try {
      Map<String, dynamic> result = jsonDecode(map);
      return result
          .map((key, value) => MapEntry(key, int.parse(value.toString())));
    } catch (e) {
      return null;
    }
  }
}

RelayDB _relayDBInfoFromMap(Map<String, dynamic> map) {
  return RelayDB(
    url: map['url'].toString(),
    pubkey: map['pubkey'].toString(),
    description: map['description'].toString(),
    contact: map['contact'].toString(),
    supportedNips: map['supportedNips'].toString(),
    supportedNipExtensions: map['supportedNipExtensions'].toString(),
    software: map['software'].toString(),
    version: map['version'].toString(),
    limitation: map['limitation'].toString(),
    paymentsUrl: map['paymentsUrl'].toString(),
    fees: map['fees'].toString(),
    icon: map['icon'].toString(),
    friendRequestSince: map['friendRequestSince'],
    friendRequestUntil: map['friendRequestUntil'],
    friendMessageSince: RelayDB.decodeMap(map['friendMessageSince'].toString()),
    friendMessageUntil: RelayDB.decodeMap(map['friendMessageUntil'].toString()),
    channelListSince: map['channelListSince'],
    channelListUntil: map['channelListUntil'],
    channelMessageSince:
        RelayDB.decodeMap(map['channelMessageSince'].toString()),
    channelMessageUntil:
        RelayDB.decodeMap(map['channelMessageUntil'].toString()),
    commonMessagesSince: map['commonMessagesSince'],
    commonMessagesUntil: map['commonMessagesUntil'],
    groupListSince: map['groupListSince'],
    groupListUntil: map['groupListUntil'],
    groupMessageSince: RelayDB.decodeMap(map['groupMessageSince'].toString()),
    groupMessageUntil: RelayDB.decodeMap(map['groupMessageUntil'].toString()),
  );
}

Map<String, dynamic> _relayDBInfoToMap(RelayDB instance) => <String, dynamic>{
      'url': instance.url,
      'pubkey': instance.pubkey,
      'description': instance.description,
      'contact': instance.contact,
      'supportedNips': instance.supportedNips,
      'supportedNipExtensions': instance.supportedNipExtensions,
      'software': instance.software,
      'version': instance.version,
      'limitation': instance.limitation,
      'paymentsUrl': instance.paymentsUrl,
      'fees': instance.fees,
      'icon': instance.icon,
      'friendRequestSince': instance.friendRequestSince,
      'friendRequestUntil': instance.friendRequestUntil,
      'friendMessageSince': jsonEncode(instance.friendMessageSince),
      'friendMessageUntil': jsonEncode(instance.friendMessageUntil),
      'channelListSince': instance.channelListSince,
      'channelListUntil': instance.channelListUntil,
      'channelMessageSince': jsonEncode(instance.channelMessageSince),
      'channelMessageUntil': jsonEncode(instance.channelMessageUntil),
      'commonMessagesSince': instance.commonMessagesSince,
      'commonMessagesUntil': instance.commonMessagesUntil,
      'groupListSince': instance.groupListSince,
      'groupListUntil': instance.groupListUntil,
      'groupMessageSince': jsonEncode(instance.groupMessageSince),
      'groupMessageUntil': jsonEncode(instance.groupMessageUntil),
    };
