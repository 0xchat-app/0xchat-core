import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class NotificationHelper {
  // call setNotification when online or updating notification
  static void setNotification(
      String serverPubkey,
      String deviceId,
      List<int> kinds,
      List<String> relays,
      List<String> toAliasPubkeys,
      List<String> channels,
      String privkey) {
    Map map = {
      'online': 1,
      'kinds': kinds,
      'deviceId': deviceId,
      'relays': relays,
      '#e': channels,
      '#p': toAliasPubkeys
    };
    Event event = Nip4.encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event);
  }

  // call when offline
  static void offline(String serverPubkey, String deviceId, String privkey) {
    Map map = {
      'online': 0,
      'deviceId': deviceId
    };
    Event event = Nip4.encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event);
  }
}
