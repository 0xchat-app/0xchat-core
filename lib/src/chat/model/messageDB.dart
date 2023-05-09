import 'package:chatcore/chat-core.dart';
import 'package:nostr/nostr.dart';

@reflector
class MessageDB extends DBObject {
  String? messageId; //event id
  String? sender; // pubkey
  String? receiver; // friend pubkey
  String? groupId; // channel or group id
  int? kind;
  String? tags;
  String? content; // content
  String? createTime;

  // additional
  String? privkey;
  String? decryptContent;
  String? type; // audio/file/video/image/text/template
  List<String>? mentions; // mention list

  MessageDB({
    this.messageId = '',
    this.sender = '',
    this.receiver = '',
    this.groupId = '',
    this.kind = 0,
    this.tags = '',
    this.content = '',
    this.createTime = '',
    this.privkey = '',
  });

  @override
  Map<String, Object?> toMap() {
    return _messageInfoToMap(this);
  }

  static MessageDB fromMap(Map<String, Object?> map) {
    return _messageInfoFromMap(map);
  }

  static String? tableName() {
    return "MessageDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['messageId'];
  }

  // static MessageDB fromPrivateMessage(Event event) {
  //
  // }
}

Map<String, dynamic> _messageInfoToMap(MessageDB instance) => <String, dynamic>{
  'messageId': instance.messageId,
  'sender': instance.sender,
  'receiver': instance.receiver,
  'groupId': instance.groupId,
  'kind': instance.kind,
  'tags': instance.tags,
  'content': instance.content,
  'createTime': instance.createTime,
};

MessageDB _messageInfoFromMap(Map<String, dynamic> map) {
  return MessageDB(
    messageId: map['messageId'].toString(),
    sender: map['sender'].toString(),
    receiver: map['receiver'].toString(),
    groupId: map['groupId'].toString(),
    kind: map['kind'],
    tags: map['tags'].toString(),
    content: map['content'].toString(),
    createTime: map['createTime'].toString(),
  );
}