import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:nostr_mls_package/nostr_mls_package.dart';
import 'groups.dart';

/// KeyPackage management for MLS private groups
extension GroupsPrivateMlsKeyPackages on Groups {
  /// Check and manage key packages for current user
  Future<void> checkKeyPackage({List<String>? relays}) async {
    // Get all key packages from relay with force refresh to ensure we get latest data
    Map<String, List<KeyPackageEvent>> categorizedKeyPackages =
        await _getAllKeyPackagesFromRelay(this.pubkey, forceRefresh: true, loadLocal: false);

    // Clean up relay keypackages: delete unknown clients and keep only latest for each client
    await _cleanupRelayKeyPackages(categorizedKeyPackages, relays);

    List<KeyPackageEvent> oxchatLiteKeyPackages = categorizedKeyPackages['0xchat-lite'] ?? [];

    if (oxchatLiteKeyPackages.isNotEmpty) {
      // Found 0xchat-lite key packages on relay, check if we can use any of them locally
      KeyPackageEvent? validKeyPackage;

      for (KeyPackageEvent keyPackageEvent in oxchatLiteKeyPackages) {
        String encoded_key_package = keyPackageEvent.encoded_key_package;
        String result = await getKeyPackageFromStorage(serializedKeyPackage: encoded_key_package);
        bool found = jsonDecode(result)['found'];

        if (found) {
          // Found a valid key package locally, use it
          validKeyPackage = keyPackageEvent;
          break;
        }
      }

      if (validKeyPackage != null) {
        // Use the first valid key package found
        Account.sharedInstance.me!.setSelectedKeyPackageEvent(validKeyPackage);
        Account.sharedInstance.syncMe();
      } else {
        // No valid key package found locally, create new one
        _createNewKeyPackage([]);
      }
    } else {
      // No 0xchat-lite key package found on relay, create new one
      _createNewKeyPackage([]);
    }
  }

