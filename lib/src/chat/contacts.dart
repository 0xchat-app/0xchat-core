import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

typedef SecretChatRequestCallBack = void Function(SecretSessionDB);
typedef SecretChatAcceptCallBack = void Function(SecretSessionDB);
typedef SecretChatRejectCallBack = void Function(SecretSessionDB);
typedef SecretChatUpdateCallBack = void Function(SecretSessionDB);
typedef SecretChatCloseCallBack = void Function(SecretSessionDB);
typedef PrivateChatMessageCallBack = void Function(MessageDB);
typedef SecretChatMessageCallBack = void Function(MessageDB);
typedef ContactUpdatedCallBack = void Function();
typedef OfflinePrivateMessageFinishCallBack = void Function();

enum CallMessageState {
  disconnect,
  offer,
  answer,
  reject,
  timeout,
  cancel,
  inCalling
}

class CallMessage {
  String callId;
  String sender;
  String receiver;
  CallMessageState state;
  int start;
  int end;
  String media;

  CallMessage(this.callId, this.sender, this.receiver, this.state, this.start,
      this.end, this.media);
}

class Contacts {
  static final String identifier = 'Chat-Friends';
  static final String blockListidentifier = 'Chat-Block';

  /// singleton
  Contacts._internal();
  factory Contacts() => sharedInstance;
  static final Contacts sharedInstance = Contacts._internal();

  /// memory storage
  String pubkey = '';
  String privkey = '';
  Map<String, UserDB> allContacts = {};
  Map<String, SecretSessionDB> secretSessionMap = {};
  String secretSessionSubscription = '';
  String friendMessageSubscription = '';
  int lastFriendListUpdateTime = 0;
  List<String>? blockList;
  Map<String, CallMessage> callMessages = {};

  /// callbacks
  SecretChatRequestCallBack? secretChatRequestCallBack;
  SecretChatAcceptCallBack? secretChatAcceptCallBack;
  SecretChatRejectCallBack? secretChatRejectCallBack;
  SecretChatUpdateCallBack? secretChatUpdateCallBack;
  SecretChatCloseCallBack? secretChatCloseCallBack;
  SecretChatMessageCallBack? secretChatMessageCallBack;
  PrivateChatMessageCallBack? privateChatMessageCallBack;
  ContactUpdatedCallBack? contactUpdatedCallBack;
  OfflinePrivateMessageFinishCallBack? offlinePrivateMessageFinishCallBack;
  OfflinePrivateMessageFinishCallBack? offlineSecretMessageFinishCallBack;
  Map<String, bool> offlinePrivateMessageFinish = {};
  Map<String, bool> offlineSecretMessageFinish = {};

  void Function(
          String friend, SignalingState state, String data, String? offerId)?
      onCallStateChange;

  Future<void> initContacts(ContactUpdatedCallBack? callBack) async {
    privkey = Account.sharedInstance.currentPrivkey;
    pubkey = Account.sharedInstance.currentPubkey;
    contactUpdatedCallBack = callBack;

    // sync friend list from DB & relays
    await syncBlockListFromDB();
    await _syncContactsFromDB();
    await syncSecretSessionFromDB();

    _updateSubscriptions();

    // subscript friend requests
    Connect.sharedInstance.addConnectStatusListener((relay, status) async {
      if (status == 1 && Account.sharedInstance.me != null) {
        _updateSubscriptions(relay: relay);
      }
    });
  }

  Future<void> _updateSubscriptions({String? relay}) async {
    if (relay == null || Connect.sharedInstance.relays().contains(relay)) {
      await syncBlockListFromRelay(relay: relay);
      await _syncContactsFromRelay(relay: relay);
      _subscriptMessages(relay: relay);
    }
    subscriptSecretChat(relay: relay);
  }

  /// contact list
  Future<void> _syncContactsToDB(String list) async {
    Account.sharedInstance.me?.friendsList = list;
    await Account.sharedInstance.syncMe();
  }

