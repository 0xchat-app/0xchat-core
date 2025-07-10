/// Bitchat service integration for 0xchat-core
/// Provides high-level interface for bitchat functionality

import 'dart:async';

import 'package:bitchat_core/bitchat_core.dart' as core;

/// Bitchat service for 0xchat integration
class BitchatService {
  static final BitchatService _instance = BitchatService._internal();
  factory BitchatService() => _instance;
  BitchatService._internal();

  final core.BitchatService _coreService = core.BitchatService();
  final List<core.BitchatPeer> _peers = [];
  final List<core.BitchatMessageData> _messages = [];
  
  // Stream controllers for real-time updates
  final StreamController<List<core.BitchatPeer>> _peersController = 
      StreamController<List<core.BitchatPeer>>.broadcast();
  final StreamController<core.BitchatMessageData> _messageController = 
      StreamController<core.BitchatMessageData>.broadcast();
  final StreamController<String> _statusController = 
      StreamController<String>.broadcast();

  /// Get peers stream
  Stream<List<core.BitchatPeer>> get peersStream => _peersController.stream;
  
  /// Get messages stream
  Stream<core.BitchatMessageData> get messageStream => _messageController.stream;
  
  /// Get status stream
  Stream<String> get statusStream => _statusController.stream;

  /// Initialize bitchat service
  Future<void> initialize() async {
    try {
      _statusController.add('Initializing bitchat service...');
      
      // Initialize core service
      final success = await _coreService.initialize();
      if (!success) {
        throw Exception('Failed to initialize core service');
      }
      
      // Set up event listeners
      _coreService.messageStream.listen(_handleMessageReceived);
      _coreService.peerStream.listen(_handlePeerDiscovered);
      _coreService.statusStream.listen(_handleStatusChanged);
      _coreService.logStream.listen(_handleLogMessage);
      
      _statusController.add('Bitchat service initialized successfully');
    } catch (e) {
      _statusController.add('Failed to initialize bitchat service: $e');
      rethrow;
    }
  }

  /// Start broadcasting identity
  Future<void> startBroadcasting({required String peerID, String? nickname}) async {
    try {
      final success = await _coreService.start(peerID: peerID, nickname: nickname);
      if (!success) {
        throw Exception('Failed to start broadcasting');
      }
      _statusController.add('Started broadcasting identity');
    } catch (e) {
      _statusController.add('Failed to start broadcasting: $e');
      rethrow;
    }
  }

  /// Send channel message
  Future<void> sendChannelMessage(String channel, String content) async {
    try {
      final success = await _coreService.sendChannelMessage(channel, content);
      if (!success) {
        throw Exception('Failed to send channel message');
      }
      
      // Create local message record
      final message = core.BitchatMessageData(
        id: _generateMessageId(),
        type: core.BitchatMessageType.channelMessage,
        content: content,
        channel: channel,
        timestamp: DateTime.now(),
        senderID: await _getMyPeerId(),
        senderNickname: await _getMyNickname(),
      );
      
      _messages.add(message);
      _messageController.add(message);
      
      _statusController.add('Sent channel message to $channel');
    } catch (e) {
      _statusController.add('Failed to send channel message: $e');
      rethrow;
    }
  }

  /// Send private message
  Future<void> sendPrivateMessage(String recipientId, String content) async {
    try {
      final success = await _coreService.sendPrivateMessage(recipientId, content);
      if (!success) {
        throw Exception('Failed to send private message');
      }
      
      // Create local message record
      final message = core.BitchatMessageData(
        id: _generateMessageId(),
        type: core.BitchatMessageType.privateMessage,
        content: content,
        recipientID: recipientId,
        timestamp: DateTime.now(),
        senderID: await _getMyPeerId(),
        senderNickname: await _getMyNickname(),
      );
      
      _messages.add(message);
      _messageController.add(message);
      
      _statusController.add('Sent private message to $recipientId');
    } catch (e) {
      _statusController.add('Failed to send private message: $e');
      rethrow;
    }
  }

  /// Join channel
  Future<void> joinChannel(String channel) async {
    try {
      final success = await _coreService.joinChannel(channel);
      if (!success) {
        throw Exception('Failed to join channel');
      }
      
      // Create local message record
      final message = core.BitchatMessageData(
        id: _generateMessageId(),
        type: core.BitchatMessageType.channelJoin,
        content: 'Joined channel',
        channel: channel,
        timestamp: DateTime.now(),
        senderID: await _getMyPeerId(),
        senderNickname: await _getMyNickname(),
      );
      
      _messages.add(message);
      _messageController.add(message);
      
      _statusController.add('Joined channel $channel');
    } catch (e) {
      _statusController.add('Failed to join channel: $e');
      rethrow;
    }
  }

