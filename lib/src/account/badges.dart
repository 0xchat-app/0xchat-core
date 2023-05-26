import 'dart:convert';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

typedef BadgeInfoCallBack = void Function(BadgeDB?);
typedef GetUserBadgesCallBack = void Function(List<BadgeDB?>?);

class BadgesHelper {
  static BadgeDB badgeToBadgeDB(Badge badge) {
    return BadgeDB(
        id: badge.badgeId,
        d: badge.identifies,
        name: badge.name,
        description: badge.description,
        image: badge.image.url,
        thumb: badge.thumb.url);
  }

  static Future<void> getBadgeInfoFromRelay(
      String creator, String identifies, BadgeInfoCallBack callBack) async {
    String subscriptionId = '';
    Filter f = Filter(kinds: [30009], d: [identifies], authors: [creator]);
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      Badge? badge = Nip58.getBadgeDefinition(event);
      if (badge != null) {
        BadgeDB badgeDB = badgeToBadgeDB(badge);
        syncBadgeInfoToDB(badgeDB);
        callBack(badgeDB);
      } else {
        callBack(null);
      }
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) callBack(null);
    });
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

  static Future<List<BadgeAwardDB?>> getBadgeAwardFromDB(
      String identifies, String creator, String badgeOwner) async {
    List<BadgeAwardDB?> maps = await DB.sharedInstance.objects<BadgeAwardDB>(
        where: 'identifies = ? AND creator = ? AND badgeOwner = ?',
        whereArgs: [identifies, creator, badgeOwner]);
    return maps;
  }

  // return badge award id list
  static Future<List<String>?> getProfileBadgesFromDB(
      String userPubkey, GetUserBadgesCallBack callBack) async {
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null && userDB.badges != null && userDB.badges!.isNotEmpty) {
      return jsonDecode(userDB.badges!);
    }
    return null;
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

  static Future<void> getUserBadgesFromRelay(
      String userPubkey, GetUserBadgesCallBack callBack) async {
    String subscriptionId = '';
    List<BadgeDB> badges = [];
    Filter f = Filter(kinds: [8], p: [userPubkey]);
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      BadgeAward? badgeAward = Nip58.getBadgeAward(event);
      if (badgeAward != null) {
        BadgeAwardDB badgeAwardDB = badgeAwardToBadgeAwardDB(badgeAward);
        // save to DB
        await DB.sharedInstance.update<BadgeAwardDB>(badgeAwardDB);
        getBadgeInfoFromRelay(badgeAward.creator!, badgeAward.identifies!,
            (BadgeDB? badgeDB) {
          if (badgeDB != null) badges.add(badgeDB);
        });
      }
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      callBack(badges);
      syncUserBadgesToDB(userPubkey, badges);
    });
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
        if (map[0] != null) {
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
    Nip58.setProfileBadges(badgeAwards, privkey);
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
        await getBadgeInfoFromRelay(badgeAward.creator!, badgeAward.identifies!,
            (BadgeDB? badgeDB) {
          if (badgeDB != null) result.add(badgeDB);
        });
      }
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      callBack(result);
    });
  }
}
