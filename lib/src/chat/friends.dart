import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

typedef FriendRequestCallBack = void Function(Alias);
typedef FriendAcceptCallBack = void Function(Alias);
typedef FriendRejectCallBack = void Function(Alias);
typedef FriendRemoveCallBack = void Function(Alias);
typedef FriendMessageCallBack = void Function(MessageDB);
typedef FriendUpdatedCallBack = void Function();

class Friends {
  static final String identifier = 'Chat-Friends';

  /// singleton
  Friends._internal();
  factory Friends() => sharedInstance;
  static final Friends sharedInstance = Friends._internal();

  /// memory storage
  UserDB? me;
  String pubkey = '';
  String privkey = '';
  Map<String, UserDB> allFriends = {};

  Map<String, String> friendRequestSubscription = {};
  Map<String, String> friendMessageSubscription = {};

  /// callbacks
  FriendRequestCallBack? friendRequestCallBack;
  FriendAcceptCallBack? friendAcceptCallBack;
  FriendRejectCallBack? friendRejectCallBack;
  FriendRemoveCallBack? friendRemoveCallBack;
  FriendMessageCallBack? friendMessageCallBack;
  FriendUpdatedCallBack? friendUpdatedCallBack;

  static String getAliasPrivkey(String friendPubkey, String privkey) {
    return Nip101.aliasPrivkey(friendPubkey, privkey);
  }

  Map<String, UserDB> get friends {
    return Map.fromEntries(
      allFriends.entries.where((entry) => (entry.value.aliasPubkey != null &&
          entry.value.aliasPubkey!.isNotEmpty)),
    );
  }

  /// sync friends
  Future<void> _syncFriendsFromDB() async {
    String? list = me?.friendsList;
    if (list != null && list.isNotEmpty) {
      Map? map = Nip51.fromContent(list, privkey, pubkey);
      if(map != null){
        List<People> friendsList = map['people'];
        for (People p in friendsList) {
          UserDB? friend = await Account.getUserFromDB(pubkey: p.pubkey);
          if (friend != null) {
            friend.toAliasPrivkey =
                Friends.getAliasPrivkey(friend.pubKey!, privkey);
            friend.toAliasPubkey = Keychain.getPublicKey(friend.toAliasPrivkey!);
            allFriends[p.pubkey] = friend;
          }
        }
      }
    }
  }

