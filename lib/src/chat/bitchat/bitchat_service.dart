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
  final List<core.Peer> _peers = [];
  final List<core.BitchatMessage> _messages = [];
  
  // Stream controllers for real-time updates
  final StreamController<List<core.Peer>> _peersController = 
      StreamController<List<core.Peer>>.broadcast();
  final StreamController<core.BitchatMessage> _messageController = 
      StreamController<core.BitchatMessage>.broadcast();
  final StreamController<String> _statusController = 
      StreamController<String>.broadcast();

  /// Get peers stream
  Stream<List<core.Peer>> get peersStream => _peersController.stream;
  
  /// Get messages stream
  Stream<core.BitchatMessage> get messageStream => _messageController.stream;
  
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
      
      _statusController.add('Left channel $channel');
    } catch (e) {
      _statusController.add('Failed to leave channel: $e');
      rethrow;
    }
  }

  /// Get all peers
  List<core.Peer> getPeers() {
    return List.unmodifiable(_peers);
  }

  /// Get all messages
  List<core.BitchatMessage> getMessages() {
    return List.unmodifiable(_messages);
  }

  /// Get messages for specific channel
  List<core.BitchatMessage> getChannelMessages(String channel) {
    return _messages
        .where((msg) => msg.channel == channel && msg.type == core.MessageTypes.message)
        .toList();
  }

  /// Get private messages with specific peer
  List<core.BitchatMessage> getPrivateMessages(String peerId) {
    return _messages
        .where((msg) => 
            (msg.recipientID == peerId || msg.senderID == peerId) && 
            msg.type == core.MessageTypes.message)
        .toList();
  }

  /// Get service status
  core.BitchatStatus getStatus() {
    return _coreService.status;
  }

  /// Check if service is running
  bool get isRunning => _coreService.status == core.BitchatStatus.running;

  /// Check if service is initialized
  bool get isInitialized => _coreService.status != core.BitchatStatus.stopped;

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
    final existingIndex = _peers.indexWhere((p) => p.id == peer.id);
    if (existingIndex >= 0) {
      _peers[existingIndex] = peer;
    } else {
      _peers.add(peer);
    }
    _peersController.add(List.unmodifiable(_peers));
  }

  void _handleMessageReceived(core.BitchatMessage message) {
    _messages.add(message);
    _messageController.add(message);
  }

  void _handleStatusChanged(core.BitchatStatus status) {
    final statusText = status.toString().split('.').last;
    _statusController.add('Service status: $statusText');
  }

  void _handleLogMessage(String logMessage) {
    _statusController.add('Log: $logMessage');
  }
} 