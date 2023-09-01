import 'dart:async';
import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Account {
  /// singleton
  Account._internal();
  factory Account() => sharedInstance;
  static final Account sharedInstance = Account._internal();

  UserDB? me;
  String pubkey = '';
  String privkey = '';

  Map<String, UserDB> userCache = {};

  Future<void> syncMe() async {
    await DB.sharedInstance.update<UserDB>(me!);
  }

  static Future<UserDB?> getUser(String pubkey) async {
    if (Account.sharedInstance.userCache.containsKey(pubkey)) {
      return Account.sharedInstance.userCache[pubkey];
    } else {
      UserDB? user = await getUserFromDB(pubkey: pubkey);
      if (user != null) {
        if (user.lastUpdatedTime == 0) {
          syncProfilesFromRelay([pubkey]);
        }
        Account.sharedInstance.userCache[pubkey] = user;
        return user;
      }
    }
    return null;
  }

  static Future<UserDB?> getUserFromDB(
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

  static Future<UserDB?> loginWithPubKeyAndPassword(
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
          Account.sharedInstance.pubkey = db.pubKey!;
          return db;
        }
      }
    }
    return null;
  }

  static Future<UserDB?> loginWithPriKey(String privkey) async {
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
    Account.sharedInstance.pubkey = db.pubKey!;
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

  static Uint8List decryptPrivateKeyWithMap(Map map) {
    return decryptPrivateKey(hexToBytes(map['privkey']), map['password']);
  }

  static Future<UserDB> newAccountWithPassword(String password) async {
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

  /// sync profile from relays
  static Future<Map<String, UserDB>> syncProfilesFromRelay(
      List<String> pubkeys) async {
    Completer<Map<String, UserDB>> completer = Completer<Map<String, UserDB>>();
    if (pubkeys.isEmpty) return {};
    Filter f = Filter(
      kinds: [0],
      authors: pubkeys,
    );
    Map<String, UserDB> users = {};
    // init users from DB
    for (var key in pubkeys) {
      UserDB? db = await getUserFromDB(pubkey: key);
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
        if (db.lnurl == null || db.lnurl == 'null') db.lnurl = null;
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
        }
        if (!completer.isCompleted) completer.complete(users);
      }
    });
    return completer.future;
  }

  static Future<List<UserDB>> syncFollowListFromRelay(String pubkey) async {
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
        List<String> nonProfiles = [];

        for (var p in profiles) {
          UserDB? userDB = await getUserFromDB(pubkey: p.key);
          if (userDB != null) {
            if (userDB.lastUpdatedTime == 0) {
              nonProfiles.add(userDB.pubKey);
            } else {
              result.add(userDB);
            }
          }
        }
        if (nonProfiles.isNotEmpty) {
          Map<String, UserDB> users = await syncProfilesFromRelay(nonProfiles);
          result.addAll(users.values);
        }

        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  static Future<List<String>> syncRelaysMetadataFromKind3(String pubkey) async {
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

  static Future<List<String>> syncRelaysMetadataFromRelay(String pubkey) async {
    Completer<List<String>> completer = Completer<List<String>>();

    Filter f = Filter(kinds: [10002], authors: [pubkey], limit: 1);
    List<Relay> result = [];
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      result = Nip65.decode(event);
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

  static Future<UserDB?> updateProfile(String privkey, UserDB updateDB) async {
    Completer<UserDB?> completer = Completer<UserDB?>();

    UserDB db = await getUserFromDB(privkey: privkey) ?? UserDB();
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

  static Future<OKEvent> updateRelaysMetadata(
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

  static Future<UserDB?> updatePassword(String privkey, String password) async {
    UserDB? db = await getUserFromDB(privkey: privkey);
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

  static Future<int> logout(String privkey) async {
    Contacts.sharedInstance.allContacts = {};
    Channels.sharedInstance.channels = {};
    Channels.sharedInstance.myChannels = {};
    return await delete(privkey);
  }

  static Future<int> delete(String privkey) async {
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
