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
      
      if (result == null) {
        // Existing permanent keypackage found, no need to create new one
        LogUtils.d('Using existing permanent keypackage for user $pubkey');
        return null;
      }
      
      return result;
    } catch (e) {
      LogUtils.e('Failed to create permanent keypackage: $e');
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
    String? groupId,
    String? eventId,
  }) async {
    await KeyPackageManager.markKeyPackageAsUsedByEncoded(
      encodedKeyPackage,
      groupId: groupId,
      eventId: eventId,
    );
  }

  /// Get keypackage statistics for a user
  Future<Map<String, int>> getKeyPackageStats(String pubkey) async {
    return await KeyPackageManager.getKeyPackageStats(pubkey);
  }

  /// Get available keypackages for a user
  Future<List<KeyPackageDBISAR>> getAvailableKeyPackages(String pubkey) async {
    return await KeyPackageManager.getAvailableLocalKeyPackages(pubkey);
  }

  /// Get keypackages by type
  Future<List<KeyPackageDBISAR>> getKeyPackagesByType(String pubkey, KeyPackageType type) async {
    return await KeyPackageManager.getLocalKeyPackagesByType(pubkey, type);
  }

  /// Track keypackage usage when processing welcome message
  Future<void> trackKeyPackageUsageForWelcome(GroupDBISAR group, String wrapperEventId) async {
    try {
      // Get the welcome event to extract keypackage information
      if (group.welcomeEventString != null) {
        // Get available keypackages for the current user
        List<KeyPackageDBISAR> availableKeyPackages =
            await KeyPackageManager.getAvailableLocalKeyPackages(pubkey);

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
            // Mark the matched keypackage as used
            KeyPackageDBISAR usedKeyPackage = availableKeyPackages[matchedIndex];
            await KeyPackageManager.markKeyPackageAsUsed(
              usedKeyPackage.keyPackageId,
              groupId: group.privateGroupId,
              eventId: wrapperEventId,
            );

            LogUtils.d(
                'Marked keypackage ${usedKeyPackage.keyPackageId} as used for group ${group.privateGroupId}');
          } else {
            LogUtils.d(
                'No matching keypackage found in welcome event for group ${group.privateGroupId}');
          }
        } else {
          LogUtils.d('No available keypackages found for user $pubkey');
        }
      }
    } catch (e) {
      LogUtils.e('Failed to track keypackage usage: $e');
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
            groupId: groupId,
            eventId: '', // No specific event ID for group creation
          );

          LogUtils.d('Marked one-time keypackage for $memberPubkey as used for group $groupId');
        } else {
          LogUtils.d(
              'Skipped marking permanent keypackage for $memberPubkey as used for group $groupId');
        }
      }
    } catch (e) {
      LogUtils.e('Failed to track one-time keypackage usage: $e');
    }
  }

  Future<void> sendPrivateKeyPackageEvent(Event event, String toPubkey, List<String> relays) async {
    Event giftWrappedEvent = await Nip59.encode(event, toPubkey);
    Connect.sharedInstance.sendEvent(giftWrappedEvent, toRelays: relays);
  }

  Future<void> handlePrivateKeyPackageEvent(Event event, String relay) async {
    //todo: handle private key package event
  }
}
