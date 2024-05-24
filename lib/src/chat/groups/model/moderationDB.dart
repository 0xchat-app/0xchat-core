import 'dart:convert';
import 'package:chatcore/chat-core.dart';

@reflector
class ModerationDB extends DBObject {
  String moderationId;
  String groupId;
  String author;
  int createdAt;
  String content;
  List<String>? previous;

  ModerationDB(
      {this.moderationId = '',
      this.groupId = '',
      this.author = '',
      this.createdAt = 0,
      this.content = '',
      this.previous});

  @override
  Map<String, Object?> toMap() {
    return _moderationInfoToMap(this);
  }

  static ModerationDB fromMap(Map<String, Object?> map) {
    return _moderationDBInfoFromMap(map);
  }

  static String? tableName() {
    return "ModerationDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['moderationId'];
  }
}

Map<String, dynamic> _moderationInfoToMap(ModerationDB instance) =>
    <String, dynamic>{
      'moderationId': instance.moderationId,
      'groupId': instance.groupId,
      'author': instance.author,
      'createdAt': instance.createdAt,
      'content': instance.content,
      'previous':
          instance.previous == null ? null : jsonEncode(instance.previous),
    };

ModerationDB _moderationDBInfoFromMap(Map<String, dynamic> map) {
  return ModerationDB(
    moderationId: map['moderationId'].toString(),
    groupId: map['groupId'].toString(),
    author: map['author'].toString(),
    createdAt: map['createdAt'],
    content: map['content'].toString(),
    previous: UserDB.decodeStringList(map['previous'].toString()),
  );
}
