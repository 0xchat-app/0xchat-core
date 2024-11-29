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
          if (completer != null && !completer.isCompleted) completer.complete(result);
          resultCompleters.remove(result.id);
          break;
        default:
          LogUtils.v(() => 'moment unhandled message ${event.toJson()}');
          break;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) {});
  }

  Future<NIP46CommandResult> sendToRemoteSigner(Event event, String id) {
    Completer<NIP46CommandResult> completer = Completer<NIP46CommandResult>();
    resultCompleters[id] = completer;
    Connect.sharedInstance.sendEvent(event, toRelays: currentConnection!.relays);
    return completer.future;
  }

  Future<bool> sendConnect() async {
    NIP46Command command =
        NIP46Command.connect(currentConnection!.pubkey, currentConnection!.secret);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentConnection!.pubkey, id, command,
        currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendConnect result: ${result.toString()}');
    return true;
  }

  Future<void> sendSignEvent(Event unsignedEvent) async {
    NIP46Command command = NIP46Command.signEvent(unsignedEvent.toJson());
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentConnection!.pubkey, id, command,
        currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendSignEvent result: ${result.toString()}');
    return result.result;
  }

  Future<void> sendGetRelays() async {
    NIP46Command command = NIP46Command.getRelays();
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentConnection!.pubkey, id, command,
        currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendGetRelays result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendGetPublicKey() async {
    NIP46Command command = NIP46Command.getPublicKey();
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentConnection!.pubkey, id, command,
        currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendGetPublicKey result: ${result.toString()}');
    return result.result;
  }

  Future<void> sendNip04Encrypt(String thirdPartyPubkey, String plaintext) async {
    NIP46Command command = NIP46Command.nip04Encrypt(thirdPartyPubkey, plaintext);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentConnection!.pubkey, id, command,
        currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendNip04Encrypt result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendNip04Decrypt(String thirdPartyPubkey, String ciphertext) async {
    NIP46Command command = NIP46Command.nip04Decrypt(thirdPartyPubkey, ciphertext);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentConnection!.pubkey, id, command,
        currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendNip04Decrypt result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendNip044Encrypt(String thirdPartyPubkey, String plaintext) async {
    NIP46Command command = NIP46Command.nip44Encrypt(thirdPartyPubkey, plaintext);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentConnection!.pubkey, id, command,
        currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendNip044Encrypt result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendNip044Decrypt(String thirdPartyPubkey, String ciphertext) async {
    NIP46Command command = NIP46Command.nip44Decrypt(thirdPartyPubkey, ciphertext);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentConnection!.pubkey, id, command,
        currentConnection!.clientPubkey!, currentConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendNip044Decrypt result: ${result.toString()}');
    return result.result;
  }
}
