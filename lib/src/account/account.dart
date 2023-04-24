import 'dart:typed_data';
import 'package:nostr/nostr.dart';
import '../common/database/db.dart';
import 'model/userDB.dart';

class Account {
  Future<UserDB?> loginWithPubKeyAndPassword(
      String pubkey, String password) async {
    List<Object?> maps = await DB.sharedInstance
        .objects<UserDB>('userDB', where: 'pubKey = ?', whereArgs: [pubkey]);
    UserDB? db;
    if (maps.isNotEmpty) {
      db = maps.first as UserDB?;
      if (db != null && db.encryptedPrivKey != null) {
        String encryptedPrivKey = db!.encryptedPrivKey!;
        Uint8List privkey =
            decryptPrivateKey(hexToBytes(encryptedPrivKey), password);
        if (Keychain.getPublicKey(bytesToHex(privkey)) == pubkey) return db;
      }
    }
    return null;
  }

  Future<UserDB?> loginWithPriKey(String privkey) async {
    String pubkey = Keychain.getPublicKey(privkey);
    List<Object?> maps = await DB.sharedInstance
        .objects<UserDB>('userDB', where: 'pubKey = ?', whereArgs: [pubkey]);
    UserDB? db;
    if (maps.isNotEmpty) {
      db = maps.first as UserDB?;
    } else {
      db?.pubKey = pubkey;
      String defaultPassword = generateStrongPassword(16);
      Uint8List enPrivkey =
          encryptPrivateKey(hexToBytes(privkey), defaultPassword);
      db?.encryptedPrivKey = bytesToHex(enPrivkey);
      db?.defaultPassword = defaultPassword;
    }
    return db;
  }

  Future<UserDB> newAccount() async {
    String defaultPassword = generateStrongPassword(16);
    var user = Keychain.generate();
    Uint8List enPrivkey =
        encryptPrivateKey(hexToBytes(user.private), defaultPassword);
    UserDB db = UserDB();
    db.pubKey = user.public;
    db.encryptedPrivKey = bytesToHex(enPrivkey);
    db.defaultPassword = defaultPassword;
    await DB.sharedInstance.update<UserDB>(db);
    return db;
  }

  Future<UserDB> newAccountWithPassword(String password) async {
    var user = Keychain.generate();
    Uint8List enPrivkey = encryptPrivateKey(hexToBytes(user.private), password);
    UserDB db = UserDB();
    db.pubKey = user.public;
    db.encryptedPrivKey = bytesToHex(enPrivkey);
    await DB.sharedInstance.update<UserDB>(db);
    return db;
  }

  Future<UserDB?> updateProfile(String privkey, String nickname, String gender,
      String area, String bio) async {
    String pubkey = Keychain.getPublicKey(privkey);
    List<Object?> maps = await DB.sharedInstance
        .objects<UserDB>('userDB', where: 'pubKey = ?', whereArgs: [pubkey]);
    UserDB? db;
    if (maps.isNotEmpty) {
      db = maps.first as UserDB?;
      if (db != null) {
        db.nickName = nickname;
        db.gender = gender;
        db.area = area;
        db.bio = bio;
        await DB.sharedInstance.update<UserDB>(db);
        return db;
      }
    }
    return null;
  }

  Future<UserDB?> updatePassword(String privkey, String password) async {
    String pubkey = Keychain.getPublicKey(privkey);
    List<Object?> maps = await DB.sharedInstance
        .objects<UserDB>('userDB', where: 'pubKey = ?', whereArgs: [pubkey]);
    UserDB? db;
    if (maps.isNotEmpty) {
      db = maps.first as UserDB?;
      if (db != null) {
        Uint8List enPrivkey = encryptPrivateKey(hexToBytes(privkey), password);
        db.encryptedPrivKey = bytesToHex(enPrivkey);
        db.defaultPassword = "";
        await DB.sharedInstance.update<UserDB>(db);
        return db;
      }
    }
    return null;
  }

  Future logout() async {}
  Future delete() async {}
}
