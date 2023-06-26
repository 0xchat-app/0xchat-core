import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

typedef ChannelsUpdatedCallBack = void Function();
typedef ChannelMessageCallBack = void Function(MessageDB);

class Channels {
  /// singleton
  Channels._internal();
  factory Channels() => sharedInstance;
  static final Channels sharedInstance = Channels._internal();

  static final String identifier = 'Chat-Channels';
  // {relay1:subscriptionID1, relay2:subscriptionID2, ...}
  Map<String, String> channelMessageSubscription = {};

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
    for (String relay in Connect.sharedInstance.relays()) {
      if (channelMessageSubscription.containsKey(relay) &&
          channelMessageSubscription[relay] != null) {
        Connect.sharedInstance
            .closeSubscription(channelMessageSubscription[relay]!);
      }

      if (myChannels.keys.isNotEmpty) {
        int lastEventTimeStamp = me!.getUpdatedTimeStampForRelay(relay);
        Filter f = Filter(
            e: myChannels.keys.toList(),
            kinds: [42],
            limit: 100,
            since: (lastEventTimeStamp + 1));
        channelMessageSubscription[relay] = Connect.sharedInstance
            .addSubscription([f], relay: relay, eventCallBack: (event) async {
          await _updateLastEventTimeStamp(event.createdAt, relay);
          switch (event.kind) {
            case 42:
              _receiveChannelMessages(event, relay);
              break;
            default:
              print('unhandled message $event');
              break;
          }
        });
      }
    }
  }

  Future<void> _updateLastEventTimeStamp(int updateTime, String relay) async {
    me = await Account.getUserFromDB(privkey: privkey);
    int lastEventTimeStamp = me!.getUpdatedTimeStampForRelay(relay);
    lastEventTimeStamp =
        lastEventTimeStamp > updateTime ? lastEventTimeStamp : updateTime;
    me!.setUpdatedTimeStampForRelay(relay, updateTime);
    await DB.sharedInstance.insert<UserDB>(me!);
  }

  bool _checkBlockedList(String user) {
    String? blockedList = me!.blockedList;
    if (blockedList != null && blockedList.isNotEmpty) {
      List<String> list = jsonDecode(blockedList);
      return list.contains(user);
    }
    return false;
  }

  Future<void> handleMuteUser(String user) async {
    String? blockedList = me!.blockedList;
    List<String> list = [];
    if (blockedList != null && blockedList.isNotEmpty) {
      list = jsonDecode(blockedList);
    }
    if (list.contains(user) == false) {
      list.add(user);
    }
    me = await Account.getUserFromDB(privkey: privkey);
    me!.blockedList = jsonEncode(list);
    await DB.sharedInstance.insert<UserDB>(me!);
  }

  Future<void> _receiveChannelMessages(Event event, String relay) async {
    ChannelMessage channelMessage = Nip28.getChannelMessage(event);
    if (_checkBlockedList(channelMessage.sender)) return;
    MessageDB messageDB = MessageDB(
      messageId: event.id,
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
    messageDB.type = MessageDB.decodeContent(messageDB.content!)['contentType'];
    if (channelMessageCallBack != null) channelMessageCallBack!(messageDB);
    await Messages.saveMessagesToDB([messageDB]);
  }

  Future<void> _loadMyChannelsFromRelay() async {
    String subscriptionId = '';
    Filter f = Filter(
      kinds: [30001],
      d: [identifier],
      authors: [pubkey],
      limit: 1,
    );
    subscriptionId = Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event) async {
      Lists lists = Nip51.getLists(event, privkey);
      me = await Account.getUserFromDB(privkey: privkey);
      me!.channelsList = jsonEncode(lists.bookmarks);
      DB.sharedInstance.insert<UserDB>(me!);
      await syncChannelsFromRelay(lists.owner, lists.bookmarks);
      myChannels = _myChannels();
      _updateSubscription();
      if (myChannelsUpdatedCallBack != null) myChannelsUpdatedCallBack!();
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
    me = await Account.getUserFromDB(privkey: privkey);
    me!.channelsList = jsonEncode(list);
    await DB.sharedInstance.insert<UserDB>(me!);
  }

  Future<void> _syncMyChannelListToRelay({OKCallBack? callBack}) async {
    List<String> list = myChannels.keys.toList();
    Event event =
        Nip51.createCategorizedBookmarks(identifier, list, [], privkey, pubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: callBack);
    _syncMyChannelListToDB();
  }

  Future<void> initWithPrivkey(String key,
      {ChannelsUpdatedCallBack? callBack}) async {
    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
    me = await Account.getUserFromDB(privkey: key);
    me ??= UserDB(pubKey: pubkey, privkey: privkey);
    myChannelsUpdatedCallBack = callBack;

    await _loadAllChannelsFromDB();

    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) {
      if (status == 1) {
        _loadMyChannelsFromRelay();
        _updateSubscription();
      }
    });
  }

  Future<ChannelDB?> createChannel(String name, String about, String picture,
      List<String>? badges, String relay,
      {OKCallBack? callBack}) async {
    Completer<ChannelDB?> completer = Completer<ChannelDB?>();
    Map<String, String> additional = {'badges': jsonEncode(badges)};
    Event event =
        Nip28.createChannel(name, about, picture, additional, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) async {
      if (ok.status == true) {
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
        completer.complete(channelDB);
      } else {
        completer.complete(null);
      }
    });

    return completer.future;
  }

  Future<void> syncChannelsFromRelay(
      String owner, List<String> channelIds) async {
    Completer<void> completer = Completer<void>();
    // get create infos
    _syncChannelsInfos(owner, channelIds, false, (status) {
      if (status == 1) {
        // get update infos
        _syncChannelsInfos(owner, channelIds, true, (status) {
          // update finished
          completer.complete();
        });
      } else {
        completer.complete();
      }
    });
    return completer.future;
  }

  Future<OKEvent> setChannel(ChannelDB channelDB,
      {OKCallBack? callBack}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip28.setChannelMetaData(
        channelDB.name!,
        channelDB.about!,
        channelDB.picture!,
        channelDB.badges!.isNotEmpty ? jsonDecode(channelDB.badges!) : [],
        channelDB.channelId!,
        channelDB.relayURL!,
        privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
      completer.complete(ok);
    });

    // update channel
    channelDB.channelId = event.id;
    channelDB.creator = pubkey;
    channelDB.createTime = event.createdAt;
    channels[channelDB.channelId!] = channelDB;
    myChannels[channelDB.channelId!] = channelDB;
    _syncChannelToDB(channelDB);
    // update my channel list
    _syncMyChannelListToRelay();
    return completer.future;
  }

  Future<OKEvent> sendChannelMessage(
      String channelId, MessageType type, String content,
      {String? channelRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip28.sendChannelMessage(
        channelId, MessageDB.encodeContent(type, content), privkey,
        channelRelay: channelRelay,
        replyMessage: replyMessage,
        replyMessageRelay: replyMessageRelay,
        replyUser: replyUser,
        replyUserRelay: replyUserRelay);

    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: event.pubkey,
        receiver: '',
        groupId: channelId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: event.content,
        createTime: event.createdAt,
        status: 0);
    Messages.saveMessagesToDB([messageDB]);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
      completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> hideMessage(String messageId, String reason,
      {OKCallBack? callBack}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Messages.deleteMessagesFromDB([messageId]);
    Event event = Nip28.hideChannelMessage(messageId, reason, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
      completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> muteUser(String userPubkey, String reason) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip28.muteUser(userPubkey, reason, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok) {
      completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> joinChannel(String channelId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    _syncChannelsInfos('', [channelId], false, (status) {
      if (channels.containsKey(channelId)) {
        myChannels[channelId] = channels[channelId]!;
        _updateSubscription();
        _syncMyChannelListToRelay(callBack: (ok) {
          print(ok.eventId);
          completer.complete(ok);
        });
      }
    });
    return completer.future;
  }

  Future<OKEvent> leaveChannel(String channelId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    myChannels.remove(channelId);
    _updateSubscription();
    _syncMyChannelListToRelay(callBack: (ok) {
      completer.complete(ok);
    });
    return completer.future;
  }

  List<ChannelDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<ChannelDB> filteredFriends = myChannels.values
          .where((channel) =>
              regex.hasMatch(channel.name!) || regex.hasMatch(channel.about!))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  // get 20 latest channels
  Future<List<ChannelDB>> getLatestChannels() async {
    Completer<List<ChannelDB>> completer = Completer<List<ChannelDB>>();

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
      completer.complete(result);
    });
    return completer.future;
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
