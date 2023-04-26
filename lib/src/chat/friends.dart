import 'package:chatcore/chat-core.dart';
import 'package:nostr/nostr.dart';

typedef GetFriendsCallBack = void Function(List<UserDB>);

class Friends {
  static final String identifier = 'Friends';

  static String getAliasPrivkey(String friendPubkey, String privkey) {
    return Nip101.aliasPrivkey(friendPubkey, privkey);
  }

  void getFriends(String privkey, GetFriendsCallBack callBack){
    String pubkey = Keychain.getPublicKey(privkey);
    String subscriptionId = '';
    Filter f = Filter(
      kinds: [30000],
      d: [identifier],
      authors: [pubkey],
    );
    subscriptionId = Connect.sharedInstance.addSubscription([f], (event) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      Lists lists = Nip51.getLists(event, privkey);
      List<UserDB> users = [];
      for(String p in lists.people){
        Account.syncProfile((user) {
          if(user != null){
            user.aliasPrivkey = Friends.getAliasPrivkey(user.pubKey!, privkey);
            user.aliasPubkey = Keychain.getPublicKey(privkey);
            users.add(user);
          }
        }, pubkey: p);
      }
      callBack(users);
    });
  }

  void requestFriend(String friendPubkey, String privkey, String content){
    String pubkey = Keychain.getPublicKey(privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.request(pubkey, aliasPubkey, aliasPrivkey, friendPubkey, content);
    Connect.sharedInstance.sendEvent(event);
  }

  void acceptFriend(String friendPubkey, String friendAliasPubkey, String privkey){
    String pubkey = Keychain.getPublicKey(privkey);
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip101.accept(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void rejectFriend(String pubkey, String aliasPubkey, String aliasPrivkey, String friendAliasPubkey){
    Event event = Nip101.reject(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }
  
  void removeFriend(String pubkey, String aliasPubkey, String aliasPrivkey, String friendAliasPubkey){
    Event event = Nip101.remove(pubkey, aliasPubkey, aliasPrivkey, friendAliasPubkey);
    Connect.sharedInstance.sendEvent(event);
  }

  void sendMessage(String friendAliasPubkey, String aliasPrivkey, String content){
    String aliasPubkey = Keychain.getPublicKey(aliasPrivkey);
    Event event = Nip4.encode(aliasPubkey, friendAliasPubkey, content, '', aliasPrivkey);
    Connect.sharedInstance.sendEvent(event);
  }
}