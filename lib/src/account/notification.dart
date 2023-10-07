import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class NotificationHelper {
  /// singleton
  NotificationHelper._internal();
  factory NotificationHelper() => sharedInstance;
  static final NotificationHelper sharedInstance =
      NotificationHelper._internal();

  // memory storage
  String pubkey = '';
  String privkey = '';
  String serverPubkey = '';
  Timer? timer;

  // key: private key
  // serverkey: server pubkey
  Future<void> init(String serverKey) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    serverPubkey = serverKey;

    _startHeartBeat();
  }

  void _startHeartBeat() {
    if (timer == null || timer!.isActive == false) {
      timer = Timer.periodic(Duration(seconds: 60), (Timer t) {
        _heartBeat(serverPubkey, privkey);
      });
    }
  }

  void _stopHeartBeat() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  Event _encode(
      String receiver, String content, String replyId, String privkey) {
    String enContent = Nip4.encryptContent(content, privkey, receiver);
    List<List<String>> tags = Nip4.toTags(receiver, replyId);
    Event event = Event.from(
        kind: 22456, tags: tags, content: enContent, privkey: privkey);
    return event;
  }

  void _heartBeat(String serverPubkey, String privkey) {
    Map map = {'online': 1};
    Event event = _encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void setOffline() {
    Map map = {'online': 0};
    Event event = _encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event);

    _stopHeartBeat();
  }

  void setOnline(){
    _heartBeat(serverPubkey, privkey);
    _startHeartBeat();
  }

  // call setNotification when online or updating notification
  Future<OKEvent> setNotification(
      String deviceId, List<int> kinds, List<String> relays) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<String> channels = Channels.sharedInstance.getAllUnMuteChannels();
    var authors = Contacts.sharedInstance.allContacts.keys.toList();
    var ptags = [pubkey];
    // List<SecretSessionDB> secretSessions =
    // Contacts.sharedInstance.secretSessionMap.values.toList();
    // for (var session in secretSessions) {
    //   if (Contacts.sharedInstance.allContacts.containsKey(session.toPubkey)) {
    //     /// in contacts list
    //     var sharePubkey = session.sharePubkey;
    //     if (sharePubkey != null && sharePubkey.isNotEmpty) {
    //       pubKeys.add(sharePubkey);
    //     }
    //   }
    // }
    Map map = {
      'online': 1,
      'authors': authors,
      'kinds': kinds,
      'deviceId': deviceId,
      'relays': relays,
      '#e': channels,
      '#p': ptags
    };
    Event event = _encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    }, relay: 'wss://relay.0xchat.com');
    return completer.future;
  }
}
