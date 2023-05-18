import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

typedef ChannelsUpdatedCallBack = void Function();
typedef ChannelMessageCallBack = void Function(MessageDB);
typedef GetChannelsCallBack = void Function(List<ChannelDB>);

class Channels {
  /// singleton
  Channels._internal();
  factory Channels() => sharedInstance;
  static final Channels sharedInstance = Channels._internal();

  static final String identifier = 'Chat-Channels';
  String subscription = '';

  // memory storage
  UserDB? me;
  String pubkey = '';
  String privkey = '';
  Map<String, ChannelDB> channels = {};
  Map<String, ChannelDB> myChannels = {};

  ChannelsUpdatedCallBack? myChannelsUpdatedCallBack;
  ChannelMessageCallBack? channelMessageCallBack;

  Future<void> _loadAllChannelsFromDB() async {
    List<Object?> maps = await DB.sharedInstance.objects<ChannelDB>();
    channels = {
      for (var channelDB in maps) (channelDB as ChannelDB).channelId!: channelDB
    };
    myChannels = _myChannels();
  }

  void _updateSubscription() {
    if(subscription.isNotEmpty) {
      Connect.sharedInstance.closeSubscription(subscription);
    }

    if (myChannels.keys.isNotEmpty) {
      Filter f = Filter(e: myChannels.keys.toList(), kinds: [42]);
      subscription =
          Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
        switch (event.kind) {
          case 42:
            _receiveChannelMessages(event);
            break;
          default:
            print('unhandled message $event');
            break;
        }
      });
    }
  }

  Future<void> _receiveChannelMessages(Event event) async {
    ChannelMessage channelMessage = Nip28.getChannelMessage(event);
    MessageDB messageDB = MessageDB(
      messageId: channelMessage.channelId,
      sender: channelMessage.sender,
      receiver: '',
      groupId: channelMessage.channelId,
      kind: event.kind,
      tags: jsonEncode(event.tags),
      content: event.content,
      createTime: event.createdAt,
    );
    messageDB.decryptContent =
        MessageDB.decodeContent(messageDB.content!)['content'];
    messageDB.type = MessageDB.stringtoMessageType(
        MessageDB.decodeContent(messageDB.content!)['contentType']);
    if (channelMessageCallBack != null) channelMessageCallBack!(messageDB);
    Messages.saveMessagesToDB([messageDB]);
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
      Lists lists = Nip51.getLists(event, privkey);
      me!.channelsList = jsonEncode(lists.bookmarks);
      DB.sharedInstance.update<UserDB>(me!);
      syncChannelsFromRelay(lists.owner, lists.bookmarks, () {
        myChannels = _myChannels();
        _updateSubscription();
        if (myChannelsUpdatedCallBack != null) myChannelsUpdatedCallBack!();
      });
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      if (status == 0) {
        // no channels list
        print('no channels list online!');
        channels.clear();
        _updateSubscription();
        if (myChannelsUpdatedCallBack != null) myChannelsUpdatedCallBack!();
      }
    });
  }

  Map<String, ChannelDB> _myChannels() {
    Map<String, ChannelDB> result = {};
    if (me != null &&
        me!.channelsList != null &&
        me!.channelsList!.isNotEmpty) {
      List<dynamic> channelList = jsonDecode(me!.channelsList!);
      for (String channelId in channelList) {
        if (channels.containsKey(channelId)) {
          result[channelId] = channels[channelId]!;
        }
      }
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
            ids: channelIds,
            authors: [owner],
            kinds: [40],
          );
    subscriptionId =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
      Channel channel = Nip28.getChannel(event);
      ChannelDB channelDB = ChannelDB(
        channelId: channel.channelId,
        createTime: event.createdAt,
        creator: channel.owner,
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
    await DB.sharedInstance.update<ChannelDB>(channelDB);
  }

  Future<void> _syncMyChannelListToDB() async {
    List<String> list = myChannels.keys.toList();
    me!.channelsList = jsonEncode(list);
    await DB.sharedInstance.update<UserDB>(me!);
  }

  Future<void> _syncMyChannelListToRelay() async {
    List<String> list = myChannels.keys.toList();
    Event event =
        Nip51.createCategorizedBookmarks(identifier, list, [], privkey, pubkey);
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

  Future<ChannelDB> createChannel(String name, String about, String picture,
      List<String>? badges, String relay) async {
    Event event =
        Nip28.createChannel(name, about, picture, badges ?? [], privkey);
    Connect.sharedInstance.sendEvent(event);

    // update channel
    ChannelDB channelDB = ChannelDB(
      channelId: event.id,
      createTime: event.createdAt,
      creator: pubkey,
      name: name,
      about: about,
      picture: picture,
      badges: jsonEncode(badges),
      relayURL: relay,
    );
    channelDB.channelId = event.id;
    channelDB.creator = pubkey;
    channelDB.createTime = event.createdAt;
    channels[channelDB.channelId!] = channelDB;
    myChannels[channelDB.channelId!] = channelDB;
    await _syncChannelToDB(channelDB);
    // update my channel list
    await _syncMyChannelListToRelay();
    return channelDB;
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
      } else {
        callBack();
      }
    });
  }

  Future<void> setChannel(ChannelDB channelDB) async {
    Event event = Nip28.setChannelMetaData(
        channelDB.name!,
        channelDB.about!,
        channelDB.picture!,
        channelDB.badges!.isNotEmpty ? jsonDecode(channelDB.badges!) : [],
        channelDB.channelId!,
        channelDB.relayURL!,
        privkey);
    Connect.sharedInstance.sendEvent(event);

    // update channel
    channelDB.channelId = event.id;
    channelDB.creator = pubkey;
    channelDB.createTime = event.createdAt;
    channels[channelDB.channelId!] = channelDB;
    myChannels[channelDB.channelId!] = channelDB;
    _syncChannelToDB(channelDB);
    // update my channel list
    _syncMyChannelListToRelay();
  }

  Future<void> sendChannelMessage(String channelId, MessageType type,
      String content, String? relay, Thread? thread) async {
    Event event = Nip28.sendChannelMessage(channelId,
        MessageDB.encodeContent(type, content), relay, thread, privkey);
    Connect.sharedInstance.sendEvent(event);

    MessageDB messageDB = MessageDB(
      messageId: event.id,
      sender: event.pubkey,
      receiver: '',
      groupId: channelId,
      kind: event.kind,
      tags: jsonEncode(event.tags),
      content: event.content,
      createTime: event.createdAt,
    );
    Messages.saveMessagesToDB([messageDB]);
  }

  Future<void> hideMessage(MessageDB messageDB, String reason) async {
    Messages.deleteMessagesFromDB([messageDB]);
    Nip28.hideChannelMessage(messageDB.messageId!, reason, privkey);
  }

  Future<void> muteUser(String userPubkey, String reason) async {
    Nip28.muteUser(userPubkey, reason, privkey);
  }

  Future<void> joinChannel(String channelId) async {
    _syncChannelsInfos('', [channelId], true, (status) {
      if (channels.containsKey(channelId)) {
        myChannels[channelId] = channels[channelId]!;
        _syncMyChannelListToRelay();
      }
    });
  }

  Future<void> leaveChannel(String channelId) async {
    myChannels.remove(channelId);
    _syncMyChannelListToRelay();
  }

  // get 20 latest channels
  Future<void> getLatestChannels(
      GetChannelsCallBack getChannelsCallBack) async {
    String subscriptionId = '';
    Filter f = Filter(kinds: [40], limit: 20);
    List<ChannelDB> result = [];
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
      result.add(channelDB);
      _syncChannelToDB(channelDB);
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      getChannelsCallBack(result);
    });
  }
}
