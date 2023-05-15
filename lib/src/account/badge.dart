import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

class Badge {
  static Future<void> syncBadgeInfosFromRelay(List<String> badgeIds) async {}
  static Future<void> syncBadgeInfosToDB(List<BadgeDB> badges) async {}
  static Future<void> getBadgeInfosFromDB(List<String> badgeIds) async {}
  static Future<void> getUserBadgesFromDB(String userPubkey) async {}
  static Future<void> getUserBadgesFromRelay(String userPubkey) async {}
  static Future<void> syncUserBadgesToDB(String userPubkey, List<BadgeDB> badges) async {}
}