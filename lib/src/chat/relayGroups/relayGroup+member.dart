import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension EMember on RelayGroup {
  Future<RelayGroupDB?> createGroup(String host, String name) async {
    Completer<RelayGroupDB?> completer = Completer<RelayGroupDB?>();
    final url = Uri.parse('https://$host/create');
    final body = {
      'pubkey': pubkey,
      'name': name,
      'createdAt': currentUnixTimestampSeconds().toString()
    };
    final sig = await Account.getSignatureWithSecret(jsonEncode(body));
    body['sig'] = sig;
    final response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      if (!completer.isCompleted) {
        final regex = RegExp(r'naddr1[0-9a-zA-Z]+');
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
              id: id);
          myGroups[groupId] = relayGroupDB;
          myGroupsUpdatedCallBack?.call();
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

  Future<OKEvent> sendJoinRequest(String groupId, String content) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event =
        await Nip29.encodeJoinRequest(groupId, content, pubkey, privkey);
    Connect.sharedInstance.sendEvent(event, toRelays: [groupDB.relay],
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
}
