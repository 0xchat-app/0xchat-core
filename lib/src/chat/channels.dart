import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr/nostr.dart';

typedef ChannelsUpdatedCallBack = void Function();

class Channels {
  /// singleton
  Channels._internal();
  factory Channels() => sharedInstance;
  static final Channels sharedInstance = Channels._internal();

  static final String identifier = 'Chat-Channels';

  // memory storage
  UserDB? me;
  String pubkey = '';
  String privkey = '';
  Map<String, ChannelDB> channels = {};
  List<ChannelDB> myChannels = [];

  ChannelsUpdatedCallBack? myChannelsUpdatedCallBack;

  Future<void> _loadAllChannelsFromDB() async {
    List<Object?> maps = await DB.sharedInstance.objects<ChannelDB>();
    channels = {
      for (var channelDB in maps) (channelDB as ChannelDB).channelId!: channelDB
    };
    myChannels = _myChannels();
  }

  Future<void> _loadMyChannelsFromRelay() async {
    String subscriptionId = '';
    Filter f = Filter(
      kinds: [30001],
      d: [identifier],
      authors: [pubkey],
      limit: 1,
    );
    subscriptionId =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
      // clear friends data
      Lists lists = Nip51.getLists(event, privkey);
      me!.channelsList = jsonEncode(lists.bookmarks);
      DB.sharedInstance.update<UserDB>(me!);
      syncChannelsFromRelay(lists.owner, lists.bookmarks, () {
        if (myChannelsUpdatedCallBack != null) {
          myChannels = _myChannels();
          myChannelsUpdatedCallBack!();
        }
      });
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) {
        // no friend list
        print('no channels list online!');
        channels.clear();
        if (myChannelsUpdatedCallBack != null) myChannelsUpdatedCallBack!();
      }
    });
  }

  List<ChannelDB> _myChannels() {
    List<String> channelList = jsonDecode(me!.channelsList!);
    List<ChannelDB> result = [];
    for (String channelId in channelList) {
      result.add(channels[channelId]!);
    }
    return result;
  }

  Future<void> _syncChannelsInfos(String owner, List<String> channelIds,
      bool updateInfos, EOSECallBack eoseCallBack) async {
    String subscriptionId = '';
    Filter f = updateInfos
        ? Filter(
            authors: [owner],
            kinds: [41],
            e: channelIds,
            limit: 1,
          )
        : Filter(
            authors: [owner],
            kinds: [40],
            e: channelIds,
          );
    subscriptionId =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
      Channel channel = Nip28.getChannel(event);
      ChannelDB channelDB = ChannelDB(
        channelId: event.id,
        createTime: event.createdAt,
        creator: event.pubkey,
        name: channel.name,
        about: channel.about,
        picture: channel.picture,
        badges: jsonEncode(channel.badges),
      );
      channels[channelDB.channelId!] = channelDB;
      _syncChannelToDB(channelDB);
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      eoseCallBack(status);
    });
  }

  Future<void> _syncChannelToDB(ChannelDB channelDB) async {
    await DB.sharedInstance.insert<ChannelDB>(channelDB);
  }

  Future<void> _syncMyChannelListToDB() async {

  }

  Future<void> _syncMyChannelListToRelay() async {
    List<String> list = myChannels.map((e) => e.channelId!).toList();
    Event event = Nip51.createCategorizedBookmarks(
        identifier, list, [], privkey, pubkey);
    Connect.sharedInstance.sendEvent(event);
    _syncMyChannelListToDB();
  }

  Future<void> initWithPrivkey(String key) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
    me = await Account.getUserFromDB(privkey: key);
    me ??= UserDB(pubKey: pubkey, privkey: privkey);

    await _loadAllChannelsFromDB();
    await _loadMyChannelsFromRelay();
  }

  Future<void> createChannel() async {
    // _syncChannelToDB();
    _syncMyChannelListToRelay();
  }

  Future<void> syncChannelsFromRelay(String owner, List<String> channelIds,
      ChannelsUpdatedCallBack callBack) async {
    // get create infos
    _syncChannelsInfos(owner, channelIds, false, (status) {
      if (status == 1) {
        // get update infos
        _syncChannelsInfos(owner, channelIds, true, (status) {
          // update finished
          callBack();
        });
      }
      else{
        callBack();
      }
    });
  }

  Future<void> setChannel(ChannelDB channelDB) async {}
  Future<void> receiveChannelMessage() async {}
  Future<void> sendChannelMessage() async {}

  Future<void> hideMessage(String messageId) async {}
  Future<void> muteUser(String userPubkey) async {}

  Future<void> joinChannel(String channelId) async {
    _syncMyChannelListToRelay();
  }
  Future<void> leaveChannel(String channelId) async {
    _syncMyChannelListToRelay();
  }
}
