import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef ChannelsUpdatedCallBack = void Function();
typedef ChannelMessageCallBack = void Function(MessageDB);

class Channels {
  /// singleton
  Channels._internal();
  factory Channels() => sharedInstance;
  static final Channels sharedInstance = Channels._internal();

  static final String identifier = 'Chat-Channels';
  // {relay1:subscriptionID1, relay2:subscriptionID2, ...}
  String channelMessageSubscription = '';

  // memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, ChannelDB> channels = {};
  Map<String, ChannelDB> myChannels = {};

  ChannelsUpdatedCallBack? myChannelsUpdatedCallBack;
  ChannelMessageCallBack? channelMessageCallBack;

  Future<void> _loadAllChannelsFromDB() async {
    List<Object?> maps = await DB.sharedInstance.objects<ChannelDB>();
    channels = {
      for (var channelDB in maps) (channelDB as ChannelDB).channelId: channelDB
    };
    myChannels = _myChannels();
  }

  void _updateChannelSubscription({String? relay}) {
    if (myChannels.isEmpty) return;
    if (channelMessageSubscription.isNotEmpty) {
      Connect.sharedInstance
          .closeRequests(channelMessageSubscription, relay: relay);
    }

    Map<String, List<Filter>> subscriptions = {};

    if (relay == null) {
      for (String relayURL in Connect.sharedInstance.relays()) {
        int channelMessageUntil =
            Relays.sharedInstance.getChannelMessageUntil(relayURL);
        Filter f = Filter(
            e: myChannels.keys.toList(),
            kinds: [42],
            limit: 1000,
            since: (channelMessageUntil + 1));
        subscriptions[relayURL] = [f];
      }
    } else {
      int channelMessageUntil =
          Relays.sharedInstance.getChannelMessageUntil(relay);
      Filter f = Filter(
          e: myChannels.keys.toList(),
          kinds: [42],
          limit: 1000,
          since: (channelMessageUntil + 1));
      subscriptions[relay] = [f];
    }

    channelMessageSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
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

  Future<bool> _checkBlockedList(String user) async {
    UserDB? me = Account.sharedInstance.me;
    if (me!.blockedList != null && me.blockedList!.isNotEmpty) {
      return me.blockedList!.contains(user);
    }
    return false;
  }

  Future<void> handleMuteUser(String user) async {
    UserDB? me = Account.sharedInstance.me;
    if (me!.blockedList != null && me.blockedList!.contains(user) == false) {
      me.blockedList!.add(user);
    }
    await DB.sharedInstance.insert<UserDB>(me);
  }

  Future<void> _receiveChannelMessages(Event event, String relay) async {
    ChannelMessage channelMessage = Nip28.getChannelMessage(event);
    if (await _checkBlockedList(channelMessage.sender)) return;
    ChannelDB? channel = channels[channelMessage.channelId];
    if (channel != null &&
        channel.badges != null &&
        channel.badges!.length > 10) {
      /// check badge request
      String badgeId =
          List<String>.from(jsonDecode(channel.badges ?? '')).first;
      UserDB? sender =
          await Account.sharedInstance.getUserInfo(channelMessage.sender);
      if (sender != null &&
          sender.badgesList != null &&
          sender.badgesList!.contains(badgeId)) {
        /// meet the request
      } else {
        return;
      }
    }
    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: channelMessage.sender,
        receiver: '',
        groupId: channelMessage.channelId,
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: event.content,
        createTime: event.createdAt,
        plaintEvent: jsonEncode(event));
    messageDB.decryptContent =
        MessageDB.decodeContent(messageDB.content!)['content'];
    messageDB.type = MessageDB.decodeContent(messageDB.content!)['contentType'];

    _updateChannelMessageTime(event.createdAt, relay);

    await Relays.sharedInstance.syncRelaysToDB();
    int status = await Messages.saveMessageToDB(messageDB);
    if (status != 0) {
      channelMessageCallBack?.call(messageDB);
    }
  }

  void _updateChannelMessageTime(int eventTime, String relay) {
    /// set channelMessageUntil channelMessageSince
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setChannelMessageUntil(eventTime, relay);
      Relays.sharedInstance.setChannelMessageSince(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDB(
          url: relay,
          channelMessageUntil: {relay: eventTime},
          channelMessageSince: {relay: eventTime});
    }
    Relays.sharedInstance.syncRelaysToDB();
  }

