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

  /// singleton
  Contacts._internal();
  factory Contacts() => sharedInstance;
  static final Contacts sharedInstance = Contacts._internal();

  /// memory storage
  UserDB? me;
  String pubkey = '';
  String privkey = '';
  Map<String, UserDB> allFriends = {};
  Map<String, FriendRequestDB> friendRequestMap = {};
  String friendRequestSubscription = '';
  String friendMessageSubscription = '';
  int lastFriendListUpdateTime = 0;

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

  Map<String, UserDB> get friends {
    return Map.fromEntries(
      allFriends.entries.where((entry) => (entry.value.aliasPubkey != null &&
          entry.value.aliasPubkey!.isNotEmpty)),
    );
  }

  /// friend list
  Future<void> _syncFriendsListToDB(String list) async {
    me = await Account.getUserFromDB(privkey: privkey);
    me?.friendsList = list;
    await DB.sharedInstance.insert<UserDB>(me!);
  }

  void _syncFriendsToRelay({OKCallBack? okCallBack}) {
    List<People> friendList = [];
    for (UserDB user in allFriends.values) {
      People p =
          People(user.pubKey!, user.mainRelay, user.nickName, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    if (event.content.isNotEmpty) {
      Connect.sharedInstance.sendEvent(event, sendCallBack: okCallBack);
      _syncFriendsListToDB(event.content);
    } else {
      throw Exception('_syncFriendsToRelay error content!, $friendList');
    }
  }

  Future<void> _syncFriendsProfiles(List<People> peoples) async {
    await _syncFriendsProfilesFromDB(peoples);
    _syncFriendsProfilesFromRelay(peoples);
  }

  Future<void> _syncFriendsProfilesFromDB(List<People> peoples) async {
    allFriends.clear();
    await Future.forEach(peoples, (p) async {
      UserDB? user = await Account.getUserFromDB(pubkey: p.pubkey);
      if (user != null) {
        user.toAliasPrivkey = Contacts.getAliasPrivkey(user.pubKey!, privkey);
        user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
        user.aliasPubkey = p.aliasPubKey;
        user.nickName = p.petName;
        allFriends[user.pubKey!] = user;
      }
    });
  }

  Future<void> _syncFriendsProfilesFromRelay(List<People> peoples) async {
    if (peoples.isNotEmpty) {
      List<String> pubkeys = peoples.map((p) => p.pubkey).toList();
      var usersMap = await Account.syncProfilesFromRelay(pubkeys);
      await Future.forEach(peoples, (p) async {
        UserDB? user = usersMap[p.pubkey];
        if (user != null) {
          user.toAliasPrivkey = Contacts.getAliasPrivkey(user.pubKey!, privkey);
          user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
          user.aliasPubkey = p.aliasPubKey;
          user.nickName = p.petName;
          // sync to db
          await DB.sharedInstance.insert<UserDB>(user);
          allFriends[user.pubKey!] = user;
        }
      });
    }
  }

  Future<void> _addFriend(String friendPubkey, String friendAliasPubkey) async {
    UserDB? friend = await Account.getUserFromDB(pubkey: friendPubkey);
    friend ??= UserDB(pubKey: friendPubkey, aliasPubkey: friendAliasPubkey);
    if (friend.toAliasPubkey == null || friend.toAliasPubkey!.isEmpty) {
      friend.toAliasPrivkey = Contacts.getAliasPrivkey(friend.pubKey!, privkey);
      friend.toAliasPubkey = Keychain.getPublicKey(friend.toAliasPrivkey!);
    }
    friend.aliasPubkey = friendAliasPubkey;
    allFriends[friendPubkey] = friend;
    _syncRequestActionsFromRelay();
    await DB.sharedInstance.insert<UserDB>(friend);
    _syncFriendsToRelay();
  }

  Future<void> _deleteFriend(String friendPubkey) async {
    UserDB? friend = allFriends.remove(friendPubkey);
    if (friend != null) {
      await _syncRequestActionsFromRelay();
      _syncFriendsToRelay();
    }
  }



  // Alias userDBToAlias(UserDB userDB) {
  //   String aliasPrivkey = Friends.getAliasPrivkey(userDB.pubKey!, privkey);
  //   String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
  //   return Alias(privkey, aliasPubkey, userDB.pubKey!, userDB.aliasPubkey!,
  //       "accept", 10101);
  // }

  Future<void> initWithPrikey(String key,
      {FriendUpdatedCallBack? callBack}) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
    me = await Account.getUserFromDB(privkey: key);
    me ??= UserDB(pubKey: pubkey, privkey: privkey);
    friendUpdatedCallBack = callBack;

    // sync friend list from DB & relays
    await _syncFriendsFromDB();
    initFriendRequestList();

    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) {
      if (status == 1) {
        _updateSubscriptions();
      }
    });
  }

  Future<void> _updateSubscriptions() async {
    await _syncFriendsFromRelay();
    await _syncAddFriendRequestsFromRelay();
    await _syncRequestActionsFromRelay();
  }

  Future<OKEvent> updateFriendNickName(
      String friendPubkey, String nickName) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allFriends[friendPubkey];
    if (friend != null && friend.aliasPubkey!.isNotEmpty) {
      friend.nickName = nickName;
      await DB.sharedInstance.update<UserDB>(friend);
      _syncFriendsToRelay(okCallBack: (ok, relay, unRelays) {
        if (!completer.isCompleted) completer.complete(ok);
      });
    }
    return completer.future;
  }

  List<UserDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<UserDB> filteredFriends = allFriends.values
          .where((person) =>
              regex.hasMatch(person.name!) ||
              regex.hasMatch(person.dns!) ||
              regex.hasMatch(person.nickName!))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  Event? getSendMessageEvent(
      String friendPubkey, String replayId, MessageType type, String content) {
    UserDB? friend = allFriends[friendPubkey];
    if (friend != null) {
      Event event = Nip4.encode(
          friend.aliasPubkey!,
          MessageDB.encodeContent(type, content),
          replayId,
          friend.toAliasPrivkey!);
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

  List<String> getAllUnMuteFriendsToAliasPubkey() {
    return allFriends.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.value.toAliasPubkey!)
        .toList();
  }

  Future<void> _setMuteFriend(String friendPubkey, bool mute) async {
    if (allFriends.containsKey(friendPubkey)) {
      UserDB friend = allFriends[friendPubkey]!;
      friend.mute = mute;
      await DB.sharedInstance.insert<UserDB>(friend);
    }
  }

  Uint8List? getFriendSharedSecret(String friendPubkey) {
    if (allFriends.containsKey(friendPubkey)) {
      UserDB friend = allFriends[friendPubkey]!;
      return Nip101.getSharedSecret(
          friend.toAliasPrivkey!, friend.aliasPubkey!);
    }
    return null;
  }

  Future<void> initFriendRequestList() async {
    // close subscriptions
    await _closeAllSubscriptions();

    // 0: sync all request & friends from DB
    await _syncAllFriendRequestFromDB();
    await _syncFriendsFromDB();

    // 1: sync friend request & friend list from relay
    await _syncAddFriendRequestsFromRelay();
    await _syncFriendsFromRelay();

    // 2: sync friend actions from relay (accept, reject, remove, sendMsg)
    await _syncRequestActionsFromRelay();
  }

  Future<void> _closeAllSubscriptions() async {
    if (friendRequestSubscription.isNotEmpty) {
      await Connect.sharedInstance.closeRequests(friendRequestSubscription);
    }
    if (friendMessageSubscription.isNotEmpty) {
      await Connect.sharedInstance.closeRequests(friendMessageSubscription);
    }
  }

  Future<void> _syncAllFriendRequestFromDB() async {
    List<FriendRequestDB> friendRequestList =
        await DB.sharedInstance.objects<FriendRequestDB>();
    if (friendRequestList.isNotEmpty) {
      friendRequestMap = {
        for (FriendRequestDB item in friendRequestList) item.friendPubkey!: item
      };
    }
  }

  /// sync friends
  Future<void> _syncFriendsFromDB() async {
    String? list = me?.friendsList;
    if (list != null && list.isNotEmpty) {
      Map? map = Nip51.fromContent(list, privkey, pubkey);
      if (map != null) {
        List<People> friendsList = map['people'];
        await Future.forEach(friendsList, (p) async {
          UserDB? friend = await Account.getUserFromDB(pubkey: p.pubkey);
          if (friend != null) {
            friend.toAliasPrivkey =
                Contacts.getAliasPrivkey(friend.pubKey!, privkey);
            friend.toAliasPubkey =
                Keychain.getPublicKey(friend.toAliasPrivkey!);
            allFriends[p.pubkey] = friend;
          }
        });
      }
    }
  }

  Future<void> _syncAddFriendRequestsFromRelay() async {
    if (friendRequestSubscription.isNotEmpty) {
      await Connect.sharedInstance.closeRequests(friendRequestSubscription);
    }
    Completer<void> completer = Completer<void>();
    Map<String, List<Filter>> subscriptions = {};
    for (String relayURL in Connect.sharedInstance.relays()) {
      int friendRequestUntil =
          Relays.sharedInstance.getFriendMessageUntil(relayURL);
      Filter f1 =
          Filter(kinds: [10100], p: [pubkey], since: (friendRequestUntil + 1));
      subscriptions[relayURL] = [f1];
    }
    friendRequestSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) {
      _handleFriendRequest(event, relay);
    }, eoseCallBack: (requestId, status, relay, unRelays) async {
      if (unRelays.isEmpty) {
        await Relays.sharedInstance.syncRelaysToDB();
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<void> _syncFriendsFromRelay() async {
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
          await _syncFriendsProfiles(result!.people);
        }
        friendUpdatedCallBack?.call();
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<void> _syncRequestActionsFromRelay() async {
    if (friendMessageSubscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(friendMessageSubscription);
    }

    Map<String, List<Filter>> subscriptions = {};
    List<String> pubkeys = [];
    allFriends.forEach((key, f) {
      if (f.toAliasPubkey != null && f.toAliasPubkey!.isNotEmpty) {
        pubkeys.add(f.toAliasPubkey!);
      }
    });
    for (String relayURL in Connect.sharedInstance.relays()) {
      int friendMessageUntil =
          Relays.sharedInstance.getFriendMessageUntil(relayURL);
      Filter f1 = Filter(
          kinds: [10101, 10102, 10103, 4, 25050],
          p: pubkeys,
          since: (friendMessageUntil + 1));
      Filter f2 =
          Filter(kinds: [4], authors: pubkeys, since: (friendMessageUntil + 1));
      subscriptions[relayURL] = [f1, f2];
    }
    friendMessageSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) {
      _updateFriendMessageTime(event.createdAt, relay);
      switch (event.kind) {
        case 10101:
          _handleFriendAccept(event);
          break;
        case 10102:
          _handleFriendReject(event);
          break;
        case 10103:
          _handleFriendRemove(event);
          break;
        case 4:
          _handlePrivateMessage(event);
          break;
        case 25050:
          handleCallEvent(event, relay);
          break;
        default:
          print('unhandled message $event');
          break;
      }
    });
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

  void _updateFriendRequestTime(int eventTime, String relay) {
    /// set friendRequestUntil friendRequestSince
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setFriendRequestUntil(eventTime, relay);
      Relays.sharedInstance.setFriendRequestSince(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDB(
          url: relay,
          friendRequestUntil: eventTime,
          friendRequestSince: eventTime);
    }
    Relays.sharedInstance.syncRelaysToDB();
  }

  Future<void> _syncRequestListToDB(List<FriendRequestDB> list) async {}

  Future<void> _addRequest(FriendRequestDB request) async {}
}
