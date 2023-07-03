import 'dart:async';
import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

typedef BadgeAwardsCallBack = void Function(List<BadgeAward?>?);

class BadgesHelper {
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
        completer.complete(badges);
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
          completer.complete(result);
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
        completer.complete(badgeDB);
      } else {
        completer.complete(null);
      }
    });
    return completer.future;
  }

  static Future<void> syncBadgeInfoToDB(BadgeDB badgeDB) async {
    await DB.sharedInstance.insert<BadgeDB>(badgeDB);
  }

  static Future<List<BadgeDB?>> getBadgeInfosFromDB(
      List<String> badgeIds) async {
    List<BadgeDB?> result = [];
    for (var badgeId in badgeIds) {
      List<BadgeDB?> maps = await DB.sharedInstance
          .objects<BadgeDB>(where: 'id = ?', whereArgs: [badgeId]);
      result.add(maps.first);
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
  static Future<List<BadgeAwardDB?>?> getUserBadgeAwardsFromRelay(
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
      if(unRelays.isEmpty){
        for (var badgeAward in badgeAwards) {
          List<BadgeDB> badges = await searchBadgeInfosFromDB([badgeAward]);
          BadgeDB? badgeDB;
          if (badges.isNotEmpty) badgeDB = badges.first;
          badgeDB ??= await _searchBadgeFromRelay(
              badgeAward.creator!, badgeAward.identifies!);
          if (badgeDB != null) {
            // save to DB
            BadgeAwardDB badgeAwardDB = badgeAwardToBadgeAwardDB(badgeAward);
            badgeAwardDB.badgeId = badgeDB.id;
            badgeAwardsDB.add(badgeAwardDB);
            await DB.sharedInstance.insert<BadgeAwardDB>(badgeAwardDB);
          }
        }
        // cache to DB
        await syncUserBadgesToDB(
            userPubkey, badgeAwardsDB.map((e) => e.badgeId!).toList());
        completer.complete(badgeAwardsDB);
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
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null && userDB.badges != null && userDB.badges!.isNotEmpty) {
      return jsonDecode(userDB.badges!);
    }
    return null;
  }

  static Future<void> syncProfileBadgesToDB(
      String userPubkey, List<String> profileBadges) async {
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null && profileBadges.isNotEmpty) {
      userDB.badges = jsonEncode(profileBadges);
      await DB.sharedInstance.insert<UserDB>(userDB);
    }
  }

  static Future<List<BadgeAwardDB?>?> getUserBadgesFromDB(
      String userPubkey) async {
    Completer<List<BadgeAwardDB?>?> completer =
        Completer<List<BadgeAwardDB?>?>();

    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null &&
        userDB.badgesList != null &&
        userDB.badgesList!.isNotEmpty) {
      List<BadgeAwardDB?> badges =
          await getBadgeAwardInfosFromDB(userDB.badgesList!, userPubkey);
      completer.complete(badges);
    } else {
      completer.complete(null);
    }
    return completer.future;
  }

  static BadgeAwardDB badgeAwardToBadgeAwardDB(BadgeAward award) {
    return BadgeAwardDB(
        awardId: award.awardId,
        awardTime: award.awardTime,
        identifies: award.identifies,
        creator: award.creator,
        relay: award.relay,
        badgeOwner: award.users != null ? award.users![0].pubkey : '');
  }

  static Future<void> syncUserBadgesToDB(
      String userPubkey, List<String> badges) async {
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null && badges.isNotEmpty) {
      userDB.badgesList = badges;
      await DB.sharedInstance.insert<UserDB>(userDB);
    }
  }

  static Future<OKEvent> setProfileBadges(
      List<String> badgeIds, String pubkey, String privkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    List<BadgeDB?> badges = await getBadgeInfosFromDB(badgeIds);
    List<BadgeAward> badgeAwards = [];
    for (BadgeDB? badgeDB in badges) {
      if (badgeDB != null) {
        List<BadgeAwardDB?> map =
            await getBadgeAwardFromDB(badgeDB.d!, badgeDB.creator!, pubkey);
        if (map.isNotEmpty && map[0] != null) {
          BadgeAwardDB? db = map[0];
          BadgeAward badgeAward = BadgeAward(
              db!.awardId!,
              db.awardTime,
              db.identifies,
              db.creator,
              [People(db.badgeOwner!, null, null, null)]);
          badgeAwards.add(badgeAward);
        }
      }
    }
    if (badgeAwards.isNotEmpty) {
      Event event = Nip58.setProfileBadges(badgeAwards, privkey);
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay, unRelays) async {
        if (unRelays.isEmpty) {
          UserDB? userDB = await Account.getUserFromDB(privkey: privkey);
          userDB!.badges = jsonEncode(badgeIds);
          await DB.sharedInstance.insert<UserDB>(userDB);
          completer.complete(ok);
        }
      });

      /// SYNC TO DB
      syncProfileBadgesToDB(pubkey, badgeIds);
    }
    return completer.future;
  }

  static Future<List<BadgeDB?>?> getProfileBadgesFromRelay(
      String userPubkey) async {
    Completer<List<BadgeDB?>?> completer = Completer<List<BadgeDB?>?>();
    String subscriptionId = '';
    List<BadgeDB?> result = [];
    Filter f =
        Filter(kinds: [30008], d: ['profile_badges'], authors: [userPubkey]);
    subscriptionId = Connect.sharedInstance.addSubscription([f],
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
          UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
          if (userDB != null) {
            userDB.badges = jsonEncode(result.map((e) => e?.id).toList());
            await DB.sharedInstance.insert<UserDB>(userDB);
          }
          completer.complete(result);
        }
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if(unRelays.isEmpty) completer.complete(result);
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
            UserDB? userDB = await Account.getUserFromDB(pubkey: p.pubkey);
            String badgeId = badges[0].id!;
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
