import 'dart:async';
import 'dart:io';

import 'package:isar/isar.dart' hide Filter;
import 'package:chatcore/chat-core.dart';
import 'package:path_provider/path_provider.dart';

class DBISAR {
  static final DBISAR sharedInstance = DBISAR._internal();
  DBISAR._internal();
  factory DBISAR() => sharedInstance;

  late Isar isar;

  final Map<Type, List<dynamic>> _buffers = {};

  Timer? _timer;

  List<IsarGeneratedSchema> schemas = [
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
    EventDBISARSchema,
    GroupKeysDBISARSchema,
    CircleDBISARSchema
  ];

  /// Generate database name for given pubkey and optional circleId
  String _getDatabaseName(String pubkey, {String? circleId}) {
    if (circleId != null) {
      return '$pubkey-$circleId';
    }
    return pubkey;
  }

  /// Get database directory path
  Future<String> _getDatabaseDirectory() async {
    bool isOS = Platform.isIOS || Platform.isMacOS;
    Directory directory = isOS ? await getLibraryDirectory() : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Get full database file path
  Future<String> _getDatabaseFilePath(String pubkey, {String? circleId}) async {
    final dbName = _getDatabaseName(pubkey, circleId: circleId);
    final dbDir = await _getDatabaseDirectory();
    return '$dbDir/$dbName.isar';
  }

  Future open(String pubkey, {String? circleId, String? dbPath}) async {
    final dbName = _getDatabaseName(pubkey, circleId: circleId);
    dbPath ??= await _getDatabaseDirectory();
    LogUtils.v(() => 'DBISAR open: $dbPath, pubkey: $pubkey');
    isar = await Isar.openAsync(
      schemas: schemas,
      directory: dbPath,
      name: dbName,
      engine: IsarEngine.sqlite,
      encryptionKey: pubkey,
    );
  }

  /// Check if database exists
  /// [pubkey] The user's public key
  /// [circleId] Optional circle ID, if null checks the main database
  /// Returns true if database file exists
  Future<bool> exists(String pubkey, {String? circleId}) async {
    try {
      final dbPath = await _getDatabaseFilePath(pubkey, circleId: circleId);
      final dbFile = File(dbPath);
      return await dbFile.exists();
    } catch (e) {
      LogUtils.e(() => 'Failed to check database existence: $e');
      return false;
    }
  }

  /// Delete an entire database instance by pubkey and circleId
  /// [pubkey] The user's public key
  /// [circleId] Optional circle ID, if null deletes the main database
  /// Returns true if deletion was successful
  Future<bool> delete(String pubkey, {String? circleId}) async {
    try {
      final dbName = _getDatabaseName(pubkey, circleId: circleId);
      
      // 如果当前 Isar 已打开且名称匹配，则先关闭
      if (isar.isOpen && isar.name == dbName) {
        isar.close();
        LogUtils.v(() => 'Closed database instance: $dbName');
      }
      
      // Delete the database file
      final dbPath = await _getDatabaseFilePath(pubkey, circleId: circleId);
      final dbFile = File(dbPath);
      
      if (await dbFile.exists()) {
        await dbFile.delete();
        LogUtils.v(() => 'Successfully deleted database file: $dbPath');
      }
      
      // Also delete associated files (like .lock files)
      final lockFile = File('$dbPath.lock');
      if (await lockFile.exists()) {
        await lockFile.delete();
        LogUtils.v(() => 'Successfully deleted lock file: $dbPath.lock');
      }
      
      // Delete any other associated files (.tmp, etc.)
      final tmpFile = File('$dbPath.tmp');
      if (await tmpFile.exists()) {
        await tmpFile.delete();
        LogUtils.v(() => 'Successfully deleted tmp file: $dbPath.tmp');
      }
      
      return true;
    } catch (e) {
      LogUtils.e(() => 'Failed to delete database: $e');
      return false;
    }
  }

  Map<Type, List<dynamic>> getBuffers() {
    return Map.from(_buffers);
  }

  Future<void> saveObjectsToDB<T>(List<T> objects) async {
    for (var object in objects) {
      await saveToDB(object);
    }
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

    if (_buffers.isEmpty) return;

    final Map<Type, List<dynamic>> typeMap = Map.from(_buffers);
    _buffers.clear();

    await DBISAR.sharedInstance.isar.writeAsync((isar) {
      for (final type in typeMap.keys) {
        _saveTOISAR(typeMap[type]!, type);
      }
    });
  }

  void _saveTOISAR(List<dynamic> objects, Type type) {
    // 根据类型分发到具体集合，适配 Isar v4 API
    switch (type) {
      case MessageDBISAR:
        isar.messageDBISARs.putAll(objects.cast<MessageDBISAR>());
        break;
      case UserDBISAR:
        isar.userDBISARs.putAll(objects.cast<UserDBISAR>());
        break;
      case BadgeAwardDBISAR:
        isar.badgeAwardDBISARs.putAll(objects.cast<BadgeAwardDBISAR>());
        break;
      case BadgeDBISAR:
        isar.badgeDBISARs.putAll(objects.cast<BadgeDBISAR>());
        break;
      case RelayDBISAR:
        isar.relayDBISARs.putAll(objects.cast<RelayDBISAR>());
        break;
      case ZapRecordsDBISAR:
        isar.zapRecordsDBISARs.putAll(objects.cast<ZapRecordsDBISAR>());
        break;
      case ZapsDBISAR:
        isar.zapsDBISARs.putAll(objects.cast<ZapsDBISAR>());
        break;
      case ChannelDBISAR:
        isar.channelDBISARs.putAll(objects.cast<ChannelDBISAR>());
        break;
      case SecretSessionDBISAR:
        isar.secretSessionDBISARs.putAll(objects.cast<SecretSessionDBISAR>());
        break;
      case GroupDBISAR:
        isar.groupDBISARs.putAll(objects.cast<GroupDBISAR>());
        break;
      case JoinRequestDBISAR:
        isar.joinRequestDBISARs.putAll(objects.cast<JoinRequestDBISAR>());
        break;
      case ModerationDBISAR:
        isar.moderationDBISARs.putAll(objects.cast<ModerationDBISAR>());
        break;
      case RelayGroupDBISAR:
        isar.relayGroupDBISARs.putAll(objects.cast<RelayGroupDBISAR>());
        break;
      case NoteDBISAR:
        isar.noteDBISARs.putAll(objects.cast<NoteDBISAR>());
        break;
      case NotificationDBISAR:
        isar.notificationDBISARs.putAll(objects.cast<NotificationDBISAR>());
        break;
      case ConfigDBISAR:
        isar.configDBISARs.putAll(objects.cast<ConfigDBISAR>());
        break;
      case EventDBISAR:
        isar.eventDBISARs.putAll(objects.cast<EventDBISAR>());
        break;
      case GroupKeysDBISAR:
        isar.groupKeysDBISARs.putAll(objects.cast<GroupKeysDBISAR>());
        break;
      case CircleDBISAR:
        isar.circleDBISARs.putAll(objects.cast<CircleDBISAR>());
        break;
      default:
        // 未匹配到的类型，可在此扩展
        break;
    }
  }

  Future<void> closeDatabase() async {
    _buffers.clear();
    _timer?.cancel();
    _timer = null;
    if (isar.isOpen) isar.close();
  }
}
