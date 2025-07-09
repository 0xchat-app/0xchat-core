import 'package:chatcore/chat-core.dart';

/// Configuration class for chat core initialization
/// 
/// Contains all the information needed by various subsystems during initialization.
/// Each subsystem extracts only the information it needs from this configuration.
class ChatCoreInitConfig {
  const ChatCoreInitConfig({
    required this.pubkey,
    required this.databasePath,
    required this.encryptionPassword,
    this.circleId,
    this.isLite = false,
    this.circleRelay,
    this.contactUpdatedCallBack,
    this.channelsUpdatedCallBack,
    this.groupsUpdatedCallBack,
    this.relayGroupsUpdatedCallBack,
  });

  // User identity
  final String pubkey;
  final String? circleId;

  // Database configuration
  final String databasePath;
  final String encryptionPassword;

  // Mode configuration
  final bool isLite;
  final String? circleRelay;

  // Callbacks
  final ContactUpdatedCallBack? contactUpdatedCallBack;
  final ChannelsUpdatedCallBack? channelsUpdatedCallBack;
  final GroupsUpdatedCallBack? groupsUpdatedCallBack;
  final GroupsUpdatedCallBack? relayGroupsUpdatedCallBack;

  // Derived properties for MLS
  String get mlsIdentity => circleId != null ? '$pubkey-$circleId' : pubkey;
  String get mlsPath => databasePath; // MLS uses same directory as circle database
} 