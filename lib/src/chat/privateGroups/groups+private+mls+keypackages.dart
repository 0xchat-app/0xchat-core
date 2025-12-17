import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:nostr_mls_package/nostr_mls_package.dart';
import 'package:convert/convert.dart';
import 'package:isar/isar.dart' hide Filter;

/// KeyPackage management for MLS private groups
/// Enhanced with support for one-time and permanent keypackages
extension GroupsPrivateMlsKeyPackages on Groups {
  /// Create new permanent key package and publish to relay
  Future<KeyPackageEvent?> createPermanentKeyPackage(List<String>? relays) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    try {
      KeyPackageEvent? result = await KeyPackageManager.createPermanentKeyPackage(
        ownerPubkey: pubkey,
        ownerPrivkey: privkey,
        relays: relays,
        client: KeyPackageClient.oxchatLite,
      );
      
      return result;
    } catch (e, stackTrace) {
      print('Failed to create permanent keypackage: $e $stackTrace');
      return null;
    }
  }

  /// Recreate permanent keypackage by deleting existing ones and creating a new one
  Future<KeyPackageEvent?> recreatePermanentKeyPackage(List<String>? relays) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    try {
      KeyPackageEvent? result = await KeyPackageManager.recreatePermanentKeyPackage(
        ownerPubkey: pubkey,
        ownerPrivkey: privkey,
        relays: relays,
        client: KeyPackageClient.oxchatLite,
      );
      
      return result;
    } catch (e, stackTrace) {
      print('Failed to recreate permanent keypackage: $e $stackTrace');
      return null;
    }
  }

  /// Create one-time keypackage for sharing
  Future<KeyPackageEvent?> createOneTimeKeyPackage({List<String>? relays}) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    return await KeyPackageManager.createOneTimeKeyPackage(
      ownerPubkey: pubkey,
      ownerPrivkey: privkey,
      relays: relays,
      client: KeyPackageClient.oxchatLite,
    );
  }

  /// Get key packages for multiple members
  Future<Map<String, String>> getMembersKeyPackages(
    List<String> pubkeys, {
    Future<KeyPackageSelectionResult?> Function(
            String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
  }) async {
    // Use the new KeyPackageManager
    return await KeyPackageManager.getMembersKeyPackages(
      pubkeys,
      onKeyPackageSelection: onKeyPackageSelection,
    );
  }

  /// Search key packages from relay
  Future<void> searchKeyPackagesFromRelay(String pubkey) async {
    await KeyPackageManager.searchAndStoreKeyPackages(pubkey);
  }

  /// Mark keypackage as used when processing welcome message
  Future<void> markKeyPackageAsUsed(
    String encodedKeyPackage, {
    String? usedByPubkey,
  }) async {
    await KeyPackageManager.markKeyPackageAsUsedByEncoded(
      encodedKeyPackage,
      usedByPubkey: usedByPubkey,
    );
  }

  /// Get keypackage statistics for a user
  Future<Map<String, int>> getKeyPackageStats(String pubkey) async {
    return await KeyPackageManager.getKeyPackageStats(pubkey);
  }

  /// Get available keypackages for a user
  Future<List<KeyPackageDBISAR>> getAvailableKeyPackages(String pubkey,
      {String? welcomeSenderPubkey}) async {
    return await KeyPackageManager.getAvailableLocalKeyPackages(pubkey,
        welcomeSenderPubkey: welcomeSenderPubkey);
  }

  /// Get keypackages by type
  Future<List<KeyPackageDBISAR>> getKeyPackagesByType(String pubkey, KeyPackageType type) async {
    return await KeyPackageManager.getLocalKeyPackagesByType(pubkey, type);
  }

  /// Track keypackage usage when processing welcome message
  /// Returns true if the welcome should be accepted, false if it should be rejected
  Future<bool> trackKeyPackageUsageForWelcome(
    GroupDBISAR group,
    String wrapperEventId,
    String welcomeSenderPubkey,
  ) async {
    try {
      // Get the welcome event to extract keypackage information
      if (group.welcomeEventString != null) {
        // Get available keypackages for the current user
        List<KeyPackageDBISAR> availableKeyPackages =
            await KeyPackageManager.getAvailableLocalKeyPackages(pubkey,
                welcomeSenderPubkey: welcomeSenderPubkey);

        if (availableKeyPackages.isNotEmpty) {
          // Extract encoded keypackages from available keypackages
          List<String> encodedKeyPackages =
              availableKeyPackages.map((kp) => kp.encodedKeyPackage).toList();

          // Convert wrapper event ID to bytes
          List<int> wrapperEventIdBytes = Uint8List.fromList(hex.decode(wrapperEventId));

          // Use the new findEncodedKeypackageFromWelcomeEvent method
          String result = await findEncodedKeypackageFromWelcomeEvent(
            encodedKeypackages: encodedKeyPackages,
            wrapperEventId: wrapperEventIdBytes,
            rumorEventString: group.welcomeEventString!,
          );

          Map<String, dynamic> resultMap = jsonDecode(result);

          if (resultMap['found'] == true) {
            int matchedIndex = resultMap['matched_index'];
            KeyPackageDBISAR matchedKeyPackage = availableKeyPackages[matchedIndex];
            // Mark the matched keypackage as used
            await KeyPackageManager.markKeyPackageAsUsed(
              matchedKeyPackage.keyPackageId,
              usedByPubkey: welcomeSenderPubkey, // Use the welcome sender's pubkey
            );

            return true; // Accept the welcome message
          } else {
            return false;
          }
        } else {
          print('No available keypackages found for user $pubkey');
          return false;
        }
      }
      return false; // Accept the welcome message if no welcome event string
    } catch (e, stackTrace) {
      print('Failed to track keypackage usage: $e $stackTrace');
      return false; // Accept the welcome message on error
    }
  }

  /// Track usage of one-time keypackages
  Future<void> trackOneTimeKeyPackageUsage(
      Map<String, String> membersKeyPackages, String groupId) async {
    try {
      for (String memberPubkey in membersKeyPackages.keys) {
        String encodedKeyPackage = membersKeyPackages[memberPubkey]!;

        // Get the keypackage from database to check its type
        final isar = DBISAR.sharedInstance.isar;
        final keyPackage =
            isar.keyPackageDBISARs.where().encodedKeyPackageEqualTo(encodedKeyPackage).findFirst();

        // Only mark as used if it's a one-time keypackage
        if (keyPackage != null && keyPackage.isOneTime) {
          await KeyPackageManager.markKeyPackageAsUsedByEncoded(
            encodedKeyPackage,
            usedByPubkey: Account.sharedInstance.currentPubkey,
          );

          print('Marked one-time keypackage for $memberPubkey as used for group $groupId');
        } else {
          print(
              'Skipped marking permanent keypackage for $memberPubkey as used for group $groupId');
        }
      }
    } catch (e) {
      print('Failed to track one-time keypackage usage: $e');
    }
  }

  Future<OKEvent> sendKeyPackageEventToMLSGroup(GroupDBISAR group) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    var relays = Account.sharedInstance.getCurrentCircleRelay();

    KeyPackageEvent? keyPackageEvent = await createPermanentKeyPackage(relays);
    if (keyPackageEvent == null) {
      completer.complete(OKEvent('', false, 'Failed to create keypackage'));
      return completer.future;
    }

    // Create sealed event for the target user
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
      pubkey,
      privkey,
    );

    return sendMessageToMLSGroup(group, event);
  }

  Future<void> handleKeyPackageEvent(Event event, String relay) async {
    KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);

    // Validate keypackage
    bool isValid = await KeyPackageManager.checkValidKeypackage(keyPackageEvent);
    if (!isValid) return;

    // Create database record
    KeyPackageDBISAR keyPackageDB = KeyPackageDBISAR.fromKeyPackageEvent(
      keyPackageEvent,
      type: KeyPackageType.permanent,
      status: KeyPackageStatus.available,
    );

    // Save to database
    await KeyPackageManager.saveKeyPackage(keyPackageDB);
  }

  Future<OKEvent> sendMyPrivateMetadataEvent(String topubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event? event = await Account.sharedInstance.getMyMetadataEvent();
    if (event == null) {
      // If failed to get metadata event, return error immediately
      return OKEvent('', false, 'Failed to get my metadata event');
    }
    Event sealedEvent = await Nip17.encode(
      event,
      topubkey,
      pubkey,
      privkey,
    );

    Connect.sharedInstance.sendEvent(sealedEvent, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(sealedEvent.id, ok.status, ok.message));
      }
    });
    return completer.future;
  }

  Future<void> handlePrivateMetadataEvent(Event event, String relay) async {
    UserDBISAR? db = await Account.sharedInstance.getUserFromDB(pubkey: event.pubkey);
    if (db == null) return;
    db = Account.sharedInstance.handleKind0Event(db, event);
    await Account.saveUserToDB(db!);
  }

  /// Enable discoverable by ID: Create and publish permanent keypackage to relay
  /// Returns true if successful, false otherwise
  Future<bool> enableDiscoverableByID({List<String>? relays}) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    try {
      // Create permanent keypackage
      KeyPackageEvent? keyPackageEvent = await createPermanentKeyPackage(relays);
      
      if (keyPackageEvent == null) {
        return false;
      }

      // Publish keypackage to relay
      OKEvent okEvent = await KeyPackageManager.publishKeyPackageEventToRelays(
        keyPackageEvent,
        relays,
        pubkey,
        privkey,
      );

      return okEvent.status;
    } catch (e, stackTrace) {
      print('Failed to enable discoverable by ID: $e $stackTrace');
      return false;
    }
  }

  /// Disable discoverable by ID: Delete all keypackage events from relay
  /// Returns true if successful, false otherwise
  Future<bool> disableDiscoverableByID({List<String>? relays}) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    try {
      OKEvent okEvent = await KeyPackageManager.deleteKeyPackageEventFromRelays(
        pubkey,
        privkey,
        relays,
      );

      return okEvent.status;
    } catch (e, stackTrace) {
      print('Failed to disable discoverable by ID: $e $stackTrace');
      return false;
    }
  }
}
