import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';

enum MessageType {
  text,
  image,
  video,
  audio,
  file,
  template,
  encryptedImage,
  encryptedVideo,
  encryptedAudio,
  encryptedFile
}

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
  String replyId;
  // additional,
  String? decryptContent;
  String? type;
  int? status; // 0 sending, 1 sent, 2 fail 3 recall

  List<String>? reportList; // hide message ids list, not save to DB

  MessageDB(
      {this.messageId = '',
      this.sender = '',
      this.receiver = '',
      this.groupId = '',
      this.kind = 0,
      this.tags = '',
      this.content = '',
      this.createTime = 0,
      this.read = false,
      this.replyId = '',
      this.decryptContent = '',
      this.type = 'text',
      this.status = 1});

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
      case MessageType.encryptedImage:
        return 'encryptedImage';
      case MessageType.encryptedVideo:
        return 'encryptedVideo';
      case MessageType.encryptedAudio:
        return 'encryptedAudio';
      case MessageType.encryptedFile:
        return 'encryptedFile';
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
      case 'encryptedImage':
        return MessageType.encryptedImage;
      case 'encryptedVideo':
        return MessageType.encryptedVideo;
      case 'encryptedAudio':
        return MessageType.encryptedAudio;
      case 'encryptedFile':
        return MessageType.encryptedFile;
      default:
        return MessageType.text;
    }
  }

  static Map<String, dynamic> decodeContent(String content) {
    try {
      return jsonDecode(content);
    } catch (e) {
      print('decodeContent fail: $content, error msg: ${e.toString()}');
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
      String author = event.pubkey;
      for (UserDB friend in Friends.sharedInstance.friends.values) {
        if (friend.toAliasPubkey != null) {
          String sender = '', receiver = '';
          if (friend.toAliasPubkey == toAliasPubkey) {
            // friends message
            sender = friend.pubKey!;
            receiver = Friends.sharedInstance.me!.pubKey!;
          } else if (friend.toAliasPubkey == author) {
            // my message
            sender = Friends.sharedInstance.me!.pubKey!;
            receiver = friend.pubKey!;
          }
          if (sender.isNotEmpty && receiver.isNotEmpty) {
            EDMessage message = Nip4.decode(
                event, friend.toAliasPubkey!, friend.toAliasPrivkey!);
            MessageDB messageDB = MessageDB(
                messageId: event.id,
                sender: sender,
                receiver: receiver,
                groupId: '',
                kind: 4,
                tags: event.tags.toString(),
                content: event.content,
                createTime: event.createdAt,
                replyId: message.replyId);
            messageDB.decryptContent =
                decodeContent(message.content)['content'];
            messageDB.type = decodeContent(message.content)['contentType'];
            return messageDB;
          }
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
      'replyId': instance.replyId,
      'decryptContent': instance.decryptContent,
      'type': instance.type,
      'status': instance.status,
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
    read: map['read'] > 0 ? true : false,
    replyId: map['replyId'].toString(),
    decryptContent: map['decryptContent'].toString(),
    type: map['type'],
    status: map['status'],
  );
}
