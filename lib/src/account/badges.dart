import 'dart:async';
import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

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

    String subscriptionId = '';
    Filter f = Filter(ids: ids);
    List<BadgeDB> badges = [];
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      Badge? badge = Nip58.getBadgeDefinition(event);
      if (badge != null) {
        BadgeDB badgeDB = _badgeToBadgeDB(badge);
        syncBadgeInfoToDB(badgeDB);
        badges.add(badgeDB);
      }
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      completer.complete(badges);
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

    String subscriptionId = '';
    Filter f = Filter(kinds: [30009], d: [identifies], authors: [creator]);
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      Badge? badge = Nip58.getBadgeDefinition(event);
      if (badge != null) {
        BadgeDB badgeDB = _badgeToBadgeDB(badge);
        syncBadgeInfoToDB(badgeDB);
        completer.complete(badgeDB);
      } else {
        completer.complete(null);
      }
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
    });
    return completer.future;
  }

  static Future<void> syncBadgeInfoToDB(BadgeDB badgeDB) async {
    await DB.sharedInstance.insert<BadgeDB>(badgeDB);
  }

  static Future<List<BadgeDB?>> getBadgeInfosFromDB(
      List<String> badgeIds) async {
    List<BadgeDB?> maps = await DB.sharedInstance
        .objects<BadgeDB>(where: 'id = ?', whereArgs: badgeIds);
    return maps;
  }

  static Future<List<BadgeDB>> searchBadgeInfosFromDB(
      List<BadgeAward> awards) async {
    List<BadgeDB> result = [];
    for (BadgeAward badgeAward in awards) {
      List<BadgeDB?> maps = await DB.sharedInstance.objects<BadgeDB>(
          where: 'creator = ? AND d = ?',
          whereArgs: [badgeAward.creator, badgeAward.identifies]);
      if (maps.first != null) {
        result.add(maps.first!);
      }
    }
    return result;
  }

  /// badge award
  static Future<List<BadgeDB?>?> getUserBadgeAwardsFromRelay(
      String userPubkey) async {
    Completer<List<BadgeDB?>?> completer = Completer<List<BadgeDB?>?>();
    String subscriptionId = '';
    List<BadgeAward> badgeAwards = [];
    Filter f = Filter(kinds: [8], p: [userPubkey]);
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      BadgeAward? badgeAward = Nip58.getBadgeAward(event);
      if (badgeAward != null) {
        badgeAwards.add(badgeAward);
        // cache to DB
        BadgeAwardDB badgeAwardDB = badgeAwardToBadgeAwardDB(badgeAward);
        await DB.sharedInstance.insert<BadgeAwardDB>(badgeAwardDB);
      }
    }, eoseCallBack: (status) async {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      List<BadgeDB> badges = await searchBadgesInfoFromRelay(badgeAwards);
      // cache to DB
      await syncUserBadgesToDB(userPubkey, badges);
      completer.complete(badges);
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

  static Future<List<BadgeDB?>?> getUserBadgesFromDB(String userPubkey) async {
    Completer<List<BadgeDB?>?> completer = Completer<List<BadgeDB?>?>();

    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null &&
        userDB.badgesList != null &&
        userDB.badgesList!.isNotEmpty) {
      List<BadgeDB?> badges = await getBadgeInfosFromDB(userDB.badgesList!);
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
      String userPubkey, List<BadgeDB> badges) async {
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null && badges.isNotEmpty) {
      List<String> badgesList = [];
      for (BadgeDB badgeDB in badges) {
        badgesList.add(badgeDB.id!);
      }
      userDB.badgesList = badgesList;
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
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) async {
        if (ok.status) {
          UserDB? userDB = await Account.getUserFromDB(privkey: privkey);
          userDB!.badges = jsonEncode(badgeIds);
          await DB.sharedInstance.insert<UserDB>(userDB);
        }
        completer.complete(ok);
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
        eventCallBack: (event) async {
      List<BadgeAward> profileBadges = Nip58.getProfileBadges(event);
      for (BadgeAward badgeAward in profileBadges) {
        BadgeDB? badgeDB = await _searchBadgeFromRelay(
            badgeAward.creator!, badgeAward.identifies!);
        if (badgeDB != null) result.add(badgeDB);
        if (profileBadges.last == badgeAward) {
          // todo: sync profile badge to db
          UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
          if(userDB != null){
            userDB.badges = jsonEncode(result.map((e) => e?.id).toList());
            await DB.sharedInstance.insert<UserDB>(userDB);
          }
          completer.complete(result);
        }
      }
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) completer.complete(result);
    });
    return completer.future;
  }
}
