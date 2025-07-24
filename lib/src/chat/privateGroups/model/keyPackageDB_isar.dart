import 'package:isar/isar.dart' hide Filter;
import 'package:nostr_core_dart/nostr.dart';

part 'keyPackageDB_isar.g.dart';

/// KeyPackage type enumeration
enum KeyPackageType {
  oneTime('one_time'),
  permanent('permanent');

  const KeyPackageType(this.value);
  final String value;

  static KeyPackageType fromString(String value) {
    return KeyPackageType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => KeyPackageType.permanent,
    );
  }
}

/// KeyPackage status enumeration
enum KeyPackageStatus {
  available('available'),
  used('used'),
  expired('expired'),
  revoked('revoked');

  const KeyPackageStatus(this.value);
  final String value;

  static KeyPackageStatus fromString(String value) {
    return KeyPackageStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => KeyPackageStatus.available,
    );
  }
}

/// KeyPackage client enumeration
enum KeyPackageClient {
  oxchatLite('0xchat-lite'),
  oxchat('0xchat'),
  unknown('unknown');

  const KeyPackageClient(this.value);
  final String value;

  static KeyPackageClient fromString(String value) {
    return KeyPackageClient.values.firstWhere(
      (client) => client.value == value,
      orElse: () => KeyPackageClient.unknown,
    );
  }
}

/// KeyPackage management table for MLS private groups
/// Supports both one-time and permanent keypackages
@collection
class KeyPackageDBISAR {
  int id = 0;

  @Index(unique: true)
  String keyPackageId; // Unique identifier for this keypackage

  /// Owner of the keypackage (pubkey)
  @Index()
  String ownerPubkey;

  /// Type of keypackage: 'one_time' or 'permanent'
  String type;

  /// Status: 'available', 'used', 'expired', 'revoked'
  String status;

  /// Client identifier
  String client;

  /// Original KeyPackageEvent data
  String encodedKeyPackage;
  String eventId;
  int createTime;
  String mlsProtocolVersion;
  String ciphersuite;
  List<String> extensions;
  List<String> relays;

  /// Usage tracking
  int? usedTime; // When this keypackage was used (for one-time keypackages)
  String? usedByGroupId; // Which group used this keypackage
  String? usedByEventId; // Which event used this keypackage

  /// Metadata
  int lastUpdatedTime;
  String? notes; // Additional notes or metadata

  KeyPackageDBISAR({
    required this.keyPackageId,
    required this.ownerPubkey,
    required this.type,
    required this.status,
    required this.client,
    required this.encodedKeyPackage,
    required this.eventId,
    required this.createTime,
    required this.mlsProtocolVersion,
    required this.ciphersuite,
    required this.extensions,
    required this.relays,
    this.usedTime,
    this.usedByGroupId,
    this.usedByEventId,
    required this.lastUpdatedTime,
    this.notes,
  });

  /// Create from KeyPackageEvent
  factory KeyPackageDBISAR.fromKeyPackageEvent(
    KeyPackageEvent event, {
    KeyPackageType type = KeyPackageType.permanent,
    KeyPackageStatus status = KeyPackageStatus.available,
  }) {
    return KeyPackageDBISAR(
      keyPackageId: event.eventId.isNotEmpty ? event.eventId : _generateKeyPackageId(event),
      ownerPubkey: event.pubkey,
      type: type.value,
      status: status.value,
      client: event.client,
      encodedKeyPackage: event.encoded_key_package,
      eventId: event.eventId,
      createTime: event.createTime,
      mlsProtocolVersion: event.mls_protocol_version,
      ciphersuite: event.ciphersuite,
      extensions: event.extensions,
      relays: event.relays,
      lastUpdatedTime: currentUnixTimestampSeconds(),
    );
  }

  /// Generate unique keypackage ID if eventId is empty
  static String _generateKeyPackageId(KeyPackageEvent event) {
    return '${event.pubkey}_${event.createTime}_${event.client}';
  }

