import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:chatcore/chat-core.dart';
import 'package:path_provider/path_provider.dart';

class DBISAR {
  static final DBISAR sharedInstance = DBISAR._internal();
  DBISAR._internal();
  factory DBISAR() => sharedInstance;

  late Isar isar;

  Future open(String? pubkey) async {
    var dbPath = (await getLibraryDirectory()).path;
    debugPrint('DBISAR open: $dbPath');
    isar = await Isar.open(
      [MessageDBISARSchema],
      directory: dbPath,
      name: pubkey ?? 'db',
    );
  }
}
