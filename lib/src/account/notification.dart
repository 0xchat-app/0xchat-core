import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

class NotificationHelper {
  /// singleton
  NotificationHelper._internal();
  factory NotificationHelper() => sharedInstance;
  static final NotificationHelper sharedInstance = NotificationHelper._internal();

  // memory storage
  String serverRelay = '';
  bool allowSendNotification = true;
  bool allowReceiveNotification = true;
  String defaultGroupName = 'XChat';
  String? unSendDevice;
  Future<void> init(String serverRelay,
      {bool allowSendNotification = true, bool allowReceiveNotification = true}) async {
    setServerRelay(serverRelay);
    setAllowSendNotification(allowSendNotification);
    setAllowReceiveNotification(allowReceiveNotification);
    Connect.sharedInstance.addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 && Account.sharedInstance.me != null && relay == serverRelay) {
        if (unSendDevice != null) {
          updateNotificationDeviceId(unSendDevice!);
        }
      }
    });
  }

  void setServerRelay(String serverRelay) {
    this.serverRelay = serverRelay;
  }

  Future<void> setAllowSendNotification(bool allow) async {
    allowSendNotification = allow;
    if (allowSendNotification) {
      await Connect.sharedInstance.connect(serverRelay, relayKind: RelayKind.notification);
    }
  }

  Future<void> setAllowReceiveNotification(bool allow) async {
    allowReceiveNotification = allow;
    if (allowReceiveNotification) {
      await Connect.sharedInstance.connect(serverRelay, relayKind: RelayKind.notification);
    }
  }

  // send notification to receivers
  Future<OKEvent> sendNotification(List<String> receivers, String relay) async {
    if (!allowSendNotification) return OKEvent('', false, 'not allow send notification');
    Keychain keychain = Keychain.generate();
    List<List<String>> tags = Nip4.toTags('', '', '', null, members: receivers);
    Event event = await Event.from(
        kind: 20285, tags: tags, content: '', pubkey: keychain.public, privkey: keychain.private);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    }, toRelays: [serverRelay]);
    return completer.future;
  }

  // create notification
  Future<OKEvent> _createNewNotificationGroup(String deviceId) async {
    Request request = Request(deviceId, [
      Filter(p: [Account.sharedInstance.currentPubkey])
    ]);
    RelayGroupDBISAR? group = await RelayGroup.sharedInstance.createGroup(serverRelay,
        myGroupId: Account.sharedInstance.currentPubkey,
        name: defaultGroupName,
        closed: true,
        picture: '',
        about: request.serialize());
    if (group == null) return OKEvent('', false, 'create notification failed');
    return OKEvent(group.groupId, true, '');
  }

  // update notification
  Future<OKEvent> updateNotificationDeviceId(String deviceId) async {
    if (!allowReceiveNotification) return OKEvent('', false, 'not allow receive notification');
    if (Connect.sharedInstance.webSockets[serverRelay]?.connectStatus != 1) {
      unSendDevice = deviceId;
      return OKEvent('', false, 'server disconnected');
    }
    unSendDevice = null;
    RelayGroupDBISAR? group = await RelayGroup.sharedInstance
        .searchGroupMetadataFromRelay(Account.sharedInstance.currentPubkey, serverRelay);
    bool isExist = group != null;
    if (!isExist) return _createNewNotificationGroup(deviceId);
    String about = group.about;
    Request r = Request.deserialize(jsonDecode(about));
    if(r.subscriptionId == deviceId){
      return OKEvent('', true, 'already updated');
    }
    Request request = Request(deviceId, [
      Filter(p: [Account.sharedInstance.currentPubkey])
    ]);
    OKEvent ok = await RelayGroup.sharedInstance.editMetadata(Account.sharedInstance.currentPubkey,
        defaultGroupName, request.serialize(), '', true, true, '');
    if (!ok.status) return ok;
    return ok;
  }

  // delete notification
  Future<OKEvent> removeNotification() async {
    return await RelayGroup.sharedInstance.deleteGroup(Account.sharedInstance.currentPubkey, '');
  }
}
