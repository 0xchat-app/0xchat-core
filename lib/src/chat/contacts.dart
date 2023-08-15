import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef SecretChatRequestCallBack = void Function(SecretSessionDB);
typedef SecretChatAcceptCallBack = void Function(SecretSessionDB);
typedef SecretChatRejectCallBack = void Function(SecretSessionDB);
typedef SecretChatUpdateCallBack = void Function(SecretSessionDB);
typedef SecretChatCloseCallBack = void Function(SecretSessionDB);
typedef SecretChatMessageCallBack = void Function(MessageDB);
typedef ContactUpdatedCallBack = void Function();

class Contacts {
  static final String identifier = 'Chat-Friends';
  static final String blockListidentifier = 'Chat-Block';

  /// singleton
  Contacts._internal();
  factory Contacts() => sharedInstance;
  static final Contacts sharedInstance = Contacts._internal();

  /// memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, UserDB> allContacts = {};
  Map<String, SecretSessionDB> secretSessionMap = {};
  String secretSessionSubscription = '';
  String friendMessageSubscription = '';
  int lastFriendListUpdateTime = 0;
  List<String>? blockList;

  /// callbacks
  SecretChatRequestCallBack? secretChatRequestCallBack;
  SecretChatAcceptCallBack? secretChatAcceptCallBack;
  SecretChatRejectCallBack? secretChatRejectCallBack;
  SecretChatUpdateCallBack? secretChatUpdateCallBack;
  SecretChatCloseCallBack? secretChatCloseCallBack;
  SecretChatMessageCallBack? secretChatMessageCallBack;
  ContactUpdatedCallBack? contactUpdatedCallBack;

  void Function(String friend, SignalingState state, String data)?
      onCallStateChange;

