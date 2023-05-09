import 'package:chatcore/chat-core.dart';
import 'package:nostr/nostr.dart';

typedef FriendRequestCallBack = void Function(Alias);
typedef FriendAcceptCallBack = void Function(Alias);
typedef FriendRejectCallBack = void Function(Alias);
typedef FriendRemoveCallBack = void Function(Alias);
typedef FriendMessageCallBack = void Function(EDMessage);

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
  String subscription = '';

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
      List<People> friendsList = Nip51.fromContent(list, privkey, pubkey);
      for (People p in friendsList) {
        UserDB? friend = await Account.getUserFromDB(pubkey: p.pubkey);
        if (friend != null) friends[pubkey] = friend;
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
    await DB.sharedInstance.update<UserDB>(me!);
  }

  void _syncFriendsToRelay() {
    List<People> friendList = [];
    for (UserDB user in friends.values) {
      People p =
          People(user.pubKey!, user.aliasPubkey, user.mainRelay, user.name);
      friendList.add(p);
    }
    Event event = Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    Connect.sharedInstance.sendEvent(event);
    _syncFriendsListToDB(event.content);
  }

  void _syncFriendsProfiles(List<People> peoples) {
    List<String> pubkeys = peoples.map((p) => p.pubkey).toList();
    Account.syncProfilesFromRelay(pubkeys, (usersMap) async {
      for (People p in peoples) {
        UserDB? user = usersMap[p.pubkey];
        if (user != null) {
          user.toAliasPrivkey = Friends.getAliasPrivkey(user.pubKey!, privkey);
          user.toAliasPubkey = Keychain.getPublicKey(user.toAliasPrivkey!);
          user.aliasPubkey = p.aliasPubKey;
          // sync to db
          await DB.sharedInstance.update<UserDB>(user);
          friends[user.pubKey!] = user;
        }
      }
      // subscript friend accept, reject, delete, private messages
      _updateSubscription();
    });
  }

  void _addFriend(String friendPubkey, String friendAliasPubkey) {
    if (!friends.containsKey(friendPubkey)) {
      Account.syncProfilesFromRelay([friendPubkey], (usersMap) async {
        UserDB? user = usersMap[friendPubkey];
        if (user != null) {
          user.toAliasPrivkey = Friends.getAliasPrivkey(user.pubKey!, privkey);
          user.toAliasPubkey = Keychain.getPublicKey(privkey);
          user.aliasPubkey = friendAliasPubkey;
          // sync to db
          await DB.sharedInstance.update<UserDB>(user);
          friends[user.pubKey!] = user;
          _updateSubscription();
          _syncFriendsToRelay();
        }
      });
    }
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
      kinds: [10100],
      p: [pubkey],
    );
    subscription =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
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
    Close(subscription);

    List<String> pubkeys = [];
    friends.forEach((key, f) {
      if (f.toAliasPubkey != null) pubkeys.add(f.toAliasPubkey!);
    });

    if (pubkeys.isNotEmpty) {
      Filter f = Filter(
        kinds: [10101, 10102, 10103, 4],
        p: pubkeys,
      );
      subscription =
          Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
        switch (event.kind) {
          case 10100:
            _handleFriendRequest(event);
            break;
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
        DB.sharedInstance.update<UserDB>(user);
        if (friendAcceptCallBack != null) friendAcceptCallBack!(alias);
        break;
      }
    }
  }

  void _handleFriendReject(Event event) {
    print('_handleFriendReject $event');
  }

  void _handleFriendRemove(Event event) {
    print('_handleFriendRemove $event');
  }

  void _handlePrivateMessage(Event event) {
    String toAliasPubkey = Nip101.getP(event);
    for (UserDB user in friends.values) {
      if (user.toAliasPubkey != null && user.toAliasPubkey == toAliasPubkey) {
        EDMessage message =
            Nip4.decode(event, user.toAliasPubkey!, user.toAliasPrivkey!);
        // todo storage messages
        if (friendMessageCallBack != null) friendMessageCallBack!(message);
        break;
      }
    }
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

  void requestFriend(String friendPubkey, String content) {
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.request(
        pubkey, aliasPubkey, aliasPrivkey, friendPubkey, content);
    Connect.sharedInstance.sendEvent(event);
    _addFriend(friendPubkey, '');
  }

  void acceptFriend(String friendPubkey, String friendAliasPubkey) {
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event =
        Nip101.accept(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
    _addFriend(friendPubkey, friendAliasPubkey);
  }

  void rejectFriend(
      String aliasPubkey, String aliasPrivkey, String friendAliasPubkey) {
    Event event =
        Nip101.reject(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void removeFriend(String friendPubkey) {
    UserDB? friend = friends[friendPubkey];
    if (friend != null) {
      Event event = Nip101.remove(pubkey, friend.toAliasPubkey!,
          friend.toAliasPrivkey!, friend.aliasPubkey!);
      Connect.sharedInstance.sendEvent(event);
    }
    _deleteFriend(friendPubkey);
  }

  void sendMessage(String friendPubkey, String replayId, String content) {
    UserDB? friend = friends[friendPubkey];
    if (friend != null) {
      Event event = Nip4.encode(friend.toAliasPubkey!, friend.aliasPubkey!,
          content, replayId, friend.toAliasPrivkey!);
      Connect.sharedInstance.sendEvent(event);
    }
  }
}
