import 'package:chatcore/chat-core.dart';
import 'package:nostr/nostr.dart';

// typedef GetFriendsCallBack = void Function(List<UserDB>);

class Friends {
  static final String identifier = 'Friends';
  List<UserDB> friends = [];
  String friendsSubscription = '';

  /// singleton
  Friends._internal();
  factory Friends() => sharedInstance;
  static final Friends sharedInstance = Friends._internal();

  void initFriends(String privkey) {
    syncFriends(privkey);
  }

  static String getAliasPrivkey(String friendPubkey, String privkey) {
    return Nip101.aliasPrivkey(friendPubkey, privkey);
  }

  void syncFriendsFromDB() {}
  void syncFriendsToDB() {}

  void syncFriends(String privkey) {
    String pubkey = Keychain.getPublicKey(privkey);
    String subscriptionId = '';
    Filter f = Filter(
      kinds: [30000],
      d: [identifier],
      authors: [pubkey],
    );
    subscriptionId = Connect.sharedInstance.addSubscription([f], (event) {
      Connect.sharedInstance.closeSubscription(subscriptionId);

      /// clear friends
      friends = [];

      Lists lists = Nip51.getLists(event, privkey);
      for (String p in lists.people) {
        Account.syncProfile((user) {
          if (user != null) {
            user.aliasPrivkey = Friends.getAliasPrivkey(user.pubKey!, privkey);
            user.aliasPubkey = Keychain.getPublicKey(privkey);
            friends.add(user);
          }
        }, pubkey: p);
      }
    });
  }

  void requestFriend(String friendPubkey, String privkey, String content) {
    String pubkey = Keychain.getPublicKey(privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.request(
        pubkey, aliasPubkey, aliasPrivkey, friendPubkey, content);
    Connect.sharedInstance.sendEvent(event);
  }

  void acceptFriend(
      String friendPubkey, String friendAliasPubkey, String privkey) {
    String pubkey = Keychain.getPublicKey(privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event =
        Nip101.accept(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void rejectFriend(String pubkey, String aliasPubkey, String aliasPrivkey,
      String friendAliasPubkey) {
    Event event =
        Nip101.reject(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void removeFriend(String pubkey, String aliasPubkey, String aliasPrivkey,
      String friendAliasPubkey) {
    Event event =
        Nip101.remove(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void sendMessage(
      String friendAliasPubkey, String aliasPrivkey, String content) {
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event =
        Nip4.encode(aliasPubkey, friendAliasPubkey, content, '', aliasPrivkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void initSubscription(String privkey) {
    Connect.sharedInstance.closeSubscription(friendsSubscription);
    String pubkey = Keychain.getPublicKey(privkey);
    List<Filter> filters = [];
    Filter friendRequest = Filter(
      kinds: [10100],
      p: [pubkey],
    );
    filters.add(friendRequest);
    List<String> p = [pubkey];
    for (UserDB friend in friends) {
      if (friend.aliasPubkey != null) {
        p.add(friend.aliasPubkey!);
      }
    }
    Filter f = Filter(
      kinds: [10101, 10102, 10103, 4],
      p: p,
    );
    filters.add(f);
    friendsSubscription =
        Connect.sharedInstance.addSubscription(filters, (event) {
      switch (event.kind) {
        case 10100:
          _handleFriendRequest(event, pubkey, privkey);
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
          _handlePrivateMessage(event, pubkey, privkey);
          break;
        default:
          print('unhandled message $event');
          break;
      }
    });
    print('friendsSubscription = $friendsSubscription');
  }

  void _handleFriendRequest(Event event, String pubkey, String privkey) {
    Alias alias = Nip101.getRequest(event, pubkey, privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(alias.toPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    alias.fromAliasPubkey = aliasPubkey;
    print('_handleFriendRequest ${alias.fromPubkey}, ${alias.fromAliasPubkey}, ${alias.toPubkey}, ${alias.toAliasPubkey}, ${alias.content}');
  }

  void _handleFriendAccept(Event event) {
    print('_handleFriendAccept $event');
  }

  void _handleFriendReject(Event event) {
    print('_handleFriendReject $event');
  }

  void _handleFriendRemove(Event event) {
    print('_handleFriendRemove $event');
  }

  void _handlePrivateMessage(Event event, String pubkey, String privkey) {
    print('event: ${event.serialize()}');
    EDMessage message = Nip4.decode(event, pubkey, privkey);
    print(
        '_handlePrivateMessage from ${message.sender}, to ${message.receiver}, content ${message.content}');
  }
}
