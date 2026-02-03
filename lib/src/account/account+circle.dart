import 'dart:async';
import 'dart:io';
import 'package:chatcore/chat-core.dart';
import 'package:isar/isar.dart' hide Filter;

extension AccountCircle on Account {
  /// Logout from current circle and clean up resources
  Future<void> _logoutCircle() async {
    await NotificationHelper.sharedInstance.removeNotification();
    await Connect.sharedInstance.closeAllConnects();
    Account.sharedInstance.userCache.clear();
    Contacts.sharedInstance.allContacts.clear();
    Contacts.sharedInstance.secretSessionMap.clear();
    Channels.sharedInstance.myChannels.clear();
    Groups.sharedInstance.myGroups.clear();
    Groups.sharedInstance.currentGroupRelays.clear();
    RelayGroup.sharedInstance.myGroups.clear();
    RelayGroup.sharedInstance.groupRelays.clear();
    Relays.sharedInstance.relays.clear();
    EventCache.sharedInstance.cacheIds.clear();
    await DBISAR.sharedInstance.closeDatabase();
  }

  /// Switch to a different circle or create a new one if it doesn't exist
  /// [circleId] Unique circle identifier
  /// Returns the circle object, null if failed
  Future<CircleDBISAR?> switchToCircle(String circleId) async {
    if (circleId.isEmpty) return null;
    await _logoutCircle();
    await DBISAR.sharedInstance.open(currentPubkey, circleId: circleId);
    await syncMe();
    return await getCircleById(circleId);
  }

  /// Create a new circle or switch to an existing one
  /// [circleId] Unique circle identifier
  /// [name] Circle name
  /// [description] Circle description
  /// [image] Circle avatar URL
  /// [relayList] Relay server list
  /// [fileserverList] File server list
  /// [iceserverList] ICE server list
  /// [pushserverList] Push server list
  /// [groupId] Associated group ID (optional)
  /// Returns the circle object, null if failed
  Future<CircleDBISAR?> createCircle({
    required String circleId,
    required String name,
    String description = '',
    String image = '',
    List<String> relayList = const [],
    List<String> fileserverList = const [],
    List<String> iceserverList = const [],
    List<String> pushserverList = const [],
    String? groupId,
    String? dbPath,
  }) async {
    try {
      // 🥚 Easter egg: Special handling for bitchat
      if (Account.isBitchatMode(name)) {
        // soon
        if(Platform.isAndroid) return null;

        LogUtils.v(() => '🥚 Easter egg detected: Bitchat mode activated!');
        
        // Start bitchat service
        await _startBitchatService();
        
        // Create a special bitchat circle
        return await _newcircle(
          circleId: circleId,
          name: '🔒 Bitchat',
          description: 'Secure peer-to-peer messaging network using BLE mesh',
          image: '',
          relayList: const [], // No relays for bitchat
          fileserverList: const [],
          iceserverList: const [],
          pushserverList: const [],
          groupId: groupId,
        );
      }

      // 🥚 Easter egg: Special relay shortcuts
      final processedRelayList = _processRelayShortcuts(relayList);
      
      // Logout from current circle first
      await _logoutCircle();

      // Open database with the target circle ID
      await DBISAR.sharedInstance.open(
        currentPubkey,
        circleId: circleId,
        dbPath: dbPath,
      );

      // Sync user profile
      await syncMe();

      // Check if circle already exists
      final existingCircle = await getCircleById(circleId);
      if (existingCircle != null) {
        LogUtils.v(() => 'Switched to existing circle: ${existingCircle.name}');
        return existingCircle;
      }

      // Create new circle if it doesn't exist
      return await _newcircle(
        circleId: circleId,
        name: name,
        description: description,
        image: image,
        relayList: processedRelayList,
        fileserverList: fileserverList,
        iceserverList: iceserverList,
        pushserverList: pushserverList,
        groupId: groupId,
      );
    } catch (e) {
      LogUtils.e(() => 'Failed to switch circle: $e');
      return null;
    }
  }