  /// Convert to KeyPackageEvent
  KeyPackageEvent toKeyPackageEvent() {
    return KeyPackageEvent(
      ownerPubkey,
      createTime,
      mlsProtocolVersion,
      ciphersuite,
      extensions,
      relays,
      client,
      encodedKeyPackage,
      eventId,
    );
  }

  /// Mark keypackage as used
  void markAsUsed({String? groupId, String? eventId}) {
    status = KeyPackageStatus.used.value;
    usedTime = currentUnixTimestampSeconds();
    usedByGroupId = groupId;
    usedByEventId = eventId;
    lastUpdatedTime = currentUnixTimestampSeconds();
  }

  /// Mark keypackage as expired
  void markAsExpired() {
    status = KeyPackageStatus.expired.value;
    lastUpdatedTime = currentUnixTimestampSeconds();
  }

  /// Mark keypackage as revoked
  void markAsRevoked() {
    status = KeyPackageStatus.revoked.value;
    lastUpdatedTime = currentUnixTimestampSeconds();
  }

  /// Get keypackage type as enum
  @ignore
  KeyPackageType get keyPackageType => KeyPackageType.fromString(type);

  /// Get keypackage status as enum
  @ignore
  KeyPackageStatus get keyPackageStatus => KeyPackageStatus.fromString(status);

  /// Get keypackage client as enum
  @ignore
  KeyPackageClient get keyPackageClient => KeyPackageClient.fromString(client);

  /// Check if keypackage is available for use
  @ignore
  bool get isAvailable => keyPackageStatus == KeyPackageStatus.available;

  /// Check if keypackage is one-time
  @ignore
  bool get isOneTime => keyPackageType == KeyPackageType.oneTime;

  /// Check if keypackage is permanent
  @ignore
  bool get isPermanent => keyPackageType == KeyPackageType.permanent;

  /// Check if keypackage has been used
  @ignore
  bool get isUsed => keyPackageStatus == KeyPackageStatus.used;

  /// Get display name for keypackage
  @ignore
  String get displayName {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(createTime * 1000);
    final dateStr = '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}';
    return '$type keypackage ($dateStr)';
  }

  /// Convert to JSON for serialization
  Map<String, dynamic> toJson() {
    return {
      'keyPackageId': keyPackageId,
      'ownerPubkey': ownerPubkey,
      'type': type,
      'status': status,
      'client': client,
      'encodedKeyPackage': encodedKeyPackage,
      'eventId': eventId,
      'createTime': createTime,
      'mlsProtocolVersion': mlsProtocolVersion,
      'ciphersuite': ciphersuite,
      'extensions': extensions,
      'relays': relays,
      'usedTime': usedTime,
      'usedByGroupId': usedByGroupId,
      'usedByEventId': usedByEventId,
      'lastUpdatedTime': lastUpdatedTime,
      'notes': notes,
    };
  }

  /// Create from JSON
  factory KeyPackageDBISAR.fromJson(Map<String, dynamic> json) {
    return KeyPackageDBISAR(
      keyPackageId: json['keyPackageId'] ?? '',
      ownerPubkey: json['ownerPubkey'] ?? '',
      type: json['type'] ?? 'permanent',
      status: json['status'] ?? 'available',
      client: json['client'] ?? '',
      encodedKeyPackage: json['encodedKeyPackage'] ?? '',
      eventId: json['eventId'] ?? '',
      createTime: json['createTime'] ?? 0,
      mlsProtocolVersion: json['mlsProtocolVersion'] ?? '',
      ciphersuite: json['ciphersuite'] ?? '',
      extensions: List<String>.from(json['extensions'] ?? []),
      relays: List<String>.from(json['relays'] ?? []),
      usedTime: json['usedTime'],
      usedByGroupId: json['usedByGroupId'],
      usedByEventId: json['usedByEventId'],
      lastUpdatedTime: json['lastUpdatedTime'] ?? 0,
      notes: json['notes'],
    );
  }
} 