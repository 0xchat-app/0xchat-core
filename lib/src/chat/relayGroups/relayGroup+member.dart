import 'dart:async';
import 'dart:convert';
import 'package:chatcore/src/common/network/connect.dart';
import 'package:http/http.dart' as http;

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension EMember on RelayGroup {
  Future<RelayGroupDB?> createGroup(String host, String name,
      {String closed = 'false'}) async {
    Completer<RelayGroupDB?> completer = Completer<RelayGroupDB?>();
    final url = Uri.parse('http://$host/create');
    final body = {
      'pubkey': pubkey,
      'name': name,
      'closed': closed,
      'createdAt': currentUnixTimestampSeconds().toString()
    };
    final sig = await Account.getSignatureWithSecret(jsonEncode(body));
    body['sig'] = sig;
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
              name: name,
              author: author,
              members: [author],
              private: closed == 'true' ? true : false,
              id: id);
          myGroups[groupId] = relayGroupDB;
          syncGroupToDB(relayGroupDB);
          syncMyGroupListToRelay();
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

  Future<OKEvent> joinGroup(String groupId, String content) async {
    if (groups.containsKey(groupId)) {
      myGroups[groupId] = groups[groupId]!;
      return await syncMyGroupListToRelay();
    }
    return OKEvent(groupId, false, 'group not found');
  }

  Future<OKEvent> sendJoinRequest(String input, String content) async {
    SimpleGroups simpleGroups = getHostAndGroupId(input);
    String groupId = simpleGroups.groupId;
    String relay = simpleGroups.relay;
    if(relay.isEmpty) return OKEvent(input, false, 'empty relay');
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null) {
      groupDB = RelayGroupDB(groupId: groupId, relay: relay, id: input);
      groups[groupId] = groupDB;
      syncGroupToDB(groupDB);
    }

    await Connect.sharedInstance.connectRelays([relay], type: 1);
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
    int result = await DB.sharedInstance
        .insert<ModerationDB>(db, conflictAlgorithm: ConflictAlgorithm.ignore);
    if (result > 0) moderationCallBack?.call(db);
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
}
