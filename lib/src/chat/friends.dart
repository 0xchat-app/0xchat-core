import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

typedef FriendRequestCallBack = void Function(Alias);
typedef FriendAcceptCallBack = void Function(Alias);
typedef FriendRejectCallBack = void Function(Alias);
typedef FriendRemoveCallBack = void Function(Alias);
typedef FriendMessageCallBack = void Function(MessageDB);

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
  Map<String, UserDB> friends = {};
  String friendRequestSubscription = '';
  String updateSubscription = '';

  /// callbacks
  FriendRequestCallBack? friendRequestCallBack;
  FriendAcceptCallBack? friendAcceptCallBack;
  FriendRejectCallBack? friendRejectCallBack;
  FriendRemoveCallBack? friendRemoveCallBack;
  FriendMessageCallBack? friendMessageCallBack;

  static String getAliasPrivkey(String friendPubkey, String privkey) {
    return Nip101.aliasPrivkey(friendPubkey, privkey);
  }

  /// sync friends
  Future<void> _syncFriendsFromDB() async {
    String? list = me?.friendsList;
    if (list != null && list.isNotEmpty) {
      Map map = Nip51.fromContent(list, privkey, pubkey);
      List<People> friendsList = map['people'];
      for (People p in friendsList) {
        UserDB? friend = await Account.getUserFromDB(pubkey: p.pubkey);
        if (friend != null) {
          friend.toAliasPrivkey =
              Friends.getAliasPrivkey(friend.pubKey!, privkey);
          friend.toAliasPubkey = Keychain.getPublicKey(friend.toAliasPrivkey!);
          friends[pubkey] = friend;
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
      friends.clear();
      Lists lists = Nip51.getLists(event, privkey);
      _syncFriendsProfiles(lists.people);
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) {
        // no friend list
        print('no friend list online!');
        friends.clear();
        _syncFriendsListToDB('');
      }
    });
  }

  Future<void> _syncFriendsListToDB(String list) async {
    me?.friendsList = list;
    await DB.sharedInstance.insert<UserDB>(me!);
  }

  void _syncFriendsToRelay() {
    List<People> friendList = [];
    for (UserDB user in friends.values) {
      People p =
          People(user.pubKey!, user.mainRelay, user.name, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    Connect.sharedInstance.sendEvent(event);
    _syncFriendsListToDB(event.content);
  }

  void _syncFriendsProfiles(List<People> peoples) {
    if (peoples.isNotEmpty) {
      List<String> pubkeys = peoples.map((p) => p.pubkey).toList();
      Account.syncProfilesFromRelay(pubkeys, (usersMap) async {
        for (People p in peoples) {
          UserDB? user = usersMap[p.pubkey];
          if (user != null) {
            user.toAliasPrivkey =
                Friends.getAliasPrivkey(user.pubKey!, privkey);
            user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
            user.aliasPubkey = p.aliasPubKey;
            // sync to db
            await DB.sharedInstance.insert<UserDB>(user);
            friends[user.pubKey!] = user;
          }
        }
        // subscript friend accept, reject, delete, private messages
        _updateSubscription();
      });
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
    friends[friendPubkey] = friend;
    await DB.sharedInstance.insert<UserDB>(friend);
    _updateSubscription();
    _syncFriendsToRelay();
  }

  void _deleteFriend(String friendPubkey) {
    UserDB? friend = friends.remove(friendPubkey);
    if (friend != null) {
      _updateSubscription();
      _syncFriendsToRelay();
    }
  }

  void _friendRequestSubscription() {
    Filter f = Filter(
        kinds: [10100], p: [pubkey], since: (me!.lastEventTimeStamp! + 1));
    friendRequestSubscription =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
      me!.lastEventTimeStamp = event.createdAt;
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

  void _updateSubscription() {
    if (updateSubscription.isNotEmpty) {
      Connect.sharedInstance.closeSubscription(updateSubscription);
    }

    List<String> pubkeys = [];
    friends.forEach((key, f) {
      if (f.toAliasPubkey != null && f.toAliasPubkey!.isNotEmpty) {
        pubkeys.add(f.toAliasPubkey!);
      }
    });
    if (pubkeys.isNotEmpty) {
      Filter f = Filter(
          kinds: [10101, 10102, 10103, 4],
          p: pubkeys,
          since: (me!.lastEventTimeStamp! + 1));
      updateSubscription =
          Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
        me!.lastEventTimeStamp = event.createdAt;

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

  void _handleFriendRequest(Event event) {
    Alias alias = Nip101.getRequest(event, pubkey, privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(alias.toPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    alias.fromAliasPubkey = aliasPubkey;
    if (friendRequestCallBack != null) friendRequestCallBack!(alias);
  }

  void _handleFriendAccept(Event event) {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB user in friends.values) {
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
    for (UserDB user in friends.values) {
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
    for (UserDB user in friends.values) {
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

  Alias userDBToAlias(UserDB userDB) {
    String aliasPrivkey = Friends.getAliasPrivkey(userDB.pubKey!, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    return Alias(privkey, aliasPubkey, userDB.pubKey!, userDB.aliasPubkey!,
        "accept", 10101);
  }

  Future<void> initWithPrikey(String key) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
    me = await Account.getUserFromDB(privkey: key);
    me ??= UserDB(pubKey: pubkey, privkey: privkey);

    // sync friend list from DB & relays
    await _syncFriendsFromDB();
    await _syncFriendsFromRelay();

    // subscript friend requests
    _friendRequestSubscription();
  }

  Future<void> requestFriend(String friendPubkey, String content) async {
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.request(
        pubkey, privkey, aliasPubkey, aliasPrivkey, friendPubkey, content);
    Connect.sharedInstance.sendEvent(event);
    await _addFriend(friendPubkey, '');
  }

  Future<void> acceptFriend(
      String friendPubkey, String friendAliasPubkey) async {
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.accept(
        pubkey, privkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
    await _addFriend(friendPubkey, friendAliasPubkey);
  }

  void rejectFriend(String friendPubkey, String friendAliasPubkey) {
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.reject(
        pubkey, privkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void removeFriend(String friendPubkey) {
    UserDB? friend = friends[friendPubkey];
    if (friend != null && friend.aliasPubkey!.isNotEmpty) {
      Event event = Nip101.remove(pubkey, privkey, friend.toAliasPubkey!,
          friend.toAliasPrivkey!, friend.aliasPubkey!);
      Connect.sharedInstance.sendEvent(event);
    }
    _deleteFriend(friendPubkey);
  }

  List<UserDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<UserDB> filteredFriends = friends.values
          .where((person) => regex.hasMatch(person.name!))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  void sendMessage(
      String friendPubkey, String replayId, MessageType type, String content) {
    UserDB? friend = friends[friendPubkey];
    if (friend != null) {
      Event event = Nip4.encode(
          friend.aliasPubkey!,
          MessageDB.encodeContent(type, content),
          replayId,
          friend.toAliasPrivkey!);
      Connect.sharedInstance.sendEvent(event);

      MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: pubkey,
        receiver: friendPubkey,
        groupId: '',
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: event.content,
        createTime: event.createdAt,
      );
      Messages.saveMessagesToDB([messageDB]);
    }
  }

  Future<void> muteFriend(String friendPubkey) async {
    _setMuteFriend(friendPubkey, true);
  }

  Future<void> unMuteFriend(String friendPubkey) async {
    _setMuteFriend(friendPubkey, false);
  }

  List<String> getAllUnMuteFriendsToAliasPubkey() {
    return friends.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.value.toAliasPubkey!)
        .toList();
  }

  Future<void> _setMuteFriend(String friendPubkey, bool mute) async {
    if (friends.containsKey(friendPubkey)) {
      UserDB friend = friends[friendPubkey]!;
      friend.mute = mute;
      await DB.sharedInstance.insert<UserDB>(friend);
    }
  }
}
