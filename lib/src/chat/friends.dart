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
      Lists lists = Nip51.getLists(event, privkey);
      List<UserDB> users = [];
      for(String p in lists.people){
        Account.syncProfile((user) {
          if(user != null) users.add(user);
        }, pubkey: p);
      }
      Connect.sharedInstance.closeSubscription(subscriptionId);
      callBack(users);
    });
  }

  void requestFriend(String friendPubkey, String privkey){
    String aliasPrivkey = Friends.getAliasPrivkey(friendPubkey, privkey);
    String aliasPubkey = Keychain.getPublicKey(privkey);

  }
  acceptFriend(){}
  rejectFriend(){}
  removeFriend(){}
  sendMessage(String content, String user){}
  listenMessages(){}
}