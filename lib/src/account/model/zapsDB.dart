import 'package:chatcore/chat-core.dart';

@reflector
class ZapsDB extends DBObject {
  String? lnAddr;
  String? lnURL;
  bool? allowsNostr;
  String? callback;
  int? minSendable;
  int? maxSendable;

  ZapsDB({
    this.lnAddr = '',
    this.lnURL = '',
    this.allowsNostr = false,
    this.callback = '',
    this.minSendable = 0,
    this.maxSendable = 0,
  });

  @override
  //Map
  Map<String, Object?> toMap() {
    return _zapsDBInfoToMap(this);
  }

  static ZapsDB fromMap(Map<String, Object?> map) {
    return _zapsDBInfoFromMap(map);
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['lnAddr', 'lnURL'];
  }
}

ZapsDB _zapsDBInfoFromMap(Map<String, dynamic> map) {
  return ZapsDB(
    lnAddr: map['lnAddr'].toString(),
    lnURL: map['lnURL'],
    allowsNostr: map['allowsNostr'],
    callback: map['callback'].toString(),
    minSendable: map['minSendable'],
    maxSendable: map['maxSendable'],
  );
}

Map<String, dynamic> _zapsDBInfoToMap(ZapsDB instance) => <String, dynamic>{
      'lnAddr': instance.lnAddr,
      'lnURL': instance.lnURL,
      'allowsNostr': instance.allowsNostr,
      'callback': instance.callback,
      'minSendable': instance.minSendable,
      'maxSendable': instance.maxSendable,
    };
