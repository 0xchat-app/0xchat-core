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

  Future<OKEvent> addGroupMembers(String groupId, List<String> members) async {
    GroupDB? groupDB = myGroups[groupId];
    if (groupDB != null && groupDB.owner == pubkey) {
      List<String>? groupMembers = groupDB.members;
      if (groupMembers != null) {
        List<String> uniqueMembers = members
            .where((element) => !groupMembers.contains(element))
            .toList();
        groupDB.members!.addAll(uniqueMembers);
      } else {
        groupDB.members = members;
      }
      return await updateGroup(groupDB);
    } else {
      return OKEvent(groupId, false, 'group dont exit');
    }
  }

  Future<OKEvent> removeGroupMembers(
      String groupId, List<String> members) async {
    GroupDB? groupDB = myGroups[groupId];
    if (groupDB != null && groupDB.owner == pubkey) {
      if (groupDB.members != null) {
        groupDB.members!.removeWhere((element) => members.contains(element));
        return await updateGroup(groupDB);
      } else {
        return OKEvent(groupId, true, 'success');
      }
    } else {
      return OKEvent(groupId, false, 'group dont exit');
    }
  }

  Future<OKEvent> updateGroupName(String groupId, String name) async {
    GroupDB? groupDB = myGroups[groupId];
    if (groupDB != null && groupDB.owner == pubkey) {
      groupDB.name = name;
      return await updateGroup(groupDB);
    } else {
      return OKEvent(groupId, false, 'group dont exit');
    }
  }

  Future<OKEvent> updateGroupPinned(String groupId, String pinned) async {
    GroupDB? groupDB = myGroups[groupId];
    if (groupDB != null && groupDB.owner == pubkey) {
      groupDB.pinned = [pinned];
      return await updateGroup(groupDB);
    } else {
      return OKEvent(groupId, false, 'group dont exit');
    }
  }
}
