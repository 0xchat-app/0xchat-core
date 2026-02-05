import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'circle_request.dart';

/// S3 configuration model
class S3Config {
  S3Config({
    required this.bucket,
    required this.region,
    required this.accessKeyId,
    required this.secretAccessKey,
    this.endpointUrl,
    this.pathPrefix,
    this.sessionToken,
    this.expiration,
  });

  final String bucket;
  final String region;
  final String accessKeyId;
  final String secretAccessKey;
  final String? endpointUrl;
  final String? pathPrefix;
  
  /// AWS Session Token (for temporary credentials from STS)
  /// If null, credentials are permanent
  final String? sessionToken;
  
  /// Credential expiration timestamp (Unix seconds)
  /// If null, credentials don't expire (permanent)
  final int? expiration;

  factory S3Config.fromJson(Map<String, dynamic> json) {
    // Handle both old format (flat) and new format (with credentials object)
    String accessKeyId;
    String secretAccessKey;
    String? sessionToken;
    int? expiration;
    
    if (json['credentials'] != null) {
      // New format with credentials object
      final creds = json['credentials'] as Map<String, dynamic>;
      accessKeyId = creds['access_key_id'] as String;
      secretAccessKey = creds['secret_access_key'] as String;
      sessionToken = creds['session_token'] as String?;
      expiration = creds['expiration'] as int?;
    } else {
      // Old format (flat) - backward compatibility
      accessKeyId = json['access_key_id'] as String;
      secretAccessKey = json['secret_access_key'] as String;
      sessionToken = json['session_token'] as String?;
      expiration = json['expiration'] as int?;
    }
    
    return S3Config(
      bucket: json['bucket'] as String,
      region: json['region'] as String,
      accessKeyId: accessKeyId,
      secretAccessKey: secretAccessKey,
      endpointUrl: json['endpoint_url'] as String?,
      pathPrefix: json['path_prefix'] as String?,
      sessionToken: sessionToken,
      expiration: expiration,
    );
  }

  Map<String, dynamic> toJson() => {
    'bucket': bucket,
    'region': region,
    'access_key_id': accessKeyId,
    'secret_access_key': secretAccessKey,
    if (endpointUrl != null) 'endpoint_url': endpointUrl,
    if (pathPrefix != null) 'path_prefix': pathPrefix,
    if (sessionToken != null) 'session_token': sessionToken,
    if (expiration != null) 'expiration': expiration,
  };
}

/// Relay address information model
class RelayAddressInfo {
  RelayAddressInfo({
    required this.tenantId,
    required this.relayUrl,
    required this.baseDomain,
    required this.tenantName,
    required this.subscriptionStatus,
    required this.status,
    this.expiresAt,
  });

  final String tenantId;
  final String relayUrl;
  final String baseDomain;
  final String tenantName;
  final String subscriptionStatus;
  final String status;
  final int? expiresAt;

