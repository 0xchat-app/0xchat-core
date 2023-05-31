import 'dart:async';
import 'dart:convert';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

typedef SearchBadgeInfoCallBack = void Function(BadgeDB?);
typedef GetBadgesInfoCallBack = void Function(List<BadgeDB>);
typedef GetUserBadgesCallBack = void Function(List<BadgeDB?>?);

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

  static Future<void> getBadgesInfoFromRelay(
      List<String> ids, GetBadgesInfoCallBack callBack) async {
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
      callBack(badges);
    });
  }

  static Future<void> searchBadgesInfoFromRelay(
      List<BadgeAward> awards, GetBadgesInfoCallBack callBack) async {
    List<BadgeDB> result = [];
    for (BadgeAward award in awards) {
      _searchBadgeFromRelay(award.creator!, award.identifies!,
          (BadgeDB? badgeDB) {
        if (badgeDB != null) {
          result.add(badgeDB);
          if (awards.last == award) {
            callBack(result);
          }
        }
      });
    }
  }

  static Future<void> _searchBadgeFromRelay(String creator, String identifies,
      SearchBadgeInfoCallBack callBack) async {
    String subscriptionId = '';
    Filter f = Filter(kinds: [30009], d: [identifies], authors: [creator]);
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      Badge? badge = Nip58.getBadgeDefinition(event);
      if (badge != null) {
        BadgeDB badgeDB = _badgeToBadgeDB(badge);
        syncBadgeInfoToDB(badgeDB);
        callBack(badgeDB);
      } else {
        callBack(null);
      }
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
    });
  }

  static Future<void> syncBadgeInfoToDB(BadgeDB badgeDB) async {
    await DB.sharedInstance.update<BadgeDB>(badgeDB);
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
  static Future<void> getUserBadgeAwardsFromRelay(
      String userPubkey, GetUserBadgesCallBack callBack) async {
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
        await DB.sharedInstance.update<BadgeAwardDB>(badgeAwardDB);
      }
    }, eoseCallBack: (status) async {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      searchBadgesInfoFromRelay(badgeAwards, (badges) {
        // cache to DB
        syncUserBadgesToDB(userPubkey, badges);
        callBack(badges);
      });
    });
  }

  static Future<List<BadgeAwardDB?>> getBadgeAwardFromDB(
      String identifies, String creator, String badgeOwner) async {
    List<BadgeAwardDB?> maps = await DB.sharedInstance.objects<BadgeAwardDB>(
        where: 'identifies = ? AND creator = ? AND badgeOwner = ?',
        whereArgs: [identifies, creator, badgeOwner]);
    return maps;
  }

  // return badge id list
  static Future<List<String>?> getProfileBadgesFromDB(
      String userPubkey, GetUserBadgesCallBack callBack) async {
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null && userDB.badges != null && userDB.badges!.isNotEmpty) {
      return jsonDecode(userDB.badges!);
    }
    return null;
  }

  static Future<void> syncProfileBadgesToDB(
      String userPubkey, List<String> profileBadges) async {
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null) {
      userDB.badges = jsonEncode(profileBadges);
      await DB.sharedInstance.update<UserDB>(userDB);
    }
  }

  static Future<void> getUserBadgesFromDB(
      String userPubkey, GetUserBadgesCallBack callBack) async {
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null &&
        userDB.badgesList != null &&
        userDB.badgesList!.isNotEmpty) {
      List<String> badgesList = jsonDecode(userDB.badgesList!);
      List<BadgeDB?> badges = await getBadgeInfosFromDB(badgesList);
      callBack(badges);
    } else {
      callBack(null);
    }
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
      userDB.badgesList = jsonEncode(badgesList);
      await DB.sharedInstance.update<UserDB>(userDB);
    }
  }

  static Future<void> setProfileBadges(
      List<String> badgeIds, String pubkey, String privkey) async {
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
      Connect.sharedInstance.sendEvent(event);
      /// SYNC TO DB
      syncProfileBadgesToDB(pubkey, badgeIds);
    }
  }

  static Future<void> getProfileBadgesFromRelay(
      String userPubkey, GetUserBadgesCallBack callBack) async {
    String subscriptionId = '';
    List<BadgeDB?> result = [];
    Filter f =
        Filter(kinds: [30008], d: ['profile_badges'], authors: [userPubkey]);
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      List<BadgeAward> profileBadges = Nip58.getProfileBadges(event);
      for (BadgeAward badgeAward in profileBadges) {
        _searchBadgeFromRelay(badgeAward.creator!, badgeAward.identifies!,
            (BadgeDB? badgeDB) {
          if (badgeDB != null) result.add(badgeDB);
          if (profileBadges.last == badgeAward) {
            callBack(result);
          }
        });
      }
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      callBack(result);
    });
  }
}
