import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension BlockList on Contacts {
  /// sync contacts
  Future<void> _syncBlockListFromDB() async {
    blockList = Account.sharedInstance.me?.blockedList;
  }

  Future<void> _syncBlockListToDB() async {
    Account.sharedInstance.me?.blockedList = blockList;
    await Account.sharedInstance.syncMe();
  }

  Future<void> _syncBlockListFromRelay() async {
    Completer<void> completer = Completer<void>();
    Filter f = Filter(
        kinds: [30000],
        d: [Contacts.blockListidentifier],
        authors: [pubkey],
        limit: 1);
    Lists? result;
    Connect.sharedInstance.addSubscription([f], eventCallBack: (event, relay) {
      if (event.content.isNotEmpty &&
          (result == null || result!.createTime < event.createdAt)) {
        result = Nip51.getLists(event, privkey);
      }
    }, eoseCallBack: (requestId, ok, relay, unCompletedRelays) async {
      Connect.sharedInstance.closeSubscription(requestId, relay);
      if (unCompletedRelays.isEmpty) {
        if (result != null) {
          blockList = result!.people.map((p) => p.pubkey).toList();
          await _syncBlockListToDB();
        }
        contactUpdatedCallBack?.call();
        if (!completer.isCompleted) completer.complete();
      }
    });
    return completer.future;
  }

  void _syncBlockListToRelay({OKCallBack? okCallBack}) {
    if (blockList != null && blockList!.isNotEmpty) {
      List<People> list = [];
      for (String pubkey in blockList!) {
        People p = People(pubkey, '', '', '');
        list.add(p);
      }
      Event event = Nip51.createCategorizedPeople(
          Contacts.blockListidentifier, [], list, privkey, pubkey);
      if (event.content.isNotEmpty) {
        Connect.sharedInstance.sendEvent(event, sendCallBack:
            (OKEvent ok, String relay, List<String> unCompletedRelays) {
          okCallBack?.call(ok, relay, unCompletedRelays);
        });
      } else {
        throw Exception('_syncFriendsToRelay error content!, $blockList');
      }
    }
  }

  Future<void> addToBlockList(String blockPubkey, OKCallBack okCallBack) async {
    blockList ??= [];
    if (!blockList!.contains(blockPubkey)) {
      blockList!.add(blockPubkey);
      _syncBlockListToRelay(okCallBack: okCallBack);
      _syncBlockListToDB();
    } else {
      okCallBack.call(
          OKEvent(blockPubkey, false, 'blockPubkey already exit'), '', []);
    }
  }

  Future<void> removeBlockList(
      String blockPubkey, OKCallBack okCallBack) async {
    if (blockList != null && blockList!.isNotEmpty) {
      bool remove = blockList!.remove(blockPubkey);
      if (remove) {
        _syncBlockListToRelay(okCallBack: okCallBack);
        _syncBlockListToDB();
      }
    } else {
      okCallBack
          .call(OKEvent(blockPubkey, false, 'blockPubkey not exit'), '', []);
    }
  }
}