  /// Leave channel
  Future<void> leaveChannel(String channel) async {
    try {
      final success = await _coreService.leaveChannel(channel);
      if (!success) {
        throw Exception('Failed to leave channel');
      }
      
      // Create local message record
      final message = core.BitchatMessageData(
        id: _generateMessageId(),
        type: core.BitchatMessageType.channelLeave,
        content: 'Left channel',
        channel: channel,
        timestamp: DateTime.now(),
        senderID: await _getMyPeerId(),
        senderNickname: await _getMyNickname(),
      );
      
      _messages.add(message);
      _messageController.add(message);
      
      _statusController.add('Left channel $channel');
    } catch (e) {
      _statusController.add('Failed to leave channel: $e');
      rethrow;
    }
  }

  /// Get all peers
  List<core.BitchatPeer> getPeers() {
    return List.unmodifiable(_peers);
  }

  /// Get all messages
  List<core.BitchatMessageData> getMessages() {
    return List.unmodifiable(_messages);
  }

  /// Get messages for specific channel
  List<core.BitchatMessageData> getChannelMessages(String channel) {
    return _messages
        .where((msg) => msg.channel == channel && msg.isChannelMessage)
        .toList();
  }

  /// Get private messages with specific peer
  List<core.BitchatMessageData> getPrivateMessages(String peerId) {
    return _messages
        .where((msg) => 
            (msg.recipientID == peerId || msg.senderID == peerId) && 
            msg.isPrivateMessage)
        .toList();
  }

  /// Get service status
  core.BitchatStatus getStatus() {
    return _coreService.status;
  }

  /// Check if service is running
  bool get isRunning => _coreService.isRunning;

  /// Check if service is initialized
  bool get isInitialized => _coreService.isInitialized;

  /// Stop bitchat service
  Future<void> stop() async {
    try {
      await _coreService.stop();
      _statusController.add('Stopped bitchat service');
    } catch (e) {
      _statusController.add('Error stopping bitchat service: $e');
    }
  }

  /// Disconnect and cleanup
  Future<void> dispose() async {
    try {
      await stop();
      await _peersController.close();
      await _messageController.close();
      await _statusController.close();
    } catch (e) {
      print('Error disposing bitchat service: $e');
    }
  }

  // Private helper methods
  void _handlePeerDiscovered(core.Peer peer) {
    // Convert core Peer to BitchatPeer
    final bitchatPeer = core.BitchatPeer(
      id: peer.id,
      nickname: peer.nickname,
      lastSeen: peer.lastSeen,
      isConnected: peer.isConnected,
    );
    
    final existingIndex = _peers.indexWhere((p) => p.id == bitchatPeer.id);
    if (existingIndex >= 0) {
      _peers[existingIndex] = bitchatPeer;
    } else {
      _peers.add(bitchatPeer);
    }
    _peersController.add(List.unmodifiable(_peers));
  }

  void _handleMessageReceived(core.BitchatMessage message) {
    // Convert core BitchatMessage to BitchatMessageData
    final messageData = core.BitchatMessageData(
      id: message.id,
      type: _convertMessageType(message.type),
      content: message.content,
      channel: message.channel,
      recipientID: message.recipientID,
      timestamp: DateTime.fromMillisecondsSinceEpoch(message.timestamp),
      senderID: message.senderID,
      senderNickname: message.senderNickname,
    );
    
    _messages.add(messageData);
    _messageController.add(messageData);
  }

  void _handleStatusChanged(core.BitchatStatus status) {
    final statusText = status.toString().split('.').last;
    _statusController.add('Service status: $statusText');
  }

  void _handleLogMessage(String logMessage) {
    _statusController.add('Log: $logMessage');
  }

  core.BitchatMessageType _convertMessageType(int type) {
    switch (type) {
      case 1: // MessageTypes.channelMessage
        return core.BitchatMessageType.channelMessage;
      case 2: // MessageTypes.privateMessage
        return core.BitchatMessageType.privateMessage;
      case 3: // MessageTypes.channelJoin
        return core.BitchatMessageType.channelJoin;
      case 4: // MessageTypes.channelLeave
        return core.BitchatMessageType.channelLeave;
      default:
        return core.BitchatMessageType.unknown;
    }
  }

  String _generateMessageId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<String> _getMyPeerId() async {
    // TODO: Get from user settings or generate
    return 'peer_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<String> _getMyNickname() async {
    // TODO: Get from user settings
    return 'User_${DateTime.now().millisecondsSinceEpoch % 1000}';
  }
} 