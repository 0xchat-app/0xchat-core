// SPDX-FileCopyrightText: 2024 0xchat
//
// SPDX-License-Identifier: MIT

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tor/tor.dart';

/// Tor network manager for handling Tor connections
/// Simplified implementation based on Tor examples
class TorNetworkManager {
  static final TorNetworkManager _instance = TorNetworkManager._internal();
  factory TorNetworkManager() => _instance;
  TorNetworkManager._internal();

  bool _isInitialized = false;
  bool _isEnabled = false;

  /// Get singleton instance
  static TorNetworkManager get instance => _instance;

  /// Check if Tor is initialized
  bool get isInitialized => _isInitialized;

  /// Check if Tor is enabled and ready
  bool get isEnabled => _isEnabled && Tor.instance.enabled && Tor.instance.bootstrapped;

  /// Get Tor proxy port
  int get proxyPort => Tor.instance.port;

  /// Initialize Tor service
  Future<void> initialize({bool enabled = false}) async {
    if (_isInitialized) return;

    try {
      await Tor.init(enabled: enabled);
      _isInitialized = true;
      _isEnabled = enabled;

      if (enabled) {
        await enable();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to initialize Tor: $e');
      }
      rethrow;
    }
  }

  /// Enable Tor service
  Future<void> enable() async {
    try {
      await Tor.instance.enable();
      _isEnabled = true;
      
      if (kDebugMode) {
        print('Tor enabled successfully, proxy port: ${Tor.instance.port}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to enable Tor: $e');
      }
      rethrow;
    }
  }

  /// Disable Tor service
  void disable() {
    Tor.instance.disable();
    _isEnabled = false;
    if (kDebugMode) {
      print('Tor disabled');
    }
  }

  /// Stop Tor service completely
  Future<void> stop() async {
    await Tor.instance.stop();
    _isInitialized = false;
    _isEnabled = false;
    if (kDebugMode) {
      print('Tor stopped');
    }
  }

  /// Check if URL should use Tor proxy
  bool shouldUseTor(String url) {
    if (!isEnabled) return false;
    
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    
    // Always use Tor for .onion addresses
    if (uri.host.contains('.onion')) {
      return true;
    }
    
    // For other addresses, check if Tor is enabled globally
    return _isEnabled;
  }

  /// Get proxy configuration for HTTP client
  String? getProxyConfig(String url) {
    if (!shouldUseTor(url)) return null;
    
    return 'SOCKS5 ${InternetAddress.loopbackIPv4.address}:$proxyPort';
  }

  /// Create HTTP client with Tor proxy
  HttpClient createHttpClient() {
    final client = HttpClient();
    
    client.findProxy = (Uri uri) {
      final proxyConfig = getProxyConfig(uri.toString());
      return proxyConfig ?? 'DIRECT';
    };
    
    client.authenticateProxy = (String host, int port, String scheme, String? realm) {
      return Future.value(true);
    };
    
    client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      return true; // Accept all certificates for Tor connections
    };
    
    return client;
  }

  /// Dispose resources
  Future<void> dispose() async {
    await stop();
  }
}
