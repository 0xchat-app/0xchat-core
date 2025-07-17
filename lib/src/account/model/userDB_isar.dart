import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:isar/isar.dart' hide Filter;

part 'userDB_isar.g.dart';

extension UserDBISARExtensions on UserDBISAR {
  UserDBISAR withGrowableLevels() => this
    ..channelsList = channelsList?.toList()
    ..groupsList = groupsList?.toList()
    ..relayGroupsList = relayGroupsList?.toList()
    ..badgesList = badgesList?.toList()
    ..blockedList = blockedList?.toList()
    ..followingList = followingList?.toList()
    ..followersList = followersList?.toList()
    ..relayList = relayList?.toList()
    ..dmRelayList = dmRelayList?.toList()
    ..inboxRelayList = inboxRelayList?.toList()
    ..outboxRelayList = outboxRelayList?.toList();
}

@collection
class UserDBISAR {
  int id = 0;

  @Index(unique: true)
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

  String? banner;

  /// private chat
  String? aliasPubkey;
  String? toAliasPubkey;
  String? toAliasPrivkey;

  /// lists for me
  String? friendsList;
  List<String>? channelsList;
  List<String>? groupsList; // private group list
  List<String>? relayGroupsList;
  List<String>? badgesList;

  List<String>? blockedList; // blocked users list
  List<String>? blockedHashTags; // blocked hash tags
  List<String>? blockedWords; // blocked words
  List<String>? blockedThreads; // blocked threads

  List<String>? followingList;
  List<String>? followersList;
  List<String>? relayList; // relay list
  List<String>? dmRelayList; // relay list
  List<String>? inboxRelayList; // inbox relay list
  List<String>? outboxRelayList; // outbox relay list

  /// list updated time
  int lastFriendsListUpdatedTime;
  int lastChannelsListUpdatedTime;
  int lastGroupsListUpdatedTime;
  int lastRelayGroupsListUpdatedTime;
  int lastBadgesListUpdatedTime;
  int lastBlockListUpdatedTime;
  int lastRelayListUpdatedTime;
  int lastFollowingListUpdatedTime;
  int lastDMRelayListUpdatedTime;

  bool? mute;

  int lastUpdatedTime;

  // banner, website, display_name
  String? otherField;
  // nostr wallet connect URI
  String? nwcURI;

  // nip46
  String? remoteSignerURI;
  String? clientPrivateKey;
  String? remotePubkey;

  String? encodedKeyPackage;

  // KeyPackageEvent list storage (JSON string)
  String? keyPackageEventListJson;

  String? settings;

