import 'dart:convert';
import 'dart:typed_data';
import 'package:nostr/nostr.dart';
import 'package:chatcore/chat-core.dart';

typedef SyncCallBack = UserDB? Function(UserDB?);

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
  static Future syncProfile(SyncCallBack callBack,
      {String pubkey = '', String privkey = ''}) async {
    if (privkey.isNotEmpty) {
      pubkey = Keychain.getPublicKey(privkey);
    }
    if (pubkey.isNotEmpty) {
      String subscriptionId = '';
      Filter f = Filter(
        kinds: [0],
        authors: [pubkey],
      );
      subscriptionId =
          Connect.sharedInstance.addSubscription([f], (event) async {
        /// close subscription
        Connect.sharedInstance.closeSubscription(subscriptionId);
        UserDB? db = await getUserFromDB(pubkey: pubkey);
        db ??= UserDB();
        Map map = jsonDecode(event.content);
        db.name = map['name'];
        db.gender = map['gender'];
        db.area = map['area'];
        db.about = map['about'];
        db.picture = map['picture'];
        db.privkey = privkey;

        db = callBack(db);
        await DB.sharedInstance.update<UserDB>(db!);
      });
    } else {
      callBack(null);
    }
  }

  static Future<UserDB?> updateProfile(String privkey, String name,
      {String gender = '',
      String area = '',
      String about = '',
      String picture = ''}) async {
    UserDB? db = await getUserFromDB(privkey: privkey);
    if (db != null) {
      db.name = name;
      db.gender = gender;
      db.area = area;
      db.about = about;
      db.picture = picture;
      db.privkey = privkey;
      await DB.sharedInstance.update<UserDB>(db);

      /// send metadata event
      Map map = {
        'name': name,
        'about': about,
        'gender': gender,
        'area': area,
        'picture': picture,
      };
      Event event = Nip1.setMetadata(jsonEncode(map), privkey);
      Connect.sharedInstance.sendEvent(event);
      return db;
    }
    return null;
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
