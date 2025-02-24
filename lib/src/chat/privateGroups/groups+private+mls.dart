import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chatcore/chat-core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:nostr_mls_package/nostr_mls_package.dart';

String toHexString(List<int> bytes) {
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join('');
}

class MlsGroup {
  final List<int> groupId;
  final List<String> groupMembers;
  final List<int> serializedWelcomeMessage;
  final NostrGroupData nostrGroupData;

  MlsGroup({
    required this.groupId,
    required this.groupMembers,
    required this.serializedWelcomeMessage,
    required this.nostrGroupData,
  });

  static MlsGroup fromJson(Map<String, dynamic> json) {
    if (json['group_id'] == null) {
      throw Exception("error: group_id does not exit");
    }

    List<dynamic> groupIdVec = json['group_id']['value']['vec'];
    List<int> groupId = groupIdVec.map((e) => e as int).toList();

    List<String> members = [];
    if (json['members'] != null) {
      members = List<String>.from(json['members']);
    }

    List<int> serializedWelcomeMessage = List<int>.from(json['serialized_welcome_message']);

    NostrGroupData nostrGroupData = NostrGroupData.fromJson(json['nostr_group_data']);

    return MlsGroup(
      groupId: groupId,
      groupMembers: members,
      serializedWelcomeMessage: serializedWelcomeMessage,
      nostrGroupData: nostrGroupData,
    );
  }
}

class NostrGroupData {
  final String nostrGroupId;
  final String name;
  final String description;
  final List<String> adminPubkeys;
  final List<String> relays;

  NostrGroupData({
    required this.nostrGroupId,
    required this.name,
    required this.description,
    required this.adminPubkeys,
    required this.relays,
  });

  static NostrGroupData fromJson(Map<String, dynamic> json) {
    List<int> nostrGroupIdInts = List<int>.from(json['nostr_group_id']);
    String nostrGroupId = toHexString(nostrGroupIdInts);

    List<int> nameInts = List<int>.from(json['name']);
    String name = utf8.decode(nameInts);

    List<int> descriptionInts = List<int>.from(json['description']);
    String description = utf8.decode(descriptionInts);

    List<String> adminPubkeys =
        (json['admin_pubkeys'] as List).map((item) => utf8.decode(List<int>.from(item))).toList();

    List<String> relays =
        (json['relays'] as List).map((item) => utf8.decode(List<int>.from(item))).toList();

    return NostrGroupData(
      nostrGroupId: nostrGroupId,
      name: name,
      description: description,
      adminPubkeys: adminPubkeys,
      relays: relays,
    );
  }
}

extension MLSPrivateGroups on Groups {
  Future<void> initMLS() async {
    await RustLib.init();
    bool isIOS = Platform.isIOS || Platform.isMacOS;
    Directory directory =
        isIOS ? await getLibraryDirectory() : await getApplicationDocumentsDirectory();
    await initNostrMls(path: directory.path, identity: pubkey);
  }

  Future<Map<String, List<KeyPackageEvent>>> getKeyPackageFromRelay(List<String> pubkeys) async {
    Completer<Map<String, List<KeyPackageEvent>>> completer =
        Completer<Map<String, List<KeyPackageEvent>>>();
    Map<String, List<KeyPackageEvent>> result = {};
    Filter f = Filter(kinds: [443], authors: pubkeys);
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) async {
      KeyPackageEvent keyPackageEvent = Nip104.decodeKeyPackageEvent(event);
      result[keyPackageEvent.pubkey] ??= [];
      result[keyPackageEvent.pubkey]!.add(keyPackageEvent);
    }, eoseCallBack: (requestId, ok, relay, unRelays) async {
      if (unRelays.isEmpty) {
        if (!completer.isCompleted) completer.complete(result);
      }
    });
    return completer.future;
  }

  Future<Future<OKEvent>> createNewKeyPackage(List<String> relays) async {
    String encodedKeyPackage = await createKeyPackageForEvent(publicKey: pubkey);
    Event event = await Nip104.encodeKeyPackageEvent(
        encodedKeyPackage, getCiphersuite(), getExtensions(), relays, pubkey, privkey);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<MlsGroup> createMLSGroup(String groupName, String groupDescription,
      List<String> membersKeyPackages, List<String> admins, List<String> relays) async {
    String createGroupResult = await createGroup(
        groupName: groupName,
        groupDescription: groupDescription,
        groupMembersKeyPackages: membersKeyPackages,
        groupCreatorPublicKey: pubkey,
        groupAdminPublicKeys: admins,
        relays: relays);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(createGroupResult));
    //send welcome & invite members
    sendWelcomeMessages(mlsGroup.serializedWelcomeMessage, mlsGroup.groupMembers, relays);
    return mlsGroup;
  }

  Future<void> sendWelcomeMessages(
      List<int> serializedWelcomeMessage, List<String> members, List<String> relays) async {
    Event welcomeEvent = await Nip104.encodeWelcomeEvent(
        serializedWelcomeMessage.toString(), relays, pubkey, privkey);
    for (var member in members) {
      Event giftWrappedEvent = await Nip59.encode(welcomeEvent, member);
      Connect.sharedInstance
          .sendEvent(giftWrappedEvent, toRelays: relays, sendCallBack: (ok, relay) {});
    }
  }

  Future<MlsGroup> joinMLSGroup(WelcomeEvent welcomeEvent) async {
    String joinGroupResult =
        await joinGroupFromWelcome(serializedWelcomeMessage: welcomeEvent.welcome);
    MlsGroup mlsGroup = MlsGroup.fromJson(jsonDecode(joinGroupResult));
    return mlsGroup;
  }

  Future<Future<OKEvent>> sendMessageToMLSGroup(
      List<int> groupId, String nostrGroupId, String messageEvent) async {
    List<int> serializedMessage =
        await createMessageForGroup(groupId: groupId, messageEvent: messageEvent);
    Event groupEvent =
        await Nip104.encodeGroupEvent(serializedMessage, nostrGroupId, pubkey, privkey);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Connect.sharedInstance.sendEvent(groupEvent, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) {
        completer.complete(ok);
      }
    });
    return completer.future;
  }

  Future<void> receiveMLSGroupEvent(Event event, String groupPubkey, String groupPrivkey) async {
    GroupEvent groupEvent = Nip104.decodeGroupEvent(event);
    String messageString =
        await Nip44.decryptContent(groupEvent.message, groupEvent.pubkey, groupPubkey, groupPrivkey);
    List<int> messageJsonString =
        await processMessageForGroup(groupId: hexToBytes(groupEvent.groupId), serializedMessage: hexToBytes(messageString));
    Event innerEvent = await Event.fromJson(jsonDecode(utf8.decode(messageJsonString)));
    GroupMessage groupMessage = Nip29.decodeGroupMessage(innerEvent);
    // TODO: handle group message
  }
}
