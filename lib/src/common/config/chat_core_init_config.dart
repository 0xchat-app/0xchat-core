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
    this.circleConnectCallback,
    this.contactUpdatedCallBack,
    this.channelsUpdatedCallBack,
    this.groupsUpdatedCallBack,
    this.relayGroupsUpdatedCallBack,
    this.allowSendNotification = false,
    this.allowReceiveNotification = false,
    this.pushServerRelay = '',
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
  final Function(bool isConnected)? circleConnectCallback;

  // Callbacks
  final ContactUpdatedCallBack? contactUpdatedCallBack;
  final ChannelsUpdatedCallBack? channelsUpdatedCallBack;
  final GroupsUpdatedCallBack? groupsUpdatedCallBack;
  final GroupsUpdatedCallBack? relayGroupsUpdatedCallBack;

  // Notification configuration
  final bool allowSendNotification;
  final bool allowReceiveNotification;
  final String pushServerRelay;

  // Derived properties for MLS
  String get mlsIdentity => circleId != null ? '$pubkey-$circleId' : pubkey;
  String get mlsPath => databasePath; // MLS uses same directory as circle database
} 