  /// Create a new circle
  /// [circleId] Unique circle identifier
  /// [name] Circle name
  /// [description] Circle description
  /// [image] Circle avatar URL
  /// [relayList] Relay server list
  /// [fileserverList] File server list
  /// [iceserverList] ICE server list
  /// [pushserverList] Push server list
  /// [groupId] Associated group ID (optional)
  /// Returns the created circle object, null if failed
  Future<CircleDBISAR?> _newcircle({
    required String circleId,
    required String name,
    String description = '',
    String image = '',
    List<String> relayList = const [],
    List<String> fileserverList = const [],
    List<String> iceserverList = const [],
    List<String> pushserverList = const [],
    String? groupId,
  }) async {
    try {
      // Validate input parameters
      if (circleId.trim().isEmpty) {
        LogUtils.e(() => 'Circle ID cannot be empty');
        return null;
      }

      if (name.trim().isEmpty) {
        LogUtils.e(() => 'Circle name cannot be empty');
        return null;
      }

      // Check if a circle with the same ID already exists
      final existingCircle = await getCircleById(circleId);
      if (existingCircle != null) {
        LogUtils.e(() => 'Circle with ID "$circleId" already exists');
        return null;
      }

      // Create new circle object
      final circle = CircleDBISAR(
        circleId: circleId,
        name: name.trim(),
        description: description.trim(),
        image: image.trim(),
        relayList: relayList,
        fileserverList: fileserverList,
        iceserverList: iceserverList,
        pushserverList: pushserverList,
        groupId: groupId,
      );

      // Save to database
      await DBISAR.sharedInstance.saveToDB(circle);

      LogUtils.v(() => 'Successfully created circle: ${circle.name}');
      return circle;
    } catch (e) {
      LogUtils.e(() => 'Failed to create circle: $e');
      return null;
    }
  }

  /// Delete a circle and its entire database
  /// [deleteId] Circle ID to delete
  /// [switchId] Circle ID to switch to after deletion
  /// Returns whether deletion was successful
  Future<bool> deletecircle(String deleteId, [String? switchId]) async {
    try {
      if (deleteId.isEmpty) return false;

      // If a switchId is provided and not the same as deleteId, attempt to switch first
      if (switchId != null && switchId.isNotEmpty && switchId != deleteId) {
        final switchSuccess = await switchToCircle(switchId);
        if (switchSuccess != null) {
          LogUtils.w(() => 'Switch to circle $switchId failed, will continue deleting $deleteId');
        }
      } else {
        await _logoutCircle();
      }

      // Delete DB files of the circle
      final success = await DBISAR.sharedInstance.delete(
        currentPubkey,
        circleId: deleteId,
      );

      if (success) {
        LogUtils.v(() => 'Successfully deleted circle: $deleteId');
      } else {
        LogUtils.w(() => 'Failed to delete circle: $deleteId');
      }

      return success;
    } catch (e) {
      LogUtils.e(() => 'Failed to delete circle: $e');
      return false;
    }
  }

  /// Update circle information
  /// [circleId] Circle ID
  /// [name] New circle name
  /// [description] New circle description
  /// [image] New circle avatar URL
  /// [relayList] New relay server list
  /// [fileserverList] New file server list
  /// [iceserverList] New ICE server list
  /// [pushserverList] New push server list
  /// [groupId] New associated group ID
  /// [s3ConfigJson] S3 configuration JSON string
  /// Returns the updated circle object, null if failed
  Future<CircleDBISAR?> updatecircle({
    required String circleId,
    String? name,
    String? description,
    String? image,
    List<String>? relayList,
    List<String>? fileserverList,
    List<String>? iceserverList,
    List<String>? pushserverList,
    String? groupId,
    String? s3ConfigJson,
  }) async {
    try {
      final isar = DBISAR.sharedInstance.isar;

      // Find the circle to update
      final circle = isar.circleDBISARs
          .where()
          .circleIdEqualTo(circleId)
          .findFirst();
      if (circle == null) {
        LogUtils.e(() => 'Circle with id $circleId not found');
        return null;
      }

      // Check if new name conflicts with other circles
      if (name != null && name.trim().isNotEmpty && name != circle.name) {
        final existingCircle = await getCircleByName(name);
        if (existingCircle != null && existingCircle.circleId != circleId) {
          LogUtils.e(() => 'Circle with name "$name" already exists');
          return null;
        }
      }

      // Update circle information
      if (name != null && name.trim().isNotEmpty) circle.name = name.trim();
      if (description != null) circle.description = description.trim();
      if (image != null) circle.image = image.trim();
      if (relayList != null) circle.relayList = relayList;
      if (fileserverList != null) circle.fileserverList = fileserverList;
      if (iceserverList != null) circle.iceserverList = iceserverList;
      if (pushserverList != null) circle.pushserverList = pushserverList;
      if (groupId != null) circle.groupId = groupId;
      if (s3ConfigJson != null) circle.s3ConfigJson = s3ConfigJson;

      // Save updates
      await DBISAR.sharedInstance.saveToDB(circle);

      LogUtils.v(() => 'Successfully updated circle: ${circle.name}');
      return circle;
    } catch (e) {
      LogUtils.e(() => 'Failed to update circle: $e');
      return null;
    }
  }

