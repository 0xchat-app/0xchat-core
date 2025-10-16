// SPDX-FileCopyrightText: 2024 0xchat
//
// SPDX-License-Identifier: MIT

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tor/socks_socket.dart';
import 'package:tor/tor.dart';

/// Tor WebSocket connection manager
/// Simplified implementation based on Tor examples
class TorWebSocketManager {
  static final TorWebSocketManager _instance = TorWebSocketManager._internal();
  factory TorWebSocketManager() => _instance;
  TorWebSocketManager._internal();

  /// Get singleton instance
  static TorWebSocketManager get instance => _instance;

  /// Create WebSocket connection through Tor proxy
  Future<TorWebSocket> connectThroughTor(String url, {Map<String, dynamic>? headers}) async {
    final uri = Uri.parse(url);
    final isSecure = uri.scheme == 'wss';
    
    // Create SOCKS socket using Tor.instance.port
    final socksSocket = await SOCKSSocket.create(
      proxyHost: InternetAddress.loopbackIPv4.address,
      proxyPort: Tor.instance.port,
      sslEnabled: isSecure,
    );

    try {
      // Connect to SOCKS proxy
      await socksSocket.connect();
      
      // Connect to target through SOCKS proxy
      await socksSocket.connectTo(uri.host, uri.port);
      
      // Create WebSocket from SOCKS socket
      return TorWebSocket._create(socksSocket, uri, headers);
    } catch (e) {
      await socksSocket.close();
      rethrow;
    }
  }
}

/// Custom WebSocket implementation that works through Tor SOCKS proxy
class TorWebSocket {
  final SOCKSSocket _socksSocket;
  
  StreamController<dynamic>? _streamController;
  StreamSubscription<List<int>>? _subscription;
  bool _isClosed = false;

  TorWebSocket._(this._socksSocket);

  static Future<TorWebSocket> _create(
    SOCKSSocket socksSocket,
    Uri uri,
    Map<String, dynamic>? headers,
  ) async {
    final ws = TorWebSocket._(socksSocket);
    await ws._initialize();
    return ws;
  }

  Future<void> _initialize() async {
    _streamController = StreamController<dynamic>.broadcast();
    
    // Listen to incoming data from SOCKS socket
    _subscription = _socksSocket.inputStream.listen(
      (data) {
        if (!_isClosed) {
          try {
            // Parse WebSocket frame and emit data
            final message = _parseWebSocketFrame(data);
            if (message != null) {
              _streamController?.add(message);
            }
          } catch (e) {
            if (kDebugMode) {
              print('Error parsing WebSocket frame: $e');
            }
          }
        }
      },
      onError: (error) {
        if (!_isClosed) {
          _streamController?.addError(error);
        }
      },
      onDone: () {
        if (!_isClosed) {
          _streamController?.close();
        }
      },
    );
  }

  /// Parse WebSocket frame from raw data
  String? _parseWebSocketFrame(List<int> data) {
    if (data.length < 2) return null;
    
    // Simple WebSocket frame parsing
    final opcode = data[0] & 0x0F;
    final masked = (data[1] & 0x80) != 0;
    
    if (opcode == 0x1) { // Text frame
      int payloadLength = data[1] & 0x7F;
      int maskStart = 2;
      
      if (payloadLength == 126) {
        payloadLength = (data[2] << 8) | data[3];
        maskStart = 4;
      } else if (payloadLength == 127) {
        // 64-bit length not supported in this simple implementation
        return null;
      }
      
      if (masked) {
        final mask = data.sublist(maskStart, maskStart + 4);
        final payload = data.sublist(maskStart + 4, maskStart + 4 + payloadLength);
        
        // Unmask payload
        for (int i = 0; i < payload.length; i++) {
          payload[i] ^= mask[i % 4];
        }
        
        return String.fromCharCodes(payload);
      } else {
        final payload = data.sublist(maskStart, maskStart + payloadLength);
        return String.fromCharCodes(payload);
      }
    }
    
    return null;
  }

  /// Send data through WebSocket
  void add(dynamic data) {
    if (_isClosed) return;
    
    final String message = data.toString();
    final frame = _createWebSocketFrame(message);
    _socksSocket.write(frame);
  }

  /// Create WebSocket frame
  List<int> _createWebSocketFrame(String message) {
    final data = message.codeUnits;
    final length = data.length;
    
    List<int> frame = [];
    
    // FIN + opcode (text frame)
    frame.add(0x81);
    
    // Payload length
    if (length < 126) {
      frame.add(length);
    } else if (length < 65536) {
      frame.add(126);
      frame.add((length >> 8) & 0xFF);
      frame.add(length & 0xFF);
    } else {
      frame.add(127);
      // 64-bit length (simplified)
      for (int i = 7; i >= 0; i--) {
        frame.add((length >> (i * 8)) & 0xFF);
      }
    }
    
    // Payload
    frame.addAll(data);
    
    return frame;
  }

  /// Stream of incoming messages
  Stream<dynamic> get stream => _streamController?.stream ?? Stream.empty();

  /// Close WebSocket connection
  Future<void> close([int? code, String? reason]) async {
    if (_isClosed) return;
    
    _isClosed = true;
    
    // Send close frame
    final closeFrame = _createCloseFrame(code ?? 1000, reason ?? '');
    _socksSocket.write(closeFrame);
    
    // Close SOCKS connection
    await _socksSocket.close();
    
    // Close stream controller
    await _streamController?.close();
    await _subscription?.cancel();
  }

  /// Create close frame
  List<int> _createCloseFrame(int code, String reason) {
    List<int> frame = [];
    
    // FIN + opcode (close frame)
    frame.add(0x88);
    
    // Payload length
    final payloadLength = 2 + reason.length;
    if (payloadLength < 126) {
      frame.add(payloadLength);
    } else {
      frame.add(126);
      frame.add((payloadLength >> 8) & 0xFF);
      frame.add(payloadLength & 0xFF);
    }
    
    // Close code
    frame.add((code >> 8) & 0xFF);
    frame.add(code & 0xFF);
    
    // Reason
    frame.addAll(reason.codeUnits);
    
    return frame;
  }

  /// Check if connection is closed
  bool get isClosed => _isClosed;

  /// Listen to incoming messages
  StreamSubscription<dynamic> listen(
    void Function(dynamic data)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _streamController?.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    ) ?? Stream.empty().listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}