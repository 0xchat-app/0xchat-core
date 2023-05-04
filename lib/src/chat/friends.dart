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
    List<String> p = [];
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

  void _handleFriendRequest(Event event) {}
  void _handleFriendAccept(Event event) {}
  void _handleFriendReject(Event event) {}
  void _handleFriendRemove(Event event) {}
  void _handlePrivateMessage(Event event) {}
}
