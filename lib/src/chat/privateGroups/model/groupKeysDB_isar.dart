import 'package:isar/isar.dart';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

part 'groupKeysDB_isar.g.dart';

@collection
class GroupKeysDBISAR {
  late int id;

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
        await isar.groupKeysDBISARs.filter().groupIdEqualTo(groupId).epochEqualTo(epoch).findAll();
    return groupKeyDB.firstOrNull;
  }

  static Future<int> deleteGroupKeysBeforeEpoch(String groupId, int epoch) async {
    final isar = DBISAR.sharedInstance.isar;
    return await isar.groupKeysDBISARs
        .filter()
        .groupIdEqualTo(groupId)
        .epochLessThan(epoch)
        .deleteAll();
  }

  static saveGroupKeysToDB(GroupKeysDBISAR groupKeysDB) async {
    await DBISAR.sharedInstance.saveToDB(groupKeysDB);
  }
}
