import 'dart:async';
import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Account {
  /// singleton
  Account._internal() {
    _startHeartBeat();
    // _loadAllUsers();
  }
  factory Account() => sharedInstance;
  static final Account sharedInstance = Account._internal();

  UserDB? me;
  String pubkey = '';
  String privkey = '';
  Timer? timer;

  Map<String, UserDB> userCache = {};
  List<String> pQueue = [];

  void _startHeartBeat() {
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

  Future<UserDB?> getUserInfo(String pubkey) async {
    UserDB? user;
    if (userCache.containsKey(pubkey)) {
      user = userCache[pubkey];
    } else {
      user = await _getUserFromDB(pubkey: pubkey);
      if (user != null) {
        userCache[pubkey] = user;
      }
    }
    if (user != null && user.lastUpdatedTime == 0) {
      _addToSyncProfiles(pubkey);
    }
    return user;
  }

  Future<Map<String, UserDB>> getUserInfos(List<String> pubkeys) async {
    Map<String, UserDB> result = {};
    for (var p in pubkeys) {
      UserDB? user = await getUserInfo(p);
      if (user != null) result[p] = user;
    }
    return result;
  }

  void _addToSyncProfiles(String user) {
    if (user.isNotEmpty && !pQueue.contains(user)) {
      pQueue.add(user);
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
          db.privkey = privkey;
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
    Completer<UserDB> completer = Completer<UserDB>();
    Filter f = Filter(
      kinds: [0],
      authors: [pubkey],
    );

    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      Map map = jsonDecode(event.content);
      UserDB? db = await getUserInfo(pubkey);
      if (db != null && db.lastUpdatedTime < event.createdAt) {
        db.name = map['name'];
        db.gender = map['gender'];
        db.area = map['area'];
        db.about = map['about'];
        db.picture = map['picture'];
        db.dns = map['nip05'];
        db.lnurl = map['lnurl'];
        if (db.lnurl == null || db.lnurl == 'null' || db.lnurl!.isEmpty) {
          db.lnurl = null;
        }
        db.lnurl ??= map['lud06'];
        db.lnurl ??= map['lud16'];
        db.lastUpdatedTime = event.createdAt;
        if (db.name == null || db.name!.isEmpty) {
          db.name = map['display_name'];
        }
        if (db.name == null || db.name!.isEmpty) {
          db.name = map['username'];
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
        print('db?.lnurl: ${db?.lnurl}');
      }
      await DB.sharedInstance.update<UserDB>(db!);
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
    Filter f = Filter(
      kinds: [0],
      authors: pQueue,
    );
    Map<String, UserDB> users = {};
    // init users from cache & DB
    for (var key in pQueue) {
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
    }

    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      Map map = jsonDecode(event.content);
      UserDB? db = users[event.pubkey];
      if (db != null && db.lastUpdatedTime < event.createdAt) {
        db.name = map['name'];
        db.gender = map['gender'];
        db.area = map['area'];
        db.about = map['about'];
        db.picture = map['picture'];
        db.dns = map['nip05'];
        db.lnurl = map['lnurl'];
        if (db.lnurl == null || db.lnurl == 'null' || db.lnurl!.isEmpty) {
          db.lnurl = null;
        }
        db.lnurl ??= map['lud06'];
        db.lnurl ??= map['lud16'];
        db.lastUpdatedTime = event.createdAt;
        if (db.name == null || db.name!.isEmpty) {
          db.name = map['display_name'];
        }
        if (db.name == null || db.name!.isEmpty) {
          db.name = map['username'];
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

  Future<UserDB?> loginWithPubKeyAndPassword(
      String pubkey, String password) async {
    List<Object?> maps = await DB.sharedInstance
        .objects<UserDB>(where: 'pubKey = ?', whereArgs: [pubkey]);
    UserDB? db;
    print(maps);
    if (maps.isNotEmpty) {
      db = maps.first as UserDB?;
      if (db != null && db.encryptedPrivKey != null) {
        String encryptedPrivKey = db.encryptedPrivKey!;
        Uint8List privkey =
            decryptPrivateKey(hexToBytes(encryptedPrivKey), password);
        db.privkey = bytesToHex(privkey);
        if (Keychain.getPublicKey(bytesToHex(privkey)) == pubkey) {
          Account.sharedInstance.me = db;
          Account.sharedInstance.privkey = db.privkey!;
          Account.sharedInstance.pubkey = db.pubKey;
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
      db?.privkey = privkey;
    } else {
      /// insert a new account
      db = UserDB();
      db.pubKey = pubkey;
      String defaultPassword = generateStrongPassword(16);
      Uint8List enPrivkey =
          encryptPrivateKey(hexToBytes(privkey), defaultPassword);
      db.encryptedPrivKey = bytesToHex(enPrivkey);
      db.defaultPassword = defaultPassword;
      db.privkey = privkey;
      await DB.sharedInstance.insert<UserDB>(db);
    }
    Account.sharedInstance.me = db;
    Account.sharedInstance.privkey = db!.privkey!;
    Account.sharedInstance.pubkey = db.pubKey;
    return db;
  }

  static Future<bool> checkDNS(DNS dns) async {
    String? pubkey = await getDNSPubkey(dns.name, dns.domain);
    return (pubkey != null && pubkey == dns.pubkey);
  }

  static Future<String?> getDNSPubkey(String name, String domain) async {
    final response = await http
        .get(Uri.parse('https://$domain/.well-known/nostr.json?name=$name'));

    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse["names"][name];
      } catch (e) {
        print(e);
        return null;
      }
    } else {
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
    db.privkey = user.private;
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
    db.privkey = user.private;
    await DB.sharedInstance.insert<UserDB>(db);
    return db;
  }

  Future<List<UserDB>> syncFollowListFromRelay(String pubkey) async {
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
      if(lastEventTime < event.createdAt) {
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

  Future<UserDB?> updateProfile(String privkey, UserDB updateDB) async {
    Completer<UserDB?> completer = Completer<UserDB?>();

    UserDB db = await _getUserFromDB(privkey: privkey) ?? UserDB();
    db.name = updateDB.name;
    db.gender = updateDB.gender;
    db.area = updateDB.area;
    db.about = updateDB.about;
    db.picture = updateDB.picture;
    db.dns = updateDB.dns;
    db.lnurl = updateDB.lnurl;
    db.privkey = privkey;
    await DB.sharedInstance.update<UserDB>(db);

    /// send metadata event
    Map map = {
      'name': updateDB.name ?? '',
      'about': updateDB.about ?? '',
      'gender': updateDB.gender ?? '',
      'area': updateDB.area ?? '',
      'picture': updateDB.picture ?? '',
      'nip05': updateDB.dns ?? '',
      'lud16': updateDB.lnurl ?? ''
    };
    Map additionMap = jsonDecode(db.otherField ?? '{}');
    map.addAll(additionMap);
    Event event = Nip1.setMetadata(jsonEncode(map), privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (ok.status) {
        completer.complete(db);
      } else {
        completer.complete(null);
      }
    });
    return completer.future;
  }

  Future<OKEvent> updateRelaysMetadata(
      List<String> relays, String privkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<Relay> list = [];
    for (var relay in relays) {
      list.add(Relay(relay, null));
    }
    Event event = Nip65.encode(list, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<UserDB?> updatePassword(String privkey, String password) async {
    UserDB? db = await _getUserFromDB(privkey: privkey);
    if (db != null) {
      Uint8List enPrivkey = encryptPrivateKey(hexToBytes(privkey), password);
      db.encryptedPrivKey = bytesToHex(enPrivkey);
      db.defaultPassword = "";
      db.privkey = privkey;
      await DB.sharedInstance.update<UserDB>(db);
      return db;
    }
    return null;
  }

  Future<int> logout(String privkey) async {
    Contacts.sharedInstance.allContacts = {};
    Channels.sharedInstance.channels = {};
    Channels.sharedInstance.myChannels = {};
    return await delete(privkey);
  }

  Future<int> delete(String privkey) async {
    String pubkey = Keychain.getPublicKey(privkey);
    return await DB.sharedInstance
        .delete<UserDB>(where: 'pubKey = ?', whereArgs: [pubkey]);
  }

  static String encodeProfile(String pubkey, List<String> relays) {
    return Nip19.encodeShareableEntity('nprofile', pubkey, relays, null);
  }

  static Map<String, dynamic>? decodeProfile(String profile) {
    Map result = Nip19.decodeShareableEntity(profile);
    if (result['prefix'] == 'nprofile') {
      return {'pubkey': result['special'], 'relays': result['relays']};
    }
    return null;
  }
}
