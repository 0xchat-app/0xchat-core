import 'dart:async';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

extension AccountRelay on Account {
  List<RelayDB> getMyDMRelayList() {
    List<String> dmRelays = me?.dmRelayList ?? [];
    List<RelayDB> result = [];
    for (var relay in dmRelays) {
      result.add(Relays.sharedInstance.relays[relay] ?? RelayDB(url: relay));
    }
    return result;
  }

  List<RelayDB> getMyGeneralRelayList() {
    List<String> generalRelays = me?.relayList ?? [];
    List<RelayDB> result = [];
    for (var relay in generalRelays) {
      result.add(Relays.sharedInstance.relays[relay] ?? RelayDB(url: relay));
    }
    return result;
  }

  List<RelayDB> getMyRecommendGeneralRelaysList() {
    List<String> dmRelays = Relays.sharedInstance.recommendGeneralRelays;
    List<RelayDB> result = [];
    for (var relay in dmRelays) {
      result.add(Relays.sharedInstance.relays[relay] ?? RelayDB(url: relay));
    }
    return result;
  }

  List<RelayDB> getMyRecommendDMRelaysList() {
    List<String> dmRelays = Relays.sharedInstance.recommendDMRelays;
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
    me!.lastDMRelayListUpdatedTime = currentUnixTimestampSeconds();
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

  Future<OKEvent> addGeneralRelay(String relay) async {
    if (relay.isEmpty) return OKEvent(relay, false, 'empty relay');
    List<String> relays = me?.relayList ?? [];
    if (relays.contains(relay)) return OKEvent(relay, false, 'already exit');
    relays.add(relay);
    Connect.sharedInstance.connectRelays([relay], relayKind: RelayKind.general);
    return await setGeneralRelayListToRelay(relays);
  }

  Future<OKEvent> removeGeneralRelay(String relay) async {
    if (relay.isEmpty) return OKEvent(relay, false, 'empty relay');
    List<String> relays = me?.relayList ?? [];
    if (!relays.contains(relay)) return OKEvent(relay, false, 'not exit');
    relays.remove(relay);
    Connect.sharedInstance.closeConnects([relay], RelayKind.general);
    return await setGeneralRelayListToRelay(relays);
  }

  Future<OKEvent> addDMRelay(String relay) async {
    if (relay.isEmpty) return OKEvent(relay, false, 'empty relay');
    List<String> relays = me?.dmRelayList ?? [];
    if (relays.contains(relay)) return OKEvent(relay, false, 'already exit');
    relays.add(relay);
    Connect.sharedInstance.connectRelays([relay], relayKind: RelayKind.dm);
    return await setDMRelayListToRelay(relays);
  }

  Future<OKEvent> removeDMRelay(String relay) async {
    if (relay.isEmpty) return OKEvent(relay, false, 'empty relay');
    List<String> relays = me?.dmRelayList ?? [];
    if (!relays.contains(relay)) return OKEvent(relay, false, 'not exit');
    relays.remove(relay);
    Connect.sharedInstance.closeConnects([relay], RelayKind.dm);
    return await setDMRelayListToRelay(relays);
  }

  Future<void> closeAllRelays() async {
    await Connect.sharedInstance.closeAllConnects();
  }

  Future<void> resumeAllRelays() async {
    await Relays.sharedInstance.connectGeneralRelays();
    await Relays.sharedInstance.connectDMRelays();
    await Contacts.sharedInstance.syncSecretSessionFromDB();
    RelayGroup.sharedInstance.groupListUpdated();
  }

  int getConnectedRelaysCount() {
    List<RelayDB> myRelays = getMyGeneralRelayList();
    myRelays.addAll(getMyDMRelayList());
    int connected = 0;
    for (var relay in myRelays) {
      if (relay.connectStatus == 1) ++connected;
    }
    return connected;
  }

  int getAllRelaysCount() {
    List<RelayDB> general = getMyGeneralRelayList();
    List<RelayDB> dm = getMyDMRelayList();
    return general.length + dm.length;
  }

  Future<OKEvent> setGeneralRelayListToRelay(List<String> relays) async {
    me!.relayList = relays;
    me!.lastRelayListUpdatedTime = currentUnixTimestampSeconds();
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
