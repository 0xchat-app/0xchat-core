import 'dart:async';
import 'package:nostr_core_dart/nostr.dart';
import 'package:chatcore/chat-core.dart';

extension AccountNIP46 on Account {
  Future<UserDBISAR?> loginWithNip46Pubkey(String pubkey) async {
    await loginWithPubKey(pubkey, SignerApplication.remoteSigner);
    if (me == null || me?.remoteSignerURI == null) return null;
    await connectToRemoteSigner(me!.remoteSignerURI!);
    await sendConnect();
    String? getPubkey = await sendGetPubicKey();
    if (getPubkey == null || getPubkey != pubkey) return null;
    return me;
  }

  Future<UserDBISAR?> loginWithNip46URI(String uri) async {
    await connectToRemoteSigner(uri);
    await sendConnect();
    String? getPubkey = await sendGetPubicKey();
    if (getPubkey == null) return null;
    UserDBISAR? userDBISAR = await loginWithPubKey(getPubkey, SignerApplication.remoteSigner);
    if (userDBISAR != null) {
      userDBISAR.remoteSignerURI = uri;
      userDBISAR.clientPrivateKey ??= currentRemoteConnection!.clientPrivkey;
      await Account.saveUserToDB(userDBISAR);
    }
    return userDBISAR;
  }

  Future<void> connectToRemoteSigner(String uri) async {
    RemoteSignerConnection remoteSignerConnection = Nip46.parseBunkerUri(uri);
    await Connect.sharedInstance
        .connectRelays(remoteSignerConnection.relays, relayKind: RelayKind.remoteSigner);
    updateNIP46Subscription();
    Connect.sharedInstance.addConnectStatusListener((relay, status, relayKinds) async {
      if (status == 1 && remoteSignerConnection.relays.contains(relay)) {
        updateNIP46Subscription(relay: relay);
      }
    });
    currentRemoteConnection = remoteSignerConnection;
    currentRemoteConnection!.clientPrivkey = me?.clientPrivateKey;
    if (currentRemoteConnection!.clientPrivkey == null) {
      Keychain newKeychain = Keychain.generate();
      currentRemoteConnection!.clientPrivkey = newKeychain.private;
      currentRemoteConnection!.clientPubkey = newKeychain.public;
    }
  }

  Future<String?> sendGetPubicKey() async {
    if (currentRemoteConnection == null) return null;
    NIP46Command command = NIP46Command.getPublicKey();
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    return null;
  }

  void updateNIP46Subscription({String? relay}) {
    if (currentRemoteConnection == null) return;
    if (NIP46Subscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(NIP46Subscription, relay: relay);
    }
    Map<String, List<Filter>> subscriptions = {};
    if (relay == null) {
      for (String relayURL in currentRemoteConnection!.relays) {
        Filter f = Filter(
            kinds: [24133],
            authors: [currentRemoteConnection!.pubkey],
            p: [currentRemoteConnection!.clientPubkey!]);
        subscriptions[relayURL] = [f];
      }
    } else {
      Filter f = Filter(
          kinds: [24133],
          authors: [currentRemoteConnection!.pubkey],
          p: [currentRemoteConnection!.clientPubkey!]);
      subscriptions[relay] = [f];
    }

    NIP46Subscription = Connect.sharedInstance.addSubscriptions(subscriptions,
        closeSubscription: false, eventCallBack: (event, relay) async {
      switch (event.kind) {
        case 24133:
          NIP46CommandResult result = await Nip46.decode(event,
              currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
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
    Connect.sharedInstance.sendEvent(event, toRelays: currentRemoteConnection!.relays);
    return completer.future;
  }

  Future<bool> sendConnect() async {
    NIP46Command command =
        NIP46Command.connect(currentRemoteConnection!.pubkey, currentRemoteConnection!.secret);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendConnect result: ${result.toString()}');

    SignerHelper.sharedInstance.signEventHandle = (Event unsignedEvent) async {
      return await sendSignEvent(unsignedEvent);
    };
    SignerHelper.sharedInstance.nip04encryptEventHandle =
        (String plainText, String peerPubkey) async {
      return await sendNip04Encrypt(peerPubkey, plainText);
    };
    SignerHelper.sharedInstance.nip04decryptEventHandle =
        (String encryptedText, String peerPubkey) async {
      return await sendNip04Decrypt(peerPubkey, encryptedText);
    };
    SignerHelper.sharedInstance.nip44encryptEventHandle =
        (String plainText, String peerPubkey) async {
      return await sendNip44Encrypt(peerPubkey, plainText);
    };
    SignerHelper.sharedInstance.nip44encryptEventHandle =
        (String encryptedText, String peerPubkey) async {
      return await sendNip44Decrypt(peerPubkey, encryptedText);
    };

    return true;
  }

  Future<Event> sendSignEvent(Event unsignedEvent) async {
    NIP46Command command = NIP46Command.signEvent(unsignedEvent.toJson());
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendSignEvent result: ${result.toString()}');
    return result.result;
  }

  Future<void> sendGetRelays() async {
    NIP46Command command = NIP46Command.getRelays();
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendGetRelays result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendGetPublicKey() async {
    NIP46Command command = NIP46Command.getPublicKey();
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendGetPublicKey result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendNip04Encrypt(String thirdPartyPubkey, String plaintext) async {
    NIP46Command command = NIP46Command.nip04Encrypt(thirdPartyPubkey, plaintext);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendNip04Encrypt result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendNip04Decrypt(String thirdPartyPubkey, String ciphertext) async {
    NIP46Command command = NIP46Command.nip04Decrypt(thirdPartyPubkey, ciphertext);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendNip04Decrypt result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendNip44Encrypt(String thirdPartyPubkey, String plaintext) async {
    NIP46Command command = NIP46Command.nip44Encrypt(thirdPartyPubkey, plaintext);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendNip044Encrypt result: ${result.toString()}');
    return result.result;
  }

  Future<String> sendNip44Decrypt(String thirdPartyPubkey, String ciphertext) async {
    NIP46Command command = NIP46Command.nip44Decrypt(thirdPartyPubkey, ciphertext);
    var id = generate64RandomHexChars();
    Event event = await Nip46.encode(currentRemoteConnection!.pubkey, id, command,
        currentRemoteConnection!.clientPubkey!, currentRemoteConnection!.clientPrivkey!);
    NIP46CommandResult result = await sendToRemoteSigner(event, id);
    print('sendNip044Decrypt result: ${result.toString()}');
    return result.result;
  }
}
