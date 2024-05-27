import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

extension EMember on RelayGroup {
  Future<OKEvent> sendJoinRequest(String groupId, String content) async {
    RelayGroupDB? groupDB = groups[groupId];
    if (groupDB == null) return OKEvent(groupId, false, 'group not exit');
    Completer<OKEvent> completer = Completer<OKEvent>();
    Event event =
        await Nip29.encodeJoinRequest(groupId, content, pubkey, privkey);
    Connect.sharedInstance.sendEvent(event, relay: groupDB.relay,
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
