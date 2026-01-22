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
}

