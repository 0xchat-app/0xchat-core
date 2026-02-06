import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'circle_api.dart';

/// Circle member management service
/// 
/// Handles member operations (add, remove, list) for circle/tenant management
/// using Nostr management API (Kind 20200, 20201, 20202, 20300)
/// 
/// Singleton service that continuously listens for Kind 20300 response events
class CircleMemberService {
  CircleMemberService._internal();
  
  /// Singleton instance
  static final CircleMemberService sharedInstance = CircleMemberService._internal();
  
  factory CircleMemberService() => sharedInstance;

  /// Map to store pending requests: requestId -> Completer
  final Map<String, Completer<Map<String, dynamic>>> _pendingRequests = {};
  
  /// Whether the service has been initialized
  bool _initialized = false;
  
  /// Original noticeCallBack before we set ours (for compatibility)
  NoticeCallBack? _originalNoticeCallBack;

  /// Initialize the service and start listening for Kind 20300 responses via NOTICE messages
  /// 
  /// Should be called once during app initialization
  void init() {
    if (_initialized) return;
    
    _initialized = true;
    _startListening();
  }

  /// Start listening for Kind 20300 response events via NOTICE messages
  void _startListening() {
    // Save original noticeCallBack if exists
    _originalNoticeCallBack = Connect.sharedInstance.noticeCallBack;
    
    // Set our notice callback to handle management responses
    Connect.sharedInstance.noticeCallBack = _handleNotice;
    
    LogUtils.v(() => 'CircleMemberService: Started listening for Kind 20300 events via NOTICE messages');
  }
  
  /// Handle NOTICE messages and extract Kind 20300 management response events
  void _handleNotice(String notice, String relay) {
    // Use async helper to handle event deserialization
    _handleNoticeAsync(notice, relay).catchError((e) {
      LogUtils.e(() => 'CircleMemberService: Error in _handleNoticeAsync: $e');
      _originalNoticeCallBack?.call(notice, relay);
    });
  }
  
  /// Async helper to handle NOTICE message parsing
  Future<void> _handleNoticeAsync(String notice, String relay) async {
    try {
      // Connect._handleNotice extracts the first element: String n = jsonDecode(notice)[0];
      // So the notice parameter is already the event JSON string (not the array)
      // Parse it directly as the event JSON object
      final eventJson = jsonDecode(notice) as Map<String, dynamic>;
      
      // Check if this is a Kind 20300 event
      final kind = eventJson['kind'] as int?;
      if (kind != 20300) {
        // Not a management response, forward to original callback if exists
        _originalNoticeCallBack?.call(notice, relay);
        return;
      }
      
      // Create Event from JSON (fromJson is async)
      final event = await Event.fromJson(eventJson, verify: false);
      
      // Handle the response event
      _handleResponseEvent(event, relay);
    } catch (e) {
      // If parsing fails, it might not be a 20300 event, forward to original callback
      LogUtils.v(() => 'CircleMemberService: Failed to parse NOTICE as 20300 event: $e');
      _originalNoticeCallBack?.call(notice, relay);
    }
  }

  /// Handle incoming Kind 20300 response events
  void _handleResponseEvent(Event event, String relay) {
    try {
      // Extract request event ID from tags
      final eTags = event.tags.where((tag) => tag.isNotEmpty && tag[0] == 'e').toList();
      if (eTags.isEmpty) {
        LogUtils.w(() => 'CircleMemberService: Response event missing e tag');
        return;
      }
      
      final requestId = eTags[0][1]; // Get the event ID from e tag
      if (requestId.isEmpty) {
        LogUtils.w(() => 'CircleMemberService: Response event has empty e tag');
        return;
      }
      
      // Find the pending request
      final completer = _pendingRequests.remove(requestId);
      if (completer == null) {
        LogUtils.v(() => 'CircleMemberService: No pending request found for $requestId');
        return;
      }
      
      // Parse response content
      try {
        final responseContent = jsonDecode(event.content) as Map<String, dynamic>;
        
        if (!completer.isCompleted) {
          completer.complete(responseContent);
          LogUtils.v(() => 'CircleMemberService: Completed request $requestId');
        }
      } catch (e) {
        LogUtils.e(() => 'CircleMemberService: Failed to parse response: $e');
        if (!completer.isCompleted) {
          completer.completeError(Exception('Failed to parse response: $e'));
        }
      }
    } catch (e) {
      LogUtils.e(() => 'CircleMemberService: Error handling response event: $e');
    }
  }

