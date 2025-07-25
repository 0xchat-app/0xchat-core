import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:isar/isar.dart' hide Filter;
import 'package:nostr_mls_package/nostr_mls_package.dart';

/// Result of keypackage selection
class KeyPackageSelectionResult {
  final String? keyPackage;
  final bool rememberSelection;

  KeyPackageSelectionResult(this.keyPackage, this.rememberSelection);
}

/// KeyPackage Manager for MLS private groups
/// Handles both one-time and permanent keypackages
class KeyPackageManager {
  /// Create a one-time keypackage for sharing
  /// This keypackage can only be used once for processing welcome messages
  static Future<KeyPackageEvent?> createOneTimeKeyPackage({
    required String ownerPubkey,
    required String ownerPrivkey,
    List<String>? relays,
    KeyPackageClient client = KeyPackageClient.oxchatLite,
  }) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    try {
      // Create keypackage using MLS library
      String result = await createKeyPackageForEvent(
        publicKey: ownerPubkey,
        relay: relays,
        client: client.value,
      );

      ParsedKeyPackage parsedKeyPackage = parseKeyPackageString(result);

      // Create event (but don't publish to relay for one-time keypackages)
      Event event = await Nip104.encodeKeyPackageEvent(
        parsedKeyPackage.encodedKeyPackage,
        parsedKeyPackage.tags,
        ownerPubkey,
        ownerPrivkey,
      );

      KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);
      await saveKeyPackageEventToDB(event, KeyPackageType.oneTime);