  Future<void> _loadMyChannelsFromRelay({String? relay}) async {
    Completer<void> completer = Completer<void>();
    Filter f = Filter(
      kinds: [30001],
      d: [identifier],
      authors: [pubkey],
      limit: 1,
    );

    Map<String, List<Filter>> subscriptions = {};
    if (relay == null) {
      for (var r in Connect.sharedInstance.relays()) {
        subscriptions[r] = [f];
      }
    } else {
      subscriptions[relay] = [f];
    }

    Event? lastEvent;
    int lastEventTime = 0;
    Connect.sharedInstance.addSubscriptions(subscriptions,
        eventCallBack: (event, relay) async {
      if (event.content.isNotEmpty && lastEventTime < event.createdAt) {
        lastEventTime = event.createdAt;
        lastEvent = event;
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty) {
        if (lastEvent != null) {
          Lists result = await Nip51.getLists(lastEvent!, privkey);

          UserDB? me = Account.sharedInstance.me;
          me!.channelsList = result.bookmarks;
          DB.sharedInstance.insert<UserDB>(me);
          await syncChannelsFromRelay(result.owner, result.bookmarks);
          myChannels = _myChannels();
          _updateChannelSubscription();
        } else {
          myChannels = _myChannels();
          _updateChannelSubscription();
        }
        if (!completer.isCompleted) completer.complete();
        myChannelsUpdatedCallBack?.call();
      }
    });
    return completer.future;
  }

  Map<String, ChannelDB> _myChannels() {
    Map<String, ChannelDB> result = {};
    UserDB? me = Account.sharedInstance.me;
    if (me != null && me.channelsList != null && me.channelsList!.isNotEmpty) {
      List<String> channelList = me.channelsList!;
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
    Filter f = updateInfos
        ? Filter(
            kinds: [41],
            e: channelIds,
            limit: 1,
          )
        : Filter(
            ids: channelIds,
            kinds: [40],
          );
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) {
      Channel channel = updateInfos
          ? Nip28.getChannelMetadata(event)
          : Nip28.getChannelCreation(event);

      String badges = '';
      if (channel.additional.containsKey('badges')) {
        badges = channel.additional['badges']!;
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
      // check the owner for kind 41
      if (event.kind == 40 ||
          (event.kind == 41 &&
              channels.containsKey(channelDB.channelId) &&
              channels[channelDB.channelId]!.creator == channelDB.creator)) {
        channels[channelDB.channelId] = channelDB;
        _syncChannelToDB(channelDB);
      }
    }, eoseCallBack: (requestId, ok, relay, unRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      eoseCallBack(requestId, ok, relay, unRelays);
    });
  }

  Future<void> _syncChannelToDB(ChannelDB channelDB) async {
    await DB.sharedInstance.insert<ChannelDB>(channelDB);
  }

  Future<void> _syncMyChannelListToDB() async {
    List<String> list = myChannels.keys.toList();
    UserDB? me = Account.sharedInstance.me;
    me!.channelsList = list;
    await DB.sharedInstance.insert<UserDB>(me);
  }

  Future<void> _syncMyChannelListToRelay({OKCallBack? callBack}) async {
    List<String> list = myChannels.keys.toList();
    Event event = await Nip51.createCategorizedBookmarks(
        identifier, list, [], privkey, pubkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: callBack);
    _syncMyChannelListToDB();
  }

