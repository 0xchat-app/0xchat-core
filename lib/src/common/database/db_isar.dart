import 'dart:async';
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

  final Map<Type, List<dynamic>> _buffers = {};

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
    LogUtils.v(() => 'DBISAR open: $dbPath, pubkey: $pubkey');
    isar = Isar.getInstance(pubkey) ??
        await Isar.open(
          schemas,
          directory: dbPath,
          name: pubkey,
        );
  }

  Future<void> saveToDB<T>(T object) async {
    final type = T;
    if (!_buffers.containsKey(type)) {
      _buffers[type] = <T>[];
    }
    _buffers[type]!.add(object);

    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 200), () async {
      await _putAll();
    });
  }

  Future<void> _putAll() async {
    _timer?.cancel();
    _timer = null;

    if(_buffers.isEmpty) return;

    final Map<Type, List<dynamic>> typeMap = Map.from(_buffers);
    _buffers.clear();

    await isar.writeTxn(() async {
      await Future.forEach(typeMap.keys, (type) async {
        await _saveTOISAR(typeMap[type]!, type);
      });
    });
  }

  Future<void> _saveTOISAR(List<dynamic> objects, Type type) async {
    IsarCollection? collection =
        isar.getCollectionByNameInternal(type.toString());
    if (collection != null) {
      await collection.putAll(objects);
    }
  }
}