  factory RelayAddressInfo.fromJson(Map<String, dynamic> json) {
    return RelayAddressInfo(
      tenantId: json['tenant_id'] as String,
      relayUrl: json['relay_url'] as String,
      baseDomain: json['base_domain'] as String,
      tenantName: json['tenant_name'] as String,
      subscriptionStatus: json['subscription_status'] as String,
      status: json['status'] as String? ?? 'active', // Default to 'active' for backward compatibility
      expiresAt: json['expires_at'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'tenant_id': tenantId,
    'relay_url': relayUrl,
    'base_domain': baseDomain,
    'tenant_name': tenantName,
    'subscription_status': subscriptionStatus,
    'status': status,
    if (expiresAt != null) 'expires_at': expiresAt,
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

/// Delete tenant files result model
class DeleteTenantFilesResult {
  DeleteTenantFilesResult({
    required this.tenantId,
    required this.deletedCount,
    required this.totalCount,
  });

  final String tenantId;
  final int deletedCount;
  final int totalCount;

  factory DeleteTenantFilesResult.fromJson(Map<String, dynamic> json) {
    return DeleteTenantFilesResult(
      tenantId: json['tenant_id'] as String,
      deletedCount: json['deleted_count'] as int,
      totalCount: json['total_count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'tenant_id': tenantId,
    'deleted_count': deletedCount,
    'total_count': totalCount,
  };
}

/// Tenant member model
class TenantMember {
  TenantMember({
    required this.pubkey,
    required this.role,
    this.displayName,
  });

  final String pubkey;
  final String role;
  final String? displayName;

  factory TenantMember.fromJson(Map<String, dynamic> json) {
    return TenantMember(
      pubkey: json['pubkey'] as String,
      role: json['role'] as String,
      displayName: json['display_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'pubkey': pubkey,
    'role': role,
    if (displayName != null) 'display_name': displayName,
  };
}

/// Tenant information model
class TenantInfo {
  TenantInfo({
    required this.tenantId,
    required this.name,
    required this.maxMembers,
    required this.currentMembers,
    this.expiresAt,
    required this.tenantAdminPubkey,
    required this.status,
    required this.members,
  });

  final String tenantId;
  final String name;
  final int maxMembers;
  final int currentMembers;
  final int? expiresAt;
  final String tenantAdminPubkey;
  final String status;
  final List<TenantMember> members;

  factory TenantInfo.fromJson(Map<String, dynamic> json) {
    final membersList = json['members'] as List<dynamic>? ?? [];
    return TenantInfo(
      tenantId: json['tenant_id'] as String,
      name: json['name'] as String,
      maxMembers: json['max_members'] as int,
      currentMembers: json['current_members'] as int,
      expiresAt: json['expires_at'] as int?,
      tenantAdminPubkey: json['tenant_admin_pubkey'] as String,
      status: json['status'] as String,
      members: membersList
          .map((m) => TenantMember.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'tenant_id': tenantId,
    'name': name,
    'max_members': maxMembers,
    'current_members': currentMembers,
    if (expiresAt != null) 'expires_at': expiresAt,
    'tenant_admin_pubkey': tenantAdminPubkey,
    'status': status,
    'members': members.map((m) => m.toJson()).toList(),
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
  static String extractBaseUrlFromRelay(String relayUrl) {
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
  /// [baseUrl] Optional base URL for the API (defaults to Config.sharedInstance.privateRelayApiBaseUrl)
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

  /// Get S3 temporary credentials for a tenant
  /// 
  /// Uses STS AssumeRole to generate temporary credentials for secure S3 access.
  /// Credentials default to 1 hour expiration, max 12 hours.
  /// 
  /// [pubkey] User's public key
  /// [privkey] User's private key
  /// [tenantId] Tenant ID
  /// [durationSeconds] Optional credential duration in seconds (default: 3600, max: 43200)
  /// [baseUrl] Optional base URL for the API (defaults to Config.sharedInstance.privateRelayApiBaseUrl)
  /// 
  /// Returns [S3Config] with temporary credentials (including sessionToken and expiration).
  /// Throws [Exception] if the request fails, user is not a tenant member, or STS is not configured.
  static Future<S3Config> getS3Credentials({
    required String pubkey,
    required String privkey,
    required String tenantId,
    int? durationSeconds,
    String? baseUrl,
  }) async {
    try {
      // Build content JSON if durationSeconds is provided
      String content = '';
      if (durationSeconds != null) {
        content = jsonEncode({'duration_seconds': durationSeconds});
      }

      final result = await CircleRequest.post<S3Config>(
        endpoint: '/api/s3',
        pubkey: pubkey,
        privkey: privkey,
        baseUrl: baseUrl,
        tags: [
          ['tenant_id', tenantId],
        ],
        content: content,
        parseSuccess: (json) {
          if (json['success'] == true && json['data'] != null) {
            final s3Config = S3Config.fromJson(json['data'] as Map<String, dynamic>);
            LogUtils.v(() => 'Successfully fetched S3 credentials for tenant $tenantId');
            return s3Config;
          } else {
            final error = json['error'] as String? ?? 'Unknown error';
            throw Exception('Failed to get S3 credentials: $error');
          }
        },
      );
      return result;
    } catch (e) {
      LogUtils.e(() => 'Error in getS3Credentials: $e');
      rethrow;
    }
  }

  /// Delete tenant files from S3 storage
  /// 
  /// Deletes all files for the specified tenant in S3 storage.
  /// This operation is irreversible and requires system admin or tenant admin permissions.
  /// 
  /// [pubkey] User's public key
  /// [privkey] User's private key
  /// [tenantId] Tenant ID
  /// [baseUrl] Optional base URL for the API (defaults to Config.sharedInstance.privateRelayApiBaseUrl)
  /// 
  /// Returns [DeleteTenantFilesResult] with deletion statistics.
  /// Throws [Exception] if the request fails, user lacks permissions, or tenant not found.
  static Future<DeleteTenantFilesResult> deleteTenantFiles({
    required String pubkey,
    required String privkey,
    required String tenantId,
    String? baseUrl,
  }) async {
    try {
      final result = await CircleRequest.post<DeleteTenantFilesResult>(
        endpoint: '/api/delete-tenant-files',
        pubkey: pubkey,
        privkey: privkey,
        baseUrl: baseUrl,
        tags: [
          ['tenant_id', tenantId],
        ],
        content: '',
        parseSuccess: (json) {
          if (json['success'] == true && json['data'] != null) {
            final deleteResult = DeleteTenantFilesResult.fromJson(json['data'] as Map<String, dynamic>);
            LogUtils.v(() => 'Successfully deleted ${deleteResult.deletedCount}/${deleteResult.totalCount} files for tenant ${deleteResult.tenantId}');
            return deleteResult;
          } else {
            final error = json['error'] as String? ?? 'Unknown error';
            throw Exception('Failed to delete tenant files: $error');
          }
        },
      );
      return result;
    } catch (e) {
      LogUtils.e(() => 'Error in deleteTenantFiles: $e');
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
  /// [baseUrl] Optional base URL for the API (defaults to Config.sharedInstance.privateRelayApiBaseUrl)
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

  /// Extract tenant ID from relay URL path
  /// 
  /// Extracts the tenant ID from the relay URL path component.
  /// Examples:
  /// - wss://domain.com/aCc4RUjN -> aCc4RUjN
  /// - wss://domain.com/tenant_xxx -> tenant_xxx
  /// 
  /// [relayUrl] The relay URL to extract tenant ID from
  /// Returns the tenant ID from the path, or null if path is empty
  static String? extractTenantIdFromRelay(String relayUrl) {
    try {
      final uri = Uri.parse(relayUrl);
      final path = uri.path;
      if (path.isEmpty || path == '/') {
        return null;
      }
      // Remove leading slash
      return path.startsWith('/') ? path.substring(1) : path;
    } catch (e) {
      LogUtils.e(() => 'Error extracting tenant ID from relay: $e');
      return null;
    }
  }

  /// Get tenant information
  /// 
  /// Queries tenant information using the HTTP API endpoint.
  /// This allows checking tenant existence before establishing WebSocket connections.
  /// 
  /// [pubkey] User's public key
  /// [privkey] User's private key
  /// [tenantId] Tenant ID to query
  /// [baseUrl] Optional base URL for the API (defaults to Config.sharedInstance.privateRelayApiBaseUrl)
  /// 
  /// Returns [TenantInfo] with tenant details.
  /// Throws [Exception] if the request fails, user is not a tenant member, or tenant not found.
  static Future<TenantInfo> getTenantInfo({
    required String pubkey,
    required String privkey,
    required String tenantId,
    String? baseUrl,
  }) async {
    try {
      final result = await CircleRequest.post<TenantInfo>(
        endpoint: '/api/tenant-info',
        pubkey: pubkey,
        privkey: privkey,
        baseUrl: baseUrl,
        kind: 20101,
        tags: [
          ['tenant_id', tenantId],
        ],
        content: '',
        parseSuccess: (json) {
          if (json['status'] == 'success' && json['data'] != null) {
            final tenantInfo = TenantInfo.fromJson(json['data'] as Map<String, dynamic>);
            LogUtils.v(() => 'Successfully fetched tenant info for tenant $tenantId');
            return tenantInfo;
          } else {
            final error = json['error'] as String? ?? 'Unknown error';
            throw Exception('Failed to get tenant info: $error');
          }
        },
      );
      return result;
    } catch (e) {
      LogUtils.e(() => 'Error in getTenantInfo: $e');
      rethrow;
    }
  }

  /// Check if a relay URL is a paid relay (based on matching privateRelayApiBaseUrl)
  /// 
  /// [relayUrl] The relay URL to check
  /// Returns true if the relay URL's host matches the privateRelayApiBaseUrl host
  static bool isPaidRelay(String relayUrl) {
    try {
      if (relayUrl.isEmpty) return false;

      // Extract host from relayUrl (e.g., wss://relay.xchat.chat/xxx -> relay.xchat.chat)
      final relayUri = Uri.parse(relayUrl);
      final relayHost = relayUri.host;

      // Get privateRelayApiBaseUrl host (e.g., https://relay.xchat.chat -> relay.xchat.chat)
      final privateRelayApiBaseUrl = Config.sharedInstance.privateRelayApiBaseUrl;
      final apiUri = Uri.parse(privateRelayApiBaseUrl);
      final apiHost = apiUri.host;

      // Check if hosts match
      return relayHost == apiHost;
    } catch (e) {
      LogUtils.w(() => 'Failed to check if paid relay: $e');
      return false;
    }
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
        apiBaseUrl = extractBaseUrlFromRelay(relayUrl);
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

