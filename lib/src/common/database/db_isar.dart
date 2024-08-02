import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:chatcore/chat-core.dart';
import 'package:path_provider/path_provider.dart';

class DBISAR {
  static final DBISAR sharedInstance = DBISAR._internal();
  DBISAR._internal();
  factory DBISAR() => sharedInstance;

  late Isar isar;

  Future open(String? pubkey,
      {List<CollectionSchema<dynamic>>? additionalSchemas}) async {
    Directory directory = Platform.isAndroid
        ? await getApplicationDocumentsDirectory()
        : await getLibraryDirectory();
    var dbPath = directory.path;
    debugPrint('DBISAR open: $dbPath');
    isar = await Isar.open(
      [
        MessageDBISARSchema,
        UserDBISARSchema,
        BadgeAwardDBISARSchema,
        BadgeDBISARSchema,
        RelayDBISARSchema,
        ZapRecordsDBISARSchema,
        ZapsDBISARSchema,
        ChannelDBISARSchema,
        SecretSessionDBISARSchema,
        GroupDBISARSchema,
        JoinRequestDBISARSchema,
        ModerationDBISARSchema,
        RelayGroupDBISARSchema,
        ...additionalSchemas ?? []
      ],
      directory: dbPath,
      name: pubkey ?? 'db',
    );
  }
}
