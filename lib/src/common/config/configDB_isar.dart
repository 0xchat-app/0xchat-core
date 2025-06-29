import 'package:isar/isar.dart' hide Filter;

part 'configDB_isar.g.dart';

@collection
class ConfigDBISAR {
  int id = 0;

  @Index(unique: true)
  String d;

  String eventId;
  int time;
  String configJson;
  String proxyJson;

  ConfigDBISAR({
    this.d = '',
    this.eventId = '',
    this.time = 0,
    this.configJson = '',
    this.proxyJson = '',
  });

  static ConfigDBISAR fromMap(Map<String, Object?> map) {
    return _configInfoFromMap(map);
  }
}

ConfigDBISAR _configInfoFromMap(Map<String, dynamic> map) {
  return ConfigDBISAR(
    d: map['d'].toString(),
    time: map['time'],
    eventId: map['eventId'].toString(),
    configJson: map['configJson'].toString(),
  );
}
