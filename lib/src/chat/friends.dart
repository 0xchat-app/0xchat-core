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

  /// storage
  UserDB? me;
  String pubkey = '';
  String privkey = '';
  Map<String, UserDB> friends = {};
  Map<String, String> subscriptions = {};

  /// callbacks
  FriendRequestCallBack? friendRequestCallBack;
  FriendAcceptCallBack? friendAcceptCallBack;
  FriendRejectCallBack? friendRejectCallBack;
  FriendRemoveCallBack? friendRemoveCallBack;
  FriendMessageCallBack? friendMessageCallBack;

  static String getAliasPrivkey(String friendPubkey, String privkey) {
    return Nip101.aliasPrivkey(friendPubkey, privkey);
  }

  void _syncFriendsFromDB() {
    //todo
  }
  void _syncFriendsToDB(String list) {

  }

  Future<void> initWithPrikey(String key) async {
    me = await Account.getUserFromDB(privkey: key);
    pubkey = me!.pubKey!;
    privkey = me!.privkey!;
    _syncFriendsFromDB();

    /// subscript friend request
    _addSubscription(pubkey);

    String subscriptionId = '';
    Filter f = Filter(
      kinds: [30000],
      d: [identifier],
      authors: [pubkey],
    );
    subscriptionId = Connect.sharedInstance.addSubscription([f], (event) {
      Connect.sharedInstance.closeSubscription(subscriptionId);

      /// clear data
      friends.clear();

      Lists lists = Nip51.getLists(event, privkey);
      for (String p in lists.people) {
        _addFriend(p);
      }
    });
  }

  void _addFriend(String friendPubkey, {String? friendAliasPubkey}) {
    Account.syncProfile((user) {
      if (user != null) {
        user.toAliasPrivkey = Friends.getAliasPrivkey(user.pubKey!, privkey);
        user.toAliasPubkey = Keychain.getPublicKey(privkey);
        if (friendAliasPubkey != null) user.aliasPubkey = friendAliasPubkey;
        friends[user.pubKey!] = user;

        /// subscript friend accept, reject, delete, private messages
        _addSubscription(user.toAliasPubkey!);
        return user;
      }
      return null;
    }, pubkey: friendPubkey);
  }

  void _deleteFriend(String friendPubkey) {
    UserDB? friend = friends.remove(friendPubkey);
    if (friend != null && subscriptions.containsKey(friend.toAliasPubkey)) {
      Close(subscriptions[friend.toAliasPubkey]!);
    }
  }

  void _addSubscription(String subscriptPubkey) {
    if (subscriptions[subscriptPubkey] == null) {
      Filter f = subscriptPubkey == pubkey
          ? Filter(
              kinds: [10100],
              p: [subscriptPubkey],
            )
          : Filter(
              kinds: [10101, 10102, 10103, 4],
              p: [subscriptPubkey],
            );
      subscriptions[subscriptPubkey] =
          Connect.sharedInstance.addSubscription([f], (event) {
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

  void requestFriend(String friendPubkey, String content) {
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.request(
        pubkey, aliasPubkey, aliasPrivkey, friendPubkey, content);
    Connect.sharedInstance.sendEvent(event);
    _addFriend(friendPubkey);
    _updateFriendList();
  }

  void acceptFriend(String friendPubkey, String friendAliasPubkey) {
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event =
        Nip101.accept(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
    _addFriend(friendPubkey, friendAliasPubkey: friendAliasPubkey);
    _updateFriendList();
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
    _updateFriendList();
  }

  void _updateFriendList() {
    List<String> friendList = friends.keys.toList();
    Event event =
        Nip51.createCategorizedPeople(identifier, friendList, privkey, pubkey);
    Connect.sharedInstance.sendEvent(event);
    _syncFriendsToDB(event.content);
  }

  void sendMessage(
      String friendAliasPubkey, String aliasPrivkey, String content) {
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event =
        Nip4.encode(aliasPubkey, friendAliasPubkey, content, '', aliasPrivkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void _handleFriendRequest(Event event) {
    Alias alias = Nip101.getRequest(event, pubkey, privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(alias.toPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    alias.fromAliasPubkey = aliasPubkey;
    if (friendRequestCallBack != null) friendRequestCallBack!(alias);
    print(
        '_handleFriendRequest ${alias.fromPubkey}, ${alias.fromAliasPubkey}, ${alias.toPubkey}, ${alias.toAliasPubkey}, ${alias.content}');
  }

  void _handleFriendAccept(Event event) {
    // Alias alias = Nip101.getAccept(event, pubkey, privkey);

    print('_handleFriendAccept $event');
  }

  void _handleFriendReject(Event event) {
    print('_handleFriendReject $event');
  }

  void _handleFriendRemove(Event event) {
    print('_handleFriendRemove $event');
  }

  void _handlePrivateMessage(Event event) {
    print('event: ${event.serialize()}');
    EDMessage message = Nip4.decode(event, pubkey, privkey);
    print(
        '_handlePrivateMessage from ${message.sender}, to ${message.receiver}, content ${message.content}');
  }
}
