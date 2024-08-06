import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:chatcore/chat-core.dart';
import 'package:nostr_core_dart/nostr.dart';
import 'package:isar/isar.dart';

part 'messageDB_isar.g.dart';

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

@collection
class MessageDBISAR {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
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
  int?
      chatType; // 0 private chat 1 group chat 2 channel chat 3 secret chat 4 relay group chat
  String? subType; // subtype of template/system type

  /// add previewData
  String? previewData;

  /// add disappearing time
  int? expiration;

  /// add decryptSecret
  String? decryptSecret;

  // actions
  List<String>? reactionEventIds;
  List<String>? zapEventIds;

  // innerEvent Id
  String giftWrappedId;

  MessageDBISAR({
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
    this.reactionEventIds,
    this.zapEventIds,
    this.giftWrappedId = '',
  });

  static MessageDBISAR fromMap(Map<String, Object?> map) {
    return _messageInfoFromMap(map);
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
        path.endsWith('.heic') ||
        path.startsWith('image/gif;base64,') ||
        path.startsWith('image/png;base64,')) {
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
      debugPrintSynchronously('decodeContent fail: $content, error msg: ${e.toString()}');
      MessageType type = _identifyUrl(content);
      return {'contentType': messageTypeToString(type), 'content': content};
    }
  }

  static String getContent(MessageType type, String content, String? source) {
    if (source != null && source.isNotEmpty == true) return source;
    switch (type) {
      case MessageType.text:
      case MessageType.image:
      case MessageType.video:
      case MessageType.audio:
        return content;
      case MessageType.file:
        return '[You\'ve received a file via 0xChat!]';
      case MessageType.template:
        if (Zaps.isLightningInvoice(content) ||
            getNostrScheme(content) != null) {
          return content;
        }
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

  static Future<MessageDBISAR?> fromPrivateMessage(
      Event event, String receiver, String privkey,
      {int chatType = 0}) async {
    EDMessage? message;
    if (event.kind == 4) {
      message = await Nip4.decode(event, receiver, privkey);
    } else if (event.kind == 44) {
      message = await Nip44.decode(event, receiver, privkey);
    } else if (event.kind == 14) {
      message = await Nip17.decodeSealedGossipDM(event, receiver);
      if (message?.groupId?.isNotEmpty == true) {
        Groups.sharedInstance.createPrivateGroup(message!.sender,
            message.groupId!, message.subject, message.members);
        chatType = 1;
      }
    }
    if (message == null) return null;
    MessageDBISAR messageDB = MessageDBISAR(
        messageId: event.id,
        sender: message.sender,
        receiver: message.receiver,
        groupId: message.groupId ?? '',
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
    final isar = DBISAR.sharedInstance.isar;

    await isar.writeTxn(() async {
      final message = await isar.messageDBISARs
          .filter()
          .messageIdEqualTo(messageId)
          .findFirst();

      if (message != null) {
        message.previewData = previewData;
        await isar.messageDBISARs.put(message);
      }
    });
  }

  static String? getNostrScheme(String content) {
    final regexNostr = RegExp(
        r'\bnostr:(npub|note|nprofile|nevent|nrelay|naddr)[0-9a-zA-Z]{8,}\b');
    final match = regexNostr.firstMatch(content);
    if (match != null) {
      return match.group(1);
    }
    return null;
  }
}

MessageDBISAR _messageInfoFromMap(Map<String, dynamic> map) {
  return MessageDBISAR(
    messageId: map['messageId'].toString(),
    sender: map['sender'].toString(),
    receiver: map['receiver'].toString(),
    groupId: map['groupId'].toString(),
    sessionId: map['sessionId'].toString(),
    kind: map['kind'],
    tags: map['tags'].toString(),
    content: map['content'].toString(),
    createTime: map['createTime'],
    read: map['read'],
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
    reactionEventIds:
        UserDBISAR.decodeStringList(map['reactionEventIds'].toString()),
    zapEventIds: UserDBISAR.decodeStringList(map['zapEventIds'].toString()),
    giftWrappedId: map['giftWrappedId'].toString(),
  );
}
