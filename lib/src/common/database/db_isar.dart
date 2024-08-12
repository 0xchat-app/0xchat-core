import 'dart:async';
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

  final List<Object> _buffer = [];
  Timer? _timer;

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
    isar = Isar.getInstance(pubkey) ??
        await Isar.open(
          schemas,
          directory: dbPath,
          name: pubkey,
        );
  }

  Future<void> saveToDB(Object object) async {
    _buffer.add(object);

    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 200), () async {
      await _putAll();
    });
  }

  Future<void> _putAll() async {
    if (_buffer.isEmpty) return;

    final Map<Type, List<Object>> typeMap = {};

    List<Object> tempBuffer = List.from(_buffer);
    _buffer.clear();
    for (var item in tempBuffer) {
      var type = item.runtimeType;
      if (!typeMap.containsKey(type)) {
        typeMap[type] = [];
      }
      typeMap[type]!.add(item);
    }

    await Future.forEach(typeMap.keys, (type) async {
      await _saveTOISAR(typeMap[type]!, type);
    });

    _timer?.cancel();
    _timer = null;
  }

  Future<void> _saveTOISAR(List<Object> objects, Type type) async {
    IsarCollection? collection;
    switch (type) {
      case MessageDBISAR:
        collection = isar.messageDBISARs;
        objects = objects.cast<MessageDBISAR>();
      case NoteDBISAR:
        collection = isar.noteDBISARs;
        objects = objects.cast<NoteDBISAR>();
      case EventDBISAR:
        collection = isar.eventDBISARs;
        objects = objects.cast<EventDBISAR>();
      case UserDBISAR:
        collection = isar.userDBISARs;
        objects = objects.cast<UserDBISAR>();
      case ZapRecordsDBISAR:
        collection = isar.zapRecordsDBISARs;
        objects = objects.cast<ZapRecordsDBISAR>();
    }
    if (collection != null) {
      await isar.writeTxn(() async {
        await collection!.putAll(objects);
      });
    }
  }
}
