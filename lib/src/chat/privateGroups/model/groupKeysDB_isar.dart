import 'package:isar/isar.dart' hide Filter;
import 'package:chatcore/chat-core.dart';

part 'groupKeysDB_isar.g.dart';

@collection
class GroupKeysDBISAR {
  int id = 0;

  @Index(unique: true)
  String groupId; //group nostr id
  List<int>? mlsGroupId;
  int epoch;
  String secretKey;

  GroupKeysDBISAR({
    this.groupId = '',
    this.mlsGroupId,
    this.epoch = 0,
    this.secretKey = '',
  });

  static Future<GroupKeysDBISAR?> getGroupKeysFromDB(String groupId, int epoch) async {
    final isar = DBISAR.sharedInstance.isar;
    final groupKeyDB =
        isar.groupKeysDBISARs.where().groupIdEqualTo(groupId).epochEqualTo(epoch).findAll();
    return groupKeyDB.firstOrNull;
  }

  static Future<int> deleteGroupKeysBeforeEpoch(String groupId, int epoch) async {
    final isar = DBISAR.sharedInstance.isar;
    return isar.groupKeysDBISARs
        .where()
        .groupIdEqualTo(groupId)
        .epochLessThan(epoch)
        .deleteAll();
  }

  static saveGroupKeysToDB(GroupKeysDBISAR groupKeysDB) async {
    await DBISAR.sharedInstance.saveToDB(groupKeysDB);
  }
}
