/// Bitchat service integration for 0xchat-core
/// Provides high-level interface for bitchat functionality
/// 
/// Usage example:
/// ```dart
/// final bitchatService = BitchatService();
/// 
/// // Set up message callback to convert to MessageDBISAR format
/// bitchatService.setMessageCallback((MessageDBISAR messageDB) {
///   // Handle the converted message
///   print('Received MessageDBISAR: ${messageDB.content}');
///   print('Chat type: ${messageDB.chatType}'); // 5 for channel, 6 for private
///   
///   // Save to database or process further
///   // await DBISAR.sharedInstance.saveToDB(messageDB);
/// });
/// 
/// // Listen to status updates
/// bitchatService.statusStream.listen((status) {
///   print('Status: $status');
/// });
/// 
/// // Listen to peer updates
/// bitchatService.peersStream.listen((peers) {
///   print('Peers: ${peers.length} connected');
/// });
/// 
/// // Initialize and start the service
/// await bitchatService.initialize();
/// 
/// // Start broadcasting (will auto-generate peerID and nickname)
/// await bitchatService.startBroadcasting();
/// 
/// // Or start with custom peerID and nickname
/// await bitchatService.startBroadcasting(
///   peerID: 'my-peer-id',
///   nickname: 'MyNickname'
/// );
/// 
/// // Update nickname later
/// await bitchatService.updateNickname(newNickname: 'NewNickname');
/// 
/// // Get current cached values
/// print('Peer ID: ${bitchatService.cachedPeerID}');
/// print('Nickname: ${bitchatService.cachedNickname}');
/// ```

import 'dart:async';
import 'dart:math';

import 'package:bitchat_core/bitchat_core.dart' as core;
import 'package:chatcore/chat-core.dart';

/// Bitchat service for 0xchat integration
class BitchatService {
  static final BitchatService _instance = BitchatService._internal();
  factory BitchatService() => _instance;
  BitchatService._internal();

  final core.BitchatService _coreService = core.BitchatService();
  final List<core.Peer> _peers = [];
  
  // Cached peer ID and nickname
  String? _cachedPeerID;
  String? _cachedNickname;
  
  // Stream controllers for real-time updates
  final StreamController<List<core.Peer>> _peersController = 
      StreamController<List<core.Peer>>.broadcast();
  final StreamController<String> _statusController = 
      StreamController<String>.broadcast();
  
  // Message callback for converting to MessageDBISAR format
  Function(MessageDBISAR)? _messageCallback;

  /// Get peers stream
  Stream<List<core.Peer>> get peersStream => _peersController.stream;
  
  /// Get status stream
  Stream<String> get statusStream => _statusController.stream;

  /// Set message callback for converting to MessageDBISAR format
  void setMessageCallback(Function(MessageDBISAR) callback) {
    _messageCallback = callback;
  }

  /// Remove message callback
  void removeMessageCallback() {
    _messageCallback = null;
  }

  /// Generate a unique peer ID (4 random bytes as hex string)
  String _generatePeerID() {
    if (_cachedPeerID != null) {
      return _cachedPeerID!;
    }
    
    final random = Random();
    final bytes = List<int>.generate(4, (_) => random.nextInt(256));
    _cachedPeerID = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return _cachedPeerID!;
  }

  /// Get current cached peer ID
  String? get cachedPeerID => _cachedPeerID;

  /// Get current cached nickname
  String? get cachedNickname => _cachedNickname;

  /// Update nickname and restart broadcasting
  /// [newNickname] New nickname to use (optional, will use default if not provided)
  Future<void> updateNickname({String? newNickname}) async {
    try {
      // Update cached nickname
      if (newNickname != null) {
        _cachedNickname = newNickname;
      } else {
        // Generate default nickname using peerID
        final peerID = _generatePeerID();
        _cachedNickname = 'user$peerID';
      }
      
      print('🔄 [0xchat-core] Updating nickname to: $_cachedNickname');
      
      // Stop current broadcasting if running
      if (isRunning) {
        await stop();
        print('⏹️ [0xchat-core] Stopped current broadcasting');
      }
      
      // Start broadcasting with new nickname
      await startBroadcasting(
        peerID: _generatePeerID(),
        nickname: _cachedNickname,
      );
      
      print('✅ [0xchat-core] Nickname updated successfully');
    } catch (e) {
      print('❌ [0xchat-core] Failed to update nickname: $e');
      rethrow;
    }
  }

  /// Convert BitchatMessage to MessageDBISAR format manually
  /// This method can be used to convert messages outside of the automatic callback
  MessageDBISAR? convertToMessageDBISAR(core.BitchatMessage message) {
    return _convertToMessageDBISAR(message);
  }

