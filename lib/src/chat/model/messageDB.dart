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
  encryptedFile,
  system
}

@reflector
class MessageDB extends DBObject {
  String messageId; //event id
  String? sender; // pubkey
  String? receiver; // friend pubkey
  String? groupId; // channel or group id
  String? sessionId; // secret chat id
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

  String? plaintEvent;

  MessageDB(
      {this.messageId = '',
      this.sender = '',
      this.receiver = '',
      this.groupId = '',
      this.sessionId = '',
      this.kind = 0,
      this.tags = '',
      this.content = '',
      this.createTime = 0,
      this.read = false,
      this.replyId = '',
      this.decryptContent = '',
      this.type = 'text',
      this.status = 1,
      this.plaintEvent = ''});

  @override
  Map<String, Object?> toMap() {
    return _messageInfoToMap(this);
  }

  Event? get originEvent {
    if (plaintEvent != null) {
      try {
        return Event.fromJson(jsonDecode(plaintEvent!));
      } catch (_) {
        return null;
      }
    }
    return null;
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

  //'ALTER TABLE Company ADD description TEXT'
  static Map<String, String?> updateTable() {
    return {
      "2":
          '''alter table MessageDB add plaintEvent TEXT; alter table MessageDB add sessionId TEXT;'''
    };
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
      case MessageType.system:
        return 'system';
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
      case 'system':
        return MessageType.system;
      default:
        return MessageType.text;
    }
  }

  static MessageType _identifyUrl(String urlString) {
    final Uri uri;

    try {
      uri = Uri.parse(urlString);
    } catch (e) {
      return MessageType.text;
    }

    if (!uri.isAbsolute) {
      return MessageType.text;
    }

    final String path = uri.path.toLowerCase();

    if (path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.gif') ||
        path.endsWith('.bmp') ||
        path.endsWith('.svg') ||
        path.endsWith('.webp')) {
      return MessageType.image;
    } else if (path.endsWith('.mp3') ||
        path.endsWith('.wav') ||
        path.endsWith('.flac') ||
        path.endsWith('.m4a') ||
        path.endsWith('.aac') ||
        path.endsWith('.ogg')) {
      return MessageType.audio;
    } else if (path.endsWith('.mp4') ||
        path.endsWith('.avi') ||
        path.endsWith('.mov') ||
        path.endsWith('.flv') ||
        path.endsWith('.wmv') ||
        path.endsWith('.mkv') ||
        path.endsWith('.webm')) {
      return MessageType.video;
    } else if (path.endsWith('.pdf') ||
        path.endsWith('.doc') ||
        path.endsWith('.docx') ||
        path.endsWith('.xls') ||
        path.endsWith('.xlsx') ||
        path.endsWith('.ppt') ||
        path.endsWith('.pptx') ||
        path.endsWith('.txt') ||
        path.endsWith('.csv')) {
      return MessageType.file;
    } else {
      return MessageType.text;
    }
  }

  static Map<String, dynamic> decodeContent(String content) {
    try {
      Map<String, dynamic> map = jsonDecode(content);
      if (map.containsKey('contentType') && map.containsKey('content')) {
        String type = map['contentType'];
        if (type == 'text' ||
            type == 'image' ||
            type == 'video' ||
            type == 'audio' ||
            type == 'file' ||
            type == 'template' ||
            type == 'encryptedImage' ||
            type == 'encryptedVideo' ||
            type == 'encryptedAudio' ||
            type == 'encryptedFile' ||
            type == 'system') return map;
      }
      return {'contentType': 'text', 'content': content};
    } catch (e) {
      print('decodeContent fail: $content, error msg: ${e.toString()}');
      MessageType type = _identifyUrl(content);
      return {'contentType': messageTypeToString(type), 'content': content};
    }
  }

  static String encodeContent(MessageType type, String content) {
    switch (type) {
      case MessageType.text:
      case MessageType.image:
      case MessageType.video:
      case MessageType.audio:
        return content;
      case MessageType.file:
      case MessageType.template:
      case MessageType.encryptedImage:
      case MessageType.encryptedVideo:
      case MessageType.encryptedAudio:
      case MessageType.encryptedFile:
      case MessageType.system:
        return jsonEncode(
            {'contentType': messageTypeToString(type), 'content': content});
      default:
        return content;
    }
  }

  static Future<MessageDB?> fromPrivateMessage(
      Event event, String receiver, String privkey) async {
    late EDMessage message;
    if (event.kind == 4) {
      message = Nip4.decode(event, receiver, privkey);
    } else if (event.kind == 44) {
      message = await Nip44.decode(event, receiver, privkey);
    } else if (event.kind == 14) {
      message = await Nip24.decodeSealedGossipDM(event, receiver, privkey);
    } else {
      return null;
    }
    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: message.sender,
        receiver: message.receiver,
        groupId: '',
        kind: event.kind,
        tags: event.tags.toString(),
        content: event.content,
        createTime: event.createdAt,
        replyId: message.replyId,
        plaintEvent: jsonEncode(event));
    messageDB.decryptContent = decodeContent(message.content)['content'];
    messageDB.type = decodeContent(message.content)['contentType'];
    return messageDB;
  }
}

Map<String, dynamic> _messageInfoToMap(MessageDB instance) => <String, dynamic>{
      'messageId': instance.messageId,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'groupId': instance.groupId,
      'sessionId': instance.sessionId,
      'kind': instance.kind,
      'tags': instance.tags,
      'content': instance.content,
      'createTime': instance.createTime,
      'read': instance.read,
      'replyId': instance.replyId,
      'decryptContent': instance.decryptContent,
      'type': instance.type,
      'status': instance.status,
      'plaintEvent': instance.plaintEvent,
    };

MessageDB _messageInfoFromMap(Map<String, dynamic> map) {
  return MessageDB(
    messageId: map['messageId'].toString(),
    sender: map['sender'].toString(),
    receiver: map['receiver'].toString(),
    groupId: map['groupId'].toString(),
    sessionId: map['sessionId'].toString(),
    kind: map['kind'],
    tags: map['tags'].toString(),
    content: map['content'].toString(),
    createTime: map['createTime'],
    read: map['read'] > 0 ? true : false,
    replyId: map['replyId'].toString(),
    decryptContent: map['decryptContent'].toString(),
    type: map['type'],
    status: map['status'],
    plaintEvent: map['plaintEvent'].toString(),
  );
}