  /// Get circle by name
  /// [name] Circle name
  /// Returns circle object, null if not found
  Future<CircleDBISAR?> getCircleByName(String name) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final circles =
          isar.circleDBISARs.where().nameEqualTo(name).findAll();
      return circles.isNotEmpty ? circles.first : null;
    } catch (e) {
      LogUtils.e(() => 'Failed to get circle by name: $e');
      return null;
    }
  }

  /// Get all circles
  /// Returns list of circles
  Future<List<CircleDBISAR>> getAllCircles() async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      return isar.circleDBISARs.where().findAll();
    } catch (e) {
      LogUtils.e(() => 'Failed to get all circles: $e');
      return [];
    }
  }

  /// Get circle by ID
  /// [circleId] Circle ID
  /// Returns circle object, null if not found
  Future<CircleDBISAR?> getCircleById(String circleId) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      return isar.circleDBISARs
          .where()
          .circleIdEqualTo(circleId)
          .findFirst();
    } catch (e) {
      LogUtils.e(() => 'Failed to get circle by id: $e');
      return null;
    }
  }

  /// 🥚 Easter egg: Start bitchat service
  Future<void> _startBitchatService() async {
    try {
      LogUtils.v(() => '🥚 Starting Bitchat service with easter egg...');
      
      // Use the static startWithEasterEgg method from BitchatService
      await BitchatService.startWithEasterEgg();
      
      LogUtils.v(() => '🥚 Bitchat service started successfully!');
    } catch (e) {
      LogUtils.e(() => '🥚 Failed to start bitchat service: $e');
    }
  }

  /// 🥚 Easter egg: Process relay shortcuts
  /// Converts special relay shortcuts to full URLs
  List<String> _processRelayShortcuts(List<String> relayList) {
    final processedList = <String>[];
    
    for (final relay in relayList) {
      final processedRelay = _convertRelayShortcut(relay);
      processedList.add(processedRelay);
    }
    
    return processedList;
  }

  /// 🥚 Easter egg: Convert relay shortcut to full URL
  String _convertRelayShortcut(String relay) {
    // First check hardcoded shortcuts for common relays
    final shortcuts = Account.getRelayShortcuts();

    final shortcut = relay.toLowerCase().trim();
    
    // Check hardcoded shortcuts first
    if (shortcuts.containsKey(shortcut)) {
      final fullUrl = shortcuts[shortcut]!;
      LogUtils.v(() => '🥚 Easter egg: Converted "$relay" to "$fullUrl"');
      return fullUrl;
    }
    
    // Check if it's already a full URL
    if (relay.startsWith('wss://') || relay.startsWith('ws://')) {
      return relay;
    }
    
    // Try to find in the relay list file
    final relayUrl = _findRelayInFile(shortcut);
    if (relayUrl != null) {
      LogUtils.v(() => '🥚 Easter egg: Found "$relay" in relay list: "$relayUrl"');
      return relayUrl;
    }
    
    // If not found, return original
    LogUtils.v(() => '🥚 Easter egg: No shortcut found for "$relay", using as-is');
    return relay;
  }

  /// 🥚 Easter egg: Find relay in the local relay list file
  String? _findRelayInFile(String shortcut) {
    try {
      // Read the relay list file
      final relayList = _loadRelayList();
      
      // Search for relays that contain the shortcut
      for (final relay in relayList) {
        if (relay.contains(shortcut)) {
          return relay;
        }
      }
      
      return null;
    } catch (e) {
      LogUtils.e(() => '🥚 Failed to load relay list: $e');
      return null;
    }
  }

  /// 🥚 Easter egg: Load relay list from local file
  List<String> _loadRelayList() {
    try {
      // For now, return a hardcoded list of popular relays
      // In a full implementation, you would read from the assets/relays.txt file
      // using Flutter's asset loading mechanism
      return [
        'wss://relay.nostr.com',
        'wss://relay.damus.io',
        'wss://relay.snort.social',
        'wss://purplepag.es',
        'wss://relay.bitcoin.com',
        'wss://nos.lol',
      ];
    } catch (e) {
      LogUtils.e(() => '🥚 Failed to load relay list: $e');
      return [];
    }
  }

  /// Save tenant info to CircleDBISAR (for paid circles only)
  /// [circleId] Circle ID
  /// [tenantInfo] Tenant information map from server
  /// Returns true if saved successfully, false otherwise
  Future<bool> saveTenantInfoToCircleDB({
    required String circleId,
    required Map<String, dynamic> tenantInfo,
  }) async {
    try {
      var circle = await getCircleById(circleId);
      
      // If CircleDBISAR doesn't exist, create it with basic info
      if (circle == null) {
        // Get circle name from tenantInfo or use a default
        final circleName = tenantInfo['name'] as String? ?? 'Circle';
        
        // Create new CircleDBISAR with basic info
        circle = CircleDBISAR(
          circleId: circleId,
          name: circleName,
          description: '',
          image: '',
          relayList: const [],
          fileserverList: const [],
          iceserverList: const [],
          pushserverList: const [],
          groupId: null,
        );
        
        // Save the new circle first
        await DBISAR.sharedInstance.saveToDB(circle);
      }

      // Update subscription info
      circle.tenantId = tenantInfo['tenant_id'] as String?;
      circle.tenantAdminPubkey = tenantInfo['tenant_admin_pubkey'] as String?;
      circle.expiresAt = tenantInfo['expires_at'] as int?;
      circle.maxMembers = tenantInfo['max_members'] as int?;
      circle.currentMembers = tenantInfo['current_members'] as int?;
      circle.subscriptionStatus = tenantInfo['subscription_status'] as String?;
      circle.tenantName = tenantInfo['name'] as String?;
      circle.status = tenantInfo['status'] as String?;

      // Update member info (only store pubkey list)
      final membersData = tenantInfo['members'] as List<dynamic>?;
      if (membersData != null) {
        circle.memberPubkeys = membersData
            .map((m) => (m as Map<String, dynamic>)['pubkey'] as String)
            .where((p) => p.isNotEmpty)
            .toList();
      } else {
        circle.memberPubkeys = [];
      }

      // Save to database
      await DBISAR.sharedInstance.saveToDB(circle);

      LogUtils.v(() => 'Successfully saved tenant info to circle: $circleId');
      return true;
    } catch (e) {
      LogUtils.e(() => 'Failed to save tenant info to circle: $e');
      return false;
    }
  }

  /// Load tenant info from CircleDBISAR (for paid circles only)
  /// [circleId] Circle ID
  /// Returns tenant info map if cached data exists, null otherwise
  Future<Map<String, dynamic>?> loadTenantInfoFromCircleDB(String circleId) async {
    try {
      final circle = await getCircleById(circleId);
      if (circle == null) {
        return null;
      }

      // Check if there is cached subscription info (at least one subscription field is not null)
      final hasCachedData = circle.tenantAdminPubkey != null ||
          circle.expiresAt != null ||
          circle.maxMembers != null ||
          circle.currentMembers != null ||
          circle.subscriptionStatus != null ||
          circle.tenantName != null ||
          circle.status != null;

      if (!hasCachedData) {
        return null;
      }

      // Build tenant info Map
      final tenantInfo = <String, dynamic>{
        if (circle.tenantAdminPubkey != null)
          'tenant_admin_pubkey': circle.tenantAdminPubkey,
        if (circle.expiresAt != null) 'expires_at': circle.expiresAt,
        if (circle.maxMembers != null) 'max_members': circle.maxMembers,
        if (circle.currentMembers != null) 'current_members': circle.currentMembers,
        if (circle.subscriptionStatus != null)
          'subscription_status': circle.subscriptionStatus,
        if (circle.tenantName != null) 'name': circle.tenantName,
        if (circle.status != null) 'status': circle.status,
      };

      // Build members list (only contains pubkey, display names retrieved from UserDBISAR)
      if (circle.memberPubkeys.isNotEmpty) {
        final members = circle.memberPubkeys.map((pubkey) => {
          'pubkey': pubkey,
          'display_name': '', // Display names retrieved from UserDBISAR
        }).toList();

        tenantInfo['members'] = members;
      }

      return tenantInfo;
    } catch (e) {
      LogUtils.e(() => 'Failed to load tenant info from circle: $e');
      return null;
    }
  }
}
