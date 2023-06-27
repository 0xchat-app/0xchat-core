import 'dart:async';
import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Account {
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
        if (Keychain.getPublicKey(bytesToHex(privkey)) == pubkey) return db;
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
    return db;
  }

  static Future<bool> checkDNS(DNS dns) async {
    final response = await http.get(Uri.parse(
        'https://${dns.domain}/.well-known/nostr.json?name=${dns.name}'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String pubkey = jsonResponse["names"][dns.name];
      return pubkey == dns.pubkey;
    } else {
      throw Exception(response.toString());
    }
  }

  static String signData(List data, String privateKey) {
    return Nip101.getSig(data, privateKey);
  }

  static Uint8List encryptPrivateKeyWithMap(Map map) {
    return encryptPrivateKey(hexToBytes(map['privkey']), map['password']);
  }

  static Future<UserDB> newAccount() async {
    String defaultPassword = generateStrongPassword(16);
    var user = Keychain.generate();
    Uint8List enPrivkey = await compute(encryptPrivateKeyWithMap,
        {'privkey': user.private, 'password': defaultPassword});
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

    String subscriptionId = '';
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
      users[key] = db;
    }
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      Map map = jsonDecode(event.content);
      UserDB? db = users[event.pubkey];
      if (db != null) {
        db.name = map['name'];
        db.gender = map['gender'];
        db.area = map['area'];
        db.about = map['about'];
        db.picture = map['picture'];
        db.dns = map['nip05'];
        db.lnurl = map['lnurl'];
        await DB.sharedInstance.insert<UserDB>(db);
      }
      completer.complete(users);
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) {
        completer.complete(users);
      }
    }, needTimeout: true);
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
    db.privkey = privkey;
    await DB.sharedInstance.update<UserDB>(db);

    /// send metadata event
    Map map = {
      'name': updateDB.name,
      'about': updateDB.about,
      'gender': updateDB.gender,
      'area': updateDB.area,
      'picture': updateDB.picture,
      'nip05': updateDB.dns,
      'lnurl': updateDB.lnurl
    };
    Event event = Nip1.setMetadata(jsonEncode(map), privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
      if (ok.status) {
        completer.complete(db);
      } else {
        completer.complete(null);
      }
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
    return delete(privkey);
  }

  static Future<int> delete(String privkey) async {
    String pubkey = Keychain.getPublicKey(privkey);
    return DB.sharedInstance
        .delete<UserDB>(where: 'pubKey = ?', whereArgs: [pubkey]);
  }

  static String encodeProfile(String pubkey, List<String> relays) {
    return Nip19.encodeShareableEntity('nprofile', pubkey, relays, null);
  }

  static Map<String, dynamic>? decodeProfile(String profile) {
    Map result = Nip19.decodeShareableEntity(profile);
    if(result['prefix'] == 'nprofile'){
      return {'pubkey': result['special'], 'relays': result['relays']};
    }
    return null;
  }
}
