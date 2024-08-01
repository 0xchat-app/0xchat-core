import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:chatcore/chat-core.dart';

part 'relayDB_isar.g.dart';

@collection
class RelayDBISAR {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
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
  String? friendMessageSinceString;
  String? friendMessageUntilString;

  // channel messages {channelID1: time1, channelID2: time2,...}
  String? channelMessageSinceString;
  String? channelMessageUntilString;

  // delete message, hide message, mute user
  int commonMessagesSince;
  int commonMessagesUntil;

  // group messages {groupID1: time1, groupID2: time2,...}
  String? groupMessageSinceString;
  String? groupMessageUntilString;

  String? momentSinceString;
  String? momentUntilString;

  String? zapRecordSinceString;
  String? zapRecordUntilString;

  RelayDBISAR(
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
      this.friendMessageSinceString,
      this.friendMessageUntilString,
      this.channelMessageSinceString,
      this.channelMessageUntilString,
      this.commonMessagesSince = 0,
      this.commonMessagesUntil = 0,
      this.groupMessageSinceString,
      this.groupMessageUntilString,
      this.momentSinceString,
      this.momentUntilString,
      this.zapRecordSinceString,
      this.zapRecordUntilString});

  @ignore
  int? get connectStatus {
    return Connect.sharedInstance.webSockets[url]?.connectStatus;
  }

  set friendMessageSince(Map<String, int> attributes) {
    friendMessageSinceString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get friendMessageSince {
    return friendMessageSinceString != null
        ? Map<String, int>.from(jsonDecode(friendMessageSinceString!))
        : {};
  }

  set friendMessageUntil(Map<String, int> attributes) {
    friendMessageUntilString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get friendMessageUntil {
    return friendMessageUntilString != null
        ? Map<String, int>.from(jsonDecode(friendMessageUntilString!))
        : {};
  }

  int getFriendMessageUntil(String relay) {
    if (friendMessageUntil.containsKey(relay)) {
      return friendMessageUntil[relay]!;
    }
    return 0;
  }

  int getFriendMessageSince(String relay) {
    if (friendMessageSince.containsKey(relay)) {
      return friendMessageSince[relay]!;
    }
    return 0;
  }

  set channelMessageSince(Map<String, int> attributes) {
    channelMessageSinceString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get channelMessageSince {
    return channelMessageSinceString != null
        ? Map<String, int>.from(jsonDecode(channelMessageSinceString!))
        : {};
  }

  set channelMessageUntil(Map<String, int> attributes) {
    channelMessageUntilString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get channelMessageUntil {
    return channelMessageUntilString != null
        ? Map<String, int>.from(jsonDecode(channelMessageUntilString!))
        : {};
  }

  int getChannelMessageSince(String relay) {
    if (channelMessageSince.containsKey(relay)) {
      return channelMessageSince[relay]!;
    }
    return 0;
  }

  int getChannelMessageUntil(String relay) {
    if (channelMessageUntil.containsKey(relay)) {
      return channelMessageUntil[relay]!;
    }
    return 0;
  }

  set groupMessageSince(Map<String, int> attributes) {
    groupMessageSinceString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get groupMessageSince {
    return groupMessageSinceString != null
        ? Map<String, int>.from(jsonDecode(groupMessageSinceString!))
        : {};
  }

  set groupMessageUntil(Map<String, int> attributes) {
    groupMessageUntilString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get groupMessageUntil {
    return groupMessageUntilString != null
        ? Map<String, int>.from(jsonDecode(groupMessageUntilString!))
        : {};
  }

  int getGroupMessageSince(String relay) {
    if (groupMessageSince.containsKey(relay)) {
      return groupMessageSince[relay]!;
    }
    return 0;
  }

  int getGroupMessageUntil(String relay) {
    if (groupMessageUntil.containsKey(relay)) {
      return groupMessageUntil[relay]!;
    }
    return 0;
  }

  set momentSince(Map<String, int> attributes) {
    momentSinceString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get momentSince {
    return momentSinceString != null
        ? Map<String, int>.from(jsonDecode(momentSinceString!))
        : {};
  }

  set momentUntil(Map<String, int> attributes) {
    momentUntilString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get momentUntil {
    return momentUntilString != null
        ? Map<String, int>.from(jsonDecode(momentUntilString!))
        : {};
  }

  int getMomentSince(String relay) {
    if (momentSince.containsKey(relay)) {
      return momentSince[relay]!;
    }
    return 0;
  }

  int getMomentUntil(String relay) {
    if (momentUntil.containsKey(relay)) {
      return momentUntil[relay]!;
    }
    return 0;
  }

  set zapRecordSince(Map<String, int> attributes) {
    zapRecordSinceString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get zapRecordSince {
    return zapRecordSinceString != null
        ? Map<String, int>.from(jsonDecode(zapRecordSinceString!))
        : {};
  }

  set zapRecordUntil(Map<String, int> attributes) {
    zapRecordUntilString = jsonEncode(attributes);
  }

  @ignore
  Map<String, int> get zapRecordUntil {
    return zapRecordUntilString != null
        ? Map<String, int>.from(jsonDecode(zapRecordUntilString!))
        : {};
  }

  int getZapRecordSince(String relay) {
    if (zapRecordSince.containsKey(relay)) {
      return zapRecordSince[relay]!;
    }
    return 0;
  }

  int getZapRecordUntil(String relay) {
    if (zapRecordUntil.containsKey(relay)) {
      return zapRecordUntil[relay]!;
    }
    return 0;
  }

  static RelayDBISAR fromMap(Map<String, Object?> map) {
    return _relayDBInfoFromMap(map);
  }

  static Map<String, int> decodeMap(String map) {
    try {
      Map<String, dynamic> result = jsonDecode(map);
      return result
          .map((key, value) => MapEntry(key, int.parse(value.toString())));
    } catch (e) {
      return {};
    }
  }

  static RelayDBISAR relayDBInfoFromJSON(String json, RelayDBISAR relayDB) {
    Map map = jsonDecode(json);
    relayDB.pubkey = map.containsKey('pubkey') ? map['pubkey'].toString() : '';
    relayDB.description =
        map.containsKey('description') ? map['description'].toString() : '';
    relayDB.contact =
        map.containsKey('contact') ? map['contact'].toString() : '';
    relayDB.supportedNips = map.containsKey('supported_nips')
        ? map['supported_nips'].toString()
        : '';
    relayDB.supportedNipExtensions = map.containsKey('supported_nip_extensions')
        ? map['supported_nip_extensions'].toString()
        : '';
    relayDB.software =
        map.containsKey('software') ? map['software'].toString() : '';
    relayDB.version =
        map.containsKey('version') ? map['version'].toString() : '';
    relayDB.limitation =
        map.containsKey('limitation') ? map['limitation'].toString() : '';
    relayDB.paymentsUrl =
        map.containsKey('payments_url') ? map['payments_url'].toString() : '';
    relayDB.fees = map.containsKey('fees') ? map['fees'].toString() : '';
    relayDB.icon = map.containsKey('icon') ? map['icon'].toString() : '';

    return relayDB;
  }
}

RelayDBISAR _relayDBInfoFromMap(Map<String, dynamic> map) {
  return RelayDBISAR(
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
    friendMessageSinceString: map['friendMessageSince'].toString(),
    friendMessageUntilString: map['friendMessageUntil'].toString(),
    channelMessageSinceString: map['channelMessageSince'].toString(),
    channelMessageUntilString: map['channelMessageUntil'].toString(),
    commonMessagesSince: map['commonMessagesSince'],
    commonMessagesUntil: map['commonMessagesUntil'],
    groupMessageSinceString: map['groupMessageSince'].toString(),
    groupMessageUntilString: map['groupMessageUntil'].toString(),
    momentUntilString: map['momentUntil'].toString(),
    momentSinceString: map['momentSince'].toString(),
    zapRecordSinceString: map['zapRecordSince'].toString(),
    zapRecordUntilString: map['zapRecordUntil'].toString(),
  );
}
