import 'dart:convert';
import 'dart:typed_data';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

typedef SyncCallBack = Function(Map<String, UserDB>);

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

  static Future<UserDB> newAccount() async {
    String defaultPassword = generateStrongPassword(16);
    var user = Keychain.generate();
    Uint8List enPrivkey =
        encryptPrivateKey(hexToBytes(user.private), defaultPassword);
    UserDB db = UserDB();
    db.pubKey = user.public;
    db.encryptedPrivKey = bytesToHex(enPrivkey);
    db.defaultPassword = defaultPassword;
    db.privkey = user.private;
    await DB.sharedInstance.insert<UserDB>(db);
    return db;
  }

  static Future<UserDB> newAccountWithPassword(String password) async {
    var user = Keychain.generate();
    Uint8List enPrivkey = encryptPrivateKey(hexToBytes(user.private), password);
    UserDB db = UserDB();
    db.pubKey = user.public;
    db.encryptedPrivKey = bytesToHex(enPrivkey);
    db.privkey = user.private;
    await DB.sharedInstance.insert<UserDB>(db);
    return db;
  }

  /// sync profile from relays
  static Future syncProfilesFromRelay(
      List<String> pubkeys, SyncCallBack callBack) async {
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
      }
    }, eoseCallBack: (status) {
          Connect.sharedInstance.closeSubscription(subscriptionId);
      callBack(users);
    });
  }

  static Future<UserDB?> updateProfile(String privkey, UserDB updateDB) async {
    UserDB db = await getUserFromDB(privkey: privkey) ?? UserDB();
    db.name = updateDB.name;
    db.gender = updateDB.gender;
    db.area = updateDB.area;
    db.about = updateDB.about;
    db.picture = updateDB.picture;
    db.privkey = privkey;
    await DB.sharedInstance.update<UserDB>(db);

    /// send metadata event
    Map map = {
      'name': updateDB.name,
      'about': updateDB.about,
      'gender': updateDB.gender,
      'area': updateDB.area,
      'picture': updateDB.picture,
    };
    Event event = Nip1.setMetadata(jsonEncode(map), privkey);
    Connect.sharedInstance.sendEvent(event);
    return db;
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
}