  Future<void> _syncFriendsFromRelay() async {
    String subscriptionId = '';
    Filter f = Filter(
      kinds: [30000],
      d: [identifier],
      authors: [pubkey],
      limit: 1,
    );
    subscriptionId =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
      // clear friends data
      allFriends.clear();
      Lists lists = Nip51.getLists(event, privkey);
      _syncFriendsProfiles(lists.people);
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) {
        // no friend list
        print('no friend list online!');
        allFriends.clear();
        _syncFriendsListToDB('');
        if (friendUpdatedCallBack != null) friendUpdatedCallBack!();
      }
    });
  }

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
    Connect.sharedInstance.sendEvent(event, sendCallBack: okCallBack);
    _syncFriendsListToDB(event.content);
  }

  Future<void> _syncFriendsProfiles(List<People> peoples) async {
    if (peoples.isNotEmpty) {
      List<String> pubkeys = peoples.map((p) => p.pubkey).toList();
      var usersMap = await Account.syncProfilesFromRelay(pubkeys);
      for (People p in peoples) {
        UserDB? user = usersMap[p.pubkey];
        if (user != null) {
          user.toAliasPrivkey = Friends.getAliasPrivkey(user.pubKey!, privkey);
          user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
          user.aliasPubkey = p.aliasPubKey;
          user.nickName = p.petName;
          // sync to db
          await DB.sharedInstance.insert<UserDB>(user);
          allFriends[user.pubKey!] = user;
        }
      }
      // subscript friend accept, reject, delete, private messages
      _updateFriendMessageSubscription();
      if (friendUpdatedCallBack != null) friendUpdatedCallBack!();
    }
  }

  Future<void> _addFriend(String friendPubkey, String friendAliasPubkey) async {
    UserDB? friend = await Account.getUserFromDB(pubkey: friendPubkey);
    friend ??= UserDB(pubKey: friendPubkey, aliasPubkey: friendAliasPubkey);
    if (friend.toAliasPubkey == null || friend.toAliasPubkey!.isEmpty) {
      friend.toAliasPrivkey = Friends.getAliasPrivkey(friend.pubKey!, privkey);
      friend.toAliasPubkey = Keychain.getPublicKey(friend.toAliasPrivkey!);
    }
    friend.aliasPubkey = friendAliasPubkey;
    allFriends[friendPubkey] = friend;
    await DB.sharedInstance.insert<UserDB>(friend);
    _updateFriendMessageSubscription();
    _syncFriendsToRelay();
  }

  void _deleteFriend(String friendPubkey) {
    UserDB? friend = allFriends.remove(friendPubkey);
    if (friend != null) {
      _updateFriendMessageSubscription();
      _syncFriendsToRelay();
    }
  }

  Future<void> _updateLastEventTimeStamp(int updateTime, String relay) async {
    me = await Account.getUserFromDB(privkey: privkey);
    int lastEventTimeStamp = me!.getUpdatedTimeStampForRelay(relay);
    lastEventTimeStamp =
        lastEventTimeStamp > updateTime ? lastEventTimeStamp : updateTime;
    me!.setUpdatedTimeStampForRelay(relay, updateTime);
    await DB.sharedInstance.insert<UserDB>(me!);
  }

  void _updateFriendRequestSubscription() {
    for (String relay in Connect.sharedInstance.relays()) {
      if (friendRequestSubscription.containsKey(relay) &&
          friendRequestSubscription[relay] != null) {
        Connect.sharedInstance
            .closeSubscription(friendRequestSubscription[relay]!);
      }

      int lastEventTimeStamp = me!.getUpdatedTimeStampForRelay(relay);
      Filter f =
          Filter(kinds: [10100], p: [pubkey], since: (lastEventTimeStamp + 1));
      friendRequestSubscription[relay] =
          Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
        _updateLastEventTimeStamp(event.createdAt, relay);
        switch (event.kind) {
          case 10100:
            _handleFriendRequest(event);
            break;
          default:
            print('unhandled message $event');
            break;
        }
      });
    }
  }

  void _updateFriendMessageSubscription() {
    for (String relay in Connect.sharedInstance.relays()) {
      if (friendMessageSubscription.containsKey(relay) &&
          friendMessageSubscription[relay] != null) {
        Connect.sharedInstance
            .closeSubscription(friendMessageSubscription[relay]!);
      }

      List<String> pubkeys = [];
      allFriends.forEach((key, f) {
        if (f.toAliasPubkey != null && f.toAliasPubkey!.isNotEmpty) {
          pubkeys.add(f.toAliasPubkey!);
        }
      });
      if (pubkeys.isNotEmpty) {
        int lastEventTimeStamp = me!.getUpdatedTimeStampForRelay(relay);

        Filter f1 = Filter(
            kinds: [10101, 10102, 10103, 4],
            p: pubkeys,
            since: (lastEventTimeStamp + 1));
        Filter f2 = Filter(
            kinds: [4], authors: pubkeys, since: (lastEventTimeStamp + 1));
        friendMessageSubscription[relay] = Connect.sharedInstance
            .addSubscription([f1, f2], eventCallBack: (event) {
          _updateLastEventTimeStamp(event.createdAt, relay);

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
            default:
              print('unhandled message $event');
              break;
          }
        });
      }
    }
  }

  void _handleFriendRequest(Event event) {
    Alias alias = Nip101.getRequest(event, pubkey, privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(alias.toPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    alias.fromAliasPubkey = aliasPubkey;
    if (friendRequestCallBack != null) friendRequestCallBack!(alias);
  }

  void _handleFriendAccept(Event event) {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB user in allFriends.values) {
      if (user.toAliasPubkey != null && user.toAliasPubkey == toAliasPubkey) {
        Alias alias = Nip101.getAccept(
            event, pubkey, user.toAliasPubkey!, user.toAliasPrivkey!);
        user.aliasPubkey = alias.toAliasPubkey;
        DB.sharedInstance.insert<UserDB>(user);
        if (friendAcceptCallBack != null) friendAcceptCallBack!(alias);
        return;
      }
    }
  }

  void _handleFriendReject(Event event) {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB user in allFriends.values) {
      if (user.toAliasPubkey != null && user.toAliasPubkey == toAliasPubkey) {
        Alias alias = Nip101.getReject(
            event, pubkey, user.toAliasPubkey!, user.toAliasPrivkey!);
        removeFriend(user.pubKey!);
        if (friendRejectCallBack != null) friendRejectCallBack!(alias);
        return;
      }
    }
  }

  void _handleFriendRemove(Event event) {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB user in allFriends.values) {
      if (user.toAliasPubkey != null && user.toAliasPubkey == toAliasPubkey) {
        Alias alias = Nip101.getRemove(
            event, pubkey, user.toAliasPubkey!, user.toAliasPrivkey!);
        // check is real friend(aliasPubkey can't not be null)
        if (user.aliasPubkey != null && user.aliasPubkey!.isNotEmpty) {
          removeFriend(user.pubKey!);
          if (friendRemoveCallBack != null) friendRemoveCallBack!(alias);
        }
        return;
      }
    }
  }

  void _handlePrivateMessage(Event event) {
    MessageDB? messageDB = MessageDB.fromPrivateMessage(event);
    if (messageDB != null) {
      Messages.saveMessagesToDB([messageDB]);
      if (friendMessageCallBack != null) {
        friendMessageCallBack!(messageDB);
      }
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
    print('initWithPrikey');
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
    me = await Account.getUserFromDB(privkey: key);
    me ??= UserDB(pubKey: pubkey, privkey: privkey);
    friendUpdatedCallBack = callBack;

    // sync friend list from DB & relays
    await _syncFriendsFromDB();

    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) {
      if (status == 1) {
        _syncFriendsFromRelay();
        _updateFriendRequestSubscription();
        _updateFriendMessageSubscription();
      }
    });
  }

  Future<OKEvent> requestFriend(String friendPubkey, String content) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.request(
        pubkey, privkey, aliasPubkey, aliasPrivkey, friendPubkey, content);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
      completer.complete(ok);
    });
    await _addFriend(friendPubkey, '');
    return completer.future;
  }

  Future<OKEvent> acceptFriend(
      String friendPubkey, String friendAliasPubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.accept(
        pubkey, privkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
      completer.complete(ok);
    });
    await _addFriend(friendPubkey, friendAliasPubkey);
    return completer.future;
  }

  Future<OKEvent> rejectFriend(
    String friendPubkey,
    String friendAliasPubkey,
  ) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.reject(
        pubkey, privkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
      completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> removeFriend(String friendPubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allFriends[friendPubkey];
    if (friend != null && friend.aliasPubkey!.isNotEmpty) {
      Event event = Nip101.remove(pubkey, privkey, friend.toAliasPubkey!,
          friend.toAliasPrivkey!, friend.aliasPubkey!);
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
        completer.complete(ok);
      });
    }
    _deleteFriend(friendPubkey);
    return completer.future;
  }

  Future<OKEvent> updateFriendNickName(
      String friendPubkey, String nickName) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allFriends[friendPubkey];
    if (friend != null && friend.aliasPubkey!.isNotEmpty) {
      friend.nickName = nickName;
      _syncFriendsToRelay(okCallBack: (ok) {
        completer.complete(ok);
      });
    }
    return completer.future;
  }

  List<UserDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<UserDB> filteredFriends = allFriends.values
          .where((person) => regex.hasMatch(person.name!))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  Future<OKEvent> sendMessage(
    String friendPubkey,
    String replayId,
    MessageType type,
    String content,
  ) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    UserDB? friend = allFriends[friendPubkey];
    if (friend != null) {
      Event event = Nip4.encode(
          friend.aliasPubkey!,
          MessageDB.encodeContent(type, content),
          replayId,
          friend.toAliasPrivkey!);

      MessageDB messageDB = MessageDB(
          messageId: event.id,
          sender: pubkey,
          receiver: friendPubkey,
          groupId: '',
          kind: event.kind,
          tags: jsonEncode(event.tags),
          content: event.content,
          createTime: event.createdAt,
          decryptContent: content,
          type: MessageDB.messageTypeToString(type),
          status: 0);
      Messages.saveMessagesToDB([messageDB]);
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
        completer.complete(ok);
      });
      return completer.future;
    }
    return completer.future;
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
}
