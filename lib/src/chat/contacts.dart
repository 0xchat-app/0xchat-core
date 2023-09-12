import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef SecretChatRequestCallBack = void Function(SecretSessionDB);
typedef SecretChatAcceptCallBack = void Function(SecretSessionDB);
typedef SecretChatRejectCallBack = void Function(SecretSessionDB);
typedef SecretChatUpdateCallBack = void Function(SecretSessionDB);
typedef SecretChatCloseCallBack = void Function(SecretSessionDB);
typedef PrivateChatMessageCallBack = void Function(MessageDB);
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

  /// calling
  bool isCalling = false;
  String callingPubkey = '';

  /// callbacks
  SecretChatRequestCallBack? secretChatRequestCallBack;
  SecretChatAcceptCallBack? secretChatAcceptCallBack;
  SecretChatRejectCallBack? secretChatRejectCallBack;
  SecretChatUpdateCallBack? secretChatUpdateCallBack;
  SecretChatCloseCallBack? secretChatCloseCallBack;
  SecretChatMessageCallBack? secretChatMessageCallBack;
  PrivateChatMessageCallBack? privateChatMessageCallBack;
  ContactUpdatedCallBack? contactUpdatedCallBack;

  void Function(String friend, SignalingState state, String data)?
      onCallStateChange;

  Future<void> initContacts(ContactUpdatedCallBack? callBack) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    contactUpdatedCallBack = callBack;

    // sync friend list from DB & relays
    await _syncContactsFromDB();
    await syncBlockListFromDB();
    await syncSecretSessionFromDB();

    _updateSubscriptions();

    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1) {
        _updateSubscriptions(relay: relay);
      }
    });
  }

  Future<void> _updateSubscriptions({String? relay}) async {
    await _syncContactsFromRelay(relay: relay);
    await syncBlockListFromRelay(relay: relay);
    await _subscriptMessages(relay: relay);
    await subscriptSecretChat(relay: relay);
  }

  /// contact list
  Future<void> _syncContactsToDB(String list) async {
    Account.sharedInstance.me?.friendsList = list;
    await Account.sharedInstance.syncMe();
  }

  Future<void> _syncContactsToRelay({OKCallBack? okCallBack}) async {
    List<People> friendList = [];
    for (UserDB user in allContacts.values) {
      People p =
          People(user.pubKey, user.mainRelay, user.nickName, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = await Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    if (event.content.isNotEmpty) {
      Connect.sharedInstance.sendEvent(event,
          sendCallBack: (OKEvent ok, String relay) async {
        if (ok.status) {
          await _syncContactsToDB(event.content);
        }
        okCallBack?.call(ok, relay);
      });
    } else {
      throw Exception('_syncFriendsToRelay error content!, $friendList');
    }
  }

  Future<void> _syncContactsProfiles(List<People> peoples) async {
    await _syncContactsProfilesFromDB(peoples);
    List<People> friendList = [];
    for (UserDB user in allContacts.values) {
      People p =
          People(user.pubKey, user.mainRelay, user.nickName, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = await Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    if (event.content.isNotEmpty) {
      await _syncContactsToDB(event.content);
    } else {
      throw Exception('_syncFriendsToRelay error content!, $friendList');
    }
  }

  Future<void> _syncContactsProfilesFromDB(List<People> peoples) async {
    allContacts.clear();
    await Future.forEach(peoples, (p) async {
      UserDB? user = await Account.sharedInstance.getUserInfo(p.pubkey);
      if (user != null) {
        if (user.toAliasPrivkey == null || user.toAliasPrivkey!.isEmpty) {
          user.toAliasPrivkey =
              bytesToHex(Nip44.shareSecret(privkey, user.pubKey));
          user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
        }
        user.nickName = p.petName;
        allContacts[user.pubKey] = user;
      }
    });
  }

  // Future<void> _syncContactsProfilesFromRelay(List<String> pubkeys) async {
  //   if (pubkeys.isNotEmpty) {
  //     var usersMap = await Account.sharedInstance.syncProfilesFromRelay(pubkeys);
  //     await Future.forEach(pubkeys, (p) async {
  //       UserDB? user = usersMap[p];
  //       if (user != null) {
  //         if (user.toAliasPrivkey == null || user.toAliasPrivkey!.isEmpty) {
  //           user.toAliasPrivkey =
  //               bytesToHex(Nip44.shareSecret(privkey, user.pubKey));
  //           user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
  //         }
  //         // sync to db
  //         await DB.sharedInstance.insert<UserDB>(user);
  //         allContacts[user.pubKey] = user;
  //       }
  //     });
  //   }
  // }

  Future<OKEvent> addToContact(List<String> pubkeys) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    await Future.forEach(pubkeys, (friendPubkey) async {
      UserDB? friend = await Account.sharedInstance.getUserInfo(friendPubkey);
      friend ??= UserDB(pubKey: friendPubkey);
      if (friend.toAliasPubkey == null || friend.toAliasPubkey!.isEmpty) {
        friend.toAliasPrivkey =
            bytesToHex(Nip44.shareSecret(privkey, friend.pubKey));
        friend.toAliasPubkey = Keychain.getPublicKey(friend.toAliasPrivkey!);
        await DB.sharedInstance.update<UserDB>(friend);
      }
      allContacts[friendPubkey] = friend;
    });
    _syncContactsToRelay(okCallBack: (OKEvent ok, String relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    _preloadKind4Messages(pubkeys, currentUnixTimestampSeconds());
    _subscriptMessages();
    return completer.future;
  }

  Future<OKEvent> removeContact(String friendPubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allContacts.remove(friendPubkey);
    if (friend != null) {
      _syncContactsToRelay(okCallBack: (OKEvent ok, String relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
      _subscriptMessages();
    }
    return completer.future;
  }

  Future<OKEvent> updateContactNickName(
      String friendPubkey, String nickName) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allContacts[friendPubkey];
    if (friend != null && friend.aliasPubkey!.isNotEmpty) {
      friend.nickName = nickName;
      await DB.sharedInstance.update<UserDB>(friend);
      _syncContactsToRelay(okCallBack: (ok, relay) {
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

  Future<Event?> getSendMessageEvent(
      String friendPubkey, String replayId, MessageType type, String content,
      {int kind = 4}) async {
    Event? event;
    if (kind == 44) {
      event ??= await Nip44.encode(friendPubkey,
          MessageDB.encodeContent(type, content), replayId, privkey);
    } else if (kind == 1059 || kind == 14) {
      var intValue = Random().nextInt(24 * 60 * 60 * 7);
      int createAt = currentUnixTimestampSeconds() - intValue;
      event ??= await Nip24.encodeSealedGossipDM(friendPubkey,
          MessageDB.encodeContent(type, content), replayId, privkey,
          createAt: createAt);
    } else {
      event ??= Nip4.encode(friendPubkey,
          MessageDB.encodeContent(type, content), replayId, privkey);
    }
    return event;
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
        .map((e) => e.value.pubKey)
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
      Map? map = await Nip51.fromContent(list, privkey, pubkey);
      if (map != null) {
        List<People> friendsList = map['people'];
        await Future.forEach(friendsList, (p) async {
          UserDB? user = await Account.sharedInstance.getUserInfo(p.pubkey);
          if (user != null) {
            if (user.toAliasPrivkey == null || user.toAliasPrivkey!.isEmpty) {
              user.toAliasPrivkey =
                  bytesToHex(Nip44.shareSecret(privkey, user.pubKey));
              user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
            }
            user.nickName = p.petName;
            allContacts[user.pubKey] = user;
          }
        });
        contactUpdatedCallBack?.call();
      }
    }
  }

  Future<void> _syncContactsFromRelay({String? relay}) async {
    Completer<void> completer = Completer<void>();
    Filter f =
        Filter(kinds: [30000], d: [identifier], authors: [pubkey], limit: 1);
    Map<String, List<Filter>> subscriptions = {};
    if (relay == null) {
      for (var r in Connect.sharedInstance.relays()) {
        subscriptions[r] = [f];
      }
    } else {
      subscriptions[relay] = [f];
    }
    Event? lastEvent;
    int lastEventTime = 0;
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
      if (event.content.isNotEmpty && lastEventTime < event.createdAt) {
        lastEventTime = event.createdAt;
        lastEvent = event;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty) {
        if (lastEvent != null) {
          Lists result = await Nip51.getLists(lastEvent!, privkey);
          await _syncContactsProfiles(result.people);
        }
        contactUpdatedCallBack?.call();
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<void> _preloadKind4Messages(List<String> pubkeys, int until) async {
    Filter f1 = Filter(
        kinds: [4, 44],
        authors: [pubkey],
        p: pubkeys,
        until: until,
        limit: pubkeys.length * 100);
    Filter f2 = Filter(
        kinds: [4, 44],
        authors: pubkeys,
        p: [pubkey],
        until: until,
        limit: pubkeys.length * 100);
    Connect.sharedInstance.addSubscription([f1, f2],
        eventCallBack: (event, relay) async {
      if (event.kind == 4 || event.kind == 44) {
        if (!inBlockList(event.pubkey)) _handlePrivateMessage(event, relay);
      }
    }, eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
    });
  }

  Future<void> _subscriptMessages({String? relay}) async {
    if (friendMessageSubscription.isNotEmpty) {
      await Connect.sharedInstance
          .closeRequests(friendMessageSubscription, relay: relay);
    }

    Map<String, List<Filter>> subscriptions = {};
    int timeOffset = 24 * 60 * 60 * 7; // 7 days
    if (relay == null) {
      for (String relayURL in Connect.sharedInstance.relays()) {
        int friendMessageUntil =
            Relays.sharedInstance.getFriendMessageUntil(relayURL);

        /// all messages, contacts & unknown contacts
        Filter f1 = Filter(
            kinds: [4, 44], p: [pubkey], since: (friendMessageUntil + 1));
        Filter f2 = Filter(
            kinds: [4, 44], authors: [pubkey], since: (friendMessageUntil + 1));
        Filter f3 = Filter(
            kinds: [1059],
            p: [pubkey],
            since: (friendMessageUntil - timeOffset + 1));
        Filter f4 = Filter(
            kinds: [1059],
            authors: [pubkey],
            since: (friendMessageUntil - timeOffset + 1));
        subscriptions[relayURL] = [f1, f2, f3, f4];
      }
    } else {
      int friendMessageUntil =
          Relays.sharedInstance.getFriendMessageUntil(relay);

      /// all messages, contacts & unknown contacts
      Filter f1 =
          Filter(kinds: [4, 44], p: [pubkey], since: (friendMessageUntil + 1));
      Filter f2 = Filter(
          kinds: [4, 44], authors: [pubkey], since: (friendMessageUntil + 1));
      Filter f3 = Filter(
          kinds: [1059],
          p: [pubkey],
          since: (friendMessageUntil - timeOffset + 1));
      Filter f4 = Filter(
          kinds: [1059],
          authors: [pubkey],
          since: (friendMessageUntil - timeOffset + 1));
      subscriptions[relay] = [f1, f2, f3, f4];
    }
    friendMessageSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
      if (event.kind == 4 || event.kind == 44) {
        updateFriendMessageTime(event.createdAt, relay);
        if (!inBlockList(event.pubkey)) _handlePrivateMessage(event, relay);
      } else if (event.kind == 1059 && Messages.addToLoaded(event.id)) {
        Event? innerEvent = await Nip24.decode(event, privkey);
        int friendMessageUntil =
            Relays.sharedInstance.getFriendMessageUntil(relay);
        if (innerEvent != null &&
            !inBlockList(innerEvent.pubkey) &&
            innerEvent.createdAt > friendMessageUntil) {
          updateFriendMessageTime(innerEvent.createdAt, relay);
          switch (innerEvent.kind) {
            case 14:
              _handlePrivateMessage(innerEvent, relay,
                  giftWrapEventId: event.id);
              break;
            case 10100:
              handleRequest(innerEvent, relay);
              break;
            case 10101:
              handleAccept(innerEvent, relay);
              break;
            case 10102:
              handleReject(innerEvent, relay);
              break;
            case 10103:
              handleClose(innerEvent, relay);
              break;
            case 10104:
              handleUpdate(innerEvent, relay);
              break;
            case 25050:
              handleCallEvent(innerEvent, relay);
              break;
            default:
              print('unhandled message $innerEvent');
              break;
          }
        }
      }
    });
  }

  Future<void> _handlePrivateMessage(Event event, String relay,
      {String? giftWrapEventId}) async {
    if (Messages.addToLoaded(event.id)) {
      MessageDB? messageDB =
          await MessageDB.fromPrivateMessage(event, pubkey, privkey);
      if (messageDB != null) {
        if (giftWrapEventId != null) messageDB.messageId = giftWrapEventId;
        int status = await Messages.saveMessageToDB(messageDB);
        if (status != 0) {
          privateChatMessageCallBack?.call(messageDB);
        }
      }
    }
  }

  Future<OKEvent> sendPrivateMessage(
      String toPubkey, String replayId, MessageType type, String content,
      {Event? event, int kind = 4}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (event == null) {
      if (kind == 44) {
        event = await Nip44.encode(toPubkey,
            MessageDB.encodeContent(type, content), replayId, privkey);
      } else if (kind == 1059 || kind == 14) {
        event = await Nip24.encodeSealedGossipDM(toPubkey,
            MessageDB.encodeContent(type, content), replayId, privkey);
      } else {
        event = Nip4.encode(toPubkey, MessageDB.encodeContent(type, content),
            replayId, privkey);
      }
    }
    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: pubkey,
        receiver: toPubkey,
        groupId: '',
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: event.content,
        createTime: currentUnixTimestampSeconds(),
        decryptContent: content,
        type: MessageDB.messageTypeToString(type),
        status: 0,
        plaintEvent: jsonEncode(event));
    privateChatMessageCallBack?.call(messageDB);
    await Messages.saveMessageToDB(messageDB);

    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      messageDB.status = ok.status ? 1 : 2;
      await Messages.saveMessageToDB(messageDB,
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  void updateFriendMessageTime(int eventTime, String relay) {
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
