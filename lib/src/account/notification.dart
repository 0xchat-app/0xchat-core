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
  Future<void> init(String key, String serverKey) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
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

  void stopHeartBeat() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  void _heartBeat(String serverPubkey, String privkey) {
    Map map = {'online': 1};
    Event event = Nip4.encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event);
  }

  // call setNotification when online or updating notification
  Future<OKEvent> setNotification(String deviceId, List<int> kinds, List<String> relays) async{
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<String> toAliasPubkeys =
        Friends.sharedInstance.getAllUnMuteFriendsToAliasPubkey();
    List<String> channels = Channels.sharedInstance.getAllUnMuteChannels();

    Map map = {
      'online': 1,
      'kinds': kinds,
      'deviceId': deviceId,
      'relays': relays,
      '#e': channels,
      '#p': toAliasPubkeys
    };
    Event event = Nip4.encode(serverPubkey, jsonEncode(map), '', privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok){
      completer.complete(ok);
    });
    return completer.future;
  }
}
