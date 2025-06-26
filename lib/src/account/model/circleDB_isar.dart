import 'package:isar/isar.dart' hide Filter;

part 'circleDB_isar.g.dart';

@collection
class CircleDBISAR  {
  late int id;

  @Index(unique: true)
  String circleId;

  String name;
  String description;
  String image; 
  List<String> relayList;
  List<String> fileserverList;
  List<String> iceserverList;
  List<String> pushserverList;
  String? groupId;

  CircleDBISAR({
    required this.circleId,
    this.name = '',
    this.description = '',
    this.image = '',
    this.relayList = const [],
    this.fileserverList = const [],
    this.iceserverList = const [],
    this.pushserverList = const [],
    this.groupId,
  });
}