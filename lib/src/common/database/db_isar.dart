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

  // Store encryption key after first open so subsequent opens re-use it.
  static String? _sharedEncKey;

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

  Future open(String pubkey, {String? circleId, String? dbPath, String? encryptionKey}) async {
    final dbName = _getDatabaseName(pubkey, circleId: circleId);
    dbPath ??= await _getDatabaseDirectory();
    LogUtils.v(() => 'DBISAR open: $dbPath, pubkey: $pubkey');
    // Persist encryption key if provided.
    if (encryptionKey != null) {
      _sharedEncKey = encryptionKey;
    }

    final String key = encryptionKey ?? _sharedEncKey ?? pubkey;
    isar = await Isar.openAsync(
      schemas: schemas,
      directory: dbPath,
      name: dbName,
      engine: IsarEngine.sqlite,
      encryptionKey: key,
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

    await DBISAR.sharedInstance.isar.writeAsyncWith(typeMap, (isar, typeMap) {
      for (final type in typeMap.keys) {
        _saveTOISAR(typeMap[type]!, type, isar);
      }
    });
  }

  /// Save objects to Isar database by type
  /// 
  /// This method is designed as static with explicit parameters to support 
  /// execution in isolate context where instance methods and fields are not accessible.
  /// 
  /// Design rationale:
  /// - [static]: Required for isolate execution - no access to instance state
  /// - [objects]: Explicit list parameter since isolates can't access instance buffers
  /// - [type]: Explicit type parameter for runtime type dispatch in isolate
  /// - [isar]: Explicit Isar instance parameter since isolates can't access singleton
  /// 
  /// Each object with id == 0 gets assigned an auto-increment ID before saving.
  static void _saveTOISAR(List<dynamic> objects, Type type, Isar isar) {
    switch (type) {
      case MessageDBISAR:
        final messageList = objects.cast<MessageDBISAR>();
        for (var message in messageList) {
          if (message.id == 0) {
            message.id = isar.messageDBISARs.autoIncrement();
          }
        }
        isar.messageDBISARs.putAll(messageList);
        break;
      case UserDBISAR:
        final userList = objects.cast<UserDBISAR>();
        for (var user in userList) {
          if (user.id == 0) {
            user.id = isar.userDBISARs.autoIncrement();
          }
        }
        isar.userDBISARs.putAll(userList);
        break;
      case BadgeAwardDBISAR:
        final badgeAwardList = objects.cast<BadgeAwardDBISAR>();
        for (var badgeAward in badgeAwardList) {
          if (badgeAward.id == 0) {
            badgeAward.id = isar.badgeAwardDBISARs.autoIncrement();
          }
        }
        isar.badgeAwardDBISARs.putAll(badgeAwardList);
        break;
      case BadgeDBISAR:
        final badgeList = objects.cast<BadgeDBISAR>();
        for (var badge in badgeList) {
          if (badge.id == 0) {
            badge.id = isar.badgeDBISARs.autoIncrement();
          }
        }
        isar.badgeDBISARs.putAll(badgeList);
        break;
      case RelayDBISAR:
        final relayList = objects.cast<RelayDBISAR>();
        for (var relay in relayList) {
          if (relay.id == 0) {
            relay.id = isar.relayDBISARs.autoIncrement();
          }
        }
        isar.relayDBISARs.putAll(relayList);
        break;
      case ZapRecordsDBISAR:
        final zapRecordsList = objects.cast<ZapRecordsDBISAR>();
        for (var zapRecord in zapRecordsList) {
          if (zapRecord.id == 0) {
            zapRecord.id = isar.zapRecordsDBISARs.autoIncrement();
          }
        }
        isar.zapRecordsDBISARs.putAll(zapRecordsList);
        break;
      case ZapsDBISAR:
        final zapsList = objects.cast<ZapsDBISAR>();
        for (var zap in zapsList) {
          if (zap.id == 0) {
            zap.id = isar.zapsDBISARs.autoIncrement();
          }
        }
        isar.zapsDBISARs.putAll(zapsList);
        break;
      case ChannelDBISAR:
        final channelList = objects.cast<ChannelDBISAR>();
        for (var channel in channelList) {
          if (channel.id == 0) {
            channel.id = isar.channelDBISARs.autoIncrement();
          }
        }
        isar.channelDBISARs.putAll(channelList);
        break;
      case SecretSessionDBISAR:
        final secretSessionList = objects.cast<SecretSessionDBISAR>();
        for (var secretSession in secretSessionList) {
          if (secretSession.id == 0) {
            secretSession.id = isar.secretSessionDBISARs.autoIncrement();
          }
        }
        isar.secretSessionDBISARs.putAll(secretSessionList);
        break;
      case GroupDBISAR:
        final groupList = objects.cast<GroupDBISAR>();
        for (var group in groupList) {
          if (group.id == 0) {
            group.id = isar.groupDBISARs.autoIncrement();
          }
        }
        isar.groupDBISARs.putAll(groupList);
        break;
      case JoinRequestDBISAR:
        final joinRequestList = objects.cast<JoinRequestDBISAR>();
        for (var joinRequest in joinRequestList) {
          if (joinRequest.id == 0) {
            joinRequest.id = isar.joinRequestDBISARs.autoIncrement();
          }
        }
        isar.joinRequestDBISARs.putAll(joinRequestList);
        break;
      case ModerationDBISAR:
        final moderationList = objects.cast<ModerationDBISAR>();
        for (var moderation in moderationList) {
          if (moderation.id == 0) {
            moderation.id = isar.moderationDBISARs.autoIncrement();
          }
        }
        isar.moderationDBISARs.putAll(moderationList);
        break;
      case RelayGroupDBISAR:
        final relayGroupList = objects.cast<RelayGroupDBISAR>();
        for (var relayGroup in relayGroupList) {
          if (relayGroup.id == 0) {
            relayGroup.id = isar.relayGroupDBISARs.autoIncrement();
          }
        }
        isar.relayGroupDBISARs.putAll(relayGroupList);
        break;
      case NoteDBISAR:
        final noteList = objects.cast<NoteDBISAR>();
        for (var note in noteList) {
          if (note.id == 0) {
            note.id = isar.noteDBISARs.autoIncrement();
          }
        }
        isar.noteDBISARs.putAll(noteList);
        break;
      case NotificationDBISAR:
        final notificationList = objects.cast<NotificationDBISAR>();
        for (var notification in notificationList) {
          if (notification.id == 0) {
            notification.id = isar.notificationDBISARs.autoIncrement();
          }
        }
        isar.notificationDBISARs.putAll(notificationList);
        break;
      case ConfigDBISAR:
        final configList = objects.cast<ConfigDBISAR>();
        for (var config in configList) {
          if (config.id == 0) {
            config.id = isar.configDBISARs.autoIncrement();
          }
        }
        isar.configDBISARs.putAll(configList);
        break;
      case EventDBISAR:
        final eventList = objects.cast<EventDBISAR>();
        for (var event in eventList) {
          if (event.id == 0) {
            event.id = isar.eventDBISARs.autoIncrement();
          }
        }
        isar.eventDBISARs.putAll(eventList);
        break;
      case GroupKeysDBISAR:
        final groupKeysList = objects.cast<GroupKeysDBISAR>();
        for (var groupKeys in groupKeysList) {
          if (groupKeys.id == 0) {
            groupKeys.id = isar.groupKeysDBISARs.autoIncrement();
          }
        }
        isar.groupKeysDBISARs.putAll(groupKeysList);
        break;
      case CircleDBISAR:
        final circleList = objects.cast<CircleDBISAR>();
        for (var circle in circleList) {
          if (circle.id == 0) {
            circle.id = isar.circleDBISARs.autoIncrement();
          }
        }
        isar.circleDBISARs.putAll(circleList);
        break;
      default:
        String typeName = type.toString().replaceAll('?', '');
        final index = isar.schemas.indexWhere((schema) => schema.name == typeName);
        if (index < 0 || index >= isar.schemas.length) return;

        final collection = isar.collectionByIndex(index);
        for (var object in objects) {
          if (object.id == 0) {
            object.id = collection.autoIncrement();
          }
        }
        collection.putAll(objects);
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
