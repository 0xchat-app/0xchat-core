import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';
import 'package:convert/convert.dart';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

typedef AccountUpdateCallback = void Function();

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

  // Map<String, UserDB> userCache = {};
  Map<String, ValueNotifier<UserDB>> userCache = {};

  List<String> pQueue = [];

  AccountUpdateCallback? relayListUpdateCallback;
  AccountUpdateCallback? dmRelayListUpdateCallback;
  AccountUpdateCallback? contactListUpdateCallback;
  AccountUpdateCallback? channelListUpdateCallback;
  AccountUpdateCallback? groupListUpdateCallback;
  AccountUpdateCallback? relayGroupListUpdateCallback;

  void startHeartBeat() {
    if (timer == null || timer!.isActive == false) {
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
        await syncProfilesFromRelay();
      });
    }
  }

  Future<void> _loadAllUsers() async {
    List<UserDB?> maps = await DB.sharedInstance.objects<UserDB>();
    for (UserDB? user in maps) {
      if (user != null) {
        userCache[user.pubKey] = ValueNotifier<UserDB>(user);
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
    UserDB? user = userCache[pubkey]?.value;
    if (user != null) {
      _addToPQueue(user);
      return user;
    }

    Completer<UserDB?> completer = Completer();
    getUserFromDB(pubkey: pubkey).then((user) {
      if (user != null) {
        userCache[pubkey] = ValueNotifier<UserDB>(user);
        _addToPQueue(user);
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

  ValueNotifier<UserDB> getUserNotifier(String pubkey) {
    if (userCache.containsKey(pubkey)) return userCache[pubkey]!;
    userCache[pubkey] = ValueNotifier(UserDB(pubKey: pubkey));
    return userCache[pubkey]!;
  }

  void _addToPQueue(UserDB user) {
    if (user.lastUpdatedTime != 0) return;
    final pubkey = user.pubKey;
    if (pubkey.isNotEmpty &&
        !pQueue.contains(pubkey) &&
        isValidPubKey(pubkey)) {
      pQueue.add(pubkey);
    }
  }

  Future<UserDB?> getUserFromDB(
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

  Future<UserDB?> loginWithPubKey(String pubkey) async {
    UserDB? userDB = await getUserFromDB(pubkey: pubkey);
    if (userDB != null) {
      me = userDB;
      currentPubkey = userDB.pubKey;
      currentPrivkey = '';
      userCache[currentPubkey] = ValueNotifier<UserDB>(userDB);
      loginSuccess();
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
          userCache[currentPubkey] = ValueNotifier<UserDB>(db);
          loginSuccess();
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
    userCache[currentPubkey] = ValueNotifier<UserDB>(db);
    loginSuccess();
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

  Future<UserDB?> updatePassword(String password) async {
    UserDB? db = await getUserFromDB(privkey: currentPrivkey);
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

  Future<Map<String, dynamic>> signEvent(Map<String, dynamic> json) async {
    if (json['pubkey'] == null) json['pubkey'] = currentPubkey;
    if (json['id'] == null) {
      var tags = (json['tags'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList();
      json['id'] = Event.processEventId(json['pubkey'], json['created_at'],
          json['kind'], tags, json['content']);
    }
    Event event = await Event.fromJson(json, verify: false);
    if (SignerHelper.needSigner(currentPrivkey)) {
      final pubkey = Account.sharedInstance.currentPubkey;
      event.sig = await SignerHelper.signMessage(event.id, pubkey) ?? '';
    } else {
      event.sig = event.getSignature(currentPrivkey);
    }
    assert(await event.isValid() == true);
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

  static Future<String> getSignatureWithSecret(String secret,
      [String? privkey]) async {
    privkey ??= Account.sharedInstance.currentPrivkey;
    if (SignerHelper.needSigner(privkey)) {
      final pubkey = Account.sharedInstance.currentPubkey;
      return await SignerHelper.signMessage(secret, pubkey) ?? '';
    }
    final hexMessage = hex.encode(
        SHA256Digest().process(Uint8List.fromList(utf8.encode(secret))));
    return Keychain(privkey).sign(hexMessage);
  }
}
