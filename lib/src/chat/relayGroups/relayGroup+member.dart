import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension EMember on RelayGroup {
  Future<RelayGroupDB?> createGroup(String relay,
      {String name = '',
      bool closed = false,
      String picture = '',
      String about = ''}) async {
    if (relay == 'wss://groups.fiatjaf.com') {
      return await createGroup2(relay,
          name: name, closed: closed, picture: picture, about: about);
    }

    await Connect.sharedInstance
        .connectRelays([relay], relayKind: RelayKind.relayGroup);
    Completer<RelayGroupDB?> completer = Completer<RelayGroupDB?>();
    String groupId = generate64RandomHexChars();
    Event event = await Nip29.encodeCreateGroup(groupId, pubkey, privkey);
    Connect.sharedInstance.sendEvent(event, toRelays: [relay],
        sendCallBack: (ok, relay) async {
      if (ok.status) {
        String id = '$relay\'$groupId';
        RelayGroupDB relayGroupDB = RelayGroupDB(
            groupId: groupId,
            relay: relay,
            author: pubkey,
            members: [pubkey],
            admins: [GroupAdmin(pubkey, 'Admin', GroupActionKind.all())],
            closed: closed,
            private: closed,
            name: name,
            picture: picture,
            about: about,
            id: id,
            lastUpdatedTime: event.createdAt);
        myGroups[groupId] = relayGroupDB;
        await syncGroupToDB(relayGroupDB);
        await editGroupStatus(groupId, closed, closed, '');
        await editMetadata(groupId, name, about, picture, '');
        syncMyGroupListToRelay();
        if (!completer.isCompleted) completer.complete(relayGroupDB);
      } else {
        if (!completer.isCompleted) completer.complete(null);
      }
    });
    return completer.future;
  }

  Future<RelayGroupDB?> createGroup2(String relay,
      {String name = '',
      bool closed = false,
      String picture = '',
      String about = ''}) async {
    Completer<RelayGroupDB?> completer = Completer<RelayGroupDB?>();
    var uri = Uri.parse(relay);
    var hostWithPort = uri.hasPort ? '${uri.host}:${uri.port}' : uri.host;
    final url = Uri.parse('https://$hostWithPort/create');
    final body = {
      'pubkey': pubkey,
      'name': name,
    };
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      if (!completer.isCompleted) {
        final regex = RegExp(r'naddr[0-9a-zA-Z]+');
        final match = regex.firstMatch(response.body);
        if (match != null) {
          final naddr = Nip19.decodeShareableEntity(match.group(0)!);
          String groupId = naddr['special'];
          String relay = naddr['relays']?.first;
          String author = naddr['author'];
          String id = '$relay\'$groupId';
          RelayGroupDB relayGroupDB = RelayGroupDB(
              groupId: groupId,
              relay: relay,
              author: author,
              members: [author],
              admins: [GroupAdmin(author, 'Admin', GroupActionKind.all())],
              closed: closed,
              private: closed,
              name: name,
              picture: picture,
              about: about,
              id: id,
              lastUpdatedTime: currentUnixTimestampSeconds());
          myGroups[groupId] = relayGroupDB;
          await syncGroupToDB(relayGroupDB);
          await syncMyGroupListToRelay();
          await editGroupStatus(groupId, closed, closed, '');
          await editMetadata(groupId, name, about, picture, '');
          if (!completer.isCompleted) completer.complete(relayGroupDB);
        } else {
          if (!completer.isCompleted) completer.complete(null);
        }
      }
    } else {
      if (!completer.isCompleted) completer.complete(null);
    }
    return completer.future;
  }

  Future<OKEvent> leaveGroup(String groupId) async {
    RelayGroupDB? groupDB = myGroups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    myGroups.remove(groupId);
    return await syncMyGroupListToRelay();
  }

  Future<OKEvent> joinGroup(String id, String content) async {
    SimpleGroups simpleGroups = getHostAndGroupId(id);
    String groupId = simpleGroups.groupId;
    if (groups.containsKey(groupId) && !myGroups.containsKey(groupId)) {
      myGroups[groupId] = groups[groupId]!;
      return await syncMyGroupListToRelay();
    }
    return OKEvent(groupId, false, 'group not found');
  }

  Future<OKEvent> sendJoinRequest(String input, String content) async {
    SimpleGroups simpleGroups = getHostAndGroupId(input);
    String groupId = simpleGroups.groupId;
    String relay = simpleGroups.relay;
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB != null) relay = groupDB.relay;
    if (relay.isEmpty) return OKEvent(input, false, 'empty relay');
    if (groupDB == null) {
      groupDB = RelayGroupDB(groupId: groupId, relay: relay, id: input);
      groups[groupId] = groupDB;
      syncGroupToDB(groupDB);
    }
    myGroups[groupId] = groups[groupId]!;
    syncMyGroupListToRelay();

    await Connect.sharedInstance
        .connectRelays([relay], relayKind: RelayKind.relayGroup);
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event =
        await Nip29.encodeJoinRequest(groupId, content, pubkey, privkey);
    Connect.sharedInstance.sendEvent(event, toRelays: [relay],
        sendCallBack: (ok, relay) async {
      if (!completer.isCompleted) completer.complete(ok);
    });
    return completer.future;
  }

  Future<void> handleModeration(Event event, String relay) async {
    GroupModeration moderation = Nip29.decodeModeration(event);
    ModerationDB db = ModerationDB.toModerationDB(moderation);
    await DB.sharedInstance.insertBatch<ModerationDB>(db,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    moderationCallBack?.call(db);
    String content = '';
    Map<String, UserDB> users =
        await Account.sharedInstance.getUserInfos(moderation.users);
    switch (moderation.actionKind) {
      case GroupActionKind.addUser:
        for (var user in users.values) {
          content = '${user.name}$content ';
        }
        content = '${content}join the group';
        break;
      case GroupActionKind.removeUser:
        for (var user in users.values) {
          content = '${user.name}$content,';
        }
        content = '${content}leave the group';
        break;
      case GroupActionKind.editMetadata:
        await handleGroupMetadataFromModeration(moderation, relay);
        return;
      case GroupActionKind.addPermission:
      case GroupActionKind.removePermission:
      case GroupActionKind.deleteEvent:
        return;
      case GroupActionKind.editGroupStatus:
        String private = moderation.private ? 'PRIVATE' : 'PUBLIC';
        String closed = moderation.closed ? 'CLOSED' : 'OPEN';
        content = 'Admin change group status to $closed, $private';
        break;
      default:
        return;
    }
    sendGroupMessage(moderation.groupId, MessageType.system, content, [],
        local: true);
  }

  Future<void> muteGroup(String groupId) async {
    _setMuteGroup(groupId, true);
  }

  Future<void> unMuteGroup(String groupId) async {
    _setMuteGroup(groupId, false);
  }

  Future<void> _setMuteGroup(String groupId, bool mute) async {
    if (myGroups.containsKey(groupId)) {
      RelayGroupDB groupDB = myGroups[groupId]!;
      groupDB.mute = mute;
      await syncGroupToDB(groupDB);
    }
  }

  Future<bool> checkInGroupFromRelay(String groupId, String user) async {
    SimpleGroups simpleGroups = getHostAndGroupId(groupId);
    groupId = simpleGroups.groupId;
    String relay = simpleGroups.relay;
    RelayGroupDB? relayGroupDB = groups[groupId];
    relayGroupDB ??=
        RelayGroupDB(groupId: groupId, relay: relay, id: '$relay\'$groupId');

    Filter f = Filter(kinds: [9000, 9001], p: [user], limit: 1);

    Completer<bool> completer = Completer<bool>();
    Connect.sharedInstance.addSubscription([f], relays: [relayGroupDB.relay],
        eventCallBack: (event, relay) {
      GroupModeration moderation = Nip29.decodeModeration(event);
      if (moderation.actionKind == GroupActionKind.addUser) {
        relayGroupDB!.members ??= [];
        relayGroupDB.members?.add(user);
        syncGroupToDB(relayGroupDB);
        if (!completer.isCompleted) completer.complete(true);
      } else if (moderation.actionKind == GroupActionKind.removeUser) {
        relayGroupDB!.members?.remove(user);
        syncGroupToDB(relayGroupDB);
        if (!completer.isCompleted) completer.complete(false);
      }
    }, eoseCallBack: (String requestId, OKEvent ok, String relay,
            List<String> unCompletedRelays) {
      if (!completer.isCompleted) {
        completer.complete(relayGroupDB!.members?.contains(user));
      }
    });
    return completer.future;
  }
}
