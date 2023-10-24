import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension Admin on Groups {
  Future<GroupDB?> createGroup(String name, List<String> members,
      {String? about, String? picture, String? relay}) async {
    Event event =
        Nip28.createChannel(name, about ?? '', picture ?? '', {}, privkey);
    OKEvent ok = await sendMessageEvent(members, event);
    if (ok.status == true) {
      // update group
      GroupDB groupDB = GroupDB(
          groupId: event.id,
          updateTime: event.createdAt,
          owner: pubkey,
          name: name,
          about: about,
          picture: picture,
          relay: relay,
          members: members);

      ok = await updateGroup(groupDB);
      if (ok.status == true) {
        sendGroupMessage(groupDB.groupId, MessageType.text, '',
            actionsType: 'add');
        myGroups[groupDB.groupId] = groupDB;
        // update my group list
        await syncMyGroupListToRelay();
        myGroupsUpdatedCallBack?.call();
        return groupDB;
      }
    }
    return null;
  }

  Future<OKEvent> updateGroup(GroupDB groupDB) async {
    Event event = Nip28.setChannelMetaData(
        groupDB.name,
        groupDB.about ?? '',
        groupDB.picture ?? '',
        groupDB.pinned,
        groupDB.members,
        null,
        groupDB.groupId,
        groupDB.relay ?? '',
        privkey);
    OKEvent ok = await sendMessageEvent(groupDB.members, event);
    if (ok.status) {
      await syncGroupToDB(groupDB);
    }
    return ok;
  }

  Future<OKEvent> addGroupMembers(
      String groupId, String content, List<String> members) async {
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
      OKEvent okEvent = await updateGroup(groupDB);
      if (okEvent.status) {
        sendGroupMessage(groupId, MessageType.text, content,
            actionsType: 'add');
      }
      return okEvent;
    } else {
      return OKEvent(groupId, false, 'group not exit');
    }
  }

  Future<OKEvent> removeGroupMembers(
      String groupId, String content, List<String> members) async {
    GroupDB? groupDB = myGroups[groupId];
    if (groupDB != null && groupDB.owner == pubkey) {
      if (groupDB.members != null) {
        OKEvent okEvent = await sendGroupMessage(groupId, MessageType.text, content,
            actionsType: 'remove');
        if(okEvent.status){
          groupDB.members!.removeWhere((element) => members.contains(element));
          okEvent = await updateGroup(groupDB);
        }
        return okEvent;
      } else {
        return OKEvent(groupId, true, 'success');
      }
    } else {
      return OKEvent(groupId, false, 'group not exit');
    }
  }

  Future<OKEvent> updateGroupName(
      String groupId, String content, String name) async {
    GroupDB? groupDB = myGroups[groupId];
    if (groupDB != null && groupDB.owner == pubkey) {
      groupDB.name = name;
      OKEvent okEvent = await updateGroup(groupDB);
      if (okEvent.status) {
        sendGroupMessage(groupId, MessageType.text, content,
            actionsType: 'updateName');
      }
      return okEvent;
    } else {
      return OKEvent(groupId, false, 'group not exit');
    }
  }

  Future<OKEvent> updateGroupPinned(
      String groupId, String content, String pinned) async {
    GroupDB? groupDB = myGroups[groupId];
    if (groupDB != null && groupDB.owner == pubkey) {
      groupDB.pinned = [pinned];
      OKEvent okEvent = await updateGroup(groupDB);
      if (okEvent.status) {
        sendGroupMessage(groupId, MessageType.text, content,
            actionsType: 'updatePinned');
      }
      return okEvent;
    } else {
      return OKEvent(groupId, false, 'group not exit');
    }
  }

  Future<List<MessageDB>> getRequestList({String? groupId}) async {
    String? where;
    List<Object?>? whereArgs;
    if (groupId == null) {
      where = 'chatType = ? AND type = ? AND subType = ?';
      whereArgs = [3, 'system', 'request'];
    } else {
      where = 'groupId = ? AND chatType = ? AND type = ? AND subType = ?';
      whereArgs = [groupId, 3, 'system', 'request'];
    }
    List<Object?> maps = await DB.sharedInstance
        .objects<MessageDB>(whereArgs: whereArgs, where: where);
    return maps.map((e) => e as MessageDB).toList();
  }

  Future<void> ignoreRequest(MessageDB messageDB) async {
    await DB.sharedInstance.delete<MessageDB>(
        where: 'messageId = ?', whereArgs: [messageDB.messageId]);
  }

  Future<void> acceptRequest(MessageDB messageDB, String content) async {
    String groupId = messageDB.groupId;
    String sender = messageDB.sender;
    GroupDB? groupDB = myGroups[groupId];
    if (groupDB != null && groupDB.owner == pubkey) {
      await addGroupMembers(groupId, content, [sender]);
    }
    await DB.sharedInstance.delete<MessageDB>(
        where: 'messageId = ?', whereArgs: [messageDB.messageId]);
  }
}