  Future<void> _syncContactsToRelay({OKCallBack? okCallBack}) async {
    List<People> friendList = [];
    for (UserDB user in allContacts.values) {
      People p =
          People(user.pubKey, user.mainRelay, user.nickName, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = await Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    if (event.content.isNotEmpty) {
      Connect.sharedInstance.sendEvent(event,
          sendCallBack: (OKEvent ok, String relay) async {
        if (ok.status) {
          Account.sharedInstance.me!.lastFriendsListUpdatedTime =
              event.createdAt;
          await _syncContactsToDB(event.content);
        }
        okCallBack?.call(ok, relay);
      });
    } else {
      throw Exception('_syncFriendsToRelay error content!, $friendList');
    }
  }

  Future<void> _syncContactsProfiles(List<People> peoples) async {
    await _syncContactsProfilesFromDB(peoples);
    List<People> friendList = [];
    for (UserDB user in allContacts.values) {
      People p =
          People(user.pubKey, user.mainRelay, user.nickName, user.aliasPubkey);
      friendList.add(p);
    }
    Event event = await Nip51.createCategorizedPeople(
        identifier, [], friendList, privkey, pubkey);
    if (event.content.isNotEmpty) {
      _syncContactsToDB(event.content);
    } else {
      throw Exception('_syncFriendsToDB error content!, $friendList');
    }
  }

  Future<void> _syncContactsProfilesFromDB(List<People> peoples) async {
    allContacts.clear();
    await Future.forEach(peoples, (p) async {
      UserDB? user = await Account.sharedInstance.getUserInfo(p.pubkey);
      if (user != null) {
        user.nickName = p.petName;
        allContacts[user.pubKey] = user;
      }
    });
  }

  Future<OKEvent> addToContact(List<String> pubkeys) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    await Future.forEach(pubkeys, (friendPubkey) async {
      UserDB? friend = await Account.sharedInstance.getUserInfo(friendPubkey);
      friend ??= UserDB(pubKey: friendPubkey);
      allContacts[friendPubkey] = friend;
    });
    _syncContactsToRelay(okCallBack: (OKEvent ok, String relay) {
      if (!completer.isCompleted) completer.complete(ok);
    });
    _preloadKind4Messages(pubkeys, currentUnixTimestampSeconds());
    _subscriptMessages();
    return completer.future;
  }

  Future<OKEvent> removeContact(String friendPubkey) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allContacts.remove(friendPubkey);
    if (friend != null) {
      _syncContactsToRelay(okCallBack: (OKEvent ok, String relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
      _subscriptMessages();
    }
    return completer.future;
  }

  Future<OKEvent> updateContactNickName(
      String friendPubkey, String nickName) async {
    Completer<OKEvent> completer = Completer<OKEvent>();

    UserDB? friend = allContacts[friendPubkey];
    if (friend != null && friend.aliasPubkey!.isNotEmpty) {
      friend.nickName = nickName;
      await DB.sharedInstance.update<UserDB>(friend);
      _syncContactsToRelay(okCallBack: (ok, relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
    }
    return completer.future;
  }

  List<UserDB>? fuzzySearch(String keyword) {
    if (keyword.isNotEmpty) {
      RegExp regex = RegExp(keyword, caseSensitive: false);
      List<UserDB> filteredFriends = allContacts.values
          .where((person) =>
              regex.hasMatch(person.name ?? '') ||
              regex.hasMatch(person.dns ?? '') ||
              regex.hasMatch(person.nickName ?? ''))
          .toList();
      return filteredFriends;
    }
    return null;
  }

  Future<Event?> getSendMessageEvent(
      String friendPubkey, String replayId, MessageType type, String content,
      {String? source,
      int? kind,
      int? expiration,
      String? decryptSecret,
      String? sealedReceiver}) async {
    Event? event;
    expiration = expiration != null
        ? (expiration + currentUnixTimestampSeconds())
        : null;
    if (kind == 4) {
      event ??= await Nip4.encode(pubkey, friendPubkey,
          MessageDB.getContent(type, content, source), replayId, privkey,
          subContent: MessageDB.getSubContent(type, content,
              decryptSecret: decryptSecret),
          expiration: expiration);
    } else if (kind == 44) {
      event ??= await Nip44.encode(pubkey, friendPubkey,
          MessageDB.getContent(type, content, source), replayId, privkey,
          subContent: MessageDB.getSubContent(type, content,
              decryptSecret: decryptSecret),
          expiration: expiration);
    } else {
      var intValue = Random().nextInt(24 * 60 * 60 * 7);
      int createAt = currentUnixTimestampSeconds() - intValue;
      event ??= await Nip24.encodeSealedGossipDM(
          friendPubkey,
          MessageDB.getContent(type, content, source),
          replayId,
          pubkey,
          privkey,
          sealedReceiver: sealedReceiver,
          createAt: createAt,
          subContent: MessageDB.getSubContent(type, content,
              decryptSecret: decryptSecret),
          expiration: expiration);
    }
    return event;
  }

  Future<void> muteFriend(String friendPubkey) async {
    _setMuteFriend(friendPubkey, true);
  }

  Future<void> unMuteFriend(String friendPubkey) async {
    _setMuteFriend(friendPubkey, false);
  }

  List<String> getAllUnMuteContacts() {
    return allContacts.entries
        .where((e) => e.value.mute == false)
        .map((e) => e.value.pubKey)
        .toList();
  }

  Future<void> _setMuteFriend(String friendPubkey, bool mute) async {
    if (allContacts.containsKey(friendPubkey)) {
      UserDB friend = allContacts[friendPubkey]!;
      friend.mute = mute;
      await DB.sharedInstance.insert<UserDB>(friend);
    }
  }

  Uint8List? getFriendSharedSecret(String friendPubkey) {
    return Nip44.shareSecret(privkey, friendPubkey);
  }

  /// sync contacts
  Future<void> _syncContactsFromDB() async {
    String? list = Account.sharedInstance.me?.friendsList;
    if (list != null && list.isNotEmpty && list != 'null') {
      Map? map = await Nip51.fromContent(list, privkey, pubkey);
      if (map != null) {
        List<People> friendsList = map['people'];
        await Future.forEach(friendsList, (p) async {
          UserDB? user = await Account.sharedInstance.getUserInfo(p.pubkey);
          if (user != null) {
            user.nickName = p.petName;
            allContacts[user.pubKey] = user;
          }
        });
        contactUpdatedCallBack?.call();
      }
    }
  }

  Future<void> _syncContactsFromRelay({String? relay}) async {
    Completer<void> completer = Completer<void>();
    Filter f = Filter(
        kinds: [30000],
        d: [identifier],
        authors: [pubkey],
        limit: 1,
        since: Account.sharedInstance.me!.lastFriendsListUpdatedTime + 1);
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
          Account.sharedInstance.me!.lastFriendsListUpdatedTime =
              lastEvent!.createdAt;
          Account.sharedInstance.syncMe();
          Lists result = await Nip51.getLists(lastEvent!, pubkey, privkey);
          await _syncContactsProfiles(result.people);
        }
        contactUpdatedCallBack?.call();
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<void> _preloadKind4Messages(List<String> pubkeys, int until) async {
    Filter f1 = Filter(
        kinds: [4, 44],
        authors: [pubkey],
        p: pubkeys,
        until: until,
        limit: pubkeys.length * 100);
    Filter f2 = Filter(
        kinds: [4, 44],
        authors: pubkeys,
        p: [pubkey],
        until: until,
        limit: pubkeys.length * 100);
    Connect.sharedInstance.addSubscription([f1, f2],
        eventCallBack: (event, relay) async {
      if (event.kind == 4 || event.kind == 44) {
        if (!inBlockList(event.pubkey)) _handlePrivateMessage(event, relay);
      }
    }, eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {
      Connect.sharedInstance.closeSubscription(requestId, relay);
    });
  }

  Future<void> _subscriptMessages({String? relay}) async {
    if (friendMessageSubscription.isNotEmpty) {
      await Connect.sharedInstance
          .closeRequests(friendMessageSubscription, relay: relay);
    }

    Map<String, List<Filter>> subscriptions = {};
    int timeOffset = 24 * 60 * 60 * 7; // 7 days
    if (relay == null) {
      for (String relayURL in Connect.sharedInstance.relays()) {
        int friendMessageUntil =
            Relays.sharedInstance.getFriendMessageUntil(relayURL);

        /// all messages, contacts & unknown contacts
        Filter f1 = Filter(
            kinds: [4, 44], p: [pubkey], since: (friendMessageUntil + 1));
        Filter f2 = Filter(
            kinds: [4, 44], authors: [pubkey], since: (friendMessageUntil + 1));
        Filter f3 = Filter(
            kinds: [1059],
            p: [pubkey],
            since: friendMessageUntil > timeOffset
                ? (friendMessageUntil - timeOffset + 1)
                : 1);
        Filter f4 = Filter(
            kinds: [1059],
            authors: [pubkey],
            since: friendMessageUntil > timeOffset
                ? (friendMessageUntil - timeOffset + 1)
                : 1);
        Filter f5 =
            Filter(kinds: [9735], p: [pubkey], since: (friendMessageUntil + 1));
        subscriptions[relayURL] = [f1, f2, f3, f4, f5];
      }
    } else {
      int friendMessageUntil =
          Relays.sharedInstance.getFriendMessageUntil(relay);

      /// all messages, contacts & unknown contacts
      Filter f1 =
          Filter(kinds: [4, 44], p: [pubkey], since: (friendMessageUntil + 1));
      Filter f2 = Filter(
          kinds: [4, 44], authors: [pubkey], since: (friendMessageUntil + 1));
      Filter f3 = Filter(
          kinds: [1059],
          p: [pubkey],
          since: friendMessageUntil > timeOffset
              ? (friendMessageUntil - timeOffset + 1)
              : 1);
      Filter f4 = Filter(
          kinds: [1059],
          authors: [pubkey],
          since: friendMessageUntil > timeOffset
              ? (friendMessageUntil - timeOffset + 1)
              : 1);
      Filter f5 =
          Filter(kinds: [9735], p: [pubkey], since: (friendMessageUntil + 1));
      subscriptions[relay] = [f1, f2, f3, f4, f5];
    }
    friendMessageSubscription = Connect.sharedInstance
        .addSubscriptions(subscriptions, eventCallBack: (event, relay) async {
      if (!Messages.addToLoaded(event.id)) return;
      if (event.kind == 4 || event.kind == 44) {
        updateFriendMessageTime(event.createdAt, relay);
        if (!inBlockList(event.pubkey)) _handlePrivateMessage(event, relay);
      } else if (event.kind == 9735) {
        updateFriendMessageTime(event.createdAt, relay);
        Zaps.handleZapRecordEvent(event);
      } else if (event.kind == 1059) {
        Event? innerEvent = await Nip24.decode(event, pubkey, privkey);
        if (innerEvent != null && !inBlockList(innerEvent.pubkey)) {
          updateFriendMessageTime(innerEvent.createdAt, relay);
          switch (innerEvent.kind) {
            case 14:
              _handlePrivateMessage(innerEvent, relay,
                  giftWrapEventId: event.id);
              break;
            case 10100:
            case 10101:
            case 10102:
            case 10103:
            case 10104:
              handleSecretSession(innerEvent, relay, event.id);
              break;
            case 25050:
              handleCallEvent(innerEvent, relay);
              break;
            case 40:
            case 41:
            case 42:
              Groups.sharedInstance
                  .receiveGroupEvents(innerEvent, relay, event.id);
              break;
            default:
              print('unhandled message $innerEvent');
              break;
          }
        }
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) {
      offlinePrivateMessageFinish[relay] = true;
      updateFriendMessageTime(currentUnixTimestampSeconds(), relay);
      if (unCompletedRelays.isEmpty) {
        offlinePrivateMessageFinishCallBack?.call();
      }
    });
  }

  Future<void> _handlePrivateMessage(Event event, String relay,
      {String? giftWrapEventId}) async {
    if (Messages.addToLoaded(event.id)) {
      MessageDB? messageDB =
          await MessageDB.fromPrivateMessage(event, pubkey, privkey);
      if (messageDB != null) {
        if (giftWrapEventId != null) messageDB.messageId = giftWrapEventId;
        int status = await Messages.saveMessageToDB(messageDB);
        if (status != 0) {
          privateChatMessageCallBack?.call(messageDB);
        }
      }
    }
  }

  Future<OKEvent> sendPrivateMessage(
      String toPubkey, String replyId, MessageType type, String content,
      {Event? event,
      int? kind,
      String? subContent,
      int? expiration,
      bool local = false,
      String? source,
      String? decryptSecret}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    event ??= await getSendMessageEvent(toPubkey, replyId, type, content,
        kind: kind,
        expiration: expiration,
        decryptSecret: decryptSecret,
        source: source);
    expiration = expiration != null
        ? (expiration + currentUnixTimestampSeconds())
        : null;
    MessageDB messageDB = MessageDB(
        messageId: event!.id,
        sender: pubkey,
        receiver: toPubkey,
        groupId: '',
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: event.content,
        replyId: replyId,
        createTime: currentUnixTimestampSeconds(),
        decryptContent: content,
        type: MessageDB.messageTypeToString(type),
        status: 0,
        plaintEvent: jsonEncode(event),
        chatType: 0,
        expiration: expiration,
        decryptSecret: decryptSecret);
    privateChatMessageCallBack?.call(messageDB);
    await Messages.saveMessageToDB(messageDB);

    if (local) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
        messageDB.status = ok.status ? 1 : 2;
        await Messages.saveMessageToDB(messageDB,
            conflictAlgorithm: ConflictAlgorithm.replace);
        if (!completer.isCompleted) completer.complete(ok);
        if (kind != 4 && kind != 44) {
          await sendPrivateMessageToSelf(toPubkey, replyId, type, content,
              kind: kind,
              subContent: subContent,
              expiration: expiration,
              local: local,
              source: source,
              decryptSecret: decryptSecret,
              innerEvent: event?.innerEvent);
        }
      });
    }
    return completer.future;
  }

  Future<OKEvent> sendPrivateMessageToSelf(
      String toPubkey, String replyId, MessageType type, String content,
      {Event? event,
      int? kind,
      String? subContent,
      int? expiration,
      bool local = false,
      String? source,
      String? decryptSecret,
      Event? innerEvent}) async {
    if (innerEvent == null) return OKEvent('', false, 'innerEvent == null');
    Completer<OKEvent> completer = Completer<OKEvent>();
    var intValue = Random().nextInt(24 * 60 * 60 * 7);
    int createAt = currentUnixTimestampSeconds() - intValue;
    event ??= await Nip24.encodeSealedGossipDM(toPubkey,
        MessageDB.getContent(type, content, source), replyId, pubkey, privkey,
        sealedReceiver: pubkey,
        createAt: createAt,
        subContent: MessageDB.getSubContent(type, content,
            decryptSecret: decryptSecret),
        expiration: expiration,
        innerEvent: innerEvent);
    expiration = expiration != null
        ? (expiration + currentUnixTimestampSeconds())
        : null;
    if (Messages.addToLoaded(innerEvent.id)) {
      MessageDB messageDB =
          MessageDB(messageId: innerEvent.id, expiration: expiration);
      await Messages.saveMessageToDB(messageDB);
    }

    if (local) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
        if (!completer.isCompleted) completer.complete(ok);
      });
    }
    return completer.future;
  }

  void updateFriendMessageTime(int eventTime, String relay) {
    /// set friendMessageUntil friendMessageSince
    if (Relays.sharedInstance.relays.containsKey(relay)) {
      Relays.sharedInstance.setFriendMessageUntil(eventTime, relay);
      Relays.sharedInstance.setFriendMessageSince(eventTime, relay);
    } else {
      Relays.sharedInstance.relays[relay] = RelayDB(
          url: relay,
          friendMessageUntil: {relay: eventTime},
          friendMessageSince: {relay: eventTime});
    }
    if (offlinePrivateMessageFinish[relay] == true &&
        offlineSecretMessageFinish[relay] == true) {
      Relays.sharedInstance.syncRelaysToDB(r: relay);
    }
  }
}
