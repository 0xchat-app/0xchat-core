import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr/nostr.dart';

enum MessageType { text, image, video, audio, file, template }

@reflector
class MessageDB extends DBObject {
  String? messageId; //event id
  String? sender; // pubkey
  String? receiver; // friend pubkey
  String? groupId; // channel or group id
  int? kind;
  String? tags;
  String? content; // content
  int? createTime;
  bool? read;
  // additional
  String? decryptContent;
  MessageType? type;

  MessageDB({
    this.messageId = '',
    this.sender = '',
    this.receiver = '',
    this.groupId = '',
    this.kind = 0,
    this.tags = '',
    this.content = '',
    this.createTime = 0,
    this.read = false,
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

  static String messageTypeToString(MessageType type) {
    switch (type) {
      case MessageType.text:
        return 'text';
      case MessageType.image:
        return 'image';
      case MessageType.video:
        return 'video';
      case MessageType.audio:
        return 'audio';
      case MessageType.file:
        return 'file';
      case MessageType.template:
        return 'template';
      default:
        return 'text';
    }
  }

  static MessageType stringtoMessageType(String type) {
    switch (type) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'video':
        return MessageType.video;
      case 'audio':
        return MessageType.audio;
      case 'file':
        return MessageType.file;
      case 'template':
        return MessageType.template;
      default:
        return MessageType.text;
    }
  }

  static Map<String, dynamic> decodeContent(String content) {
    try {
      return jsonDecode(content);
    } catch (e) {
      print(e.toString());
      return {'contentType': 'text', 'content': content};
    }
  }

  static String encodeContent(MessageType type, String content) {
    return jsonEncode(
        {'contentType': messageTypeToString(type), 'content': content});
  }

  static MessageDB? fromPrivateMessage(Event event) {
    if (event.kind == 4) {
      String toAliasPubkey = Nip101.getP(event);
      for (UserDB friend in Friends.sharedInstance.friends.values) {
        if (friend.toAliasPubkey != null &&
            friend.toAliasPubkey == toAliasPubkey) {
          EDMessage message =
              Nip4.decode(event, friend.toAliasPubkey!, friend.toAliasPrivkey!);
          MessageDB messageDB = MessageDB(
              messageId: event.id,
              sender: friend.pubKey,
              receiver: Friends.sharedInstance.me!.pubKey,
              groupId: '',
              kind: 4,
              tags: event.tags.toString(),
              content: event.content,
              createTime: event.createdAt);
          messageDB.decryptContent = decodeContent(message.content)['content'];
          messageDB.type = stringtoMessageType(
              decodeContent(message.content)['contentType']);
          return messageDB;
        }
      }
    }
    return null;
  }
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
      'read': instance.read,
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
    createTime: map['createTime'],
    read: map['read'],
  );
}
