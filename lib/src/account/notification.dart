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
  String oxchatRelay = 'wss://relay.0xchat.com';

  // key: private key
  // serverkey: server pubkey
  Future<void> init(String serverKey) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    serverPubkey = serverKey;

    startHeartBeat();
  }

  void startHeartBeat() {
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

  Future<Event> _encode(
      String receiver, String content, String replyId, String privkey) async {
    String enContent =
        await Nip4.encryptContent(content, receiver, pubkey, privkey);
    List<List<String>> tags = Nip4.toTags(receiver, replyId, null);
    Event event = await Event.from(
        kind: 22456,
        tags: tags,
        content: enContent,
        pubkey: pubkey,
        privkey: privkey);
    return event;
  }

  Future<void> _heartBeat(String serverPubkey, String privkey) async {
    Map map = {'online': 1};
    Event event = await _encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event, toRelays: [oxchatRelay]);
  }

  Future<void> setOffline() async {
    Map map = {'online': 0};
    Event event = await _encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event, toRelays: [oxchatRelay]);

    _stopHeartBeat();
  }

  void setOnline() {
    _heartBeat(serverPubkey, privkey);
    startHeartBeat();
  }

  Future<void> logout() async {
    Map map = {'online': 0, 'deviceId': ''};
    Event event = await _encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event, toRelays: [oxchatRelay]);

    _stopHeartBeat();
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
    Event event = await _encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    }, toRelays: [oxchatRelay]);
    return completer.future;
  }
}
