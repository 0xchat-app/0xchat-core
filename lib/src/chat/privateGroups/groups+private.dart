import 'dart:async';
import 'dart:convert';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension PrivateGroups on Groups {
  // Future<void> connectToGroupRelays(String groupId) async {
  //   GroupDB? groupDB = myGroups[groupId];
  //   if (groupDB != null) {
  //     Map<String, UserDB> users =
  //         await Account.sharedInstance.getUserInfos(groupDB.members ?? []);
  //     Set<String> relays = {};
  //     for (var user in users.values) {
  //       relays.addAll(user.relayList ?? []);
  //     }
  //     currentGroupRelays[groupId] = relays.toList();
  //     await Connect.sharedInstance.connectRelays(currentGroupRelays[groupId]!,
  //         relayKind: RelayKind.relayGroup);
  //   }
  // }

  Future<void> closeGroupConnects(String groupId) async {
    await Connect.sharedInstance
        .closeConnects(currentGroupRelays[groupId] ?? [], RelayKind.relayGroup);
  }

  Future<GroupDBISAR?> createPrivateGroup(
      String sender, String groupId, String? name, List<String>? members,
      {int createAt = 0}) async {
    if (members == null || members.isEmpty) return null;
    if (!members.contains(pubkey)) return null;
    members = members.toSet().toList();
    if (groupId.isEmpty) groupId = ChatRoom.generateChatRoomID(members);
    if (myGroups.containsKey(groupId)) {
      myGroups[groupId]?.members = members;
      if (name != null && name.isNotEmpty && name != myGroups[groupId]?.name) {
        updatePrivateGroupName(sender, groupId, name, createAt: createAt);
      }
    } else {
      // add group
      GroupDBISAR groupDB = GroupDBISAR(
          groupId: groupId,
          updateTime: currentUnixTimestampSeconds(),
          name: name ?? '',
          members: members);
      groups[groupId] = groupDB;
      myGroups[groupId] = groupDB;
      // update my group list
      await syncGroupToDB(groupDB);
      await syncMyGroupListToDB();
    }
    myGroupsUpdatedCallBack?.call();
    return myGroups[groupId];
  }

  Future<GroupDBISAR?> addMembersToPrivateGroup(
      String groupId, List<String> members) async {
    GroupDBISAR? groupDB = myGroups[groupId];
    if (groupDB == null) return null;
    List<String> existingMembers = groupDB.members ?? [];
    Set<String> uniqueMembersSet = {...existingMembers, ...members};
    return await createPrivateGroup(
        pubkey, '', groupDB.name, uniqueMembersSet.toList());
  }

  Future<GroupDBISAR?> removeMembersFromPrivateGroup(
      String groupId, List<String> membersToRemove) async {
    GroupDBISAR? groupDB = myGroups[groupId];
    if (groupDB == null) return null;
    List<String> existingMembers = groupDB.members ?? [];
    Set<String> updatedMembersSet = existingMembers.toSet();
    for (String member in membersToRemove) {
      updatedMembersSet.remove(member);
    }
    return await createPrivateGroup(
        pubkey, '', groupDB.name, updatedMembersSet.toList());
  }

  Future<OKEvent> updatePrivateGroupName(
      String sender, String groupId, String name,
      {int createAt = 0}) async {
    GroupDBISAR? groupDB = myGroups[groupId];
    if (groupDB != null) {
      groupDB.name = name;
      syncGroupToDB(groupDB);
      UserDBISAR? user = await Account.sharedInstance.getUserInfo(sender);
      sendPrivateGroupMessage(groupId, MessageType.system,
          "${user?.name} update group name to $name",
          local: true, createAt: createAt);
      return OKEvent(groupId, true, '');
    } else {
      return OKEvent(groupId, false, 'group not exit');
    }
  }

  Future<Event?> getSendPrivateGroupMessageEvent(
      String groupId, MessageType type, String content,
      {String? source,
      String? replyMessage,
      String? decryptSecret,
      int createAt = 0}) async {
    GroupDBISAR? groupDB = myGroups[groupId];
    if (groupDB == null) return null;
    List<String>? members = groupDB.members;
    if (members == null) return null;
    Event event = await Nip17.encodeInnerEvent(
        '',
        MessageDBISAR.getContent(type, content, source),
        replyMessage ?? '',
        pubkey,
        privkey,
        subContent: MessageDBISAR.getSubContent(type, content,
            decryptSecret: decryptSecret),
        members: members,
        subject: groupDB.name,
        createAt: createAt);
    return event;
  }

  Future<OKEvent> sendPrivateGroupMessage(
      String groupId, MessageType type, String content,
      {String? source,
      String? replyMessage,
      Event? event,
      bool local = false,
      String? decryptSecret,
      int createAt = 0,
      String? replaceMessageId}) async {
    Completer<OKEvent> completer = Completer<OKEvent>();
    event ??= await getSendPrivateGroupMessageEvent(groupId, type, content,
        source: source,
        replyMessage: replyMessage,
        decryptSecret: decryptSecret,
        createAt: createAt);

    late MessageDBISAR messageDB;
    if (replaceMessageId != null) {
      messageDB =
          await Messages.sharedInstance.loadMessageDBFromDB(replaceMessageId) ??
              MessageDBISAR();
      messageDB.messageId = event!.id;
      groupMessageUpdateCallBack?.call(messageDB, replaceMessageId);
    } else {
      messageDB = MessageDBISAR(
          messageId: event!.id,
          sender: event.pubkey,
          receiver: '',
          groupId: groupId,
          kind: event.kind,
          tags: jsonEncode(event.tags),
          replyId: replyMessage ?? '',
          content: event.content,
          decryptContent: content,
          type: MessageDBISAR.messageTypeToString(type),
          createTime: event.createdAt,
          status: 0,
          plaintEvent: jsonEncode(event),
          chatType: 1,
          decryptSecret: decryptSecret);
      groupMessageCallBack?.call(messageDB);
    }
    var map = await MessageDBISAR.decodeContent(messageDB.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    messageDB.decryptSecret = map['decryptSecret'];
    await Messages.saveMessageToDB(messageDB);

    if (local) {
      if (!completer.isCompleted) {
        completer.complete(OKEvent(event.id, true, ''));
      }
    } else {
      OKEvent ok = await sendToGroup(groupId, event);
      messageDB.status = ok.status ? 1 : 2;
      await Messages.saveMessageToDB(messageDB,
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (!completer.isCompleted) completer.complete(ok);
    }

    return completer.future;
  }
}
