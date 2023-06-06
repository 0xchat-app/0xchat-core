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
    if (subscription.isNotEmpty) {
      Connect.sharedInstance.closeSubscription(subscription);
    }

    if (myChannels.keys.isNotEmpty) {
      Filter f = Filter(
          e: myChannels.keys.toList(),
          kinds: [42],
          since: (me!.lastEventTimeStamp! + 1));
      subscription =
          Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
        me!.lastEventTimeStamp = event.createdAt;

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
      DB.sharedInstance.insert<UserDB>(me!);
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
            // authors: [owner], //todo check channel owner
            kinds: [41],
            e: channelIds,
            limit: 1,
          )
        : Filter(
            ids: channelIds,
            // authors: [owner],
            kinds: [40],
          );
    subscriptionId =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
      Channel channel = updateInfos
          ? Nip28.getChannelMetadata(event)
          : Nip28.getChannelCreation(event);

      String badges = '';
      if (channel.additional.containsKey('badges')) {
        badges = jsonEncode(channel.additional['badges']);
      }

      ChannelDB channelDB = ChannelDB(
        channelId: channel.channelId,
        createTime: event.createdAt,
        creator: channel.owner,
        name: channel.name,
        about: channel.about,
        picture: channel.picture,
        badges: badges,
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
    List<String> list = myChannels.keys.toList();
    me!.channelsList = jsonEncode(list);
    await DB.sharedInstance.insert<UserDB>(me!);
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
    Map<String, String> additional = {'badges': jsonEncode(badges)};
    Event event =
        Nip28.createChannel(name, about, picture, additional, privkey);
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
    _updateSubscription();
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
    Event event = Nip28.sendChannelMessage(
        channelId, MessageDB.encodeContent(type, content), privkey,
        relay: relay);
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
        _updateSubscription();
        _syncMyChannelListToRelay();
      }
    });
  }

  Future<void> leaveChannel(String channelId) async {
    myChannels.remove(channelId);
    _updateSubscription();
    _syncMyChannelListToRelay();
  }

  List<ChannelDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      List<ChannelDB> filteredFriends = myChannels.values
          .where((channel) =>
              channel.name!.contains(keyword) ||
              channel.about!.contains(keyword))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  // get 20 latest channels
  Future<void> getLatestChannels(
      GetChannelsCallBack getChannelsCallBack) async {
    String subscriptionId = '';
    Filter f = Filter(kinds: [40], limit: 20);
    List<ChannelDB> result = [];
    subscriptionId =
        Connect.sharedInstance.addSubscription([f], eventCallBack: (event) {
      Channel channel = Nip28.getChannelCreation(event);
      String badges = '';
      if (channel.additional.containsKey('badges')) {
        badges = jsonEncode(channel.additional['badges']);
      }
      ChannelDB channelDB = ChannelDB(
        channelId: event.id,
        createTime: event.createdAt,
        creator: event.pubkey,
        name: channel.name,
        about: channel.about,
        picture: channel.picture,
        badges: badges,
      );
      channels[channelDB.channelId!] = channelDB;
      result.add(channelDB);
      _syncChannelToDB(channelDB);
    }, eoseCallBack: (status) {
      Connect.sharedInstance.closeSubscription(subscriptionId);
      getChannelsCallBack(result);
    });
  }

  Future<void> muteChannel(String channelId) async {
    _setMuteChannel(channelId, true);
  }

  Future<void> unMuteChannel(String channelId) async {
    _setMuteChannel(channelId, false);
  }

  List<String> getAllUnMuteChannels() {
    return myChannels.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.key)
        .toList();
  }

  Future<void> _setMuteChannel(String channelId, bool mute) async {
    if (myChannels.containsKey(channelId)) {
      ChannelDB channelDB = myChannels[channelId]!;
      channelDB.mute = mute;
      await _syncChannelToDB(channelDB);
    }
  }
}
