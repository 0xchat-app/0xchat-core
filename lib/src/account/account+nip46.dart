import 'dart:async';

import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

extension AccountNIP46 on Account {
  Future<void> connectToRemoteSigner(String uri) async {
    RemoteSignerConnection connection = Nip46.parseBunkerUri(uri);
    currentConnection = connection;
    await Connect.sharedInstance
        .connectRelays(connection.relays, relayKind: RelayKind.remoteSigner);
    updateNIP46Subscription();
    Connect.sharedInstance.addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 && currentConnection!.relays.contains(relay)) {
        updateNIP46Subscription(relay: relay);
      }
    });
  }

  void updateNIP46Subscription({String? relay}) {
    if (currentConnection == null) return;
    if (NIP46Subscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(NIP46Subscription, relay: relay);
    }
    Map<String, List<Filter>> subscriptions = {};
    if (relay == null) {
      for (String relayURL in currentConnection!.relays) {
        Filter f = Filter(
            kinds: [24133],
            authors: [currentConnection!.pubkey],
            p: [currentConnection!.clientPubkey!]);
        subscriptions[relayURL] = [f];
      }
    } else {
      Filter f = Filter(
          kinds: [24133],
          authors: [currentConnection!.pubkey],
          p: [currentConnection!.clientPubkey!]);
      subscriptions[relay] = [f];
    }

    NIP46Subscription = Connect.sharedInstance.addSubscriptions(subscriptions,
        closeSubscription: false, eventCallBack: (event, relay) async {
      switch (event.kind) {
        case 24133:
          NIP46CommandResult result = await Nip46.decode(
              event, currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
          Completer? completer = resultCompleters[result.id];
          if(completer != null && !completer.isCompleted) completer.complete(result);
          resultCompleters.remove(result.id);
          break;
        default:
          LogUtils.v(() => 'moment unhandled message ${event.toJson()}');
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) {});
  }

  Future<NIP46CommandResult> sendToRemoteSigner(Event event){
    var id = generate64RandomHexChars();
    Completer<NIP46CommandResult> completer = Completer<NIP46CommandResult>();
    resultCompleters[id] = completer;
    Connect.sharedInstance.sendEvent(event, toRelays: currentConnection!.relays);
    return completer.future;
  }

  Future<void> sendConnect() async {

  }

  Future<void> sendSignEvent() async {}

  Future<void> sendGetRelays() async {}

  Future<void> sendGetPublicKey() async {}

  Future<void> sendNip04Encrypt() async {}

  Future<void> sendNip04Decrypt() async {}

  Future<void> sendNip044Encrypt() async {}

  Future<void> sendNip044Decrypt() async {}
}
