import 'dart:async';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

extension AccountRelay on Account {
  Future<List<RelayDB>> getMyDMRelayList() async {
    List<String> dmRelays = me?.dmRelayList ?? [];
    List<RelayDB> result = [];
    for (var relay in dmRelays) {
      result.add(Relays.sharedInstance.relays[relay] ?? RelayDB(url: relay));
    }
    return result;
  }

  Future<List<RelayDB>> getMyGeneralRelayList() async {
    List<String> dmRelays = me?.relayList ?? [];
    List<RelayDB> result = [];
    for (var relay in dmRelays) {
      result.add(Relays.sharedInstance.relays[relay] ?? RelayDB(url: relay));
    }
    return result;
  }

  Future<List<String>> getUserDMRelayList(String pubkey) async {
    UserDB? userDB = await getUserInfo(pubkey);
    if (userDB != null) {
      return userDB.dmRelayList ?? [];
    }
    return [];
  }

  Future<List<String>> getUserGeneralRelayList(String pubkey) async {
    UserDB? userDB = await getUserInfo(pubkey);
    if (userDB != null) {
      return userDB.relayList ?? [];
    }
    return [];
  }

  Future<OKEvent> setDMRelayListToRelay(List<String> relays) async {
    me!.dmRelayList = relays;
    Relays.sharedInstance.connectDMRelays();
    syncMe();
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

  Future<OKEvent> setGeneralRelayListToRelay(List<String> relays) async {
    me!.relayList = relays;
    Relays.sharedInstance.connectGeneralRelays();
    syncMe();
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