  /// Convert npub to hex pubkey
  static String? normalizePubkey(String pubkey) {
    if (pubkey.isEmpty) return null;
    
    // If already hex format (64 chars), return as is
    if (pubkey.length == 64 && RegExp(r'^[a-fA-F0-9]+$').hasMatch(pubkey)) {
      return pubkey.toLowerCase();
    }
    
    // Try to decode npub format
    try {
      final decoded = Nip19.decodePubkey(pubkey);
      if (decoded.isNotEmpty) {
        return decoded.toLowerCase();
      }
    } catch (e) {
      LogUtils.w(() => 'Failed to decode npub: $e');
    }
    
    return null;
  }

  /// Get current circle relay URL
  String? _getCurrentCircleRelay() {
    return ChatCoreManager().circleRelay;
  }

  /// Get current user's pubkey
  String? _getCurrentPubkey() {
    final pubkey = Account.sharedInstance.currentPubkey;
    if (pubkey.isEmpty) return null;
    return pubkey;
  }

  /// Get current user's private key
  String? _getCurrentPrivkey() {
    return Account.sharedInstance.currentPrivkey;
  }

  /// Send management event and wait for response
  /// Backend will handle tenant_id extraction from relay URL
  Future<Map<String, dynamic>> _sendManagementEvent({
    required int kind,
    List<List<String>> tags = const [],
    String content = '',
  }) async {
    // Ensure service is initialized
    if (!_initialized) {
      init();
    }

    final relay = _getCurrentCircleRelay();
    if (relay == null) {
      throw Exception('No circle relay available');
    }

    final pubkey = _getCurrentPubkey();
    final privkey = _getCurrentPrivkey();
    
    if (pubkey == null || privkey == null || privkey.isEmpty) {
      throw Exception('User not logged in or private key not available');
    }

    // Build tags without tenant_id (backend handles it from relay URL)
    final eventTags = [
      ...tags,
    ];

    // Create and sign event
    final event = await Event.from(
      kind: kind,
      tags: eventTags,
      content: content,
      pubkey: pubkey,
      privkey: privkey,
    );

    // Create completer for response
    final completer = Completer<Map<String, dynamic>>();
    final requestId = event.id;
    
    // Store the completer for this request
    _pendingRequests[requestId] = completer;

    // Send event
    Connect.sharedInstance.sendEvent(
      event,
      toRelays: [relay],
      relayKinds: [RelayKind.circleRelay],
      sendCallBack: (ok, sendRelay) {
        if (!ok.status) {
          _pendingRequests.remove(requestId);
          if (!completer.isCompleted) {
            completer.completeError(Exception(ok.message.isNotEmpty ? ok.message : 'Failed to send event'));
          }
        }
      },
    );

    // Wait for response with timeout
    try {
      final response = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _pendingRequests.remove(requestId);
          throw Exception('Request timeout');
        },
      );
      return response;
    } catch (e) {
      _pendingRequests.remove(requestId);
      LogUtils.e(() => 'Management event error: $e');
      rethrow;
    }
  }

  /// Add member to circle
  /// 
  /// [memberPubkey] Member pubkey (hex or npub format)
  /// [role] Optional role (default: "member")
  /// 
  /// Returns response data or throws exception
  Future<Map<String, dynamic>> addMember({
    required String memberPubkey,
    String? role,
  }) async {
    final normalizedPubkey = normalizePubkey(memberPubkey);
    if (normalizedPubkey == null) {
      throw Exception('Invalid pubkey format');
    }

    // Build content JSON
    final contentMap = <String, dynamic>{};
    if (role != null) contentMap['role'] = role;

    final content = contentMap.isEmpty ? '' : jsonEncode(contentMap);

    // Build tags
    final tags = [
      ['member_pubkey', normalizedPubkey],
    ];

    final response = await _sendManagementEvent(
      kind: 20200,
      tags: tags,
      content: content,
    );

    if (response['status'] == 'success') {
      return response['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to add member');
    }
  }

  /// Remove member from circle
  /// 
  /// [memberPubkey] Member pubkey (hex or npub format)
  /// 
  /// Returns response data or throws exception
  Future<Map<String, dynamic>> removeMember({
    required String memberPubkey,
  }) async {
    final normalizedPubkey = normalizePubkey(memberPubkey);
    if (normalizedPubkey == null) {
      throw Exception('Invalid pubkey format');
    }

    final tags = [
      ['member_pubkey', normalizedPubkey],
    ];

    final response = await _sendManagementEvent(
      kind: 20201,
      tags: tags,
      content: '',
    );

    if (response['status'] == 'success') {
      return response['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to remove member');
    }
  }

  /// List members of circle
  /// 
  /// [limit] Optional limit (default: 100)
  /// [offset] Optional offset (default: 0)
  /// 
  /// Returns list of members
  Future<List<Map<String, dynamic>>> listMembers({
    int? limit,
    int? offset,
  }) async {
    final tags = <List<String>>[];
    if (limit != null) tags.add(['limit', limit.toString()]);
    if (offset != null) tags.add(['offset', offset.toString()]);

    final response = await _sendManagementEvent(
      kind: 20202,
      tags: tags,
      content: '',
    );

    if (response['status'] == 'success') {
      final data = response['data'] as Map<String, dynamic>?;
      if (data != null && data['members'] != null) {
        final membersList = data['members'] as List<dynamic>;
        return membersList
            .map((m) => m as Map<String, dynamic>)
            .toList();
      }
      return [];
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to list members');
    }
  }

  /// Get tenant info for a specific relay (preferred over [getTenantInfo]).
  ///
  /// [relayUrl] Relay URL for the circle/tenant.
  /// [tenantId] If known (e.g. from [RelayAddressInfo]), pass to skip lookup.
  /// [circleId] If provided, used to resolve [tenantId] from [CircleDBISAR].
  /// Returns [TenantInfo] model using [CircleApi.getTenantInfo].
  Future<TenantInfo> getTenantInfoForRelay(
    String relayUrl, {
    String? tenantId,
    String? circleId,
  }) async {
    final baseUrl = CircleApi.extractBaseUrlFromRelay(relayUrl);

    String? resolvedTenantId = tenantId;
    if (resolvedTenantId == null || resolvedTenantId.isEmpty) {
      if (circleId != null && circleId.isNotEmpty) {
        try {
          final circle = await Account.sharedInstance.getCircleById(circleId);
          if (circle?.tenantId != null && circle!.tenantId!.isNotEmpty) {
            resolvedTenantId = circle.tenantId;
          }
        } catch (e) {
          LogUtils.v(() => 'Could not get tenantId from CircleDBISAR by circleId: $e');
        }
      }
      if (resolvedTenantId == null || resolvedTenantId.isEmpty) {
        try {
          final circles = await Account.sharedInstance.getAllCircles();
          for (final circle in circles) {
            if (circle.relayList.contains(relayUrl) &&
                circle.tenantId != null &&
                circle.tenantId!.isNotEmpty) {
              resolvedTenantId = circle.tenantId;
              break;
            }
          }
        } catch (e) {
          LogUtils.v(() => 'Could not get tenantId from CircleDBISAR: $e');
        }
      }
      if (resolvedTenantId == null || resolvedTenantId.isEmpty) {
        resolvedTenantId = CircleApi.extractTenantIdFromRelay(relayUrl);
      }
    }

    if (resolvedTenantId == null || resolvedTenantId.isEmpty) {
      throw Exception('Cannot determine tenantId from relay URL: $relayUrl');
    }

    final pubkey = _getCurrentPubkey();
    final privkey = _getCurrentPrivkey();
    if (pubkey == null || privkey == null || privkey.isEmpty) {
      throw Exception('User not logged in or private key not available');
    }

    return CircleApi.getTenantInfo(
      pubkey: pubkey,
      privkey: privkey,
      tenantId: resolvedTenantId,
      baseUrl: baseUrl,
    );
  }

  /// Get tenant info for the current circle relay (from [ChatCoreManager.circleRelay]).
  /// Prefer [getTenantInfoForRelay] with an explicit relay/circle when available.
  Future<TenantInfo> getTenantInfo() async {
    final relay = _getCurrentCircleRelay();
    if (relay == null) {
      throw Exception('No circle relay available');
    }
    return getTenantInfoForRelay(relay);
  }

  /// Update tenant configuration
  /// 
  /// [name] Optional new tenant name (tenant admin can update)
  /// [maxMembers] Optional new max members count (system admin only)
  /// [expiresAt] Optional new expiration timestamp (system admin only)
  /// [tenantAdminPubkey] Optional new tenant admin pubkey (system admin only)
  /// 
  /// Returns updated tenant info
  /// Tenant admin can only update name
  /// System admin can update all fields
  Future<Map<String, dynamic>> updateTenant({
    String? name,
    int? maxMembers,
    int? expiresAt,
    String? tenantAdminPubkey,
  }) async {
    // Build content JSON with provided fields
    final contentMap = <String, dynamic>{};
    if (name != null) contentMap['name'] = name;
    if (maxMembers != null) contentMap['max_members'] = maxMembers;
    if (expiresAt != null) contentMap['expires_at'] = expiresAt;
    if (tenantAdminPubkey != null) {
      // Normalize pubkey if provided
      final normalizedPubkey = normalizePubkey(tenantAdminPubkey);
      if (normalizedPubkey == null) {
        throw Exception('Invalid tenant_admin_pubkey format');
      }
      contentMap['tenant_admin_pubkey'] = normalizedPubkey;
    }

    final content = contentMap.isEmpty ? '' : jsonEncode(contentMap);

    final response = await _sendManagementEvent(
      kind: 20102,
      tags: [],
      content: content,
    );

    if (response['status'] == 'success') {
      return response['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to update tenant');
    }
  }

  /// Delete tenant
  /// 
  /// Soft deletes the tenant (marks as deleted)
  /// Requires system admin or tenant admin permissions
  Future<Map<String, dynamic>> deleteTenant() async {
    final response = await _sendManagementEvent(
      kind: 20103,
      tags: [],
      content: '',
    );

    if (response['status'] == 'success') {
      return response['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to delete tenant');
    }
  }

  /// Generate invitation code
  /// 
  /// [maxUses] Optional maximum number of uses (default: 1)
  /// [expiresAt] Optional expiration timestamp (Unix seconds)
  /// 
  /// Returns invitation code info
  /// Requires system admin or tenant admin permissions
  Future<Map<String, dynamic>> generateInvitationCode({
    int? maxUses,
    int? expiresAt,
  }) async {
    // Build content JSON
    final contentMap = <String, dynamic>{};
    if (maxUses != null) contentMap['max_uses'] = maxUses;
    if (expiresAt != null) contentMap['expires_at'] = expiresAt;

    final content = contentMap.isEmpty ? '' : jsonEncode(contentMap);

    final response = await _sendManagementEvent(
      kind: 20210,
      tags: [],
      content: content,
    );

    if (response['status'] == 'success') {
      return response['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to generate invitation code');
    }
  }

  /// List invitation codes
  /// 
  /// Returns list of all invitation codes for the current tenant
  /// Requires system admin or tenant admin permissions
  Future<List<Map<String, dynamic>>> listInvitationCodes() async {
    final response = await _sendManagementEvent(
      kind: 20212,
      tags: [],
      content: '',
    );

    if (response['status'] == 'success') {
      final data = response['data'] as Map<String, dynamic>?;
      if (data != null && data['invitation_codes'] != null) {
        final codesList = data['invitation_codes'] as List<dynamic>;
        return codesList
            .map((c) => c as Map<String, dynamic>)
            .toList();
      }
      return [];
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to list invitation codes');
    }
  }

  /// Reset invitation code (Kind 20214)
  /// 
  /// Deletes all existing invitation codes for the tenant and generates a new one
  /// 
  /// [maxUses] Optional maximum number of uses (default: tenant's max_members)
  /// [expiresAt] Optional expiration timestamp (Unix seconds)
  /// 
  /// Returns new invitation code info with deleted_count
  /// Requires system admin or tenant admin permissions
  Future<Map<String, dynamic>> resetInvitationCode({
    int? maxUses,
    int? expiresAt,
  }) async {
    // Build content JSON
    final contentMap = <String, dynamic>{};
    if (maxUses != null) contentMap['max_uses'] = maxUses;
    if (expiresAt != null) contentMap['expires_at'] = expiresAt;

    final content = contentMap.isEmpty ? '' : jsonEncode(contentMap);

    final response = await _sendManagementEvent(
      kind: 20214,
      tags: [],
      content: content,
    );

    if (response['status'] == 'success') {
      return response['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to reset invitation code');
    }
  }

  /// Delete invitation code
  /// 
  /// [invitationCode] The invitation code to delete
  /// 
  /// Returns deletion result
  /// Requires system admin or tenant admin permissions
  Future<Map<String, dynamic>> deleteInvitationCode({
    required String invitationCode,
  }) async {
    if (invitationCode.isEmpty) {
      throw Exception('Invitation code cannot be empty');
    }

    final tags = [
      ['invitation_code', invitationCode],
    ];

    final response = await _sendManagementEvent(
      kind: 20213,
      tags: tags,
      content: '',
    );

    if (response['status'] == 'success') {
      return response['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
    } else {
      final message = response['message'];
      throw Exception(message is String ? message : 'Failed to delete invitation code');
    }
  }
}

