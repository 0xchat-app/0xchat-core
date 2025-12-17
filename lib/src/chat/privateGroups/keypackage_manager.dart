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
          await getLocalKeyPackagesByType(
              ownerPubkey, KeyPackageType.permanent);

      if (existingPermanentKeyPackages.isNotEmpty) {
        // Use existing permanent keypackage
        KeyPackageDBISAR existingKeyPackage =
            existingPermanentKeyPackages.first;
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
      return keyPackageEvent;
    } catch (e, stackTrace) {
      print('Failed to create permanent keypackage: $e $stackTrace');
      return null;
    }
  }

  static Future<OKEvent> publishKeyPackageEventToRelays(
      KeyPackageEvent keyPackageEvent,
      List<String> relays,
      String ownerPubkey,
      String ownerPrivkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    List<List<String>> tags = [
      ['mls_protocol_version', keyPackageEvent.mls_protocol_version],
      ['mls_ciphersuite', keyPackageEvent.ciphersuite],
      ['mls_extensions', ...keyPackageEvent.extensions],
      ['relays', ...keyPackageEvent.relays],
      ['client', keyPackageEvent.client],
    ];
    Event event = await Nip104.encodeKeyPackageEvent(
      keyPackageEvent.encoded_key_package,
      tags,
      ownerPubkey,
      ownerPrivkey,
    );

    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      // Only save to database and mark as published if successful
      if (ok.status) {
        await saveKeyPackageEventToDB(event, KeyPackageType.permanent);
      }
      
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    }, toRelays: relays);
    return completer.future;
  }

  static Future<OKEvent> deleteKeyPackageEventFromRelays(
      String ownerPubkey, String ownerPrivkey, List<String> relays) async {
    try {
      // Get all local keypackages (both permanent and one-time)
      List<KeyPackageDBISAR> permanentKeyPackages =
          await getLocalKeyPackagesByType(
              ownerPubkey, KeyPackageType.permanent);
      List<KeyPackageDBISAR> oneTimeKeyPackages =
          await getLocalKeyPackagesByType(ownerPubkey, KeyPackageType.oneTime);

      // Combine all keypackages
      List<KeyPackageDBISAR> allKeyPackages = [
        ...permanentKeyPackages,
        ...oneTimeKeyPackages,
      ];

      // Extract all event ids (filter out empty ones)
      List<String> eventIds = allKeyPackages
          .where((kp) => kp.eventId.isNotEmpty)
          .map((kp) => kp.eventId)
          .toList();

      // Delete all keypackages from relay
      if (eventIds.isNotEmpty) {
        return await _deleteKeyPackagesFromRelay(eventIds, relays, allKeyPackages);
      } else {
        // Return a completed completer with a dummy OKEvent if no events to delete
        Completer<OKEvent> completer = Completer<OKEvent>();
        completer.complete(OKEvent('', true, 'No keypackages to delete'));
        return completer.future;
      }
    } catch (e) {
      print('Failed to delete keypackage events from relays: $e');
      Completer<OKEvent> completer = Completer<OKEvent>();
      completer.complete(
          OKEvent('', false, 'Failed to delete keypackage events: $e'));
      return completer.future;
    }
  }

  /// Recreate permanent keypackage by deleting existing ones and creating a new one
  /// This method deletes all existing permanent keypackages from relay and database, then creates a new one
  static Future<KeyPackageEvent?> recreatePermanentKeyPackage({
    required String ownerPubkey,
    required String ownerPrivkey,
    List<String>? relays,
    KeyPackageClient client = KeyPackageClient.oxchatLite,
  }) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    try {
      // First, delete all existing permanent keypackages from relay and database
      await _deleteAllPermanentKeyPackages(ownerPubkey, relays);

      // Then create a new permanent keypackage
      return await createPermanentKeyPackage(
        ownerPubkey: ownerPubkey,
        ownerPrivkey: ownerPrivkey,
        relays: relays,
        client: client,
      );
    } catch (e, stackTrace) {
      print('Failed to recreate permanent keypackage: $e $stackTrace');
      return null;
    }
  }

  /// Delete all permanent keypackages for a user from relay and database
  static Future<void> _deleteAllPermanentKeyPackages(
      String ownerPubkey, List<String> relays) async {
    try {
      // Get all permanent keypackages from database
      List<KeyPackageDBISAR> permanentKeyPackages =
          await getLocalKeyPackagesByType(
              ownerPubkey, KeyPackageType.permanent);
      // Delete from relay and database
      await _deleteKeyPackageFromDB(permanentKeyPackages);
      await _deleteKeyPackagesFromRelay(
          permanentKeyPackages.map((e) => e.eventId).toList(), relays, permanentKeyPackages);
    } catch (e) {
      print('Failed to delete permanent keypackages: $e');
    }
  }

  static Future<void> deleteAllKeyPackagesFromUser(String pubkey) async {
    try {
      List<KeyPackageDBISAR> keyPackages =
          await getLocalKeyPackagesByType(pubkey, KeyPackageType.permanent);
      await _deleteKeyPackageFromDB(keyPackages);
    } catch (e) {
      print('Failed to delete all keypackages from user: $e');
    }
  }

  /// Delete keypackage from relay
  static Future<OKEvent> _deleteKeyPackagesFromRelay(
      List<String> keyPackageEventIds, List<String> relays, List<KeyPackageDBISAR> keyPackages) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    /// send delete event to relay
    Event event = await Nip9.encode(
        keyPackageEventIds,
        '',
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      // Only mark as not published if deletion was successful
      if (ok.status) {
        for (KeyPackageDBISAR keyPackage in keyPackages) {
          if (keyPackage.isPublished) {
            keyPackage.isPublished = false;
            await KeyPackageManager.saveKeyPackage(keyPackage);
          }
        }
      }
      
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  static Future<void> saveKeyPackageEventToDB(
      Event event, KeyPackageType type) async {
    KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);

    try {
      final isar = DBISAR.sharedInstance.isar;
      
      // Check if a keypackage with the same encodedKeyPackage already exists
      KeyPackageDBISAR? existingKeyPackage = await isar.keyPackageDBISARs
          .where()
          .encodedKeyPackageEqualTo(keyPackageEvent.encoded_key_package)
          .findFirst();

      if (existingKeyPackage != null) {
        // Update existing record with new event information
        existingKeyPackage.eventId = keyPackageEvent.eventId;
        existingKeyPackage.isPublished = true; // Mark as published
        // Save updated record
        await KeyPackageManager.saveKeyPackage(existingKeyPackage);
      } else {
        // Create new database record
        KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
          keyPackageEvent,
          type: type,
          status: KeyPackageStatus.available,
          isPublished: true, // Mark as published
        );
        // Save to database
        await KeyPackageManager.saveKeyPackage(keyPackageDB);
      }
    } catch (e) {
      print('Failed to save keypackage event to DB: $e');
      // Fallback to original behavior if update fails
      KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
        keyPackageEvent,
        type: type,
        status: KeyPackageStatus.available,
        isPublished: true, // Mark as published
      );
      await KeyPackageManager.saveKeyPackage(keyPackageDB);
    }
  }

  /// Get available keypackages for a user
  static Future<List<KeyPackageDBISAR>> getAvailableLocalKeyPackages(
      String pubkey,
      {String? welcomeSenderPubkey}) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final allKeyPackages = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .sortByCreateTimeDesc()
          .findAll();

      // Filter out one-time keypackages that have been used by a different user
      List<KeyPackageDBISAR> availableKeyPackages = [];
      String currentPubkey = Account.sharedInstance.currentPubkey;

      for (KeyPackageDBISAR keyPackage in allKeyPackages) {
        // For one-time keypackages, check if they've been used by a different user
        if (keyPackage.isOneTime &&
            keyPackage.usedByPubkey != null &&
            welcomeSenderPubkey != null &&
            keyPackage.usedByPubkey != welcomeSenderPubkey) {
          continue;
        }

        // Only verify keypackages in nostr_mls storage if this is the current user's keypackages
        if (pubkey == currentPubkey) {
          bool existsInStorage =
              await _verifyKeyPackageInStorage(keyPackage.encodedKeyPackage);
          if (existsInStorage) {
            availableKeyPackages.add(keyPackage);
          } else {
            // Remove from database if not found in nostr_mls storage
            await _deleteKeyPackageFromDB([keyPackage]);
          }
        } else {
          availableKeyPackages.add(keyPackage);
        }
      }

      return availableKeyPackages;
    } catch (e) {
      return [];
    }
  }

  static Future<KeyPackageDBISAR?> getKeyPackageById(
      String keyPackageId) async {
    final isar = DBISAR.sharedInstance.isar;
    KeyPackageDBISAR? keyPackage = isar.keyPackageDBISARs
        .where()
        .keyPackageIdEqualTo(keyPackageId)
        .findFirst();

    if (keyPackage != null) {
      // Only verify keypackage in nostr_mls storage if this is the current user's keypackage
      String currentPubkey = Account.sharedInstance.currentPubkey;
      if (keyPackage.ownerPubkey == currentPubkey) {
        bool existsInStorage =
            await _verifyKeyPackageInStorage(keyPackage.encodedKeyPackage);
        if (!existsInStorage) {
          // Remove from database if not found in nostr_mls storage
          await _deleteKeyPackageFromDB([keyPackage]);
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
          bool existsInStorage =
              await _verifyKeyPackageInStorage(keyPackage.encodedKeyPackage);
          if (existsInStorage) {
            validKeyPackages.add(keyPackage);
          } else {
            // Remove from database if not found in nostr_mls storage
            await _deleteKeyPackageFromDB([keyPackage]);
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
    // First check if user has a scanned keypackage ID (highest priority)
    UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
    // Second check if user has a last selected keypackage ID
    if (user?.lastSelectedKeyPackageId != null &&
        user!.lastSelectedKeyPackageId!.isNotEmpty) {
      // Try to get the last selected keypackage
      final isar = DBISAR.sharedInstance.isar;
      final lastSelectedKeyPackage = isar.keyPackageDBISARs
          .where()
          .keyPackageIdEqualTo(user.lastSelectedKeyPackageId!)
          .findFirst();

      if (lastSelectedKeyPackage != null &&
          lastSelectedKeyPackage.isAvailable) {
        return lastSelectedKeyPackage.encodedKeyPackage;
      }
    }

    // If no last selected keypackage or it's not available, proceed with normal logic
    // First try local database - prioritize XChat client
    List<KeyPackageDBISAR> localKeyPackages =
        await getAvailableLocalKeyPackages(pubkey);

    if (localKeyPackages.isNotEmpty) {
      // First try to find XChat client keypackages
      List<KeyPackageDBISAR> oxchatLiteKeyPackages = localKeyPackages
          .where((kp) => kp.keyPackageClient == KeyPackageClient.oxchatLite)
          .toList();

      if (oxchatLiteKeyPackages.isNotEmpty) {
        // Prefer permanent keypackages
        KeyPackageDBISAR? permanentKeyPackage =
            oxchatLiteKeyPackages.where((kp) => kp.isPermanent).firstOrNull;
        if (permanentKeyPackage != null) {
          return permanentKeyPackage.encodedKeyPackage;
        }

        // Return first available XChat keypackage
        return oxchatLiteKeyPackages.first.encodedKeyPackage;
      }
    }
    // If the user is the current user, create a permanent keypackage
    else if (pubkey == Account.sharedInstance.currentPubkey) {
      KeyPackageEvent? keyPackageEvent = await createPermanentKeyPackage(
          ownerPubkey: Account.sharedInstance.currentPubkey,
          ownerPrivkey: Account.sharedInstance.currentPrivkey);
      if (keyPackageEvent != null) {
        return keyPackageEvent.encoded_key_package;
      }
    }

    // Search relay for more keypackages
    List<KeyPackageEvent> relayKeyPackages =
        await searchAndStoreKeyPackages(pubkey);

    // Combine local and relay keypackages
    List<KeyPackageEvent> localKeyPackageEvents =
        localKeyPackages.map((kp) => kp.toKeyPackageEvent()).toList();
    List<KeyPackageEvent> availableKeyPackages = [
      ...localKeyPackageEvents,
      ...relayKeyPackages
    ];

    // search all keypackages (local + relay)
    List<KeyPackageEvent> oxchatLiteKeyPackages = availableKeyPackages
        .where((kp) => kp.client == KeyPackageClient.oxchatLite.value)
        .toList();
    if (oxchatLiteKeyPackages.isNotEmpty) {
      return oxchatLiteKeyPackages.first.encoded_key_package;
    }

    // If no XChat keypackages locally, search relay and let upper layer choose
    if (onKeyPackageSelection != null) {
      KeyPackageSelectionResult? result =
          await onKeyPackageSelection(pubkey, availableKeyPackages);
      if (result?.keyPackage != null) {
        // Find the keypackage ID for the selected keypackage
        KeyPackageDBISAR? selectedKeyPackageDB = localKeyPackages
            .where((kp) => kp.encodedKeyPackage == result!.keyPackage)
            .firstOrNull;
        if (selectedKeyPackageDB != null) {
          if (result!.rememberSelection) {
            // Remember the selection
            await updateUserLastSelectedKeyPackageId(
                pubkey, selectedKeyPackageDB.keyPackageId);
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
  static Future<List<KeyPackageEvent>> searchAndStoreKeyPackages(
      String pubkey) async {
    try {
      Completer<List<KeyPackageEvent>> completer =
          Completer<List<KeyPackageEvent>>();
      List<Event> cachedEvents = [];
      List<KeyPackageEvent> relayKeyPackages = [];
      Filter filter = Filter(kinds: [443], authors: [pubkey], limit: 10);

      Connect.sharedInstance.addSubscription([filter],
          eventCallBack: (event, relay) async {
        cachedEvents.add(event);
      }, eoseCallBack: (requestId, ok, relay, unRelays) async {
        for (Event event in cachedEvents) {
          try {
            KeyPackageEvent keyPackageEvent =
                Nip104.decodeKeyPackageEvent(event);

            // Validate keypackage
            bool isValid = await checkValidKeypackage(keyPackageEvent);
            if (!isValid) continue;

            // Determine type based on client or other criteria
            KeyPackageType type = _determineKeyPackageType(keyPackageEvent);

            // Create database record
            KeyPackageDBISAR keyPackageDB =
                KeyPackageDBISAR.fromKeyPackageEvent(
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
    String? usedByPubkey,
  }) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final keyPackage = isar.keyPackageDBISARs
          .where()
          .keyPackageIdEqualTo(keyPackageId)
          .findFirst();

      if (keyPackage != null) {
        // For one-time keypackages, check if it's already used by a different user
        if (keyPackage.isOneTime && keyPackage.usedByPubkey != null) {
          // If it's already used by a different user, don't allow reuse
          if (usedByPubkey != null && keyPackage.usedByPubkey != usedByPubkey) {
            print(
                'One-time keypackage ${keyPackage.keyPackageId} already used by user ${keyPackage.usedByPubkey}, cannot be used by $usedByPubkey');
            return;
          }
        }

        keyPackage.markAsUsed(usedByPubkey: usedByPubkey);
        await DBISAR.sharedInstance.saveToDB(keyPackage);
      }
    } catch (e) {
      print('Failed to mark keypackage as used: $e');
    }
  }

  /// Mark a keypackage as used by encoded keypackage
  static Future<void> markKeyPackageAsUsedByEncoded(
    String encodedKeyPackage, {
    String? usedByPubkey,
  }) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final keyPackage = isar.keyPackageDBISARs
          .where()
          .encodedKeyPackageEqualTo(encodedKeyPackage)
          .findFirst();

      if (keyPackage != null) {
        // For one-time keypackages, check if it's already used by a different user
        if (keyPackage.isOneTime && keyPackage.usedByPubkey != null) {
          // If it's already used by a different user, don't allow reuse
          if (usedByPubkey != null && keyPackage.usedByPubkey != usedByPubkey) {
            print(
                'One-time keypackage ${keyPackage.keyPackageId} already used by user ${keyPackage.usedByPubkey}, cannot be used by $usedByPubkey');
            return;
          }
        }

        keyPackage.markAsUsed(usedByPubkey: usedByPubkey);
        await DBISAR.sharedInstance.saveToDB(keyPackage);
      }
    } catch (e) {
      print('Failed to mark keypackage as used: $e');
    }
  }

  static Future<void> saveKeyPackage(KeyPackageDBISAR keyPackage) async {
    await DBISAR.sharedInstance.saveToDB(keyPackage);
  }

  /// Record scanned keypackage ID to user for priority selection
  static Future<void> recordScannedKeyPackageId(
      String senderPubkey, String? keyPackageId) async {
    try {
      UserDBISAR? user = await Account.sharedInstance.getUserInfo(senderPubkey);
      if (user != null) {
        // Generate keypackage ID from the scanned data
        if (keyPackageId != null && keyPackageId.isNotEmpty) {
          user.lastSelectedKeyPackageId = keyPackageId;
          await Account.saveUserToDB(user);
          // Groups.sharedInstance.sendMyPrivateMetadataEvent(senderPubkey);
        }
      }
    } catch (e) {
      print('Error recording scanned keypackage ID: $e');
    }
  }

  static Future<OKEvent> _publishKeyPackageEvent(
      Event event, List<String> relays) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(event, toRelays: relays,
        sendCallBack: (ok, relay) {
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

  static Future<bool> checkValidKeypackage(
      KeyPackageEvent keyPackageEvent) async {
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
    return Set.from(list1).containsAll(list2) &&
        Set.from(list2).containsAll(list1);
  }

  /// Update user's last selected keypackage ID
  static Future<void> updateUserLastSelectedKeyPackageId(
      String pubkey, String keyPackageId) async {
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

      final total =
          isar.keyPackageDBISARs.where().ownerPubkeyEqualTo(pubkey).count();

      // Count keypackages that have been used (have usedByPubkey)
      final used = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .usedByPubkeyIsNotNull()
          .count();

      // Count keypackages that haven't been used (usedByPubkey is null)
      final available = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .usedByPubkeyIsNull()
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
  static Future<bool> _verifyKeyPackageInStorage(
      String encodedKeyPackage) async {
    try {
      String result = await getKeyPackageFromStorage(
          serializedKeyPackage: encodedKeyPackage);
      Map<String, dynamic> resultMap = jsonDecode(result);
      return resultMap['found'] == true;
    } catch (e) {
      print('Failed to verify keypackage in storage: $e');
      return false;
    }
  }

  /// Delete keypackage from database
  static Future<void> _deleteKeyPackageFromDB(
      List<KeyPackageDBISAR> keyPackages) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      await isar.writeAsync((isar) {
        for (var keyPackage in keyPackages) {
          isar.keyPackageDBISARs
              .where()
              .keyPackageIdEqualTo(keyPackage.keyPackageId)
              .deleteAll();
        }
      });
    } catch (e) {
      print('Failed to delete keypackage from database: $e');
    }
  }

  /// Handle one-time invite link
  /// This method processes a one-time keypackage from an invite link
  static Future<String> handleOneTimeInviteLink({
    required String encodedKeyPackage,
    required String senderPubkey,
    required List<String> relays,
  }) async {
    try {
      // First check if the encodedKeyPackage already exists in database
      final isar = DBISAR.sharedInstance.isar;
      final existingKeyPackage = isar.keyPackageDBISARs
          .where()
          .encodedKeyPackageEqualTo(encodedKeyPackage)
          .findFirst();

      if (existingKeyPackage != null) {
        return existingKeyPackage.keyPackageId;
      }

      // Create KeyPackageEvent from the encoded keypackage
      final keyPackageEvent = KeyPackageEvent(
        senderPubkey,
        currentUnixTimestampSeconds(),
        '1.0',
        '1',
        ['RequiredCapabilities,LastResort,RatchetTree,Unknown(62190)'],
        relays,
        'XChat',
        encodedKeyPackage,
        '', // eventId will be empty for one-time keypackages
      );

      // Create database record
      KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
        keyPackageEvent,
        type: KeyPackageType.permanent,
        status: KeyPackageStatus.available,
      );

      await KeyPackageManager.deleteAllKeyPackagesFromUser(senderPubkey);
      // Save to database
      await KeyPackageManager.saveKeyPackage(keyPackageDB);

      print('Successfully processed one-time invite link from $senderPubkey');
      return keyPackageDB.keyPackageId;
    } catch (e) {
      print('Failed to handle one-time invite link: $e');
      return '';
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
      // First try to fetch from local database
      var keyPackageDB = await _fetchKeyPackageFromLocal(eventId);
      if (keyPackageDB != null) {
        print('Found keypackage in local database: $eventId');
        return {
          'success': true,
          'pubkey': keyPackageDB.ownerPubkey,
          'keyPackageId': keyPackageDB.keyPackageId
        };
      }

      // If not found locally, fetch from relay
      final relayKeyPackageEvent =
          await _fetchKeyPackageFromRelay(eventId, relays);
      if (relayKeyPackageEvent == null) {
        print('Failed to fetch keypackage event from relay');
        return {'success': false, 'pubkey': null};
      }

      // Create database record
      keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
        relayKeyPackageEvent,
        type: KeyPackageType.permanent,
        status: KeyPackageStatus.available,
      );

      await KeyPackageManager.deleteAllKeyPackagesFromUser(
          relayKeyPackageEvent.pubkey);
      // Save to database
      await KeyPackageManager.saveKeyPackage(keyPackageDB);

      print('Successfully processed permanent invite link: $eventId');
      return {
        'success': true,
        'pubkey': relayKeyPackageEvent.pubkey,
        'keyPackageId': keyPackageDB.keyPackageId
      };
    } catch (e) {
      print('Failed to handle permanent invite link: $e');
      return {'success': false, 'pubkey': null};
    }
  }

  /// Fetch KeyPackageEvent from local database
  static Future<KeyPackageDBISAR?> _fetchKeyPackageFromLocal(
      String eventId) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final localKeyPackage =
          isar.keyPackageDBISARs.where().eventIdEqualTo(eventId).findFirst();

      if (localKeyPackage != null) {
        return localKeyPackage;
      }
      return null;
    } catch (e) {
      print('Error fetching keypackage from local database: $e');
      return null;
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

      print('Fetching keypackage from relay: $eventId');

      // Fetch from relay
      final completer = Completer<KeyPackageEvent?>();
      final relayUrl = relays.first;

      // Check if already connected to the relay
      final connectedRelays =
          Connect.sharedInstance.relays(relayKinds: [RelayKind.circleRelay]);
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
  static void _makeKeyPackageRequest(
      String eventId, Completer<KeyPackageEvent?> completer) {
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
  static void _listenForConnectionAndRequest(
      String relayUrl, String eventId, Completer<KeyPackageEvent?> completer) {
    // Add connection status listener
    ConnectStatusCallBack? connectionListener;
    connectionListener = (relay, ConnectStatus status, relayKinds) {
      if (relay == relayUrl && status == ConnectStatus.open) {
        // status 1 = connected
        // Remove the listener to avoid multiple calls
        Connect.sharedInstance.removeConnectStatusListener(connectionListener!);
        // Make the request once connected
        _makeKeyPackageRequest(eventId, completer);
      }
    };

    Connect.sharedInstance.addConnectStatusListener(connectionListener);

    // Also connect to the relay if not already connected
    Connect.sharedInstance.connect(relayUrl, relayKind: RelayKind.circleRelay);

    // Add a fallback timeout in case connection fails
    Timer(Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        Connect.sharedInstance.removeConnectStatusListener(connectionListener!);
        completer.complete(null);
      }
    });
  }
}
