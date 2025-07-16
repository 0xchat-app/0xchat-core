import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:isar/isar.dart' hide Filter;

part 'userDB_isar.g.dart';

/// KeyPackage data class to store keypackage information
class KeyPackageData {
  final String encodedKeyPackage;
  final int timestamp;
  final String client;
  final String eventId;

  KeyPackageData({
    required this.encodedKeyPackage,
    required this.timestamp,
    required this.client,
    required this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {
      'encodedKeyPackage': encodedKeyPackage,
      'timestamp': timestamp,
      'client': client,
      'eventId': eventId,
    };
  }

  factory KeyPackageData.fromJson(Map<String, dynamic> json) {
    return KeyPackageData(
      encodedKeyPackage: json['encodedKeyPackage'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      client: json['client'] ?? '',
      eventId: json['eventId'] ?? '',
    );
  }

  @override
  String toString() {
    return 'KeyPackageData(encodedKeyPackage: $encodedKeyPackage, timestamp: $timestamp, client: $client, eventId: $eventId)';
  }
}

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

  // KeyPackage list storage (JSON string)
  String? keyPackageListJson;

  String? settings;

  UserDBISAR({
    this.pubKey = '',
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
    this.keyPackageListJson
  });

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

  /// Get keypackage list from JSON string
  @ignore
  List<KeyPackageData> get keyPackageList {
    if (keyPackageListJson == null || keyPackageListJson!.isEmpty) {
      return [];
    }
    try {
      List<dynamic> jsonList = jsonDecode(keyPackageListJson!);
      return jsonList.map((json) => KeyPackageData.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Set keypackage list to JSON string
  @ignore
  set keyPackageList(List<KeyPackageData> keyPackages) {
    keyPackageListJson = jsonEncode(keyPackages.map((kp) => kp.toJson()).toList());
  }

  /// Add a keypackage to the list
  @ignore
  void addKeyPackage(KeyPackageData keyPackage) {
    List<KeyPackageData> currentList = keyPackageList;
    
    // If client is empty, directly add without comparison
    if (keyPackage.client.isEmpty) {
      currentList.add(keyPackage);
      
      // Sort by timestamp (newest first)
      currentList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      
      keyPackageList = currentList;
      return;
    }
    
    // Find all keypackages with the same client
    List<KeyPackageData> sameClientKeyPackages = currentList.where((kp) => kp.client == keyPackage.client).toList();
    
    if (sameClientKeyPackages.isNotEmpty) {
      // Find the latest keypackage for this client
      KeyPackageData latestKeyPackage = sameClientKeyPackages.reduce((a, b) => a.timestamp > b.timestamp ? a : b);
      
      // Only add if the new keypackage is newer than the latest existing one
      if (keyPackage.timestamp > latestKeyPackage.timestamp) {
        // Remove all existing keypackages with same client
        currentList.removeWhere((kp) => kp.client == keyPackage.client);
        
        // Add new keypackage
        currentList.add(keyPackage);
        
        // Sort by timestamp (newest first)
        currentList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        
        keyPackageList = currentList;
      }
    } else {
      // No existing keypackage for this client, add the new one
      currentList.add(keyPackage);
      
      // Sort by timestamp (newest first)
      currentList.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      
      keyPackageList = currentList;
    }
  }

  /// Get the selected keypackage (stored in encodedKeyPackage field)
  @ignore
  KeyPackageData? get selectedKeyPackage {
    if (encodedKeyPackage == null || encodedKeyPackage!.isEmpty) {
      return null;
    }
    
    // Find the keypackage in the list that matches the selected encodedKeyPackage
    return keyPackageList.firstWhere(
      (kp) => kp.encodedKeyPackage == encodedKeyPackage,
      orElse: () => KeyPackageData(
        encodedKeyPackage: encodedKeyPackage!,
        timestamp: lastUpdatedTime,
        client: 'unknown',
        eventId: '',
      ),
    );
  }

  /// Set the selected keypackage
  @ignore
  void setSelectedKeyPackage(KeyPackageData keyPackage) {
    encodedKeyPackage = keyPackage.encodedKeyPackage;
    addKeyPackage(keyPackage);
  }

  /// Check if a keypackage should be updated (newer timestamp)
  @ignore
  bool shouldUpdateKeyPackage(KeyPackageData newKeyPackage) {
    // If client is empty, always allow update
    if (newKeyPackage.client.isEmpty) {
      return true;
    }
    
    List<KeyPackageData> currentList = keyPackageList;
    
    // Find all keypackages with the same client
    List<KeyPackageData> sameClientKeyPackages = currentList.where((kp) => kp.client == newKeyPackage.client).toList();
    
    if (sameClientKeyPackages.isNotEmpty) {
      // Find the latest keypackage for this client
      KeyPackageData latestKeyPackage = sameClientKeyPackages.reduce((a, b) => a.timestamp > b.timestamp ? a : b);
      
      // Return true if new keypackage is newer than the latest existing one
      return newKeyPackage.timestamp > latestKeyPackage.timestamp;
    } else {
      // No existing keypackage for this client, should add
      return true;
    }
  }

  /// Get the latest keypackage by client
  @ignore
  KeyPackageData? getLatestKeyPackageByClient(String client) {
    List<KeyPackageData> sameClientKeyPackages = keyPackageList.where((kp) => kp.client == client).toList();
    
    if (sameClientKeyPackages.isNotEmpty) {
      // Return the latest keypackage for this client
      return sameClientKeyPackages.reduce((a, b) => a.timestamp > b.timestamp ? a : b);
    }
    
    return null;
  }

  /// Get all keypackages with empty client
  @ignore
  List<KeyPackageData> getEmptyClientKeyPackages() {
    return keyPackageList.where((kp) => kp.client.isEmpty).toList();
  }

  /// Get keypackage by client (legacy method, returns first found)
  @ignore
  KeyPackageData? getKeyPackageByClient(String client) {
    try {
      return keyPackageList.firstWhere((kp) => kp.client == client);
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
    keyPackageListJson: map['keyPackageListJson']?.toString(),
    settings: map['settings']?.toString(),
  );
}