  void _loadChannelPreMessages(String channelId, int until, int maxAmount) {
    Filter f =
        Filter(e: [channelId], kinds: [42], limit: maxAmount, until: until);
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      switch (event.kind) {
        case 42:
          _receiveChannelMessages(event, relay);
          break;
        default:
          print('unhandled message $event');
          break;
      }
    }, eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {
      if (unCompletedRelays.isEmpty) {
        Connect.sharedInstance.closeRequests(requestId);
      }
    });
  }

  Future<void> init({ChannelsUpdatedCallBack? callBack}) async {
    if (channelMessageSubscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(channelMessageSubscription);
    }

    privkey = Account.sharedInstance.privkey;
    pubkey = Account.sharedInstance.pubkey;
    myChannelsUpdatedCallBack = callBack;

    await _loadAllChannelsFromDB();
    _updateSubscriptions();
    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1) {
        _updateSubscriptions(relay: relay);
      }
    });
  }

  Future<void> _updateSubscriptions({String? relay}) async {
    await _loadMyChannelsFromRelay(relay: relay);
    _updateChannelSubscription(relay: relay);
  }

  Future<ChannelDB?> createChannel(String name, String about, String picture,
      List<String> badges, String relay,
      {OKCallBack? callBack}) async {
    Completer<ChannelDB?> completer = Completer<ChannelDB?>();
    Map<String, String> additional = {'badges': jsonEncode(badges)};
    Event event =
        Nip28.createChannel(name, about, picture, additional, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
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
        channels[channelDB.channelId] = channelDB;
        myChannels[channelDB.channelId] = channelDB;
        _updateChannelSubscription();
        await _syncChannelToDB(channelDB);
        // update my channel list
        await _syncMyChannelListToRelay();
        myChannelsUpdatedCallBack?.call();
        if (!completer.isCompleted) completer.complete(channelDB);
      } else {
        if (!completer.isCompleted) completer.complete(null);
      }
    });

    return completer.future;
  }

  Future<void> syncChannelsFromRelay(
      String owner, List<String> channelIds) async {
    Completer<void> completer = Completer<void>();
    // get create infos
    _syncChannelsInfos(owner, channelIds, false,
        (requestId, status, relay, unRelays) {
      if (unRelays.isEmpty) {
        // get update infos
        _syncChannelsInfos(owner, channelIds, true,
            (requestId, status, relay, unRelays) {
          // update finished
          if (!completer.isCompleted) completer.complete();
        });
      } else {
        if (!completer.isCompleted) completer.complete();
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
        channelDB.badges!.isNotEmpty ? {'badges': channelDB.badges!} : null,
        channelDB.channelId,
        channelDB.relayURL!,
        privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      if (ok.status) {
        channels[channelDB.channelId] = channelDB;
        myChannels[channelDB.channelId] = channelDB;
        await _syncChannelToDB(channelDB);
      }
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Event? getSendChannelMessageEvent(
      String channelId, MessageType type, String content,
      {String? channelRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay}) {
    Event event = Nip28.sendChannelMessage(
        channelId, MessageDB.encodeContent(type, content), privkey,
        channelRelay: channelRelay,
        replyMessage: replyMessage,
        replyMessageRelay: replyMessageRelay,
        replyUser: replyUser,
        replyUserRelay: replyUserRelay);
    return event;
  }

  Future<OKEvent> sendChannelMessage(
      String channelId, MessageType type, String content,
      {String? channelRelay,
      String? replyMessage,
      String? replyMessageRelay,
      String? replyUser,
      String? replyUserRelay,
      Event? event}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    event ??= Nip28.sendChannelMessage(
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
        decryptContent: content,
        type: MessageDB.messageTypeToString(type),
        createTime: event.createdAt,
        status: 0,
        plaintEvent: jsonEncode(event));
    await Messages.saveMessageToDB(messageDB);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      messageDB.status = ok.status ? 1 : 2;
      await Messages.saveMessageToDB(messageDB,
          conflictAlgorithm: ConflictAlgorithm.replace);
      channelMessageCallBack?.call(messageDB);
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> hideMessage(String messageId, String reason,
      {OKCallBack? callBack}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Messages.deleteMessagesFromDB([messageId]);
    Event event = Nip28.hideChannelMessage(messageId, reason, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> muteUser(String userPubkey, String reason) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip28.muteUser(userPubkey, reason, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> joinChannel(String channelId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    _syncChannelsInfos('', [channelId], false,
        (requestId, ok, relay, unRelays) {
      if (channels.containsKey(channelId)) {
        myChannels[channelId] = channels[channelId]!;
        _loadChannelPreMessages(
            channelId, DateTime.now().millisecondsSinceEpoch ~/ 1000, 100);
        _updateChannelSubscription();
        _syncMyChannelListToRelay(callBack: (ok, relay) {
          if (!completer.isCompleted) completer.complete(ok);
        });
      } else {
        OKEvent okEvent = OKEvent(channelId, false, 'channel not found');
        if (!completer.isCompleted) completer.complete(okEvent);
      }
    });
    return completer.future;
  }

  Future<OKEvent> leaveChannel(String channelId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    myChannels.remove(channelId);
    _updateChannelSubscription();
    _syncMyChannelListToRelay(callBack: (ok, relay) {
      if (!completer.isCompleted) completer.complete(ok);
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

  static String decodeNote(String data) {
    try{
      return Nip19.decodeNote(data);
    }catch(_){
      return '';
    }
  }

  static encodeNote(String noteid) {
    return Nip19.encodeNote(noteid);
  }

  // get 20 latest channels
  Future<List<ChannelDB>> getChannelsFromRelay(
      {List<String>? channelIds}) async {
    Completer<List<ChannelDB>> completer = Completer<List<ChannelDB>>();

    Filter f = channelIds == null
        ? Filter(kinds: [40], limit: 20)
        : Filter(ids: channelIds, kinds: [40]);
    List<ChannelDB> result = [];
    Connect.sharedInstance.addSubscription([f],
        eventCallBack: (event, relay) async {
      Channel channel = Nip28.getChannelCreation(event);
      String badges = '';
      if (channel.additional.containsKey('badges')) {
        badges = channel.additional['badges']!;
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
      result.add(channelDB);
    }, eoseCallBack: (requestId, status, relay, unRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) {
        await Future.forEach(result, (channel) async {
          await syncChannelsFromRelay(channel.creator!, [channel.channelId]);
          if (channels.containsKey(channel.channelId)) {
            channel = channels[channel.channelId]!;
          }
        });
        completer.complete(result);
      }
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

  static String encodeChannel(
      String channelId, List<String>? relays, String? author) {
    return Nip19.encodeShareableEntity('nevent', channelId, relays, author);
  }

  static Map<String, dynamic>? decodeChannel(String encodedChannel) {
    Map result = Nip19.decodeShareableEntity(encodedChannel);
    if (result['prefix'] == 'nevent') {
      return {
        'channelId': result['special'],
        'relays': result['relays'],
        'author': result['author']
      };
    }
    return null;
  }
}
