import 'dart:async';
import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

import '../account/relays.dart';

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
    if (myChannels.isEmpty) return;
    if (channelMessageSubscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(channelMessageSubscription);
    }

    Map<String, List<Filter>> subscriptions = {};
    for (String relayURL in Connect.sharedInstance.relays()) {
      int channelMessageUntil =
          Relays.sharedInstance.getChannelMessageUntil(relayURL);
      Filter f = Filter(
          e: myChannels.keys.toList(),
          kinds: [42],
          limit: 100,
          since: (channelMessageUntil + 1));
      subscriptions[relayURL] = [f];
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
    me = await Account.getUserFromDB(privkey: privkey);
    if (me!.blockedList != null && me!.blockedList!.isNotEmpty) {
      return me!.blockedList!.contains(user);
    }
    return false;
  }

  Future<void> handleMuteUser(String user) async {
    me = await Account.getUserFromDB(privkey: privkey);
    if (me!.blockedList != null && me!.blockedList!.contains(user) == false) {
      me!.blockedList!.add(user);
    }
    await DB.sharedInstance.insert<UserDB>(me!);
  }

  Future<void> _receiveChannelMessages(Event event, String relay) async {
    ChannelMessage channelMessage = Nip28.getChannelMessage(event);
    if (await _checkBlockedList(channelMessage.sender)) return;
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

    _updateChannelMessageTime(event.createdAt, relay);

    await Relays.sharedInstance.syncRelaysToDB();
    await Messages.saveMessagesToDB([messageDB]);
    channelMessageCallBack?.call(messageDB);
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
  }

  Future<void> _loadMyChannelsFromRelay() async {
    Completer<void> completer = Completer<void>();
    Filter f = Filter(
      kinds: [30001],
      d: [identifier],
      authors: [pubkey],
      limit: 1,
    );
    Lists? result;
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) {
      if (result == null || result!.createTime < event.createdAt) {
        result = Nip51.getLists(event, privkey);
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty) {
        if (result != null) {
          me = await Account.getUserFromDB(privkey: privkey);
          me!.channelsList = result!.bookmarks;
          DB.sharedInstance.insert<UserDB>(me!);
          await syncChannelsFromRelay(result!.owner, result!.bookmarks);
          myChannels = _myChannels();
          _updateSubscription();
        } else {
          myChannels = _myChannels();
          _updateSubscription();
        }
        completer.complete();
        myChannelsUpdatedCallBack?.call();
      }
    });
    return completer.future;
  }

  Map<String, ChannelDB> _myChannels() {
    Map<String, ChannelDB> result = {};
    if (me != null &&
        me!.channelsList != null &&
        me!.channelsList!.isNotEmpty) {
      List<String> channelList = me!.channelsList!;
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
              channels.containsKey(channelDB.channelId!) &&
              channels[channelDB.channelId!]!.creator == channelDB.creator)) {
        channels[channelDB.channelId!] = channelDB;
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
    me = await Account.getUserFromDB(privkey: privkey);
    me!.channelsList = list;
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
    if (channelMessageSubscription.isNotEmpty) {
      Connect.sharedInstance.closeRequests(channelMessageSubscription);
    }

    privkey = key;
    pubkey = Keychain.getPublicKey(privkey);
    me = await Account.getUserFromDB(privkey: key);
    me ??= UserDB(pubKey: pubkey, privkey: privkey);
    myChannelsUpdatedCallBack = callBack;

    await _loadAllChannelsFromDB();
    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1) {
        await _updateSubscriptions();
      }
    });
    await _updateSubscriptions();
  }

  Future<void> _updateSubscriptions() async {
    await _loadMyChannelsFromRelay();
    _updateSubscription();
  }

  Future<ChannelDB?> createChannel(String name, String about, String picture,
      List<String> badges, String relay,
      {OKCallBack? callBack}) async {
    Completer<ChannelDB?> completer = Completer<ChannelDB?>();
    Map<String, String> additional = {'badges': jsonEncode(badges)};
    Event event =
        Nip28.createChannel(name, about, picture, additional, privkey);
    Connect.sharedInstance.sendEvent(event,
        sendCallBack: (ok, relay, unRelays) async {
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
    _syncChannelsInfos(owner, channelIds, false,
        (requestId, status, relay, unRelays) {
      if (unRelays.isEmpty) {
        // get update infos
        _syncChannelsInfos(owner, channelIds, true,
            (requestId, status, relay, unRelays) {
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
        channelDB.badges!.isNotEmpty ? {'badges': channelDB.badges!} : null,
        channelDB.channelId!,
        channelDB.relayURL!,
        privkey);
    Connect.sharedInstance.sendEvent(event,
        sendCallBack: (ok, relay, unRelays) {
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
    Connect.sharedInstance.sendEvent(event,
        sendCallBack: (ok, relay, unRelays) {
      messageDB.status = ok.status ? 1 : 2;
      Messages.saveMessagesToDB([messageDB]);
      completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> hideMessage(String messageId, String reason,
      {OKCallBack? callBack}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Messages.deleteMessagesFromDB([messageId]);
    Event event = Nip28.hideChannelMessage(messageId, reason, privkey);
    Connect.sharedInstance.sendEvent(event,
        sendCallBack: (ok, relay, unRelays) {
      completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> muteUser(String userPubkey, String reason) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip28.muteUser(userPubkey, reason, privkey);
    Connect.sharedInstance.sendEvent(event,
        sendCallBack: (ok, relay, unRelays) {
      completer.complete(ok);
    });
    return completer.future;
  }

  Future<OKEvent> joinChannel(String channelId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    _syncChannelsInfos('', [channelId], false,
        (requestId, ok, relay, unRelays) {
      if (channels.containsKey(channelId)) {
        myChannels[channelId] = channels[channelId]!;
        _updateSubscription();
        _syncMyChannelListToRelay(callBack: (ok, relay, unRelays) {
          print(ok.eventId);
          completer.complete(ok);
        });
      } else {
        OKEvent okEvent = OKEvent(channelId, false, 'channel not found');
        completer.complete(okEvent);
      }
    });
    return completer.future;
  }

  Future<OKEvent> leaveChannel(String channelId) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    myChannels.remove(channelId);
    _updateSubscription();
    _syncMyChannelListToRelay(callBack: (ok, relay, unRelays) {
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
  Future<List<ChannelDB>> getChannelsFromRelay(
      {List<String>? channelIds}) async {
    Completer<List<ChannelDB>> completer = Completer<List<ChannelDB>>();

    Filter f = channelIds == null
        ? Filter(kinds: [40], limit: 20)
        : Filter(ids: channelIds, kinds: [40]);
    List<ChannelDB> result = [];
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) {
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
      channels[channelDB.channelId!] = channelDB;
      result.add(channelDB);
      _syncChannelToDB(channelDB);
    }, eoseCallBack: (requestId, status, relay, unRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unRelays.isEmpty) completer.complete(result);
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