  /// Create new key package and publish to relay
  Future<OKEvent> _createNewKeyPackage(List<String> relays) async {
    if (relays.isEmpty) {
      List<String> generalRelays = Account.sharedInstance.getCurrentCircleRelay();
      relays = generalRelays;
    }
    String result = await createKeyPackageForEvent(
        publicKey: this.pubkey, relay: relays, client: '0xchat-lite');
    ParsedKeyPackage parsedKeyPackage = parseKeyPackageString(result);
    Event event = await Nip104.encodeKeyPackageEvent(
        parsedKeyPackage.encodedKeyPackage, parsedKeyPackage.tags, this.pubkey, this.privkey);

    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(event, toRelays: relays, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        if (ok.status) {
          // Create KeyPackageEvent from the parsed data
          KeyPackageEvent keyPackageEvent = KeyPackageEvent(
              this.pubkey,
              currentUnixTimestampSeconds(),
              '',
              '',
              [],
              relays,
              '0xchat-lite',
              parsedKeyPackage.encodedKeyPackage,
              event.id);
          Account.sharedInstance.me!.setSelectedKeyPackageEvent(keyPackageEvent);
          Account.sharedInstance.syncMe();
        }
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  /// Get key packages for multiple members
  Future<Map<String, String>> getMembersKeyPackages(
    List<String> pubkeys, {
    Future<String?> Function(String pubkey, List<KeyPackageEvent> availableKeyPackages)?
        onKeyPackageSelection,
    bool forceRefresh = false,
  }) async {
    Map<String, String> result = {};
    for (var pubkey in pubkeys) {
      // Get all key packages in one request
      Map<String, List<KeyPackageEvent>> categorizedKeyPackages =
          await _getAllKeyPackagesFromRelay(pubkey, forceRefresh: forceRefresh);

      // First try to use 0xchat-lite key package
      List<KeyPackageEvent> oxchatLiteKeyPackages = categorizedKeyPackages['0xchat-lite'] ?? [];
      if (oxchatLiteKeyPackages.isNotEmpty) {
        // Use the first 0xchat-lite key package (no need to check local storage for other users)
        result[pubkey] = oxchatLiteKeyPackages.first.encoded_key_package;
      } else {
        // No 0xchat-lite key package found, collect all other available key packages
        List<KeyPackageEvent> allOtherKeyPackages = [];
        for (var entry in categorizedKeyPackages.entries) {
          if (entry.key != '0xchat-lite') {
            allOtherKeyPackages.addAll(entry.value);
          }
        }

        if (allOtherKeyPackages.isNotEmpty) {
          // Found alternative key packages, use callback for selection
          String? selectedKeyPackage;
          if (onKeyPackageSelection != null) {
            selectedKeyPackage = await onKeyPackageSelection(pubkey, allOtherKeyPackages);
          } else {
            // Fallback to default selection (first available)
            selectedKeyPackage = allOtherKeyPackages.first.encoded_key_package;
          }

          if (selectedKeyPackage != null) {
            result[pubkey] = selectedKeyPackage;
          }
        } else {
          // No key package found at all
          UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
          if (user != null && user.selectedKeyPackageEvent != null) {
            result[pubkey] = user.selectedKeyPackageEvent!.encoded_key_package;
          }
        }
      }
    }
    return result;
  }

  /// Get all key packages from relay and return them categorized by client
  /// If forceRefresh is false and user has encodedKeyPackage, use cached data
  Future<Map<String, List<KeyPackageEvent>>> _getAllKeyPackagesFromRelay(String pubkey,
      {bool loadLocal = true, bool forceRefresh = false}) async {
    Map<String, KeyPackageEvent> latestKeyPackages = {};

    // Get existing key packages from local storage first
    UserDBISAR? user = await Account.sharedInstance.getUserInfo(pubkey);
    if (loadLocal) {
      if (user != null && user.keyPackageEventList.isNotEmpty) {
        for (var keyPackageEvent in user.keyPackageEventList) {
          String client = (keyPackageEvent.client.isEmpty) ? 'unknown' : keyPackageEvent.client;
          if (!latestKeyPackages.containsKey(client) ||
              keyPackageEvent.createTime > latestKeyPackages[client]!.createTime) {
            latestKeyPackages[client] = keyPackageEvent;
          }
        }
      }
    }

    // If forceRefresh is false and local data exists, return it directly
    if (!forceRefresh && user != null && user.selectedKeyPackageEvent != null) {
      String client = '0xchat-lite';
      if (!latestKeyPackages.containsKey(client)) {
        latestKeyPackages[client] = user.selectedKeyPackageEvent!;
      }
      // Convert to Map<String, List<KeyPackageEvent>>
      return latestKeyPackages.map((k, v) => MapEntry(k, [v]));
    }

    // Fetch from network
    Completer<Map<String, List<KeyPackageEvent>>> completer =
        Completer<Map<String, List<KeyPackageEvent>>>();
    List<Event> cachedEvents = [];
    Filter filter = Filter(kinds: [443], authors: [pubkey], limit: 10);

    Connect.sharedInstance.addSubscription([filter], eventCallBack: (event, relay) async {
      cachedEvents.add(event);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      for (Event event in cachedEvents) {
        try {
          KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);

          bool result = await _checkValidKeypackage(keyPackageEvent, client: null);

          if (result) {
            // Only keep the latest for each client
            String client = (keyPackageEvent.client.isEmpty) ? 'unknown' : keyPackageEvent.client;

            if (!latestKeyPackages.containsKey(client) ||
                keyPackageEvent.createTime > latestKeyPackages[client]!.createTime) {
              latestKeyPackages[client] = keyPackageEvent;
            }
            // Sync to local
            if (user != null && user.shouldUpdateKeyPackageEvent(keyPackageEvent)) {
              user.addKeyPackageEvent(keyPackageEvent);
              await Account.saveUserToDB(user);
            }
          }
          EventCache.sharedInstance.saveEventToDB(EventDBISAR(eventId: event.id));
        } catch (e) {
          continue;
        }
      }

      // Convert latestKeyPackages to the expected format
      Map<String, List<KeyPackageEvent>> result = {};
      for (var entry in latestKeyPackages.entries) {
        result[entry.key] = [entry.value];
      }

      completer.complete(result);
    });
    return completer.future;
  }

  /// Get key package from relay with optional client filter
  Future<String?> getKeyPackageFromRelay(String pubkey, {String? client}) async {
    // Use the new getAllKeyPackagesFromRelay method
    Map<String, List<KeyPackageEvent>> categorizedKeyPackages =
        await _getAllKeyPackagesFromRelay(pubkey);

    String targetClient = client ?? '0xchat-lite';

    // First try to find a key package with the specified client
    List<KeyPackageEvent> targetClientKeyPackages = categorizedKeyPackages[targetClient] ?? [];
    if (targetClientKeyPackages.isNotEmpty) {
      // Try to find a valid key package
      for (KeyPackageEvent keyPackageEvent in targetClientKeyPackages) {
        String result = await getKeyPackageFromStorage(
            serializedKeyPackage: keyPackageEvent.encoded_key_package);
        bool found = jsonDecode(result)['found'];
        if (found) {
          return keyPackageEvent.encoded_key_package;
        }
      }
    }

    // If no matching client found or no valid key package, return null
    return null;
  }

  /// Clean up relay keypackages: delete unknown clients and keep only latest for each client
  Future<void> _cleanupRelayKeyPackages(
      Map<String, List<KeyPackageEvent>> categorizedKeyPackages, List<String>? relays) async {
    if (relays == null || relays.isEmpty) {
      relays = Account.sharedInstance.getCurrentCircleRelay();
    }

    List<String> eventsToDelete = [];

    // Collect all keypackage events that should be deleted
    for (var entry in categorizedKeyPackages.entries) {
      String client = entry.key;
      List<KeyPackageEvent> keyPackages = entry.value;

      // Skip unknown client keypackages (they will be deleted)
      if (client == 'unknown') {
        for (var keyPackage in keyPackages) {
          if (keyPackage.eventId.isNotEmpty) {
            eventsToDelete.add(keyPackage.eventId);
          }
        }
        continue;
      }

      // For known clients, keep only the latest one, delete the rest
      if (keyPackages.length > 1) {
        // Sort by createTime, keep the latest
        keyPackages.sort((a, b) => b.createTime.compareTo(a.createTime));

        // Add all except the first (latest) one to deletion list
        for (int i = 1; i < keyPackages.length; i++) {
          if (keyPackages[i].eventId.isNotEmpty) {
            eventsToDelete.add(keyPackages[i].eventId);
          }
        }
      }
    }

    // Delete the collected events if any
    if (eventsToDelete.isNotEmpty) {
      await _deleteKeyPackageEvents(eventsToDelete, relays);
    }
  }

  /// Delete specific keypackage events from relay
  Future<void> _deleteKeyPackageEvents(List<String> eventIds, List<String> relays) async {
    Completer<void> completer = Completer<void>();
    Event deleteEvent = await Nip9.encode(eventIds, '', this.pubkey, this.privkey);
    Connect.sharedInstance.sendEvent(deleteEvent, toRelays: relays, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    });
    return completer.future;
  }

