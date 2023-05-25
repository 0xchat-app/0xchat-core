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
      }
      callBack(null);
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

  static Future<void> getUserBadgesFromDB(
      String userPubkey, GetUserBadgesCallBack callBack) async {
    UserDB? userDB = await Account.getUserFromDB(pubkey: userPubkey);
    if (userDB != null && userDB.badgesList != null) {
      List<String> badgesList = jsonDecode(userDB.badgesList!);
      List<BadgeDB?> badges = await getBadgeInfosFromDB(badgesList);
      callBack(badges);
    } else {
      callBack(null);
    }
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
}
