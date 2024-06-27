import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

extension AccountProfile on Account {
  Future<void> loginSuccess() async {
    reloadMyProfileFromRelay();

    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        reloadMyProfileFromRelay(relay: relay);
      }
    });
  }

  Future<UserDB> reloadMyProfileFromRelay({String? relay}) async {
    Completer<UserDB> completer = Completer<UserDB>();
    Filter f = Filter(
        kinds: [0, 3, 10000, 10002, 10005, 10009, 10050, 30000, 30003, 30008],
        authors: [currentPubkey]);
    List<Event> events = [];
    Connect.sharedInstance
        .addSubscription([f], relays: relay == null ? null : [relay],
            eventCallBack: (event, relay) async {
      events.add(event);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        for (var event in events) {
          switch (event.kind) {
            case 0:
              me = _handleKind0Event(me, event);
              break;
            case 3:
              me = _handleKind3Event(me, event);
              break;
            case 10000:
              me = await _handleKind10000Event(me, event);
              break;
            case 10002:
              me = _handleKind10002Event(me, event);
              break;
            case 10005:
              me = await _handleKind10005Event(me, event);
              break;
            case 10009:
              me = await _handleKind10009Event(me, event);
              break;
            case 10050:
              me = _handleKind10050Event(me, event);
              break;
            case 30000:
              me = await _handleKind30000Event(me, event);
              break;
            case 30003:
              me = await _handleKind30003Event(me, event);
              break;
            case 30008:
              me = _handleKind30008Event(me, event);
              break;
          }
        }
        userCache[currentPubkey] = ValueNotifier<UserDB>(me!);
        syncMe();
        if (!completer.isCompleted) completer.complete(me);
      }
    });
    return completer.future;
  }

  Future<UserDB> reloadProfileFromRelay(String pubkey) async {
    if (!isValidPubKey(pubkey)) return UserDB(pubKey: pubkey);
    Completer<UserDB> completer = Completer<UserDB>();
    UserDB? db = await getUserInfo(pubkey);
    Filter f = Filter(kinds: [0, 10050, 30008], authors: [pubkey]);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      switch (event.kind) {
        case 0:
          db = _handleKind0Event(db, event);
          break;
        case 10050:
          db = _handleKind10050Event(db, event);
          break;
        case 30008:
          db = _handleKind30008Event(db, event);
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        userCache[pubkey] = ValueNotifier<UserDB>(db!);
        if (pubkey == currentPubkey) me = db;
        DB.sharedInstance.update<UserDB>(db!);
        if (!completer.isCompleted) completer.complete(db);
      }
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
      kinds: [0, 10050, 30008],
      authors: pQueue,
    );

    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      UserDB? db = users[event.pubkey];
      if (event.kind == 0) {
        users[event.pubkey] = _handleKind0Event(db, event)!;
      }
      if (event.kind == 10050) {
        users[event.pubkey] = _handleKind10050Event(db, event)!;
      }
      if (event.kind == 30008) {
        users[event.pubkey] = _handleKind30008Event(db, event)!;
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

  // following list
  UserDB? _handleKind3Event(UserDB? db, Event event) {
    if (db != null && db.lastFollowingListUpdatedTime < event.createdAt) {
      db.lastFollowingListUpdatedTime = event.createdAt;
      // following list
      List<Profile> profiles = Nip2.decode(event);
      db.followingList = profiles.map((e) => e.key).toList();
      // relay list
      Map map = jsonDecode(event.content);
      db.relayList ??= [];
      Set<String> relaySet = Set.from(db.relayList!);
      relaySet.addAll(map.keys.map((e) => e.toString()).toList());
      db.relayList = relaySet.toList();
      relayListUpdateCallback?.call();
    }
    return db;
  }

  // mute&block list
  Future<UserDB?> _handleKind10000Event(UserDB? db, Event event) async {
    if (db != null && db.lastBlockListUpdatedTime < event.createdAt) {
      db.lastBlockListUpdatedTime = event.createdAt;
      Lists result = await Nip51.getLists(event, currentPubkey, currentPrivkey);
      Set<String> blockedList = Set.from(db.blockedList ?? []);
      blockedList.addAll(result.people.map((p) => p.pubkey).toList());
      db.blockedList = blockedList.toList();
    }
    return db;
  }

  // relay list
  UserDB? _handleKind10002Event(UserDB? db, Event event) {
    if (db != null && db.lastRelayListUpdatedTime < event.createdAt) {
      db.lastRelayListUpdatedTime = event.createdAt;
      List<Relay> result = Nip65.decode(event);
      db.relayList ??= [];
      Set<String> relaySet = Set.from(db.relayList!);
      relaySet.addAll(result.map((e) => e.url).toList());
      db.relayList = relaySet.toList();
      relayListUpdateCallback?.call();
    }
    return db;
  }

  // channel list
  Future<UserDB?> _handleKind10005Event(UserDB? db, Event event) async {
    if (db != null && db.lastChannelsListUpdatedTime < event.createdAt) {
      db.lastChannelsListUpdatedTime = event.createdAt;
      Lists result = await Nip51.getLists(event, currentPubkey, currentPrivkey);
      db.channelsList = result.bookmarks;
      channelListUpdateCallback?.call();
    }
    return db;
  }

  // relay group list
  Future<UserDB?> _handleKind10009Event(UserDB? db, Event event) async {
    if (db != null && db.lastRelayGroupsListUpdatedTime < event.createdAt) {
      db.lastRelayGroupsListUpdatedTime = event.createdAt;
      Lists result = await Nip51.getLists(event, currentPubkey, currentPrivkey);
      db.relayGroupsList = result.bookmarks;
      relayGroupListUpdateCallback?.call();
    }
    return db;
  }

  // dm relay list
  UserDB? _handleKind10050Event(UserDB? db, Event event) {
    if (db != null && db.lastDMRelayListUpdatedTime < event.createdAt) {
      db.lastDMRelayListUpdatedTime = event.createdAt;
      List<String> relayList = Nip17.decodeDMRelays(event);
      db.dmRelayList = relayList;
      if (db.pubKey == currentPubkey) dmRelayListUpdateCallback?.call();
    }
    return db;
  }

  // contact list
  Future<UserDB?> _handleKind30000Event(UserDB? db, Event event) async {
    if (db == null) return null;
    Lists result = await Nip51.getLists(event, currentPubkey, currentPrivkey);
    if (result.identifier == Contacts.identifier &&
        db.lastFriendsListUpdatedTime < event.createdAt) {
      // contact list
      db.lastFriendsListUpdatedTime = event.createdAt;
      Event e = await Nip51.createCategorizedPeople(Contacts.identifier, [],
          result.people, currentPrivkey, currentPubkey);
      db.friendsList = e.content;
      contactListUpdateCallback?.call();
    }
    return db;
  }

  // bookmark list
  Future<UserDB?> _handleKind30003Event(UserDB? db, Event event) async {
    if (db == null) return null;
    Lists result = await Nip51.getLists(event, currentPubkey, currentPrivkey);
    if (result.identifier == Groups.identifier &&
        db.lastGroupsListUpdatedTime < event.createdAt) {
      // private group list
      db.lastGroupsListUpdatedTime = event.createdAt;
      db.groupsList = result.bookmarks;
      groupListUpdateCallback?.call();
    }
    return db;
  }

  // profile badge
  UserDB? _handleKind30008Event(UserDB? db, Event event) {
    if (db != null && db.lastUpdatedTime < event.createdAt) {
      List<BadgeAward> profileBadges = Nip58.getProfileBadges(event);
      db.badges = jsonEncode(profileBadges.map((e) => e.awardId).toList());
    }
    return db;
  }
}