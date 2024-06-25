import 'dart:async';
import 'dart:convert';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

extension AccountRelay on Account {
  Future<List<String>> getDMRelayList(String pubkey) async {
    UserDB? userDB = await getUserInfo(pubkey);
    if (userDB != null) {
      return userDB.relayList ?? [];
    }
    return [];
  }

  Future<OKEvent> setDMRelayListToRelay(List<String> relays) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event =
        await Nip17.encodeDMRelays(relays, currentPubkey, currentPrivkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<List<String>> syncRelaysMetadataFromKind3(String pubkey) async {
    Completer<List<String>> completer = Completer<List<String>>();
    Filter f = Filter(
        kinds: [3],
        authors: [pubkey],
        limit: 1,
        since: me?.lastRelayListUpdatedTime);
    String content = '';
    int lastTimeStamp = 0;
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (event.createdAt > lastTimeStamp) {
        content = event.content;
        lastTimeStamp = event.createdAt;
        me?.lastRelayListUpdatedTime = lastTimeStamp;
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        List<String> result = [];
        try {
          Map map = jsonDecode(content);
          List<String> result = map.keys.map((e) => e.toString()).toList();
          if (!completer.isCompleted) completer.complete(result);
        } catch (e) {
          if (!completer.isCompleted) completer.complete(result);
        }
      }
    });
    return completer.future;
  }

  Future<List<String>> syncRelaysMetadataFromRelay(String pubkey) async {
    Completer<List<String>> completer = Completer<List<String>>();
    Filter f = Filter(
        kinds: [10002],
        authors: [pubkey],
        limit: 1,
        since: me?.lastRelayListUpdatedTime);
    List<Relay> result = [];
    int lastEventTime = 0;
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      if (lastEventTime < event.createdAt) {
        result = Nip65.decode(event);
        lastEventTime = event.createdAt;
        me?.lastRelayListUpdatedTime = lastEventTime;
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        List<String> relayList = result.map((e) => e.url).toList();
        if (relayList.isEmpty) {
          relayList = await syncRelaysMetadataFromKind3(pubkey);
        }
        if (!completer.isCompleted) completer.complete(relayList);
        syncMe();
      }
    });
    return completer.future;
  }

  Future<OKEvent> updateRelaysMetadata(List<String> relays) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    List<Relay> list = [];
    for (var relay in relays) {
      list.add(Relay(relay, null));
    }
    Event event = await Nip65.encode(list, currentPubkey, currentPrivkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }
}
