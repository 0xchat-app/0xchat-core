import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:chatcore/chat-core.dart';
import 'package:path_provider/path_provider.dart';

const int intMaxValue = 9223372036854775807; // 64-bit signed integer max value

class DBISAR {
  static final DBISAR sharedInstance = DBISAR._internal();
  DBISAR._internal();
  factory DBISAR() => sharedInstance;

  late Isar isar;

  List<CollectionSchema<dynamic>> schemas = [
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
    NoteDBISARSchema,
    NotificationDBISARSchema,
    ConfigDBISARSchema,
    EventDBISARSchema
  ];

  Future open(String pubkey) async {
    Directory directory = Platform.isAndroid
        ? await getApplicationDocumentsDirectory()
        : await getLibraryDirectory();
    var dbPath = directory.path;
    debugPrintSynchronously('DBISAR open: $dbPath, pubkey: $pubkey');
    if(Isar.getInstance(pubkey) != null) return;
    isar = await Isar.open(
      schemas,
      directory: dbPath,
      name: pubkey,
    );
  }
}
