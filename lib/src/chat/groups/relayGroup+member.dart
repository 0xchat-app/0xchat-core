import 'dart:async';

import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

extension EMember on RelayGroup {
  Future<void> sendJoinRequest(Event event, String relay) async {}

  Future<void> handleAddUser(Event event, String relay) async {}
  Future<void> handleRemoveUser(Event event, String relay) async {}
  Future<void> handleEditMetadata(Event event, String relay) async {}
  Future<void> handleAddPermission(Event event, String relay) async {}
  Future<void> handleRemovePermission(Event event, String relay) async {}
  Future<void> handleDeleteEvent(Event event, String relay) async {}
  Future<void> handleEditGroupStatus(Event event, String relay) async {}

}