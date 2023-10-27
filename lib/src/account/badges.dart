import 'dart:async';
import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef BadgeAwardsCallBack = void Function(List<BadgeAward?>?);

class BadgesHelper {
  /// singleton
  BadgesHelper._internal();
  factory BadgesHelper() => sharedInstance;
  static final BadgesHelper sharedInstance = BadgesHelper._internal();

  String badgeSubscription = '';
  final String serverPubkey =
      '093dff31a87bbf838c54fd39ff755e72b38bd6b7975c670c0f2633fa7c54ddd0';

  Map<String, BadgeDB> badgeInfos = {};
  Map<String, BadgeDB> chatBadges = {};

  Future<void> init() async {
    await _loadChatBadges();
    _updateSubscriptions();
    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        _updateSubscriptions(relay: relay);
      }
    });
  }

  void _updateSubscriptions({String? relay}) {
    if (badgeSubscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(badgeSubscription, relay: relay);
    }

    Map<String, List<Filter>> subscriptions = {};

    if (relay == null) {
      for (String relayURL in Connect.sharedInstance.relays()) {
        int commonMessageUntil =
            Relays.sharedInstance.getCommonMessageUntil(relayURL);
        Filter f = Filter(
            kinds: [8], authors: [serverPubkey], since: commonMessageUntil);

        subscriptions[relayURL] = [f];
      }
    } else {
      int commonMessageUntil =
          Relays.sharedInstance.getCommonMessageUntil(relay);
      Filter f = Filter(
          kinds: [8], authors: [serverPubkey], since: commonMessageUntil);
      subscriptions[relay] = [f];
    }

    badgeSubscription = Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
      Relays.sharedInstance.setCommonMessageUntil(event.createdAt, relay);
      BadgeAward? badgeAward = Nip58.getBadgeAward(event);
      if (badgeAward != null) {
        BadgeDB? badgeDB = _get0xchatBadgeInfo(badgeAward.identifies);
        if (badgeDB != null) {
          // save to DB
          BadgeAwardDB badgeAwardDB = badgeAwardToBadgeAwardDB(badgeAward);
          badgeAwardDB.badgeId = badgeDB.id;
          await DB.sharedInstance.insert<BadgeAwardDB>(badgeAwardDB,
              conflictAlgorithm: ConflictAlgorithm.ignore);
          // cache to user DB
          await _addUserBadgeToDB(badgeAwardDB.badgeOwner, badgeDB.id);
        }
      }
    });
  }

  BadgeDB? _get0xchatBadgeInfo(String? d) {
    return chatBadges[d];
  }

  Future<void> _loadChatBadges() async {
    String jsonString =
        '{\"code\":\"000000\",\"message\":\"Success\",\"data\":[{\"identifies\":\"aa330e14a58c5ada40ee0cea7f4c3121\",\"badgeId\":\"00003f2b93a5a3888fff0d251d270ca82f757a0d5efd556070a036ca8be8e820\",\"badgeName\":\"Egg\",\"badgeImageUrl\":\"https://www.0xchat.com/ipfs/QmWvaqDS5m35577sXZDae7m6fEU6SidznSwdbWndAEmUPe\",\"thumbUrl\":\"https://www.0xchat.com/ipfs/QmXgDVHfUcK5dXeQDKyX7R4DggTTkL9snEc61SXMqSNy4e\",\"creator\":\"0xchat\",\"description\":\"Earn the 0xchat Egg badge with cumulative donations of 2.1k sats. Your humble beginning sets the stage for a journey of a thousand miles.\",\"benefits\":[\"4-digit 0xchat DNS\"],\"benefitsIcon\":[\"https://www.0xchat.com/ipfs/QmU1CAcYjoVJq1DeeN66Yn4T2WSH8n1e1piHJ9BbQ1giyK\"],\"creatorAbout\":\"0xchat is a decentralized chatting app built on Nostr protocol. It prioritizes privacy with features like private key login, encrypted private chats and contacts, coupled with an open communication platform through public channels.\",\"howToGet\":\"Cumulative donations of 2.1k sats\"},{\"identifies\":\"fafec3cd6d8c04ad424ca82ed54e9afb\",\"badgeId\":\"00000f0951248ace7d69be0ed136a069f1d1021443b03e81ffbabda4e53bda9e\",\"badgeName\":\"Hatchling\",\"badgeImageUrl\":\"https://www.0xchat.com/ipfs/QmUTQT3djB92u4UEBtcjup7dhRhPAsGc3uLeEhRcforuDH\",\"thumbUrl\":\"https://www.0xchat.com/ipfs/QmTchyNpgxC4gFZ2P3UEHDKBwMrta9WV8Xp9uy4rwdyWNC\",\"creator\":\"0xchat\",\"description\":\"Garner the 0xchat Hatchling badge with cumulative donations of 4.2k sats. Your continued support hatches new opportunities and fosters breakthroughs.\",\"benefits\":[\"4-digit 0xchat DNS\"],\"benefitsIcon\":[\"https://www.0xchat.com/ipfs/QmU1CAcYjoVJq1DeeN66Yn4T2WSH8n1e1piHJ9BbQ1giyK\"],\"creatorAbout\":\"0xchat is a decentralized chatting app built on Nostr protocol. It prioritizes privacy with features like private key login, encrypted private chats and contacts, coupled with an open communication platform through public channels.\",\"howToGet\":\"Cumulative donations of 4.2k sats\"},{\"identifies\":\"115e7ac9cb28ccc172b9fde8b5ef4a50\",\"badgeId\":\"00002295d1ef76eee9a8d8d04cb2009483acedb452814e040a949555210f928e\",\"badgeName\":\"Chick\",\"badgeImageUrl\":\"https://www.0xchat.com/ipfs/QmaosfucQmDWt7hHnb1qgcgN8xREzwnHzYu9ysVeBweE4p\",\"thumbUrl\":\"https://www.0xchat.com/ipfs/QmWoyYV1DxK1A89M89YMSNSVgj2MgxipTL1ZASLyMJ7a8w\",\"creator\":\"0xchat\",\"description\":\"Attain the 0xchat Chick badge with cumulative donations of 21k sats. Like a chick learning to walk, your contributions enable steady progress.\",\"benefits\":[\"3-digit 0xchat DNS\"],\"benefitsIcon\":[\"https://www.0xchat.com/ipfs/QmU1CAcYjoVJq1DeeN66Yn4T2WSH8n1e1piHJ9BbQ1giyK\"],\"creatorAbout\":\"0xchat is a decentralized chatting app built on Nostr protocol. It prioritizes privacy with features like private key login, encrypted private chats and contacts, coupled with an open communication platform through public channels.\",\"howToGet\":\"Cumulative donations of 21k sats\"},{\"identifies\":\"8aeb9c5cd440dadbdeb6daa4fd97b763\",\"badgeId\":\"00001e93260c429660e39abd7cec733f9f3d9278bb7b2bbd8a3fff98d94a02bb\",\"badgeName\":\"Adolescent\",\"badgeImageUrl\":\"https://www.0xchat.com/ipfs/QmU5SUQu3dGrPE4jibkBYuXsE1YLjRJuFUPv894dkqDaVr\",\"thumbUrl\":\"https://www.0xchat.com/ipfs/QmXaP3fPLLtXS5a9iZrXgAvLmpjtY7FjdLj4VXRhKTgVCE\",\"creator\":\"0xchat\",\"description\":\"Acquire the 0xchat Adolescent badge with cumulative donations of 42k sats. Your speedy commitment propels us towards our mission.\",\"benefits\":[\"3-digit 0xchat DNS\"],\"benefitsIcon\":[\"https://www.0xchat.com/ipfs/QmU1CAcYjoVJq1DeeN66Yn4T2WSH8n1e1piHJ9BbQ1giyK\"],\"creatorAbout\":\"0xchat is a decentralized chatting app built on Nostr protocol. It prioritizes privacy with features like private key login, encrypted private chats and contacts, coupled with an open communication platform through public channels.\",\"howToGet\":\"Cumulative donations of 42k sats\"},{\"identifies\":\"ceba4defe16e22c5ca2d9bedcaec430e\",\"badgeId\":\"00000f7a835198691c5cd6f024fdfcf2ab82ef147160bf966ba5706271baa003\",\"badgeName\":\"Mature\",\"badgeImageUrl\":\"https://www.0xchat.com/ipfs/QmNuPsPojLxiBbPVEwYGCi8BqYQEkTemD9QLT4wWaBUP2u\",\"thumbUrl\":\"https://www.0xchat.com/ipfs/QmcKPMr6JX1ewUJzX6vPWPsuE9zDPg1ZiXhecryi57Tcgt\",\"creator\":\"0xchat\",\"description\":\"Receive the 0xchat Mature badge with cumulative donations of 210k sats. Your significant support, like a full-grown ostrich, matures into incredible growth.\",\"benefits\":[\"2-digit 0xchat DNS\"],\"benefitsIcon\":[\"https://www.0xchat.com/ipfs/QmU1CAcYjoVJq1DeeN66Yn4T2WSH8n1e1piHJ9BbQ1giyK\"],\"creatorAbout\":\"0xchat is a decentralized chatting app built on Nostr protocol. It prioritizes privacy with features like private key login, encrypted private chats and contacts, coupled with an open communication platform through public channels.\",\"howToGet\":\"Cumulative donations of 210k sats\"},{\"identifies\":\"1882297acefba82b14317c7c8e8fe28d\",\"badgeId\":\"000001a0ec0e7908caed173a82f68e93f8d791f7a045da0bf622c7bee0b72dee\",\"badgeName\":\"Geeky\",\"badgeImageUrl\":\"https://www.0xchat.com/ipfs/QmVKujbWMQCN6LfW2MvMo6B6XPrPAoA1nuwPf5YiCJeiuB\",\"thumbUrl\":\"https://www.0xchat.com/ipfs/Qme4TT55HCUbrx6SAZd9uwt5uotzekxFfmYJBNVhvFGEgN\",\"creator\":\"0xchat\",\"description\":\"Obtain the 0xchat Geeky badge with cumulative donations of 420k sats. You are not just a superhero, but a geeky one, powering innovation across our work.\",\"benefits\":[\"2-digit 0xchat DNS\"],\"benefitsIcon\":[\"https://www.0xchat.com/ipfs/QmU1CAcYjoVJq1DeeN66Yn4T2WSH8n1e1piHJ9BbQ1giyK\"],\"creatorAbout\":\"0xchat is a decentralized chatting app built on Nostr protocol. It prioritizes privacy with features like private key login, encrypted private chats and contacts, coupled with an open communication platform through public channels.\",\"howToGet\":\"Cumulative donations of 420k sats\"}]}';
    final List datas = json.decode(jsonString)['data'];
    for (var data in datas) {
      BadgeDB badgeDB = BadgeDB(
          id: data['badgeId'],
          name: data['badgeName'],
          description: data['description'],
          image: data['badgeImageUrl'],
          thumb: data['thumbUrl'],
          creator: serverPubkey,
          d: data['identifies']);
      chatBadges[badgeDB.d] = badgeDB;
      badgeInfos[badgeDB.id] = badgeDB;
      DB.sharedInstance.insert<BadgeDB>(badgeDB,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  static BadgeDB _badgeToBadgeDB(Badge badge) {
    return BadgeDB(
        id: badge.badgeId,
        d: badge.identifies,
        name: badge.name,
        description: badge.description,
        image: badge.image.url,
        thumb: badge.thumb.url,
        creator: badge.creator,
        createTime: badge.createTime);
  }

  static Future<List<BadgeDB>> getBadgesInfoFromRelay(List<String> ids) async {
    Completer<List<BadgeDB>> completer = Completer<List<BadgeDB>>();

    Filter f = Filter(ids: ids);
    List<BadgeDB> badges = [];
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      Badge? badge = Nip58.getBadgeDefinition(event);
      if (badge != null) {
        BadgeDB badgeDB = _badgeToBadgeDB(badge);
        badges.add(badgeDB);
        syncBadgeInfoToDB(badgeDB);
      }
    }, eoseCallBack: (requestId, status, relay, unRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(badges);
      }
    });
    return completer.future;
  }

  static Future<List<BadgeDB>> searchBadgesInfoFromRelay(
      List<BadgeAward> awards) async {
    Completer<List<BadgeDB>> completer = Completer<List<BadgeDB>>();

    List<BadgeDB> result = [];
    for (BadgeAward award in awards) {
      BadgeDB? badgeDB =
          await _searchBadgeFromRelay(award.creator!, award.identifies!);
      if (badgeDB != null) {
        result.add(badgeDB);
        if (awards.last == award) {
          if (!completer.isCompleted) completer.complete(result);
        }
      }
    }
    return completer.future;
  }

  static Future<BadgeDB?> _searchBadgeFromRelay(
      String creator, String identifies) async {
    Completer<BadgeDB?> completer = Completer<BadgeDB?>();

    Filter f = Filter(kinds: [30009], d: [identifies], authors: [creator]);
    Badge? badge;
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      badge = Nip58.getBadgeDefinition(event);
    }, eoseCallBack: (requestId, status, relay, unRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty && badge != null) {
        BadgeDB badgeDB = _badgeToBadgeDB(badge!);
        syncBadgeInfoToDB(badgeDB);
        if (!completer.isCompleted) completer.complete(badgeDB);
      } else {
        if (!completer.isCompleted) completer.complete(null);
      }
    });
    return completer.future;
  }

  static Future<void> syncBadgeInfoToDB(BadgeDB badgeDB) async {
    await DB.sharedInstance.insert<BadgeDB>(badgeDB);
    BadgesHelper.sharedInstance.badgeInfos[badgeDB.id] = badgeDB;
  }

  static Future<List<BadgeDB?>> getBadgeInfosFromDB(
      List<String> badgeIds) async {
    List<BadgeDB?> result = [];
    for (var badgeId in badgeIds) {
      if (BadgesHelper.sharedInstance.badgeInfos.containsKey(badgeId)) {
        result.add(BadgesHelper.sharedInstance.badgeInfos[badgeId]);
      } else {
        List<BadgeDB?> maps = await DB.sharedInstance
            .objects<BadgeDB>(where: 'id = ?', whereArgs: [badgeId]);
        if (maps.isNotEmpty) {
          BadgeDB badgeDB = maps.first!;
          BadgesHelper.sharedInstance.badgeInfos[badgeId] = badgeDB;
          result.add(badgeDB);
        }
      }
    }
    return result;
  }

  static Future<List<BadgeAwardDB?>> getBadgeAwardInfosFromDB(
      List<String> badgeIds, String owner) async {
    List<BadgeAwardDB?> result = [];
    for (var badgeId in badgeIds) {
      List<BadgeAwardDB?> maps = await DB.sharedInstance.objects<BadgeAwardDB>(
          where: 'badgeId = ? AND badgeOwner = ?', whereArgs: [badgeId, owner]);
      if (maps.isNotEmpty) result.add(maps.first);
    }
    return result;
  }

  static Future<List<BadgeDB>> searchBadgeInfosFromDB(
      List<BadgeAward> awards) async {
    List<BadgeDB> result = [];
    for (BadgeAward badgeAward in awards) {
      List<BadgeDB?> maps = await DB.sharedInstance.objects<BadgeDB>(
          where: 'creator = ? AND d = ?',
          whereArgs: [badgeAward.creator, badgeAward.identifies]);
      if (maps.isNotEmpty) {
        result.add(maps.first!);
      }
    }
    return result;
  }

  /// badge award
  Future<List<BadgeAwardDB?>?> getUserBadgeAwardsFromRelay(
      String userPubkey) async {
    Completer<List<BadgeAwardDB?>?> completer =
        Completer<List<BadgeAwardDB?>?>();
    List<BadgeAward> badgeAwards = [];
    List<BadgeAwardDB> badgeAwardsDB = [];

    Filter f = Filter(kinds: [8], p: [userPubkey]);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      BadgeAward? badgeAward = Nip58.getBadgeAward(event);
      if (badgeAward != null) {
        badgeAwards.add(badgeAward);
      }
    }, eoseCallBack: (requestId, status, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        for (var badgeAward in badgeAwards) {
          BadgeDB? badgeDB = _get0xchatBadgeInfo(badgeAward.identifies);
          if (badgeDB != null) {
            // save to DB
            BadgeAwardDB badgeAwardDB = badgeAwardToBadgeAwardDB(badgeAward);
            badgeAwardDB.badgeId = badgeDB.id;
            await DB.sharedInstance.insert<BadgeAwardDB>(badgeAwardDB,
                conflictAlgorithm: ConflictAlgorithm.ignore);
            badgeAwardsDB.add(badgeAwardDB);
          }
        }
        // cache to DB
        await syncUserBadgesToDB(
            userPubkey, badgeAwardsDB.map((e) => e.badgeId).toList());
        if (!completer.isCompleted) completer.complete(badgeAwardsDB);
      }
    });
    return completer.future;
  }

  static Future<List<BadgeAwardDB?>> getBadgeAwardFromDB(
      String identifies, String creator, String badgeOwner) async {
    List<BadgeAwardDB?> maps = await DB.sharedInstance.objects<BadgeAwardDB>(
        where: 'identifies = ? AND creator = ? AND badgeOwner = ?',
        whereArgs: [identifies, creator, badgeOwner]);
    return maps;
  }

  // return badge id list
  static Future<List<String>?> getProfileBadgesFromDB(String userPubkey) async {
    UserDB? userDB = await Account.sharedInstance.getUserInfo(userPubkey);
    if (userDB != null && userDB.badges != null && userDB.badges!.isNotEmpty) {
      return jsonDecode(userDB.badges!);
    }
    return null;
  }

  static Future<void> syncProfileBadgesToDB(
      String userPubkey, List<String> profileBadges) async {
    UserDB? userDB = await Account.sharedInstance.getUserInfo(userPubkey);
    if (userDB != null && profileBadges.isNotEmpty) {
      userDB.badges = jsonEncode(profileBadges);
      await DB.sharedInstance.update<UserDB>(userDB);
    }
  }

  static Future<List<BadgeAwardDB?>?> getUserBadgesFromDB(
      String userPubkey) async {
    UserDB? userDB = await Account.sharedInstance.getUserInfo(userPubkey);
    if (userDB != null &&
        userDB.badgesList != null &&
        userDB.badgesList!.isNotEmpty) {
      return await getBadgeAwardInfosFromDB(userDB.badgesList!, userPubkey);
    } else {
      return null;
    }
  }

  static BadgeAwardDB badgeAwardToBadgeAwardDB(BadgeAward award) {
    return BadgeAwardDB(
        awardId: award.awardId,
        awardTime: award.awardTime ?? 0,
        identifies: award.identifies ?? '',
        creator: award.creator ?? '',
        relay: award.relay ?? '',
        badgeOwner: award.users != null ? award.users![0].pubkey : '');
  }

  static Future<void> syncUserBadgesToDB(
      String userPubkey, List<String> badges) async {
    UserDB? userDB = await Account.sharedInstance.getUserInfo(userPubkey);
    if (userDB != null && badges.isNotEmpty) {
      userDB.badgesList = badges;
      await DB.sharedInstance.insert<UserDB>(userDB);
    }
  }

  static Future<void> _addUserBadgeToDB(
      String userPubkey, String addBadge) async {
    UserDB? userDB = await Account.sharedInstance.getUserInfo(userPubkey);
    if (userDB != null && addBadge.isNotEmpty) {
      if (userDB.badgesList != null && !userDB.badgesList!.contains(addBadge)) {
        userDB.badgesList!.add(addBadge);
        await DB.sharedInstance.insert<UserDB>(userDB);
      } else if (userDB.badgesList == null) {
        userDB.badgesList = [addBadge];
        await DB.sharedInstance.insert<UserDB>(userDB);
      }
    }
  }

  static Future<OKEvent> setProfileBadges(List<String> badgeIds) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    List<BadgeDB?> badges = await getBadgeInfosFromDB(badgeIds);
    List<BadgeAward> badgeAwards = [];
    for (BadgeDB? badgeDB in badges) {
      if (badgeDB != null) {
        List<BadgeAwardDB?> map = await getBadgeAwardFromDB(
            badgeDB.d, badgeDB.creator, Account.sharedInstance.currentPubkey);
        if (map.isNotEmpty && map[0] != null) {
          BadgeAwardDB? db = map[0];
          BadgeAward badgeAward = BadgeAward(
              db!.awardId,
              db.awardTime,
              db.identifies,
              db.creator,
              [People(db.badgeOwner, null, null, null)]);
          badgeAwards.add(badgeAward);
        }
      }
    }
    if (badgeAwards.isNotEmpty) {
      Event event = Nip58.setProfileBadges(
          badgeAwards, Account.sharedInstance.currentPrivkey);
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
        if (ok.status) {
          UserDB? userDB = Account.sharedInstance.me;
          userDB!.badges = jsonEncode(badgeIds);
          await DB.sharedInstance.insert<UserDB>(userDB);
        }
        if (!completer.isCompleted) completer.complete(ok);
      });

      /// SYNC TO DB
      syncProfileBadgesToDB(Account.sharedInstance.currentPubkey, badgeIds);
    }
    return completer.future;
  }

  static Future<List<BadgeDB?>?> getProfileBadgesFromRelay(
      String userPubkey) async {
    Completer<List<BadgeDB?>?> completer = Completer<List<BadgeDB?>?>();
    List<BadgeDB?> result = [];
    Filter f =
        Filter(kinds: [30008], d: ['profile_badges'], authors: [userPubkey]);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      List<BadgeAward> profileBadges = Nip58.getProfileBadges(event);
      for (BadgeAward badgeAward in profileBadges) {
        List<BadgeDB> badges = await searchBadgeInfosFromDB([badgeAward]);
        BadgeDB? badgeDB;
        if (badges.isNotEmpty) badgeDB = badges.first;
        badgeDB ??= await _searchBadgeFromRelay(
            badgeAward.creator!, badgeAward.identifies!);
        if (badgeDB != null) {
          // save to DB
          BadgeAwardDB badgeAwardDB = badgeAwardToBadgeAwardDB(badgeAward);
          badgeAwardDB.badgeId = badgeDB.id;
          await DB.sharedInstance.insert<BadgeAwardDB>(badgeAwardDB);
          result.add(badgeDB);
        }
        if (profileBadges.last == badgeAward) {
          UserDB? userDB = await Account.sharedInstance.getUserInfo(userPubkey);
          if (userDB != null) {
            userDB.badges = jsonEncode(result.map((e) => e?.id).toList());
            await DB.sharedInstance.insert<UserDB>(userDB);
          }
          if (!completer.isCompleted) completer.complete(result);
        }
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  /// subscript Chat Badge Awards
  static void subscriptChatBadgeAwards(
      int since, String serverPubkey, BadgeAwardsCallBack? callBack) async {
    Filter f = Filter(kinds: [8], authors: [serverPubkey], since: since);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      BadgeAward? badgeAward = Nip58.getBadgeAward(event);
      if (badgeAward != null) {
        // cache to DB
        BadgeAwardDB badgeAwardDB = badgeAwardToBadgeAwardDB(badgeAward);
        await DB.sharedInstance.insert<BadgeAwardDB>(badgeAwardDB);
        List<BadgeDB> badges = await searchBadgeInfosFromDB([badgeAward]);
        if (badges.isEmpty) {
          badges = await searchBadgesInfoFromRelay([badgeAward]);
        }
        if (badges.isNotEmpty) {
          for (var p in badgeAward.users!) {
            UserDB? userDB = await Account.sharedInstance.getUserInfo(p.pubkey);
            String badgeId = badges[0].id;
            if (userDB != null && !userDB.badgesList!.contains(badgeId)) {
              userDB.badgesList!.add(badgeId);
              await DB.sharedInstance.insert<UserDB>(userDB);
            }
          }
          if (callBack != null) callBack([badgeAward]);
        }
      }
    }, eoseCallBack: (requestId, status, relay, unRelays) async {});
  }
}
