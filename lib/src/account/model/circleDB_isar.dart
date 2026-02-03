import 'package:isar/isar.dart' hide Filter;

part 'circleDB_isar.g.dart';

/// Tenant status enum
enum TenantStatus {
  active,
  expired,
  notfound,
}

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
  String? tenantId;
  String? tenantAdminPubkey;
  int? expiresAt; // Unix timestamp in seconds
  int? maxMembers;
  int? currentMembers;
  String? subscriptionStatus;
  String? tenantName;
  String? status; // Tenant status: "active", "expired", "notfound"

  /// Convert status string to TenantStatus enum
  /// Returns null if status is null or invalid
  @ignore
  TenantStatus? get statusEnum {
    if (status == null) return null;
    switch (status!.toLowerCase()) {
      case 'active':
        return TenantStatus.active;
      case 'expired':
        return TenantStatus.expired;
      case 'notfound':
        return TenantStatus.notfound;
      default:
        return null;
    }
  }

  // Member info (for paid circles only)
  List<String> memberPubkeys; // Only store pubkey list, display names retrieved from UserDBISAR

  // S3 configuration (stored as JSON string)
  String? s3ConfigJson;

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
    this.tenantId,
    this.tenantAdminPubkey,
    this.expiresAt,
    this.maxMembers,
    this.currentMembers,
    this.subscriptionStatus,
    this.tenantName,
    this.status,
    this.memberPubkeys = const [],
    this.s3ConfigJson,
  });
}