import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension Admin on Groups {
  Future<GroupDB?> createGroup(String name, List<String> members,
      {String? about,
        String? picture,
        String? relay,
        OKCallBack? callBack}) async {
    Completer<GroupDB?> completer = Completer<GroupDB?>();
    Event event =
    Nip28.createChannel(name, about ?? '', picture ?? '', {}, privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      if (ok.status == true) {
        // update channel
        GroupDB groupDB = GroupDB(
            groupId: event.id,
            updateTime: event.createdAt,
            owner: pubkey,
            name: name,
            about: about,
            picture: picture,
            relay: relay,
            members: members);

        await updateGroup(groupDB, callBack: (OKEvent ok, String relay) async {
          if (ok.status == true) {
            myGroups[groupDB.groupId] = groupDB;
            // update my channel list
            await syncMyGroupListToRelay();
            myGroupsUpdatedCallBack?.call();
            if (!completer.isCompleted) completer.complete(groupDB);
          } else {
            if (!completer.isCompleted) completer.complete(null);
          }
        });
      } else {
        if (!completer.isCompleted) completer.complete(null);
      }
    });

    return completer.future;
  }

  Future<OKEvent> updateGroup(GroupDB groupDB, {OKCallBack? callBack}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event = Nip28.setChannelMetaData(
        groupDB.name,
        groupDB.about!,
        groupDB.picture!,
        groupDB.pinned,
        groupDB.members,
        null,
        groupDB.groupId,
        groupDB.relay ?? '',
        privkey);
    Connect.sharedInstance.sendEvent(event, sendCallBack: (ok, relay) async {
      if (ok.status) {
        await syncGroupToDB(groupDB);
      }
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }
}