import 'dart:convert';
import 'dart:typed_data';
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
  system,
  call
}

@reflector
class MessageDB extends DBObject {
  String messageId; //event id
  String sender; // pubkey
  String receiver; // friend pubkey
  String groupId; // channel or group id
  String sessionId; // secret chat id
  int kind;
  String tags;
  String content; // content
  int createTime;
  bool read;
  String replyId;
  // additional,
  String decryptContent;
  String type;
  int? status; // 0 sending, 1 sent, 2 fail 3 recall

  List<String>? reportList; // hide message ids list, not save to DB

  String plaintEvent;

  /// add type
  int? chatType; // 0 private chat 1 group chat 2 channel chat 3 secret chat
  String? subType; // subtype of template/system type

  /// add previewData
  String? previewData;

  /// add disappearing time
  int? expiration;

  /// add decryptSecret
  String? decryptSecret;

  MessageDB({
    this.messageId = '',
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
    this.plaintEvent = '',
    this.chatType,
    this.subType,
    this.previewData,
    this.expiration,
    this.decryptSecret,
  });

  @override
  Map<String, Object?> toMap() {
    return _messageInfoToMap(this);
  }

  Event? get originEvent {
    try {
      return Event.fromJson(jsonDecode(plaintEvent));
    } catch (_) {
      return null;
    }
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
          '''alter table MessageDB add plaintEvent TEXT; alter table MessageDB add sessionId TEXT;''',
      "4":
          '''alter table MessageDB add chatType INT; alter table MessageDB add subType TEXT;''',
      "5":
          '''alter table MessageDB add previewData TEXT; alter table MessageDB add expiration INT; alter table MessageDB add decryptSecret TEXT;'''
    };
  }

  static Uint8List getRandomSecret() {
    Keychain k = Keychain.generate();
    return hexToBytes(k.private);
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
      case MessageType.call:
        return 'call';
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
      case 'call':
        return MessageType.call;
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
        path.endsWith('.webp') ||
        path.startsWith('data:image/gif;base64,') ||
        path.startsWith('data:image/png;base64,')) {
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
    content = content.trim();
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
            type == 'system' ||
            type == 'call') return map;
      }
      return {'contentType': 'text', 'content': content};
    } catch (e) {
      print('decodeContent fail: $content, error msg: ${e.toString()}');
      MessageType type = _identifyUrl(content);
      return {'contentType': messageTypeToString(type), 'content': content};
    }
  }

  static String getContent(MessageType type, String content) {
    switch (type) {
      case MessageType.text:
      case MessageType.image:
      case MessageType.video:
      case MessageType.audio:
        return content;
      case MessageType.file:
        return '[You\'ve received a file via 0xChat!]';
      case MessageType.template:
        return '[You\'ve received a template via 0xChat!]';
      case MessageType.encryptedImage:
        return '[You\'ve received an end-to-end encrypted image via 0xChat!]';
      case MessageType.encryptedVideo:
        return '[You\'ve received an end-to-end encrypted video via 0xChat!]';
      case MessageType.encryptedAudio:
        return '[You\'ve received an end-to-end encrypted audio via 0xChat!]';
      case MessageType.encryptedFile:
        return '[You\'ve received an end-to-end encrypted file via 0xChat!]';
      case MessageType.system:
        return '[You\'ve received a system message via 0xChat!]';
      case MessageType.call:
        return '[You\'ve received a call via 0xChat!]';
      default:
        return content;
    }
  }

  static String? getSubContent(MessageType type, String content,
      {String? decryptSecret}) {
    switch (type) {
      case MessageType.text:
      case MessageType.image:
      case MessageType.video:
      case MessageType.audio:
        return null;
      case MessageType.file:
      case MessageType.template:
      case MessageType.encryptedImage:
      case MessageType.encryptedVideo:
      case MessageType.encryptedAudio:
      case MessageType.encryptedFile:
      case MessageType.system:
      case MessageType.call:
        return jsonEncode({
          'contentType': messageTypeToString(type),
          'content': content,
          'decryptSecret': decryptSecret
        });
      default:
        return null;
    }
  }

  static Future<MessageDB?> fromPrivateMessage(
      Event event, String receiver, String privkey,
      {int chatType = 0}) async {
    EDMessage? message;
    if (event.kind == 4) {
      message = Nip4.decode(event, receiver, privkey);
    } else if (event.kind == 44) {
      message = await Nip44.decode(event, receiver, privkey);
    } else if (event.kind == 14) {
      message = await Nip24.decodeSealedGossipDM(event, receiver);
    }
    if (message == null) return null;
    MessageDB messageDB = MessageDB(
        messageId: event.id,
        sender: message.sender,
        receiver: message.receiver,
        groupId: '',
        kind: event.kind,
        tags: jsonEncode(event.tags),
        content: message.content,
        createTime: event.createdAt,
        replyId: message.replyId,
        plaintEvent: jsonEncode(event),
        chatType: chatType,
        expiration:
            message.expiration == null ? null : int.parse(message.expiration!));
    var map = decodeContent(message.content);
    messageDB.decryptContent = map['content'];
    messageDB.type = map['contentType'];
    messageDB.decryptSecret = map['decryptSecret'];
    return messageDB;
  }

  static Future<void> savePreviewData(
      String messageId, String previewData) async {
    await DB.sharedInstance.rawUpdate(
        'UPDATE MessageDB SET previewData = ? WHERE messageId = ?',
        [previewData, messageId]);
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
      'subType': instance.subType,
      'chatType': instance.chatType,
      'previewData': instance.previewData,
      'expiration': instance.expiration,
      'decryptSecret': instance.decryptSecret,
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
    chatType: map['chatType'],
    subType: map['subType']?.toString(),
    previewData: map['previewData']?.toString(),
    expiration: map['expiration'],
    decryptSecret: map['decryptSecret']?.toString(),
  );
}
