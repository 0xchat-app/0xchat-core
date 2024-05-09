import 'dart:async';
import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Account {
  /// singleton
  Account._internal() {
    startHeartBeat();
    _loadAllUsers();
  }
  factory Account() => sharedInstance;
  static final Account sharedInstance = Account._internal();

  UserDB? me;
  String currentPubkey = '';
  String currentPrivkey = '';
  Timer? timer;

  Map<String, UserDB> userCache = {};
  List<String> pQueue = [];

  void startHeartBeat() {
    if (timer == null || timer!.isActive == false) {
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
        await _syncProfilesFromRelay();
      });
    }
  }

  Future<void> _loadAllUsers() async {
    List<UserDB?> maps = await DB.sharedInstance.objects<UserDB>();
    for (UserDB? user in maps) {
      if (user != null) {
        userCache[user.pubKey] = user;
      }
    }
  }

  Future<void> syncMe() async {
    await DB.sharedInstance.update<UserDB>(me!);
  }

  bool isValidPubKey(String pubKey) {
    final pattern = RegExp(r'^[a-fA-F0-9]{64}$');
    return pattern.hasMatch(pubKey);
  }

  FutureOr<UserDB?> getUserInfo(String pubkey) {
    final user = userCache[pubkey];
    if (user != null) {
      _tryAddToSyncProfiles(user);
      return user;
    }

    Completer<UserDB?> completer = Completer();
    _getUserFromDB(pubkey: pubkey).then((user) {
      if (user != null) {
        userCache[pubkey] = user;
        _tryAddToSyncProfiles(user);
      }
      completer.complete(user);
    });
    return completer.future;
  }

  Future<Map<String, UserDB>> getUserInfos(List<String> pubkeys) async {
    Map<String, UserDB> result = {};
    for (var p in pubkeys) {
      UserDB? user = await getUserInfo(p);
      if (user != null) result[p] = user;
    }
    return result;
  }

  void _tryAddToSyncProfiles(UserDB user) {
    if (user.lastUpdatedTime != 0) return;
    final pubkey = user.pubKey;
    if (pubkey.isNotEmpty &&
        !pQueue.contains(pubkey) &&
        isValidPubKey(pubkey)) {
      pQueue.add(pubkey);
    }
  }

  Future<UserDB?> _getUserFromDB(
      {String pubkey = '', String privkey = ''}) async {
    if (privkey.isNotEmpty) {
      pubkey = Keychain.getPublicKey(privkey);
    }
    if (pubkey.isNotEmpty) {
      List<Object?> maps = await DB.sharedInstance
          .objects<UserDB>(where: 'pubKey = ?', whereArgs: [pubkey]);
      UserDB? db;
      if (maps.isNotEmpty) {
        db = maps.first as UserDB?;
        if (db != null) {
          return db;
        }
      } else {
        db = UserDB(pubKey: pubkey);
        db.name = db.shortEncodedPubkey;
        await DB.sharedInstance.insert<UserDB>(db);
        return db;
      }
    }
    return null;
  }

  Future<UserDB> reloadProfileFromRelay(String pubkey) async {
    if (!isValidPubKey(pubkey)) return UserDB(pubKey: pubkey);
    Completer<UserDB> completer = Completer<UserDB>();
    UserDB? db = await getUserInfo(pubkey);
    Filter f = Filter(kinds: [0], authors: [pubkey]);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      Map map = jsonDecode(event.content);
      if (db != null && db.lastUpdatedTime < event.createdAt) {
        db.name = map['name']?.toString();
        db.gender = map['gender']?.toString();
        db.area = map['area']?.toString();
        db.about = map['about']?.toString();
        db.picture = map['picture']?.toString();
        db.banner = map['banner']?.toString();
        db.dns = map['nip05']?.toString();
        db.lnurl = map['lnurl']?.toString();
        if (db.lnurl == null || db.lnurl == 'null' || db.lnurl!.isEmpty) {
          db.lnurl = null;
        }
        db.lnurl ??= map['lud06']?.toString();
        db.lnurl ??= map['lud16']?.toString();
        db.lastUpdatedTime = event.createdAt;
        if (db.name == null || db.name!.isEmpty) {
          db.name = map['display_name']?.toString();
        }
        if (db.name == null || db.name!.isEmpty) {
          db.name = map['username']?.toString();
        }
        if (db.name == null || db.name!.isEmpty) {
          db.name = db.shortEncodedPubkey;
        }
        var keysToRemove = {
          'name',
          'display_name',
          'username',
          'gender',
          'area',
          'about',
          'picture',
          'banner',
          'nip05',
          'lnurl',
          'lud16',
          'lud06'
        };
        Map filteredMap = Map.from(map)
          ..removeWhere((key, value) => keysToRemove.contains(key));
        db.otherField = jsonEncode(filteredMap);
      } else {
        if (db?.lnurl == null || db?.lnurl == 'null' || db!.lnurl!.isEmpty) {
          db?.lnurl = null;
        }
        db?.lnurl ??= map['lud16'];
        db?.lnurl ??= map['lud06'];
      }
      userCache[pubkey] = db!;
      if (pubkey == currentPubkey) me = db;
      DB.sharedInstance.update<UserDB>(db);
      if (!completer.isCompleted) completer.complete(db);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
    });
    return completer.future;
  }

  /// sync profile from relays
  Future<void> _syncProfilesFromRelay() async {
    if (pQueue.isEmpty) return;
    Completer<void> completer = Completer<void>();

    Map<String, UserDB> users = {};
    // init users from cache & DB
    List<String> pQueueTemp = List.from(pQueue);
    for (var key in pQueueTemp) {
      UserDB? db = userCache[key];
      db ??= await _getUserFromDB(pubkey: key);
      if (db == null) {
        db = UserDB();
        db.pubKey = key;
      }
      if (db.name == null || db.name!.isEmpty) {
        db.name = db.shortEncodedPubkey;
      }
      users[key] = db;
      if (db.lastUpdatedTime > 0) pQueue.remove(db.pubKey);
    }

    Filter f = Filter(
      kinds: [0],
      authors: pQueue,
    );
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      Map map = jsonDecode(event.content);
      UserDB? db = users[event.pubkey];
      if (db != null && db.lastUpdatedTime < event.createdAt) {
        db.name = map['name']?.toString();
        db.gender = map['gender']?.toString();
        db.area = map['area']?.toString();
        db.about = map['about']?.toString();
        db.picture = map['picture']?.toString();
        db.banner = map['banner']?.toString();
        db.dns = map['nip05']?.toString();
        db.lnurl = map['lnurl']?.toString();
        if (db.lnurl == null || db.lnurl == 'null' || db.lnurl!.isEmpty) {
          db.lnurl = null;
        }
        db.lnurl ??= map['lud06']?.toString();
        db.lnurl ??= map['lud16']?.toString();
        db.lastUpdatedTime = event.createdAt;
        if (db.name == null || db.name!.isEmpty) {
          db.name = map['display_name']?.toString();
        }
        if (db.name == null || db.name!.isEmpty) {
          db.name = map['username']?.toString();
        }
        if (db.name == null || db.name!.isEmpty) {
          db.name = db.shortEncodedPubkey;
        }
        var keysToRemove = {
          'name',
          'display_name',
          'username',
          'gender',
          'area',
          'about',
          'picture',
          'banner',
          'nip05',
          'lnurl',
          'lud16',
          'lud06'
        };
        Map filteredMap = Map.from(map)
          ..removeWhere((key, value) => keysToRemove.contains(key));
        db.otherField = jsonEncode(filteredMap);
      } else {
        if (db?.lnurl == null || db?.lnurl == 'null') db?.lnurl = null;
        db?.lnurl ??= map['lud16'];
        db?.lnurl ??= map['lud06'];
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        for (var db in users.values) {
          await DB.sharedInstance.insert<UserDB>(db);
          userCache[db.pubKey] = db;
          pQueue.remove(db.pubKey);
        }
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<UserDB?> loginWithPubKey(String pubkey) async {
    UserDB? userDB = await _getUserFromDB(pubkey: pubkey);
    if (userDB != null) {
      me = userDB;
      currentPubkey = userDB.pubKey;
      currentPrivkey = '';
      userCache[currentPubkey] = userDB;
    }
    return userDB;
  }

  Future<UserDB?> loginWithPubKeyAndPassword(String pubkey) async {
    List<Object?> maps = await DB.sharedInstance
        .objects<UserDB>(where: 'pubKey = ?', whereArgs: [pubkey]);
    UserDB? db;
    if (maps.isNotEmpty) {
      db = maps.first as UserDB?;
      if (db != null &&
          db.encryptedPrivKey != null &&
          db.encryptedPrivKey!.isNotEmpty &&
          db.defaultPassword != null &&
          db.defaultPassword!.isNotEmpty) {
        String encryptedPrivKey = db.encryptedPrivKey!;
        Uint8List privkey = decryptPrivateKey(
            hexToBytes(encryptedPrivKey), db.defaultPassword!);
        if (Keychain.getPublicKey(bytesToHex(privkey)) == pubkey) {
          me = db;
          currentPrivkey = bytesToHex(privkey);
          currentPubkey = db.pubKey;
          userCache[currentPubkey] = db;
          return db;
        }
      }
    }
    return null;
  }

  Future<UserDB?> loginWithPriKey(String privkey) async {
    String pubkey = Keychain.getPublicKey(privkey);
    List<Object?> maps = await DB.sharedInstance
        .objects<UserDB>(where: 'pubKey = ?', whereArgs: [pubkey]);
    UserDB? db;
    if (maps.isNotEmpty) {
      db = maps.first as UserDB?;
    }

    /// insert a new account
    db ??= UserDB();
    db.pubKey = pubkey;
    String defaultPassword = generateStrongPassword(16);
    Uint8List enPrivkey =
        encryptPrivateKey(hexToBytes(privkey), defaultPassword);
    db.encryptedPrivKey = bytesToHex(enPrivkey);
    db.defaultPassword = defaultPassword;
    await DB.sharedInstance.insert<UserDB>(db);
    me = db;
    currentPrivkey = privkey;
    currentPubkey = db.pubKey;
    userCache[currentPubkey] = db;
    return db;
  }

  static Future<bool> checkDNS(DNS dns) async {
    String? pubkey = await getDNSPubkey(dns.name, dns.domain);
    return (pubkey != null && pubkey == dns.pubkey);
  }

  static Future<String?> getDNSPubkey(String name, String domain) async {
    try {
      final response = await http
          .get(Uri.parse('https://$domain/.well-known/nostr.json?name=$name'));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse["names"][name];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // static String signData(List data, String privateKey) {
  //   return Nip101.getSig(data, privateKey);
  // }

  static Uint8List encryptPrivateKeyWithMap(Map map) {
    return encryptPrivateKey(hexToBytes(map['privkey']), map['password']);
  }

  static Keychain generateNewKeychain() {
    return Keychain.generate();
  }

  static String getPublicKey(String privkey) {
    return Keychain.getPublicKey(privkey);
  }

  static Future<UserDB> newAccount({Keychain? user}) async {
    user ?? Keychain.generate();
    String defaultPassword = generateStrongPassword(16);
    Uint8List enPrivkey = await compute(encryptPrivateKeyWithMap,
        {'privkey': user!.private, 'password': defaultPassword});
    UserDB db = UserDB();
    db.pubKey = user.public;
    db.encryptedPrivKey = bytesToHex(enPrivkey);
    db.defaultPassword = defaultPassword;
    await DB.sharedInstance.insert<UserDB>(db);
    return db;
  }

  Uint8List decryptPrivateKeyWithMap(Map map) {
    return decryptPrivateKey(hexToBytes(map['privkey']), map['password']);
  }

  Future<UserDB> newAccountWithPassword(String password) async {
    var user = Keychain.generate();
    Uint8List enPrivkey = await compute(decryptPrivateKeyWithMap,
        {'privkey': user.private, 'password': password});
    UserDB db = UserDB();
    db.pubKey = user.public;
    db.encryptedPrivKey = bytesToHex(enPrivkey);
    await DB.sharedInstance.insert<UserDB>(db);
    return db;
  }

  List<Profile> toProfiles(List<String> pubkeys) {
    List<Profile> result = [];
    for (var p in pubkeys) {
      result.add(Profile(p, '', ''));
    }
    return result;
  }

  Future<OKEvent> addFollows(List<String> pubkeys) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    List<String> followingList = me?.followingList ?? [];
    for (var p in pubkeys) {
      if (!followingList.contains(p)) followingList.add(p);
    }
    Event event = await Nip2.encode(
        toProfiles(followingList), currentPubkey, currentPrivkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
        if (ok.status) {
          me?.followingList = followingList;
          syncMe();
        }
      }
    });
    return completer.future;
  }

  Future<OKEvent> removeFollows(List<String> pubkeys) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    List<String> followingList = me?.followingList ?? [];
    for (var p in pubkeys) {
      if (followingList.contains(p)) followingList.remove(p);
    }
    Event event = await Nip2.encode(
        toProfiles(followingList), currentPubkey, currentPrivkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
        if (ok.status) {
          me?.followingList = followingList;
          syncMe();
        }
      }
    });
    return completer.future;
  }

  Future<bool> onFollowingList(String pubkey) async {
    return me?.followingList?.contains(pubkey) == true;
  }

  Future<List<UserDB>> syncFollowingListFromDB(String pubkey) async {
    UserDB? user = await getUserInfo(pubkey);
    List<UserDB> result = [];
    for (var p in user?.followingList ?? []) {
      UserDB? userDB = await getUserInfo(p.key);
      if (userDB != null) {
        result.add(userDB);
      }
    }
    return result;
  }

  Future<List<UserDB>> syncFollowingListFromRelay(String pubkey) async {
    Completer<List<UserDB>> completer = Completer<List<UserDB>>();
    Filter f = Filter(kinds: [3], authors: [pubkey], limit: 1);
    List<Profile> profiles = [];
    int lastTimeStamp = 0;
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (event.createdAt > lastTimeStamp) {
        profiles = Nip2.decode(event);
        lastTimeStamp = event.createdAt;
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        UserDB? user = await getUserInfo(pubkey);
        if (user != null) {
          user.followingList = profiles.map((e) => e.key).toList();
          await DB.sharedInstance.insert<UserDB>(user);
        }

        List<UserDB> result = [];
        for (var p in profiles) {
          UserDB? userDB = await getUserInfo(p.key);
          if (userDB != null) {
            result.add(userDB);
          }
        }
        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  Future<List<String>> syncRelaysMetadataFromKind3(String pubkey) async {
    Completer<List<String>> completer = Completer<List<String>>();
    Filter f = Filter(kinds: [3], authors: [pubkey], limit: 1);
    String content = '';
    int lastTimeStamp = 0;
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (event.createdAt > lastTimeStamp) {
        content = event.content;
        lastTimeStamp = event.createdAt;
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        List<String> result = [];
        try {
          Map map = jsonDecode(content);
          List<String> result = map.keys.map((e) => e.toString()).toList();
          if (!completer.isCompleted) completer.complete(result);
        } catch (e) {
          if (!completer.isCompleted) completer.complete(result);
        }
      }
    });
    return completer.future;
  }

  Future<List<String>> syncRelaysMetadataFromRelay(String pubkey) async {
    Completer<List<String>> completer = Completer<List<String>>();

    Filter f = Filter(kinds: [10002], authors: [pubkey], limit: 1);
    List<Relay> result = [];
    int lastEventTime = 0;
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (lastEventTime < event.createdAt) {
        result = Nip65.decode(event);
        lastEventTime = event.createdAt;
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        List<String> relayList = result.map((e) => e.url).toList();
        if (relayList.isEmpty) {
          relayList = await syncRelaysMetadataFromKind3(pubkey);
        }
        if (!completer.isCompleted) completer.complete(relayList);
      }
    });
    return completer.future;
  }

  Future<UserDB?> updateProfile(UserDB updateDB) async {
    Completer<UserDB?> completer = Completer<UserDB?>();

    UserDB db = await _getUserFromDB(pubkey: currentPubkey) ?? UserDB();
    db.name = updateDB.name;
    db.gender = updateDB.gender;
    db.area = updateDB.area;
    db.about = updateDB.about;
    db.picture = updateDB.picture;
    db.banner = updateDB.banner;
    db.dns = updateDB.dns;
    db.lnurl = updateDB.lnurl;
    db.mute = updateDB.mute;
    await DB.sharedInstance.update<UserDB>(db);

    /// send metadata event
    Map map = {
      'name': updateDB.name ?? '',
      'about': updateDB.about ?? '',
      'gender': updateDB.gender ?? '',
      'area': updateDB.area ?? '',
      'picture': updateDB.picture ?? '',
      'banner': updateDB.banner ?? '',
      'nip05': updateDB.dns ?? '',
      'lud16': updateDB.lnurl ?? ''
    };
    Map additionMap = jsonDecode(db.otherField ?? '{}');
    map.addAll(additionMap);
    Event event =
        await Nip1.setMetadata(jsonEncode(map), currentPubkey, currentPrivkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (ok.status) {
        completer.complete(db);
      } else {
        completer.complete(null);
      }
    });
    return completer.future;
  }

  Future<OKEvent> updateRelaysMetadata(List<String> relays) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<Relay> list = [];
    for (var relay in relays) {
      list.add(Relay(relay, null));
    }
    Event event = await Nip65.encode(list, currentPubkey, currentPrivkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<UserDB?> updatePassword(String password) async {
    UserDB? db = await _getUserFromDB(privkey: currentPrivkey);
    if (db != null) {
      Uint8List enPrivkey =
          encryptPrivateKey(hexToBytes(currentPrivkey), password);
      db.encryptedPrivKey = bytesToHex(enPrivkey);
      db.defaultPassword = password;
      await DB.sharedInstance.update<UserDB>(db);
      return db;
    }
    return null;
  }

  void logout() {
    Contacts.sharedInstance.allContacts.clear();
    Contacts.sharedInstance.secretSessionMap.clear();
    Channels.sharedInstance.channels.clear();
    Channels.sharedInstance.myChannels.clear();
    Relays.sharedInstance.relays.clear();
    Messages.sharedInstance.messagesLoaded.clear();
    NotificationHelper.sharedInstance.logout();
    me?.defaultPassword = '';
    syncMe();
    me = null;
    currentPubkey = '';
    currentPrivkey = '';
    userCache.remove(currentPubkey);
  }

  Future<int> _delete() async {
    return await DB.sharedInstance
        .delete<UserDB>(where: 'pubKey = ?', whereArgs: [currentPubkey]);
  }

  static Future<Event?> loadAddress(String d, String pubkey) async {
    Completer<Event?> completer = Completer<Event?>();
    Filter f = Filter(d: [d], authors: [pubkey]);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (!completer.isCompleted) completer.complete(event);
    }, eoseCallBack: (requestId, status, relay, unRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(null);
      }
    });
    return completer.future;
  }

  static Future<Event?> loadEvent(String eventId) async {
    if (Connect.sharedInstance.relays().isEmpty) return null;
    Completer<Event?> completer = Completer<Event?>();
    Filter f = Filter(ids: [eventId]);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (!completer.isCompleted) completer.complete(event);
    }, eoseCallBack: (requestId, status, relay, unRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(null);
      }
    });
    return completer.future;
  }

  static String encodeProfile(String pubkey, List<String> relays) {
    String profile =
        Nip19.encodeShareableEntity('nprofile', pubkey, relays, null, null);
    return Nip21.encode(profile);
  }

  static Map<String, dynamic>? decodeProfile(String profile) {
    if (profile.startsWith('nostr:')) {
      profile = Nip21.decode(profile)!;
    }
    if (profile.startsWith('npub')) {
      return {'pubkey': Nip19.decodePubkey(profile), 'relays': []};
    } else if (profile.startsWith('nprofile')) {
      Map result = Nip19.decodeShareableEntity(profile);
      if (result['prefix'] == 'nprofile') {
        return {'pubkey': result['special'], 'relays': result['relays']};
      }
    }
    return null;
  }

  Map<String, dynamic> signEvent(Map<String, dynamic> json) {
    if (json['pubkey'] == null) json['pubkey'] = currentPubkey;
    if (json['id'] == null) {
      var tags = (json['tags'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList();
      json['id'] = Event.processEventId(json['pubkey'], json['created_at'],
          json['kind'], tags, json['content']);
    }
    Event event = Event.fromJson(json, verify: false);
    //todo: sign from signer
    event.sig = event.getSignature(currentPrivkey);
    assert(event.isValid() == true);
    return event.toJson();
  }

  Future<String> encryptNip04(String content, String peer) async {
    return await Nip4.encryptContent(
        content, peer, currentPubkey, currentPrivkey);
  }

  Future<String> decryptNip04(String content, String peer) async {
    return await Nip4.decryptContent(
        content, peer, currentPubkey, currentPrivkey);
  }
}
