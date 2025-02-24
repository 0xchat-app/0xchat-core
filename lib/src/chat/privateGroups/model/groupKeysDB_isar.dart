import 'package:isar/isar.dart';

part 'groupKeysDB_isar.g.dart';

@collection
class GroupKeysDBISAR {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String groupId; //group nostrid
  int epoch;
  String secretKey;

  GroupKeysDBISAR({
    this.groupId = '',
    this.epoch = 0,
    this.secretKey = '',
  });
}