  /// Initialize bitchat service
  Future<void> initialize() async {
    try {
      _statusController.add('Initializing bitchat service...');
      
      // Initialize core service
      final success = await _coreService.initialize();
      if (!success) {
        throw Exception('Failed to initialize core service');
      }
      
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
  Future<void> startBroadcasting({String? peerID, String? nickname}) async {
    try {
      // Use cached values if not provided
      final finalPeerID = peerID ?? _generatePeerID();
      String finalNickname;
      
      if (nickname != null) {
        finalNickname = nickname;
      } else if (_cachedNickname != null) {
        finalNickname = _cachedNickname!;
      } else {
        // Generate default nickname using peerID
        finalNickname = 'user$finalPeerID';
      }
      
      final success = await _coreService.start(peerID: finalPeerID, nickname: finalNickname);
      if (!success) {
        throw Exception('Failed to start broadcasting');
      }
      
      // Update cached values
      _cachedPeerID = finalPeerID;
      _cachedNickname = finalNickname;
      
      _statusController.add('Started broadcasting identity');
      print('✅ [0xchat-core] Started broadcasting with peerID: $finalPeerID, nickname: $finalNickname');
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
  Future<void> sendPrivateMessage(String recipientID, String content) async {
    try {
      final success = await _coreService.sendPrivateMessage(recipientID, content);
      if (!success) {
        throw Exception('Failed to send private message');
      }
      
      _statusController.add('Sent private message to $recipientID');
    } catch (e) {
      _statusController.add('Failed to send private message: $e');
      rethrow;
    }
  }
  
  /// Send broadcast message to all connected peers (main chat)
  Future<void> sendBroadcastMessage(String content) async {
    try {
      print('📢 [0xchat-core] Sending broadcast message: "$content"');
      
      final success = await _coreService.sendBroadcastMessage(content);
      if (!success) {
        throw Exception('Failed to send broadcast message');
      }
      
      _statusController.add('Sent broadcast message to all peers');
      print('✅ [0xchat-core] Broadcast message sent successfully');
    } catch (e) {
      _statusController.add('Failed to send broadcast message: $e');
      print('❌ [0xchat-core] Failed to send broadcast message: $e');
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

  /// Test method to send different types of messages
  Future<void> testSendMessages() async {
    try {
  
  /// Get all peers
  List<core.Peer> getPeers() {
    return List.unmodifiable(_peers);
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

  /// Handle incoming messages from bitchat core
  void _handleMessageReceived(core.BitchatMessage message) {
    print('✅ [0xchat-core] _handleMessageReceived: ${message.content}');

    try {      
      // Log message type details
      switch (message.type) {
        case core.MessageTypes.message:
          if (message.recipientID != null) {
            print('🔒 [0xchat-core] Private message from ${message.senderNickname}');
          } else if (message.channel != null) {
            print('📢 [0xchat-core] Channel message in ${message.channel} from ${message.senderNickname}');
          } else {
            print('📢 [0xchat-core] Broadcast message from ${message.senderNickname}');
          }
          break;
        case core.MessageTypes.announce:
          print('📢 [0xchat-core] Announce from ${message.senderNickname}');
          break;
        case core.MessageTypes.keyExchange:
          print('🔑 [0xchat-core] Key exchange from ${message.senderID}');
          break;
        case core.MessageTypes.channelJoin:
          print('➕ [0xchat-core] Channel join: ${message.channel} by ${message.senderNickname}');
          break;
        case core.MessageTypes.channelLeave:
          print('➖ [0xchat-core] Channel leave: ${message.channel} by ${message.senderNickname}');
          break;
        default:
          print('❓ [0xchat-core] Unknown message type: ${message.type}');
      }      
      // Convert to MessageDBISAR format and call callback if set
      if (_messageCallback != null) {
        try {
          final messageDB = _convertToMessageDBISAR(message);
          if (messageDB != null) {
            _messageCallback!(messageDB);
          }
        } catch (e) {
          print('❌ [0xchat-core] Error converting to MessageDBISAR: $e');
        }
      }
    } catch (e) {
      print('❌ [0xchat-core] Error handling incoming message: $e');
    }
  }

  /// Convert BitchatMessage to MessageDBISAR format
  MessageDBISAR? _convertToMessageDBISAR(core.BitchatMessage message) {
    try {
      // Determine chat type based on message properties
      int? chatType;
      if (message.recipientID != null) {
        // Private message
        chatType = 6; // ble private chat
      } else if (message.channel != null) {
        // Channel message
        chatType = 5; // ble channel chat
      } else {
        // Broadcast message (main chat)
        chatType = 5; // ble channel chat for broadcast
      }

      // Create MessageDBISAR object
      final messageDB = MessageDBISAR(
        messageId: message.id,
        sender: message.senderID,
        receiver: message.recipientID ?? '', // Empty for broadcast/channel messages
        groupId: message.channel ?? '', // Channel name for channel messages
        sessionId: '', // Not used for bitchat
        kind: message.type,
        tags: '', // Not used for bitchat
        content: message.content,
        createTime: message.timestamp,
        read: false, // Default to unread
        replyId: '', // No reply support in bitchat yet
        decryptContent: message.content, // Same as content for now
        type: 'text', // Default to text type
        status: 1, // Sent status
        plaintEvent: '', // Not used for bitchat
        chatType: chatType,
        subType: null,
        previewData: null,
        expiration: null,
        decryptSecret: null,
        decryptNonce: null,
        decryptAlgo: null,
        reactionEventIds: null,
        zapEventIds: null,
      );

      return messageDB;
    } catch (e) {
      print('❌ [0xchat-core] Error converting BitchatMessage to MessageDBISAR: $e');
      return null;
    }
  }

  void _handleStatusChanged(core.BitchatStatus status) {
    final statusText = status.toString().split('.').last;
    _statusController.add('Service status: $statusText');
  }

  void _handleLogMessage(String logMessage) {
    _statusController.add('Log: $logMessage');
  }
} 