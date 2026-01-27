import 'package:isar/isar.dart' hide Filter;

part 'circleDB_isar.g.dart';

@collection
class CircleDBISAR  {
  int id = 0;

  @Index(unique: true)
  String circleId;

  String name;
  String description;
  String image; 
  List<String> relayList;
  List<String> fileserverList;
  List<String> iceserverList;
  List<String> pushserverList;
  String? groupId;

  // Subscription info (for paid circles only)
  String? tenantAdminPubkey;
  int? expiresAt; // Unix timestamp in seconds
  int? maxMembers;
  int? currentMembers;
  String? subscriptionStatus;
  String? tenantName;

  // Member info (for paid circles only)
  List<String> memberPubkeys; // Only store pubkey list, display names retrieved from UserDBISAR

  CircleDBISAR({
    required this.circleId,
    this.name = '',
    this.description = '',
    this.image = '',
    this.relayList = const [],
    this.fileserverList = const [],
    this.iceserverList = const [],
    this.pushserverList = const [],
    this.groupId,
    this.tenantAdminPubkey,
    this.expiresAt,
    this.maxMembers,
    this.currentMembers,
    this.subscriptionStatus,
    this.tenantName,
    this.memberPubkeys = const [],
  });
}