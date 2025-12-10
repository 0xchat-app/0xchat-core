import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:flutter/cupertino.dart';
import 'package:nostr_core_dart/nostr.dart';

abstract class PushPermissionChecker {
  Future<bool> canSendNotification();
  Future<bool> canReceiveNotification();
}

class NotificationHelper {
  /// singleton
  NotificationHelper._internal();
  factory NotificationHelper() => sharedInstance;
  static final NotificationHelper sharedInstance = NotificationHelper._internal();

  // memory storage
  String serverRelay = '';
  String defaultGroupName = 'XChat';

  PushPermissionChecker? permissionChecker;

  void setServerRelay(String serverRelay) {
    this.serverRelay = serverRelay;
  }

  Future connectServerRelay() {
    return Connect.sharedInstance.connect(serverRelay, relayKind: RelayKind.notification);
  }

  // send notification to receivers
  Future<OKEvent> sendNotification(List<String> receivers, String relay) async {
    final allowSendNotification = await permissionChecker?.canSendNotification() ?? false;
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
  Future<OKEvent> updateNotificationDeviceId(String deviceId, [int retryTimes = 1]) async {
    if (Connect.sharedInstance.webSockets[serverRelay]?.status != ConnectStatus.open) {
      if (retryTimes > 0) {
        await Connect.sharedInstance.connect(serverRelay, relayKind: RelayKind.notification);
        return updateNotificationDeviceId(deviceId, retryTimes - 1);
      }
      return OKEvent('', false, 'server disconnected');
    }
    RelayGroupDBISAR? group = await RelayGroup.sharedInstance
        .searchGroupMetadataFromRelay(Account.sharedInstance.currentPubkey, serverRelay);
    bool isExist = group != null;
    if (!isExist) return _createNewNotificationGroup(deviceId);
    group.admins = [
      GroupAdmin(Account.sharedInstance.currentPubkey, 'king', GroupActionKind.king())
    ];
    RelayGroup.sharedInstance.myGroups[group.groupId] = ValueNotifier(group);
    String about = group.about;
    // Check if about is empty or invalid JSON before parsing
    if (about.isEmpty) {
      // If about is empty, create a new request
      Request request = Request(deviceId, [
        Filter(p: [Account.sharedInstance.currentPubkey])
      ]);
      OKEvent ok = await RelayGroup.sharedInstance.editMetadata(Account.sharedInstance.currentPubkey,
          defaultGroupName, request.serialize(), '', true, true, '');
      return ok;
    }
    
    Request r;
    try {
      r = Request.deserialize(jsonDecode(about));
    } catch (e) {
      // If JSON parsing fails, create a new request
      Request request = Request(deviceId, [
        Filter(p: [Account.sharedInstance.currentPubkey])
      ]);
      OKEvent ok = await RelayGroup.sharedInstance.editMetadata(Account.sharedInstance.currentPubkey,
          defaultGroupName, request.serialize(), '', true, true, '');
      return ok;
    }
    
    if (r.subscriptionId == deviceId) {
      return OKEvent('', true, 'already updated');
    }
    Request request = Request(deviceId, [
      Filter(p: [Account.sharedInstance.currentPubkey])
    ]);
    OKEvent ok = await RelayGroup.sharedInstance.editMetadata(Account.sharedInstance.currentPubkey,
        defaultGroupName, request.serialize(), '', true, true, '');
    return ok;
  }

  // delete notification
  Future<OKEvent> removeNotification() async {
    return await updateNotificationDeviceId('');
  }

  // Generate AUTH response for push service
  // Same as connect.dart line 670-672
  static Future<String> generateAuthJson(String challenge, String relay) async {
    if (Account.sharedInstance.currentPubkey.isEmpty || 
        Account.sharedInstance.currentPrivkey.isEmpty) {
      return '';
    }
    Event event = await Nip42.encode(
        challenge, relay, 
        Account.sharedInstance.currentPubkey,
        Account.sharedInstance.currentPrivkey);
    return Nip42.authString(event);
  }
}