  Future<void> initContacts(ContactUpdatedCallBack? callBack) async {
    privkey = Account.sharedInstance.privkey;
    pubkey = Account.sharedInstance.pubkey;
    contactUpdatedCallBack = callBack;

    // sync friend list from DB & relays
    await _syncContactsFromDB();
    await _syncBlockListFromDB();
    await _syncSecretSessionFromDB();

    _updateSubscriptions();

    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1) {
        _updateSubscriptions();
      }
    });
  }

  Future<void> _updateSubscriptions() async {
    await _syncContactsFromRelay();
    await _syncBlockListFromRelay();
    await _subscriptMessages();
    await _subscriptSecretChat();
  }

  /// contact list
  Future<void> _syncContactsToDB(String list) async {
    Account.sharedInstance.me?.friendsList = list;
    await Account.sharedInstance.syncMe();
  }

  void _syncContactsToRelay({OKCallBack? okCallBack}) {
    List<People> friendList = [];
    for (UserDB user in allContacts.values) {
      People p =
          People(user.pubKey!, user.mainRelay, user.nickName, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    if (event.content.isNotEmpty) {
      Connect.sharedInstance.sendEvent(event, sendCallBack:
          (OKEvent ok, String relay, List<String> unCompletedRelays) {
        if (unCompletedRelays.isEmpty && ok.status) {
          _syncContactsToDB(event.content);
        }
        okCallBack?.call(ok, relay, unCompletedRelays);
      });
    } else {
      throw Exception('_syncFriendsToRelay error content!, $friendList');
    }
  }

  Future<void> _syncContactsProfiles(List<People> peoples) async {
    await _syncContactsProfilesFromDB(peoples);
    List<UserDB> unknowProfiles = allContacts.values
        .where((userDB) => userDB.lastUpdatedTime == 0)
        .toList();
    List<String> pubkeys = unknowProfiles.map((e) => e.pubKey!).toList();
    _syncContactsProfilesFromRelay(pubkeys);
  }

  Future<void> _syncContactsProfilesFromDB(List<People> peoples) async {
    allContacts.clear();
    await Future.forEach(peoples, (p) async {
      UserDB? user = await Account.getUserFromDB(pubkey: p.pubkey);
      if (user != null) {
        if (user.toAliasPrivkey == null || user.toAliasPrivkey!.isEmpty) {
          user.toAliasPrivkey =
              bytesToHex(Nip44.shareSecret(privkey, user.pubKey!));
          user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
        }
        user.nickName = p.petName;
        allContacts[user.pubKey!] = user;
      }
    });
  }

  Future<void> _syncContactsProfilesFromRelay(List<String> pubkeys) async {
    if (pubkeys.isNotEmpty) {
      var usersMap = await Account.syncProfilesFromRelay(pubkeys);
      await Future.forEach(pubkeys, (p) async {
        UserDB? user = usersMap[p];
        if (user != null) {
          if (user.toAliasPrivkey == null || user.toAliasPrivkey!.isEmpty) {
            user.toAliasPrivkey =
                bytesToHex(Nip44.shareSecret(privkey, user.pubKey!));
            user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
          }
          // sync to db
          await DB.sharedInstance.insert<UserDB>(user);
          allContacts[user.pubKey!] = user;
        }
      });
    }
  }

  Future<void> addToContact(String friendPubkey, OKCallBack okCallBack) async {
    UserDB? friend = await Account.getUserFromDB(pubkey: friendPubkey);
    friend ??= UserDB(pubKey: friendPubkey);
    if (friend.toAliasPubkey == null || friend.toAliasPubkey!.isEmpty) {
      friend.toAliasPrivkey =
          bytesToHex(Nip44.shareSecret(privkey, friend.pubKey!));
      friend.toAliasPubkey = Keychain.getPublicKey(friend.toAliasPrivkey!);
    }
    allContacts[friendPubkey] = friend;
    await DB.sharedInstance.insert<UserDB>(friend);
    _syncContactsToRelay(okCallBack: okCallBack);
    _subscriptMessages();
  }

  Future<void> removeContact(String friendPubkey, OKCallBack okCallBack) async {
    UserDB? friend = allContacts.remove(friendPubkey);
    if (friend != null) {
      _syncContactsToRelay(okCallBack: okCallBack);
      _subscriptMessages();
    }
  }

  Future<OKEvent> updateContactNickName(
      String friendPubkey, String nickName) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allContacts[friendPubkey];
    if (friend != null && friend.aliasPubkey!.isNotEmpty) {
      friend.nickName = nickName;
      await DB.sharedInstance.update<UserDB>(friend);
      _syncContactsToRelay(okCallBack: (ok, relay, unRelays) {
        if (!completer.isCompleted) completer.complete(ok);
      });
    }
    return completer.future;
  }

  List<UserDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<UserDB> filteredFriends = allContacts.values
          .where((person) =>
              regex.hasMatch(person.name!) ||
              regex.hasMatch(person.dns!) ||
              regex.hasMatch(person.nickName!))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  Future<Event?> getSendMessageEvent(String friendPubkey, String replayId,
      MessageType type, String content) async {
    UserDB? friend = allContacts[friendPubkey];
    if (friend != null) {
      Event event = await Nip44.encode(friend.pubKey!,
          MessageDB.encodeContent(type, content), replayId, privkey);
      return event;
    }
    return null;
  }

  Future<void> muteFriend(String friendPubkey) async {
    _setMuteFriend(friendPubkey, true);
  }

  Future<void> unMuteFriend(String friendPubkey) async {
    _setMuteFriend(friendPubkey, false);
  }

  List<String> getAllUnMuteContacts() {
    return allContacts.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.value.pubKey!)
        .toList();
  }

  Future<void> _setMuteFriend(String friendPubkey, bool mute) async {
    if (allContacts.containsKey(friendPubkey)) {
      UserDB friend = allContacts[friendPubkey]!;
      friend.mute = mute;
      await DB.sharedInstance.insert<UserDB>(friend);
    }
  }

  Uint8List? getFriendSharedSecret(String friendPubkey) {
    if (allContacts.containsKey(friendPubkey)) {
      return Nip44.shareSecret(privkey, friendPubkey);
    }
    return null;
  }

  /// sync contacts
  Future<void> _syncContactsFromDB() async {
    String? list = Account.sharedInstance.me?.friendsList;
    if (list != null && list.isNotEmpty) {
      Map? map = Nip51.fromContent(list, privkey, pubkey);
      if (map != null) {
        List<People> friendsList = map['people'];
        await Future.forEach(friendsList, (p) async {
          UserDB? friend = await Account.getUserFromDB(pubkey: p.pubkey);
          if (friend != null) {
            if (friend.toAliasPrivkey == null ||
                friend.toAliasPrivkey!.isEmpty) {
              friend.toAliasPrivkey =
                  bytesToHex(Nip44.shareSecret(privkey, friend.pubKey!));
              friend.toAliasPubkey =
                  Keychain.getPublicKey(friend.toAliasPrivkey!);
            }
            allContacts[p.pubkey] = friend;
          }
        });
      }
    }
  }

  Future<void> _syncContactsFromRelay() async {
    Completer<void> completer = Completer<void>();
    Filter f =
        Filter(kinds: [30000], d: [identifier], authors: [pubkey], limit: 1);
    Lists? result;
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) {
      if (event.content.isNotEmpty &&
          (result == null || result!.createTime < event.createdAt)) {
        result = Nip51.getLists(event, privkey);
        lastFriendListUpdateTime = event.createdAt;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty) {
        if (result != null) {
          await _syncContactsProfiles(result!.people);
        }
        contactUpdatedCallBack?.call();
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<void> _subscriptMessages() async {
    if (friendMessageSubscription.isNotEmpty) {
      await Connect.sharedInstance.closeRequests(friendMessageSubscription);
    }

    Map<String, List<Filter>> subscriptions = {};
    List<String> pubkeys = [pubkey];
    allContacts.forEach((key, value) {
      pubkeys.add(key);
      pubkeys.add(value.toAliasPubkey!);
    });
    for (String relayURL in Connect.sharedInstance.relays()) {
      int friendMessageUntil =
          Relays.sharedInstance.getFriendMessageUntil(relayURL);

      /// contacts messages
      Filter f1 = Filter(
          kinds: [1059, 4, 44],
          authors: pubkeys,
          since: (friendMessageUntil + 1));

      /// unknown contacts messages
      Filter f2 =
          Filter(kinds: [4, 44], p: [pubkey], since: (friendMessageUntil + 1));
      subscriptions[relayURL] = [f1, f2];
    }
    friendMessageSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
      _updateFriendMessageTime(event.createdAt, relay);
      if (event.kind == 4 || event.kind == 44) {
        if (!inBlockList(event.pubkey)) _handlePrivateMessage(event, relay);
      } else if (event.kind == 1059) {
        event = await Nip24.decode(event, privkey);
        switch (event.kind) {
          case 10100:
            handleRequest(event, relay);
            break;
          case 10101:
            handleAccept(event, relay);
            break;
          case 10102:
            handleReject(event, relay);
            break;
          case 10103:
            handleUpdate(event, relay);
            break;
          case 10104:
            handleClose(event, relay);
            break;
          case 25050:
            handleCallEvent(event, relay);
            break;
          default:
            print('unhandled message $event');
            break;
        }
      }
    });
  }

  Future<void> _handlePrivateMessage(Event event, String relay) async {
    MessageDB? messageDB = await MessageDB.fromPrivateMessage(event, privkey);
    if (messageDB != null) secretChatMessageCallBack?.call(messageDB);
  }

  Future<OKEvent> sendPrivateMessage(
      String toPubkey, String replayId, MessageType type, String content,
      {Event? event}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    UserDB? toUserDB = allContacts[toPubkey];
    if (toUserDB != null) {
      event ??= await Nip44.encode(toUserDB.pubKey!,
          MessageDB.encodeContent(type, content), replayId, privkey);

      MessageDB messageDB = MessageDB(
          messageId: event.id,
          sender: pubkey,
          receiver: toPubkey,
          groupId: '',
          kind: event.kind,
          tags: jsonEncode(event.tags),
          content: event.content,
          createTime: event.createdAt,
          decryptContent: content,
          type: MessageDB.messageTypeToString(type),
          status: 0);
      await Messages.saveMessagesToDB([messageDB]);

      Connect.sharedInstance.sendEvent(event,
          sendCallBack: (ok, relay, unRelays) async {
        messageDB.status = ok.status ? 1 : 2;
        await Messages.saveMessagesToDB([messageDB],
            conflictAlgorithm: ConflictAlgorithm.replace);
        if (!completer.isCompleted) completer.complete(ok);
      });
      return completer.future;
    }
    return completer.future;
  }

  void _updateFriendMessageTime(int eventTime, String relay) {
    /// set friendMessageUntil friendMessageSince
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setFriendMessageUntil(eventTime, relay);
      Relays.sharedInstance.setFriendMessageSince(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDB(
          url: relay,
          friendMessageUntil: {relay: eventTime},
          friendMessageSince: {relay: eventTime});
    }
    Relays.sharedInstance.syncRelaysToDB();
  }
}