  /// Delete all key packages from relay
  Future<void> _deleteAllKeyPackagesFromRelay(List<String> relays) async {
    Completer<void> completer = Completer<void>();
    Filter f = Filter(kinds: [443], authors: [this.pubkey]);
    List<String> keypackageEvents = [];
    Connect.sharedInstance.addSubscription([f], relays: relays,
        eventCallBack: (event, relay) async {
      keypackageEvents.add(event.id);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      if (unRelays.isEmpty) {
        Event deleteEvent = await Nip9.encode(keypackageEvents, '', this.pubkey, this.privkey);
        Connect.sharedInstance.sendEvent(deleteEvent, toRelays: relays);
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  /// Rotate key packages (delete old ones and create new ones)
  Future<void> _rotateKeyPackages(List<String> relays) async {
    await _deleteAllKeyPackagesFromRelay(relays);
    await checkKeyPackage(relays: relays);
  }

  /// Check if two lists are equal
  bool _areListsEqual(List<String> list1, List<String> list2) {
    return Set.from(list1).containsAll(list2) && Set.from(list2).containsAll(list1);
  }

  /// Check if a key package is valid
  Future<bool> _checkValidKeypackage(KeyPackageEvent keyPackageEvent, {String? client}) async {
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

    // If client is specified, check if the key package has the correct client
    if (client != null) {
      return keyPackageEvent.client == client;
    }

    // If no client specified, reject unknown client key packages
    if (keyPackageEvent.client.isEmpty) {
      return false;
    }

    // Accept any valid key package with a known client
    return true;
  }
}
