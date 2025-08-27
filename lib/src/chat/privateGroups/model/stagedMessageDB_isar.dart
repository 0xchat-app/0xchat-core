import 'package:isar/isar.dart' hide Filter;

part 'stagedMessageDB_isar.g.dart';

/// Staged message database model for MLS private groups
/// Stores messages that need to be processed later
@collection
class StagedMessageDBISAR {
  int id = 0;

  @Index(unique: true)
  String eventId; // Primary key - unique event identifier

  String nostrGroupId; // Nostr group identifier
  List<int>? mlsGroupId; // MLS group identifier (byte array)
  List<int> messageBytes; // Raw message bytes that need to be processed
  String senderPubkey; // Sender's public key
  int createTime; // Creation timestamp

  StagedMessageDBISAR({
    required this.eventId,
    required this.nostrGroupId,
    this.mlsGroupId,
    required this.messageBytes,
    required this.senderPubkey,
    required this.createTime,
  });

  /// Create from map
  static StagedMessageDBISAR fromMap(Map<String, Object?> map) {
    return StagedMessageDBISAR(
      eventId: map['eventId'].toString(),
      nostrGroupId: map['nostrGroupId'].toString(),
      mlsGroupId: map['mlsGroupId'] != null 
          ? List<int>.from(map['mlsGroupId'] as List) 
          : null,
      messageBytes: List<int>.from(map['messageBytes'] as List),
      senderPubkey: map['senderPubkey'].toString(),
      createTime: map['createTime'] as int? ?? 0,
    );
  }

  /// Convert to map
  Map<String, Object?> toMap() {
    return {
      'eventId': eventId,
      'nostrGroupId': nostrGroupId,
      'mlsGroupId': mlsGroupId,
      'messageBytes': messageBytes,
      'senderPubkey': senderPubkey,
      'createTime': createTime,
    };
  }
}