  UserDBISAR(
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
      this.banner = '',
      this.aliasPubkey = '',
      this.toAliasPubkey = '',
      this.toAliasPrivkey = '',
      this.friendsList,
      this.channelsList,
      this.groupsList,
      this.relayGroupsList,
      this.badgesList,
      this.blockedList,
      this.blockedHashTags,
      this.blockedThreads,
      this.blockedWords,
      this.followersList,
      this.followingList,
      this.relayList,
      this.dmRelayList,
      this.inboxRelayList,
      this.outboxRelayList,
      this.mute = false,
      this.lastUpdatedTime = 0,
      this.lastBadgesListUpdatedTime = 0,
      this.lastBlockListUpdatedTime = 0,
      this.lastChannelsListUpdatedTime = 0,
      this.lastFriendsListUpdatedTime = 0,
      this.lastGroupsListUpdatedTime = 0,
      this.lastRelayGroupsListUpdatedTime = 0,
      this.lastRelayListUpdatedTime = 0,
      this.lastFollowingListUpdatedTime = 0,
      this.lastDMRelayListUpdatedTime = 0,
      this.otherField = '{}',
      this.nwcURI,
      this.settings,
      this.clientPrivateKey,
      this.remoteSignerURI,
      this.remotePubkey,
      this.encodedKeyPackage,
      this.keyPackageEventListJson});

  static UserDBISAR fromMap(Map<String, Object?> map) {
    return _userInfoFromMap(map);
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

  @ignore
  String? _encodedPubkey;

  /// nip19 encode
  @ignore
  String get encodedPubkey {
    if (_encodedPubkey != null) return _encodedPubkey!;
    _encodedPubkey = Nip19.encodePubkey(pubKey);
    return _encodedPubkey!;
  }

  void updateEncodedPubkey(String value) {
    _encodedPubkey = value;
  }

  @ignore
  String get encodedPrivkey {
    if (pubKey == Account.sharedInstance.currentPubkey) {
      return Nip19.encodePrivkey(Account.sharedInstance.currentPrivkey);
    }
    return '';
  }

  @ignore
  String get shortEncodedPubkey {
    String k = encodedPubkey;
    if (k.length < 7) return k;
    final String start = k.substring(0, 6);
    final String end = k.substring(k.length - 6);

    return '$start:$end';
  }

  @ignore
  String get lnAddress {
    return lnurl?.isNotEmpty == true ? lnurl! : NpubCash.address(pubKey);
  }

  @ignore
  NostrWalletConnection? get nwc {
    return NostrWalletConnection.fromURI(nwcURI);
  }

  static List<String> decodeStringList(String list) {
    try {
      if (list.isNotEmpty && list != 'null' && list != '[]') {
        List<dynamic> result = jsonDecode(list);
        return result.map((e) => e.toString()).toList();
      }
    } catch (e) {
      return [];
    }
    return [];
  }

  /// Get keypackage event list from JSON string
  @ignore
  List<KeyPackageEvent> get keyPackageEventList {
    if (keyPackageEventListJson == null || keyPackageEventListJson!.isEmpty) {
      return [];
    }
    try {
      List<dynamic> jsonList = jsonDecode(keyPackageEventListJson!);
      return jsonList.map((json) => KeyPackageEvent.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Set keypackage event list to JSON string
  @ignore
  set keyPackageEventList(List<KeyPackageEvent> keyPackageEvents) {
    keyPackageEventListJson = jsonEncode(keyPackageEvents.map((kp) => kp.toJson()).toList());
  }

  /// Add a keypackage event to the list
  @ignore
  void addKeyPackageEvent(KeyPackageEvent keyPackageEvent) {
    List<KeyPackageEvent> currentList = keyPackageEventList;
    if (keyPackageEvent.client.isEmpty) {
      currentList.add(keyPackageEvent);
      currentList.sort((a, b) => b.createTime.compareTo(a.createTime));
      keyPackageEventList = currentList;
      return;
    }
    List<KeyPackageEvent> sameClientKeyPackages =
        currentList.where((kp) => kp.client == keyPackageEvent.client).toList();
    if (sameClientKeyPackages.isNotEmpty) {
      KeyPackageEvent latestKeyPackage =
          sameClientKeyPackages.reduce((a, b) => a.createTime > b.createTime ? a : b);
      if (keyPackageEvent.createTime > latestKeyPackage.createTime) {
        currentList.removeWhere((kp) => kp.client == keyPackageEvent.client);
        currentList.add(keyPackageEvent);
        currentList.sort((a, b) => b.createTime.compareTo(a.createTime));
        keyPackageEventList = currentList;
      }
    } else {
      currentList.add(keyPackageEvent);
      currentList.sort((a, b) => b.createTime.compareTo(a.createTime));
      keyPackageEventList = currentList;
    }
  }

  /// Get the selected keypackage event (stored in encodedKeyPackage field)
  @ignore
  KeyPackageEvent? get selectedKeyPackageEvent {
    if (encodedKeyPackage == null || encodedKeyPackage!.isEmpty) {
      return null;
    }
    return keyPackageEventList.firstWhere(
      (kp) => kp.encoded_key_package == encodedKeyPackage,
      orElse: () => KeyPackageEvent(
          pubKey, lastUpdatedTime, '', '', [], [], 'unknown', encodedKeyPackage!, ''),
    );
  }

  /// Set the selected keypackage event
  @ignore
  void setSelectedKeyPackageEvent(KeyPackageEvent keyPackageEvent) {
    encodedKeyPackage = keyPackageEvent.encoded_key_package;
    addKeyPackageEvent(keyPackageEvent);
  }

  /// Check if a keypackage event should be updated (newer createTime)
  @ignore
  bool shouldUpdateKeyPackageEvent(KeyPackageEvent newKeyPackageEvent) {
    if (newKeyPackageEvent.client.isEmpty) {
      return true;
    }
    List<KeyPackageEvent> currentList = keyPackageEventList;
    List<KeyPackageEvent> sameClientKeyPackages =
        currentList.where((kp) => kp.client == newKeyPackageEvent.client).toList();
    if (sameClientKeyPackages.isNotEmpty) {
      KeyPackageEvent latestKeyPackage =
          sameClientKeyPackages.reduce((a, b) => a.createTime > b.createTime ? a : b);
      return newKeyPackageEvent.createTime > latestKeyPackage.createTime;
    } else {
      return true;
    }
  }

  /// Get the latest keypackage event by client
  @ignore
  KeyPackageEvent? getLatestKeyPackageEventByClient(String client) {
    List<KeyPackageEvent> sameClientKeyPackages =
        keyPackageEventList.where((kp) => kp.client == client).toList();
    if (sameClientKeyPackages.isNotEmpty) {
      return sameClientKeyPackages.reduce((a, b) => a.createTime > b.createTime ? a : b);
    }
    return null;
  }

  /// Get all keypackage events with empty client
  @ignore
  List<KeyPackageEvent> getEmptyClientKeyPackageEvents() {
    return keyPackageEventList.where((kp) => kp.client.isEmpty).toList();
  }

  /// Get keypackage event by client (legacy method, returns first found)
  @ignore
  KeyPackageEvent? getKeyPackageEventByClient(String client) {
    try {
      return keyPackageEventList.firstWhere((kp) => kp.client == client);
    } catch (e) {
      return null;
    }
  }
}

class NostrWalletConnection {
  String server; // server pubkey
  List<String> relays;
  String secret;
  String? lud16;

  NostrWalletConnection(this.server, this.relays, this.secret, this.lud16);

  static NostrWalletConnection? fromURI(String? uri) {
    if (uri != null && uri.startsWith('nostr+walletconnect://')) {
      var decodedUri = Uri.parse(uri);
      var server = decodedUri.host;
      var queryParams = decodedUri.queryParametersAll;
      var relays = queryParams['relay'] ?? [];
      var secret = queryParams['secret']?.first ?? '';
      var lud16 = queryParams['lud16']?.first;
      return NostrWalletConnection(server, relays, secret, lud16);
    }
    return null;
  }
}

UserDBISAR _userInfoFromMap(Map<String, dynamic> map) {
  return UserDBISAR(
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
    banner: map['banner'].toString(),
    friendsList: map['friendsList'].toString(),
    channelsList: UserDBISAR.decodeStringList(map['channelsList'].toString()),
    groupsList: UserDBISAR.decodeStringList(map['groupsList'].toString()),
    relayGroupsList: UserDBISAR.decodeStringList(map['relayGroupsList'].toString()),
    badgesList: UserDBISAR.decodeStringList(map['badgesList'].toString()),
    blockedList: UserDBISAR.decodeStringList(map['blockedList'].toString()),
    followingList: UserDBISAR.decodeStringList(map['followingList'].toString()),
    followersList: UserDBISAR.decodeStringList(map['followersList'].toString()),
    relayList: UserDBISAR.decodeStringList(map['relayList'].toString()),
    dmRelayList: UserDBISAR.decodeStringList(map['dmRelayList'].toString()),
    aliasPubkey: map['aliasPubkey'],
    mute: map['mute'],
    lastUpdatedTime: map['lastUpdatedTime'],
    lastBadgesListUpdatedTime: map['lastBadgesListUpdatedTime'] ?? 0,
    lastBlockListUpdatedTime: map['lastBlockListUpdatedTime'] ?? 0,
    lastChannelsListUpdatedTime: map['lastChannelsListUpdatedTime'] ?? 0,
    lastFriendsListUpdatedTime: map['lastFriendsListUpdatedTime'] ?? 0,
    lastGroupsListUpdatedTime: map['lastGroupsListUpdatedTime'] ?? 0,
    lastRelayGroupsListUpdatedTime: map['lastRelayGroupsListUpdatedTime'] ?? 0,
    lastRelayListUpdatedTime: map['lastRelayListUpdatedTime'] ?? 0,
    lastFollowingListUpdatedTime: map['lastRelayListUpdatedTime'] ?? 0,
    lastDMRelayListUpdatedTime: map['lastDMRelayListUpdatedTime'] ?? 0,
    otherField: map['otherField']?.toString(),
    nwcURI: map['nwcURI']?.toString(),
    remoteSignerURI: map['remoteSignerURI']?.toString(),
    clientPrivateKey: map['clientPrivateKey']?.toString(),
    remotePubkey: map['remotePubkey']?.toString(),
    encodedKeyPackage: map['encodedKeyPackage']?.toString(),
    keyPackageEventListJson: map['keyPackageEventListJson']?.toString(),
    settings: map['settings']?.toString(),
  );
}
