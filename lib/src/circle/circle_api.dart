import 'package:chatcore/chat-core.dart';
import 'circle_request.dart';

/// Relay address information model
class RelayAddressInfo {
  RelayAddressInfo({
    required this.tenantId,
    required this.relayUrl,
    required this.baseDomain,
    required this.tenantName,
    required this.subscriptionStatus,
    this.expiresAt,
  });

  final String tenantId;
  final String relayUrl;
  final String baseDomain;
  final String tenantName;
  final String subscriptionStatus;
  final int? expiresAt;

  factory RelayAddressInfo.fromJson(Map<String, dynamic> json) {
    return RelayAddressInfo(
      tenantId: json['tenant_id'] as String,
      relayUrl: json['relay_url'] as String,
      baseDomain: json['base_domain'] as String,
      tenantName: json['tenant_name'] as String,
      subscriptionStatus: json['subscription_status'] as String,
      expiresAt: json['expires_at'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'tenant_id': tenantId,
    'relay_url': relayUrl,
    'base_domain': baseDomain,
    'tenant_name': tenantName,
    'subscription_status': subscriptionStatus,
    'expires_at': expiresAt,
  };
}

/// Join with invitation code result model
class JoinWithInvitationResult {
  JoinWithInvitationResult({
    required this.tenantId,
    required this.memberPubkey,
    required this.role,
    required this.addedVia,
    required this.relayUrl,
  });

  final String tenantId;
  final String memberPubkey;
  final String role;
  final String addedVia;
  final String relayUrl;

  factory JoinWithInvitationResult.fromJson(Map<String, dynamic> json) {
    return JoinWithInvitationResult(
      tenantId: json['tenant_id'] as String,
      memberPubkey: json['member_pubkey'] as String,
      role: json['role'] as String,
      addedVia: json['added_via'] as String,
      relayUrl: json['relay_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'tenant_id': tenantId,
    'member_pubkey': memberPubkey,
    'role': role,
    'added_via': addedVia,
    'relay_url': relayUrl,
  };
}

/// Payment type enum
enum PaymentType {
  appStore('app_store'),
  googlePlay('google_play');

  const PaymentType(this.value);
  final String value;
}

/// Payment verification result model
class PaymentVerificationResult {
  PaymentVerificationResult({
    required this.tenantId,
    required this.relayUrl,
    required this.baseDomain,
    required this.subscriptionStatus,
    this.expiresAt,
  });

  final String tenantId;
  final String relayUrl;
  final String baseDomain;
  final String subscriptionStatus;
  final int? expiresAt;

  factory PaymentVerificationResult.fromJson(Map<String, dynamic> json) {
    return PaymentVerificationResult(
      tenantId: json['tenant_id'] as String,
      relayUrl: json['relay_url'] as String,
      baseDomain: json['base_domain'] as String,
      subscriptionStatus: json['subscription_status'] as String,
      expiresAt: json['expires_at'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'tenant_id': tenantId,
    'relay_url': relayUrl,
    'base_domain': baseDomain,
    'subscription_status': subscriptionStatus,
    'expires_at': expiresAt,
  };
}

/// API client for Circle operations
class CircleApi {
  CircleApi._();

  /// Extract HTTP base URL from WebSocket relay URL
  /// 
  /// Converts ws:// or wss:// URLs to http:// or https:// and removes path
  /// Examples:
  /// - ws://127.0.0.1:3000/tenant_xxx -> http://127.0.0.1:3000
  /// - wss://domain.com/tenant_xxx -> https://domain.com
  static String _extractBaseUrlFromRelay(String relayUrl) {
    try {
      final uri = Uri.parse(relayUrl);
      final scheme = uri.scheme;
      String httpScheme;
      
      if (scheme == 'ws') {
        httpScheme = 'http';
      } else if (scheme == 'wss') {
        httpScheme = 'https';
      } else {
        // If already http/https, use as is
        httpScheme = scheme;
      }
      
      // Reconstruct URL with http/https scheme, host, and port (if any), but no path
      final port = uri.hasPort ? ':${uri.port}' : '';
      return '$httpScheme://${uri.host}$port';
    } catch (e) {
      LogUtils.e(() => 'Error extracting base URL from relay: $e');
      // Fallback: try simple string replacement
      String result = relayUrl;
      result = result.replaceFirst(RegExp(r'^ws://'), 'http://');
      result = result.replaceFirst(RegExp(r'^wss://'), 'https://');
      // Remove path
      final pathIndex = result.indexOf('/', 8); // Skip protocol (http:// or https://)
      if (pathIndex != -1) {
        result = result.substring(0, pathIndex);
      }
      return result;
    }
  }

  /// Get relay addresses for current user
  /// 
  /// Returns a list of relay addresses associated with the current user's pubkey.
  /// Each pubkey can be an admin or member of multiple tenants.
  /// 
  /// [pubkey] User's public key
  /// [privkey] User's private key
  /// [baseUrl] Optional base URL for the API (defaults to http://192.168.0.18:3000)
  /// 
  /// Returns a list of [RelayAddressInfo].
  /// Throws [Exception] if the request fails or pubkey/privkey is invalid.
  static Future<List<RelayAddressInfo>> getRelayAddresses({
    required String pubkey,
    required String privkey,
    String? baseUrl,
  }) async {
    try {
      final result = await CircleRequest.post<List<RelayAddressInfo>>(
        endpoint: '/api/relay-address',
        pubkey: pubkey,
        privkey: privkey,
        baseUrl: baseUrl,
        parseSuccess: (json) {
          final relaysList = json['relays'] as List<dynamic>? ?? [];
          final relays = relaysList
              .map((item) => RelayAddressInfo.fromJson(item as Map<String, dynamic>))
              .toList();
          LogUtils.v(() => 'Successfully fetched ${relays.length} relay addresses');
          return relays;
        },
      );
      return result;
    } catch (e) {
      LogUtils.e(() => 'Error in getRelayAddresses: $e');
      rethrow;
    }
  }

  /// Verify payment and assign relay address
  /// 
  /// This is the ONLY way to create a subscription for first-time purchases.
  /// The webhook will NOT create tenants - must be called actively by the client
  /// to bind the pubkey with payment receipt.
  /// 
  /// [pubkey] User's public key
  /// [privkey] User's private key
  /// [productId] Product ID from App Store or Google Play
  /// [receiptData] Payment receipt (Base64 encoded receipt for Apple, purchase_token for Google)
  /// [paymentType] Payment type (app_store or google_play)
  /// [baseUrl] Optional base URL for the API (defaults to http://192.168.0.18:3000)
  /// 
  /// Returns [PaymentVerificationResult] with tenant and relay information.
  /// Throws [Exception] if the request fails or pubkey/privkey is invalid.
  static Future<PaymentVerificationResult> verifyPayment({
    required String pubkey,
    required String privkey,
    required String productId,
    required String receiptData,
    required PaymentType paymentType,
    String? baseUrl,
  }) async {
    try {
      // Create tags for payment information
      final tags = [
        ['product_id', productId],
        ['receipt', receiptData],
        ['type', paymentType.value],
      ];

      final result = await CircleRequest.post<PaymentVerificationResult>(
        endpoint: '/api/verify-payment',
        pubkey: pubkey,
        privkey: privkey,
        tags: tags,
        baseUrl: baseUrl,
        parseSuccess: (json) {
          final result = PaymentVerificationResult.fromJson(json);
          LogUtils.v(() => 'Payment verified successfully. Tenant ID: ${result.tenantId}, Relay URL: ${result.relayUrl}');
          return result;
        },
      );
      return result;
    } catch (e) {
      LogUtils.e(() => 'Error in verifyPayment: $e');
      rethrow;
    }
  }

  /// Verify Apple App Store payment
  /// 
  /// [pubkey] User's public key
  /// [privkey] User's private key
  /// [productId] Product ID from App Store (e.g., "com.yourapp.subscription.starter.monthly")
  /// [receiptData] Base64 encoded receipt data from App Store
  /// [baseUrl] Optional base URL for the API
  /// 
  /// Returns [PaymentVerificationResult] with tenant and relay information.
  static Future<PaymentVerificationResult> verifyApplePayment({
    required String pubkey,
    required String privkey,
    required String productId,
    required String receiptData,
    String? baseUrl,
  }) async {
    return verifyPayment(
      pubkey: pubkey,
      privkey: privkey,
      productId: productId,
      receiptData: receiptData,
      paymentType: PaymentType.appStore,
      baseUrl: baseUrl,
    );
  }

  /// Verify Google Play payment
  /// 
  /// [pubkey] User's public key
  /// [privkey] User's private key
  /// [productId] Product ID from Google Play (e.g., "starter_monthly")
  /// [purchaseToken] Purchase token from Google Play Billing
  /// [baseUrl] Optional base URL for the API
  /// 
  /// Returns [PaymentVerificationResult] with tenant and relay information.
  static Future<PaymentVerificationResult> verifyGooglePayment({
    required String pubkey,
    required String privkey,
    required String productId,
    required String purchaseToken,
    String? baseUrl,
  }) async {
    return verifyPayment(
      pubkey: pubkey,
      privkey: privkey,
      productId: productId,
      receiptData: purchaseToken,
      paymentType: PaymentType.googlePlay,
      baseUrl: baseUrl,
    );
  }

  /// Join circle using invitation code via HTTP API
  /// 
  /// This allows users to join a tenant using an invitation code without
  /// needing to be connected to the WebSocket relay first.
  /// 
  /// [pubkey] User's public key
  /// [privkey] User's private key
  /// [invitationCode] The invitation code to use
  /// [relayUrl] Optional relay URL (will extract baseUrl from it)
  /// [baseUrl] Optional base URL for the API (if not provided, will extract from relayUrl)
  /// 
  /// Returns [JoinWithInvitationResult] with tenant and member information.
  /// Throws [Exception] if the request fails or pubkey/privkey is invalid.
  static Future<JoinWithInvitationResult> joinWithInvitationCode({
    required String pubkey,
    required String privkey,
    required String invitationCode,
    String? relayUrl,
    String? baseUrl,
  }) async {
    if (invitationCode.isEmpty) {
      throw Exception('Invitation code cannot be empty');
    }

    try {
      // Extract baseUrl from relayUrl if not provided
      String? apiBaseUrl = baseUrl;
      if (apiBaseUrl == null && relayUrl != null && relayUrl.isNotEmpty) {
        apiBaseUrl = _extractBaseUrlFromRelay(relayUrl);
      }

      // Create tags for invitation code
      final tags = [
        ['invitation_code', invitationCode],
      ];

      final result = await CircleRequest.post<JoinWithInvitationResult>(
        endpoint: '/api/join-with-invitation',
        pubkey: pubkey,
        privkey: privkey,
        tags: tags,
        baseUrl: apiBaseUrl,
        parseSuccess: (json) {
          // Handle both success response format (with status/data) and direct data format
          Map<String, dynamic> data;
          if (json.containsKey('status') && json['status'] == 'success') {
            data = json['data'] as Map<String, dynamic>? ?? json;
          } else {
            data = json;
          }
          
          final result = JoinWithInvitationResult.fromJson(data);
          LogUtils.v(() => 'Successfully joined with invitation code. Tenant ID: ${result.tenantId}, Relay URL: ${result.relayUrl}');
          return result;
        },
      );
      return result;
    } catch (e) {
      LogUtils.e(() => 'Error in joinWithInvitationCode: $e');
      rethrow;
    }
  }
}

