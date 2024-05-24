import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension EAdmin on RelayGroup {
  Future<void> handleJoinRequest(Event event, String relay) async {
    GroupJoinRequest joinRequest = Nip29.decodeJoinRequest(event);
    
  }

  Future<void> addUser(Event event, String relay) async {}

  Future<void> removeUser(Event event, String relay) async {}

  Future<void> editMetadata(Event event, String relay) async {}

  Future<void> addPermission(Event event, String relay) async {}

  Future<void> removePermission(Event event, String relay) async {}

  Future<void> deleteEvent(Event event, String relay) async {}

  Future<void> editGroupStatus(Event event, String relay) async {}
}
