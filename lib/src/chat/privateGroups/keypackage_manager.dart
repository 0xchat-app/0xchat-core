import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:isar/isar.dart' hide Filter;
import 'package:nostr_mls_package/nostr_mls_package.dart';
import 'model/keyPackageDB_isar.dart';

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
  static Future<OKEvent> createOneTimeKeyPackage({
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

      // Decode KeyPackageEvent from the created event
      KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);

      // Create database record
      KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
        keyPackageEvent,
        type: KeyPackageType.oneTime,
        status: KeyPackageStatus.available,
      );

      // Save to database only (no relay publishing for one-time keypackages)
      await _saveKeyPackage(keyPackageDB);

      return OKEvent(
          keyPackageDB.keyPackageId, true, 'One-time keypackage created and stored locally');
    } catch (e) {
      LogUtils.e('Failed to create one-time keypackage: $e');
      return OKEvent('', false, e.toString());
    }
  }

  /// Create a permanent keypackage and sync to relay
  /// This keypackage can be used multiple times
  static Future<OKEvent> createPermanentKeyPackage({
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

      // Create event and publish to relay
      Event event = await Nip104.encodeKeyPackageEvent(
        parsedKeyPackage.encodedKeyPackage,
        parsedKeyPackage.tags,
        ownerPubkey,
        ownerPrivkey,
      );

      // Decode KeyPackageEvent from the created event
      KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);

      // Create database record
      KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
        keyPackageEvent,
        type: KeyPackageType.permanent,
        status: KeyPackageStatus.available,
      );

      // Save to database
      await _saveKeyPackage(keyPackageDB);

      // Publish to relay and return result
      return await _publishKeyPackageEvent(event, relays);
    } catch (e) {
      LogUtils.e('Failed to create permanent keypackage: $e');
      return OKEvent('', false, e.toString());
    }
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

      return keyPackages;
    } catch (e) {
      LogUtils.e('Failed to get available keypackages: $e');
      return [];
    }
  }

  /// Get keypackages by type
  static Future<List<KeyPackageDBISAR>> getLocalKeyPackagesByType(String pubkey, KeyPackageType type) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      final keyPackages = isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .typeEqualTo(type.value)
          .sortByCreateTimeDesc()
          .findAll();

      return keyPackages;
    } catch (e) {
      LogUtils.e('Failed to get keypackages by type: $e');
      return [];
    }
  }

  /// Get keypackages for multiple users
  static Future<Map<String, String>> getMembersKeyPackages(
    List<String> pubkeys, {
    Future<KeyPackageSelectionResult?> Function(String pubkey, List<KeyPackageEvent> availableKeyPackages)?
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
    Future<KeyPackageSelectionResult?> Function(String pubkey, List<KeyPackageEvent> availableKeyPackages)?
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
    await searchAndStoreKeyPackages(pubkey);

    // Get all keypackages (local + relay)
    List<KeyPackageEvent> availableKeyPackages =
        localKeyPackages.map((kp) => kp.toKeyPackageEvent()).toList();

         // If no 0xchat-lite keypackages locally, search relay and let upper layer choose
     if (onKeyPackageSelection != null) {
       KeyPackageSelectionResult? result = await onKeyPackageSelection(pubkey, availableKeyPackages);
       if (result?.keyPackage != null) {
         // Find the keypackage ID for the selected keypackage
         KeyPackageDBISAR? selectedKeyPackageDB = localKeyPackages
             .where((kp) => kp.encodedKeyPackage == result!.keyPackage)
             .firstOrNull;
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
     return availableKeyPackages.first.encoded_key_package;
  }

  /// Search for keypackages on relay and store them locally
  static Future<void> searchAndStoreKeyPackages(String pubkey) async {
    try {
      Completer<void> completer = Completer<void>();
      List<Event> cachedEvents = [];
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
            await _saveKeyPackage(keyPackageDB);
          } catch (e) {
            LogUtils.e('Failed to process keypackage event: $e');
            continue;
          }
        }

        if (!completer.isCompleted) {
          completer.complete();
        }
      });

      await completer.future;
    } catch (e) {
      LogUtils.e('Failed to search keypackages: $e');
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
        await isar.writeAsync((isar) {
          isar.keyPackageDBISARs.put(keyPackage);
        });
      }
    } catch (e) {
      LogUtils.e('Failed to mark keypackage as used: $e');
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
      final keyPackage = isar.keyPackageDBISARs
          .where()
          .encodedKeyPackageEqualTo(encodedKeyPackage)
          .findFirst();

      if (keyPackage != null) {
        keyPackage.markAsUsed(groupId: groupId, eventId: eventId);
        await isar.writeAsync((isar) {
          isar.keyPackageDBISARs.put(keyPackage);
        });
      }
    } catch (e) {
      LogUtils.e('Failed to mark keypackage as used: $e');
    }
  }

  static Future<void> _saveKeyPackage(KeyPackageDBISAR keyPackage) async {
    try {
      final isar = DBISAR.sharedInstance.isar;
      await isar.writeAsync((isar) {
        isar.keyPackageDBISARs.put(keyPackage);
      });
    } catch (e) {
      LogUtils.e('Failed to save keypackage: $e');
    }
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
      bool basicValid = _areListsEqual(keyPackageEvent.extensions, [extensions]) &&
          ciphersuite == keyPackageEvent.ciphersuite;

      if (!basicValid) return false;

      // Check if relays are not empty and contain current circle relay
      if (keyPackageEvent.relays.isEmpty) {
        return false;
      }

      List<String> currentCircleRelays = Account.sharedInstance.getCurrentCircleRelay();
      if (currentCircleRelays.isEmpty) {
        return false;
      }

      bool hasMatchingRelay = false;
      for (String circleRelay in currentCircleRelays) {
        if (keyPackageEvent.relays.contains(circleRelay)) {
          hasMatchingRelay = true;
          break;
        }
      }

      if (!hasMatchingRelay) {
        return false;
      }

      // Accept any valid keypackage with a known client
      return keyPackageEvent.client.isNotEmpty;
    } catch (e) {
      LogUtils.e('Failed to check keypackage validity: $e');
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
      LogUtils.e('Failed to update user last selected keypackage ID: $e');
    }
  }

  /// Get keypackage statistics
  static Future<Map<String, int>> getKeyPackageStats(String pubkey) async {
    try {
      final isar = DBISAR.sharedInstance.isar;

      final total = await isar.keyPackageDBISARs.where().ownerPubkeyEqualTo(pubkey).count();

      final available = await isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .statusEqualTo(KeyPackageStatus.available.value)
          .count();

      final used = await isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .statusEqualTo(KeyPackageStatus.used.value)
          .count();

      final oneTime = await isar.keyPackageDBISARs
          .where()
          .ownerPubkeyEqualTo(pubkey)
          .and()
          .typeEqualTo(KeyPackageType.oneTime.value)
          .count();

      final permanent = await isar.keyPackageDBISARs
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
      LogUtils.e('Failed to get keypackage stats: $e');
      return {};
    }
  }
}
