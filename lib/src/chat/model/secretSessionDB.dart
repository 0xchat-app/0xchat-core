import 'package:chatcore/chat-core.dart';

@reflector
class SecretSessionDB extends DBObject {
  String? sessionId;
  String? fromPubkey;
  String? toPubkey;
  String? fromAliasPubkey;
  String? fromAliasPrivkey;
  String? toAliasPubkey;
  String? toAliasPrivkey;
  String? shareSecretKey;
  String? sharePubkey;

  int? lastUpdateTime;
  int? expirationTime;
  int? status; // 0: init 1: request 2: accept 3: reject 4: close

  SecretSessionDB(
      {this.sessionId = '',
      this.fromPubkey = '',
      this.toPubkey = '',
      this.fromAliasPubkey = '',
      this.fromAliasPrivkey = '',
      this.toAliasPubkey = '',
      this.toAliasPrivkey = '',
      this.shareSecretKey = '',
      this.lastUpdateTime = 0,
      this.status = 0});

  @override
  Map<String, Object?> toMap() {
    return _secretSessionInfoToMap(this);
  }

  static SecretSessionDB fromMap(Map<String, Object?> map) {
    return _secretSessionInfoFromMap(map);
  }

  static String? tableName() {
    return "SecretSessionDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['sessionId'];
  }
}

Map<String, dynamic> _secretSessionInfoToMap(SecretSessionDB instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'fromPubkey': instance.fromPubkey,
      'toPubkey': instance.toPubkey,
      'fromAliasPubkey': instance.fromAliasPubkey,
      'fromAliasPrivkey': instance.fromAliasPrivkey,
      'toAliasPubkey': instance.toAliasPubkey,
      'toAliasPrivkey': instance.toAliasPrivkey,
      'shareSecretKey': instance.shareSecretKey,
      'lastUpdateTime': instance.lastUpdateTime,
      'status': instance.status
    };

SecretSessionDB _secretSessionInfoFromMap(Map<String, dynamic> map) {
  return SecretSessionDB(
    sessionId: map['sessionId'].toString(),
    fromPubkey: map['fromPubkey'].toString(),
    toPubkey: map['toPubkey'].toString(),
    fromAliasPubkey: map['fromAliasPubkey'].toString(),
    fromAliasPrivkey: map['fromAliasPrivkey'].toString(),
    toAliasPubkey: map['toAliasPubkey'].toString(),
    toAliasPrivkey: map['toAliasPrivkey'].toString(),
    shareSecretKey: map['shareSecretKey'].toString(),
    lastUpdateTime: map['lastUpdateTime'],
    status: map['status'],
  );
}
