import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

extension AccountProfile on Account {
  Future<UserDB> reloadProfileFromRelay(String pubkey) async {
    if (!isValidPubKey(pubkey)) return UserDB(pubKey: pubkey);
    Completer<UserDB> completer = Completer<UserDB>();
    UserDB? db = await getUserInfo(pubkey);
    Filter f = Filter(kinds: [0, 10050], authors: [pubkey]);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (event.kind == 10050) db = _handleKind10050Event(db, event);
      if (event.kind == 0) db = _handleKind0Event(db, event);
      userCache[pubkey] = ValueNotifier<UserDB>(db!);
      if (pubkey == currentPubkey) me = db;
      DB.sharedInstance.update<UserDB>(db!);
      if (!completer.isCompleted) completer.complete(db);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
    });
    return completer.future;
  }

  /// sync profile from relays
  Future<void> syncProfilesFromRelay() async {
    if (pQueue.isEmpty) return;
    Completer<void> completer = Completer<void>();

    Map<String, UserDB> users = {};
    // init users from cache & DB
    List<String> pQueueTemp = List.from(pQueue);
    for (var key in pQueueTemp) {
      UserDB? db = userCache[key]?.value;
      db ??= await getUserFromDB(pubkey: key);
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
      kinds: [0, 10050],
      authors: pQueue,
    );
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      UserDB? db = users[event.pubkey];
      if (event.kind == 10050) {
        users[event.pubkey] = _handleKind10050Event(db, event)!;
      }
      if (event.kind == 0) {
        users[event.pubkey] = _handleKind0Event(db, event)!;
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        for (var db in users.values) {
          await DB.sharedInstance.insert<UserDB>(db);
          UserDB? user = await getUserFromDB(pubkey: db.pubKey);
          userCache[db.pubKey]?.value = user!;
          pQueue.remove(db.pubKey);
        }
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<UserDB?> updateProfile(UserDB updateDB) async {
    Completer<UserDB?> completer = Completer<UserDB?>();

    UserDB db = await getUserFromDB(pubkey: currentPubkey) ?? UserDB();
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

  UserDB? _handleKind0Event(UserDB? db, Event event) {
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
    return db;
  }

  UserDB? _handleKind10050Event(UserDB? db, Event event) {
    List<String> relayList = Nip17.decodeDMRelays(event);
    db?.relayList = relayList;
    return db;
  }
}
