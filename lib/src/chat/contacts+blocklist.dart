import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension BlockList on Contacts {
  bool inBlockList(String pubkey) {
    return blockList != null && blockList!.contains(pubkey);
  }

  /// sync
  Future<void> syncBlockListFromDB() async {
    blockList = Account.sharedInstance.me?.blockedList;
  }

  Future<void> _syncBlockListToDB() async {
    Account.sharedInstance.me?.blockedList = blockList;
    await Account.sharedInstance.syncMe();
  }

  Future<void> syncBlockListFromRelay({String? relay}) async {
    Completer<void> completer = Completer<void>();
    Filter f = Filter(
        kinds: [30000],
        d: [Contacts.blockListidentifier],
        authors: [pubkey],
        limit: 1,
        since: Account.sharedInstance.me!.lastBlockListUpdatedTime + 1);

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
          Account.sharedInstance.me!.lastBlockListUpdatedTime =
              lastEvent!.createdAt;
          await Account.sharedInstance.syncMe();
          Lists result = await Nip51.getLists(lastEvent!, pubkey, privkey);
          blockList = result.people.map((p) => p.pubkey).toList();
          await _syncBlockListToDB();
        }
        contactUpdatedCallBack?.call();
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  Future<void> _syncBlockListToRelay({OKCallBack? okCallBack}) async {
    if (blockList != null) {
      List<People> list = [];
      for (String pubkey in blockList!) {
        People p = People(pubkey, '', '', '');
        list.add(p);
      }
      Event event = await Nip51.createCategorizedPeople(
          Contacts.blockListidentifier, [], list, privkey, pubkey);
      if (event.content.isNotEmpty) {
        Connect.sharedInstance.sendEvent(event,
            sendCallBack: (OKEvent ok, String relay) {
          okCallBack?.call(ok, relay);
        });
      } else {
        throw Exception('_syncBlockListToRelay error!, $blockList');
      }
    } else {
      okCallBack?.call(OKEvent('', false, 'blockList is empty'), '');
    }
  }

  Future<OKEvent> addToBlockList(String blockPubkey) async {
    if (blockPubkey == pubkey) {
      return OKEvent(blockPubkey, false, 'can not block self');
    }

    Completer<OKEvent> completer = Completer<OKEvent>();

    blockList ??= [];
    if (!blockList!.contains(blockPubkey)) {
      blockList!.add(blockPubkey);
      _syncBlockListToRelay(okCallBack: (OKEvent ok, String relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
      _syncBlockListToDB();
    } else {
      if (!completer.isCompleted) {
        completer
            .complete(OKEvent(blockPubkey, false, 'blockPubkey already exit'));
      }
    }

    return completer.future;
  }

  Future<OKEvent> removeBlockList(List<String> blockPubkeys) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    if (blockList != null && blockList!.isNotEmpty) {
      for (var p in blockPubkeys) {
        blockList!.remove(p);
      }
      _syncBlockListToRelay(okCallBack: (OKEvent ok, String relay) {
        if (!completer.isCompleted) completer.complete(ok);
      });
      _syncBlockListToDB();
    } else {
      if (!completer.isCompleted) {
        completer.complete(OKEvent('', false, 'blockList empty'));
      }
    }
    return completer.future;
  }
}