      return keyPackageEvent;
    } catch (e) {
      return null;
    }
  }

  /// Create a permanent keypackage and sync to relay
  /// This keypackage can be used multiple times
  static Future<KeyPackageEvent?> createPermanentKeyPackage({
    required String ownerPubkey,
    required String ownerPrivkey,
    List<String>? relays,
    KeyPackageClient client = KeyPackageClient.oxchatLite,
  }) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    try {
      // Check if permanent keypackage already exists locally
      List<KeyPackageDBISAR> existingPermanentKeyPackages =
          await getLocalKeyPackagesByType(ownerPubkey, KeyPackageType.permanent);

      if (existingPermanentKeyPackages.isNotEmpty) {
        // Use existing permanent keypackage
        KeyPackageDBISAR existingKeyPackage = existingPermanentKeyPackages.first;
        // Convert KeyPackageDBISAR back to KeyPackageEvent using the existing method
        return existingKeyPackage.toKeyPackageEvent();
      }

      // Create new keypackage if none exists
      String result = await createKeyPackageForEvent(
        publicKey: ownerPubkey,
        relay: relays,
        client: client.value,
      );

      ParsedKeyPackage parsedKeyPackage = parseKeyPackageString(result);

      // Create event and publish to relay
      Event event = await Nip104.encodeKeyPackageEvent(
        parsedKeyPackage.encodedKeyPackage,
        parsedKeyPackage.tags,
        ownerPubkey,
        ownerPrivkey,
      );

      KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);
      await saveKeyPackageEventToDB(event, KeyPackageType.permanent);

      // Publish to relay and return result
      OKEvent okEvent = await _publishKeyPackageEvent(event, relays);
      if (okEvent.status) {
        return keyPackageEvent;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print('Failed to create permanent keypackage: $e $stackTrace');
      return null;
    }
  }

  static Future<void> saveKeyPackageEventToDB(Event event, KeyPackageType type) async {
    KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);

    // Create database record
    KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
      keyPackageEvent,
      type: type,
      status: KeyPackageStatus.available,
    );

    // Save to database
    await KeyPackageManager.saveKeyPackage(keyPackageDB);
  }

  /// Get available keypackages for a user
  static Future<List<KeyPackageDBISAR>> getAvailableLocalKeyPackages(String pubkey) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final keyPackages = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .statusEqualTo(KeyPackageStatus.available.value)
          .sortByCreateTimeDesc()
          .findAll();

      // Only verify keypackages in nostr_mls storage if this is the current user's keypackages
      String currentPubkey = Account.sharedInstance.currentPubkey;
      if (pubkey == currentPubkey) {
        List<KeyPackageDBISAR> validKeyPackages = [];
        for (KeyPackageDBISAR keyPackage in keyPackages) {
          bool existsInStorage = await _verifyKeyPackageInStorage(keyPackage.encodedKeyPackage);
          if (existsInStorage) {
            validKeyPackages.add(keyPackage);
          } else {
            // Remove from database if not found in nostr_mls storage
            await _deleteKeyPackageFromDB(keyPackage);
          }
        }
        return validKeyPackages;
      }

      return keyPackages;
    } catch (e) {
      return [];
    }
  }

  static Future<KeyPackageDBISAR?> getKeyPackageById(String keyPackageId) async {
    final isar = DBISAR.sharedInstance.isar;
    KeyPackageDBISAR? keyPackage =
        isar.keyPackageDBISARs.where().keyPackageIdEqualTo(keyPackageId).findFirst();

    if (keyPackage != null) {
      // Only verify keypackage in nostr_mls storage if this is the current user's keypackage
      String currentPubkey = Account.sharedInstance.currentPubkey;
      if (keyPackage.ownerPubkey == currentPubkey) {
        bool existsInStorage = await _verifyKeyPackageInStorage(keyPackage.encodedKeyPackage);
        if (!existsInStorage) {
          // Remove from database if not found in nostr_mls storage
          await _deleteKeyPackageFromDB(keyPackage);
          return null;
        }
      }
    }

    return keyPackage;
  }

  /// Get keypackages by type
  static Future<List<KeyPackageDBISAR>> getLocalKeyPackagesByType(
      String pubkey, KeyPackageType type) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final keyPackages = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .typeEqualTo(type.value)
          .sortByCreateTimeDesc()
          .findAll();

      // Only verify keypackages in nostr_mls storage if this is the current user's keypackages
      String currentPubkey = Account.sharedInstance.currentPubkey;
      if (pubkey == currentPubkey) {
        List<KeyPackageDBISAR> validKeyPackages = [];
        for (KeyPackageDBISAR keyPackage in keyPackages) {
          bool existsInStorage = await _verifyKeyPackageInStorage(keyPackage.encodedKeyPackage);
          if (existsInStorage) {
            validKeyPackages.add(keyPackage);
          } else {
            // Remove from database if not found in nostr_mls storage
            await _deleteKeyPackageFromDB(keyPackage);
          }
        }
        return validKeyPackages;
      }

      return keyPackages;
    } catch (e) {
      return [];
    }
  }

  /// Get keypackages for multiple users
  static Future<Map<String, String>> getMembersKeyPackages(
    List<String> pubkeys, {
    Future<KeyPackageSelectionResult?> Function(
            String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
  }) async {
    Map<String, String> result = {};

    for (String pubkey in pubkeys) {
      String? keyPackage = await _getBestKeyPackageForUser(
        pubkey,
        onKeyPackageSelection: onKeyPackageSelection,
      );

      if (keyPackage != null) {
        result[pubkey] = keyPackage;
      }
    }

    return result;
  }

  /// Get the best available keypackage for a user
  static Future<String?> _getBestKeyPackageForUser(
    String pubkey, {
    Future<KeyPackageSelectionResult?> Function(
            String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
  }) async {
    // First check if user has a last selected keypackage ID
    UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
    if (user?.lastSelectedKeyPackageId != null && user!.lastSelectedKeyPackageId!.isNotEmpty) {
      // Try to get the last selected keypackage
      final isar = DBISAR.sharedInstance.isar;
      final lastSelectedKeyPackage = isar.keyPackageDBISARs
          .where()
          .keyPackageIdEqualTo(user.lastSelectedKeyPackageId!)
          .findFirst();

      if (lastSelectedKeyPackage != null && lastSelectedKeyPackage.isAvailable) {
        return lastSelectedKeyPackage.encodedKeyPackage;
      }
    }

    // If no last selected keypackage or it's not available, proceed with normal logic
    // First try local database - prioritize 0xchat-lite client
    List<KeyPackageDBISAR> localKeyPackages = await getAvailableLocalKeyPackages(pubkey);

    if (localKeyPackages.isNotEmpty) {
      // First try to find 0xchat-lite client keypackages
      List<KeyPackageDBISAR> oxchatLiteKeyPackages = localKeyPackages
          .where((kp) => kp.keyPackageClient == KeyPackageClient.oxchatLite)
          .toList();

      if (oxchatLiteKeyPackages.isNotEmpty) {
        // Prefer one-time keypackages
        KeyPackageDBISAR? oneTimeKeyPackage =
            oxchatLiteKeyPackages.where((kp) => kp.isOneTime).firstOrNull;
        if (oneTimeKeyPackage != null) {
          return oneTimeKeyPackage.encodedKeyPackage;
        }

        // Return first available 0xchat-lite keypackage
        return oxchatLiteKeyPackages.first.encodedKeyPackage;
      }
    }

    // Search relay for more keypackages
    List<KeyPackageEvent> relayKeyPackages = await searchAndStoreKeyPackages(pubkey);

    // Combine local and relay keypackages
    List<KeyPackageEvent> localKeyPackageEvents = localKeyPackages.map((kp) => kp.toKeyPackageEvent()).toList();
    List<KeyPackageEvent> availableKeyPackages = [...localKeyPackageEvents, ...relayKeyPackages];

    // search all keypackages (local + relay)    
    List<KeyPackageEvent> oxchatLiteKeyPackages = availableKeyPackages.where((kp) => kp.client == KeyPackageClient.oxchatLite.value).toList();
    if (oxchatLiteKeyPackages.isNotEmpty) {
      return oxchatLiteKeyPackages.first.encoded_key_package;
    }

    // If no 0xchat-lite keypackages locally, search relay and let upper layer choose
    if (onKeyPackageSelection != null) {
      KeyPackageSelectionResult? result = await onKeyPackageSelection(pubkey, availableKeyPackages);
      if (result?.keyPackage != null) {
        // Find the keypackage ID for the selected keypackage
        KeyPackageDBISAR? selectedKeyPackageDB =
            localKeyPackages.where((kp) => kp.encodedKeyPackage == result!.keyPackage).firstOrNull;
        if (selectedKeyPackageDB != null) {
          if (result!.rememberSelection) {
            // Remember the selection
            await updateUserLastSelectedKeyPackageId(pubkey, selectedKeyPackageDB.keyPackageId);
          } else {
            // Clear the last selected keypackage ID
            await updateUserLastSelectedKeyPackageId(pubkey, '');
          }
        }
      }
      return result?.keyPackage;
    }
    
    // If no keypackages available, return null
    if (availableKeyPackages.isEmpty) {
      return null;
    }
    
    return availableKeyPackages.first.encoded_key_package;
  }

  /// Search for keypackages on relay and store them locally
  static Future<List<KeyPackageEvent>> searchAndStoreKeyPackages(String pubkey) async {
    try {
      Completer<List<KeyPackageEvent>> completer = Completer<List<KeyPackageEvent>>();
      List<Event> cachedEvents = [];
      List<KeyPackageEvent> relayKeyPackages = [];
      Filter filter = Filter(kinds: [443], authors: [pubkey], limit: 10);

      Connect.sharedInstance.addSubscription([filter], eventCallBack: (event, relay) async {
        cachedEvents.add(event);
      }, eoseCallBack: (requestId, ok, relay, unRelays) async {
        for (Event event in cachedEvents) {
          try {
            KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);

            // Validate keypackage
            bool isValid = await _checkValidKeypackage(keyPackageEvent);
            if (!isValid) continue;

            // Determine type based on client or other criteria
            KeyPackageType type = _determineKeyPackageType(keyPackageEvent);

            // Create database record
            KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
              keyPackageEvent,
              type: type,
              status: KeyPackageStatus.available,
            );

            // Save to database
            await saveKeyPackage(keyPackageDB);
            
            // Add to relay keypackages list
            relayKeyPackages.add(keyPackageEvent);
          } catch (e) {
            continue;
          }
        }

        if (!completer.isCompleted) {
          completer.complete(relayKeyPackages);
        }
      });

      return await completer.future;
    } catch (e) {
      print('Failed to search keypackages: $e');
      return [];
    }
  }

  /// Mark a keypackage as used
  static Future<void> markKeyPackageAsUsed(
    String keyPackageId, {
    String? groupId,
    String? eventId,
  }) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final keyPackage =
          isar.keyPackageDBISARs.where().keyPackageIdEqualTo(keyPackageId).findFirst();

      if (keyPackage != null) {
        keyPackage.markAsUsed(groupId: groupId, eventId: eventId);
        await DBISAR.sharedInstance.saveToDB(keyPackage);
      }
    } catch (e) {
      print('Failed to mark keypackage as used: $e');
    }
  }

  /// Mark a keypackage as used by encoded keypackage
  static Future<void> markKeyPackageAsUsedByEncoded(
    String encodedKeyPackage, {
    String? groupId,
    String? eventId,
  }) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final keyPackage =
          isar.keyPackageDBISARs.where().encodedKeyPackageEqualTo(encodedKeyPackage).findFirst();

      if (keyPackage != null) {
        keyPackage.markAsUsed(groupId: groupId, eventId: eventId);
        await DBISAR.sharedInstance.saveToDB(keyPackage);
      }
    } catch (e) {
      print('Failed to mark keypackage as used: $e');
    }
  }

  static Future<void> saveKeyPackage(KeyPackageDBISAR keyPackage) async {
    await DBISAR.sharedInstance.saveToDB(keyPackage);
  }

  static Future<OKEvent> _publishKeyPackageEvent(Event event, List<String> relays) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(event, toRelays: relays, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  static KeyPackageType _determineKeyPackageType(KeyPackageEvent event) {
    // Default to permanent for now
    // In the future, this could be determined by tags or other metadata
    return KeyPackageType.permanent;
  }

  static Future<bool> _checkValidKeypackage(KeyPackageEvent keyPackageEvent) async {
    try {
      String extensions = jsonDecode(await getExtensions())['extensions'];
      String ciphersuite = jsonDecode(await getCiphersuite())['ciphersuite'];

      // Check basic validity (extensions and ciphersuite)
      return _areListsEqual(keyPackageEvent.extensions, [extensions]) &&
          ciphersuite == keyPackageEvent.ciphersuite;
    } catch (e) {
      print('Failed to check keypackage validity: $e');
      return false;
    }
  }

  static bool _areListsEqual(List<String> list1, List<String> list2) {
    return Set.from(list1).containsAll(list2) && Set.from(list2).containsAll(list1);
  }

  /// Update user's last selected keypackage ID
  static Future<void> updateUserLastSelectedKeyPackageId(String pubkey, String keyPackageId) async {
    try {
      UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
      if (user != null) {
        user.lastSelectedKeyPackageId = keyPackageId;
        await Account.saveUserToDB(user);
      }
    } catch (e) {
      print('Failed to update user last selected keypackage ID: $e');
    }
  }

  /// Get keypackage statistics
  static Future<Map<String, int>> getKeyPackageStats(String pubkey) async {
    try {
      final isar = DBISAR.sharedInstance.isar;

      final total = isar.keyPackageDBISARs.where().ownerPubkeyEqualTo(pubkey).count();

      final available = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .statusEqualTo(KeyPackageStatus.available.value)
          .count();

      final used = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .statusEqualTo(KeyPackageStatus.used.value)
          .count();

      final oneTime = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .typeEqualTo(KeyPackageType.oneTime.value)
          .count();

      final permanent = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .typeEqualTo(KeyPackageType.permanent.value)
          .count();

      return {
        'total': total,
        'available': available,
        'used': used,
        'one_time': oneTime,
        'permanent': permanent,
      };
    } catch (e) {
      print('Failed to get keypackage stats: $e');
      return {};
    }
  }

  /// Verify if keypackage exists in nostr_mls storage
  static Future<bool> _verifyKeyPackageInStorage(String encodedKeyPackage) async {
    try {
      String result = await getKeyPackageFromStorage(serializedKeyPackage: encodedKeyPackage);
      Map<String, dynamic> resultMap = jsonDecode(result);
      return resultMap['found'] == true;
    } catch (e) {
      print('Failed to verify keypackage in storage: $e');
      return false;
    }
  }

  /// Delete keypackage from database
  static Future<void> _deleteKeyPackageFromDB(KeyPackageDBISAR keyPackage) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      await isar.writeAsync((isar) async {
        isar.keyPackageDBISARs.delete(keyPackage.id);
      });
      print('Deleted keypackage ${keyPackage.keyPackageId} from database');
    } catch (e) {
      print('Failed to delete keypackage from database: $e');
    }
  }

  /// Handle one-time invite link
  /// This method processes a one-time keypackage from an invite link
  static Future<bool> handleOneTimeInviteLink({
    required String encodedKeyPackage,
    required String senderPubkey,
    required List<String> relays,
  }) async {
    try {
      // Create KeyPackageEvent from the encoded keypackage
      final keyPackageEvent = KeyPackageEvent(
        senderPubkey,
        currentUnixTimestampSeconds(),
        '1.0',
        '1',
        ['RequiredCapabilities,LastResort,RatchetTree,Unknown(62190)'],
        relays,
        '0xchat-lite',
        encodedKeyPackage,
        '', // eventId will be empty for one-time keypackages
      );

      // Create database record
      KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
        keyPackageEvent,
        type: KeyPackageType.oneTime,
        status: KeyPackageStatus.available,
      );

      // Save to database
      await KeyPackageManager.saveKeyPackage(keyPackageDB);

      print('Successfully processed one-time invite link from $senderPubkey');
      return true;
    } catch (e) {
      print('Failed to handle one-time invite link: $e');
      return false;
    }
  }

  /// Handle permanent invite link
  /// This method processes a permanent keypackage from an invite link
  /// Returns a tuple of (success, pubkey)
  static Future<Map<String, dynamic>> handlePermanentInviteLink({
    required String eventId,
    required List<String> relays,
  }) async {
    try {
      // Fetch the KeyPackageEvent from relay
      final keyPackageEvent = await _fetchKeyPackageFromRelay(eventId, relays);
      if (keyPackageEvent == null) {
        print('Failed to fetch keypackage event from relay');
        return {'success': false, 'pubkey': null};
      }
      
      // Create database record
      KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
        keyPackageEvent,
        type: KeyPackageType.permanent,
        status: KeyPackageStatus.available,
      );

      // Save to database
      await KeyPackageManager.saveKeyPackage(keyPackageDB);

      print('Successfully processed permanent invite link: $eventId');
      return {'success': true, 'pubkey': keyPackageEvent.pubkey};
    } catch (e) {
      print('Failed to handle permanent invite link: $e');
      return {'success': false, 'pubkey': null};
    }
  }

  /// Fetch KeyPackageEvent from relay
  static Future<KeyPackageEvent?> _fetchKeyPackageFromRelay(
      String eventId, List<String> relays) async {
    try {
      if (relays.isEmpty) {
        print('No relays provided for fetching keypackage');
        return null;
      }

      // First, try to find the keypackage in local database
      final isar = DBISAR.sharedInstance.isar;
      final localKeyPackage = isar.keyPackageDBISARs
          .where()
          .eventIdEqualTo(eventId)
          .findFirst();

      if (localKeyPackage != null) {
        print('Found keypackage in local database: $eventId');
        return localKeyPackage.toKeyPackageEvent();
      }

      print('Keypackage not found in local database, fetching from relay: $eventId');

      // If not found locally, fetch from relay
      final completer = Completer<KeyPackageEvent?>();
      final relayUrl = relays.first;
      
      // Check if already connected to the relay
      final connectedRelays = Connect.sharedInstance.relays();
      bool isConnected = connectedRelays.contains(relayUrl);
      
      if (isConnected) {
        // Already connected, make request immediately
        _makeKeyPackageRequest(eventId, completer);
      } else {
        // Not connected, listen for connection and then make request
        _listenForConnectionAndRequest(relayUrl, eventId, completer);
      }

      // Wait for response with timeout
      final result = await completer.future.timeout(Duration(seconds: 10));
      return result;
    } catch (e) {
      print('Error fetching keypackage from relay: $e');
      return null;
    }
  }

  /// Make keypackage request to relay
  static void _makeKeyPackageRequest(String eventId, Completer<KeyPackageEvent?> completer) {
    // Subscribe to the specific event
    final filter = Filter(ids: [eventId], kinds: [443]);
    Connect.sharedInstance.addSubscription(
      [filter],
      eventCallBack: (event, relay) {
        if (event.kind == 443) {
          final keyPackageEvent = Nip104.decodeKeyPackageEvent(event);
          completer.complete(keyPackageEvent);
        }
      },
      eoseCallBack: (requestId, ok, relay, unCompletedRelays) {
        if (!completer.isCompleted) {
          completer.complete(null);
        }
      },
    );
  }

  /// Listen for connection and then make request
  static void _listenForConnectionAndRequest(String relayUrl, String eventId, Completer<KeyPackageEvent?> completer) {    
     Future.delayed(Duration(seconds: 2), () {
        _makeKeyPackageRequest(eventId, completer);
     });
  }
}
