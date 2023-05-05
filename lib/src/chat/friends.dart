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
  String privkey = '';
  String pubkey = '';
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

  void syncFriendsFromDB() {}
  void syncFriendsToDB() {}

  void initFriends(String key) {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);

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

  void _addFriend(String friendPubkey) {
    Account.syncProfile((user) {
      if (user != null) {
        user.toAliasPrivkey = Friends.getAliasPrivkey(user.pubKey!, privkey);
        user.toAliasPubkey = Keychain.getPublicKey(privkey);
        friends[user.pubKey!] = user;

        /// subscript friend accept, reject, delete, private messages
        _addSubscription(user.toAliasPubkey!);
      }
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
  }

  void acceptFriend(String friendPubkey, String friendAliasPubkey) {
    String pubkey = Keychain.getPublicKey(privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event =
        Nip101.accept(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
    _addFriend(friendPubkey);
  }

  void rejectFriend(
      String aliasPubkey, String aliasPrivkey, String friendAliasPubkey) {
    Event event =
        Nip101.reject(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void removeFriend(String friendPubkey) {
    UserDB? friend = friends[friendPubkey];
    if(friend != null){
      Event event =
      Nip101.remove(pubkey, friend.toAliasPubkey!, friend.toAliasPrivkey!, friend.aliasPubkey!);
      Connect.sharedInstance.sendEvent(event);
    }
    _deleteFriend(friendPubkey);
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
