import 'package:chatcore/chat-core.dart';

@reflector
class NotificationDB extends DBObject {
  String notificationId; //event id
  int kind; // 1：reply 2:quoteRepost 6:repost 7:reaction 9735:zap
  String author;
  int createAt;
  String content;
  int zapAmount;
  String associatedNoteId;

  NotificationDB(
      {this.notificationId = '',
      this.kind = 0,
      this.author = '',
      this.createAt = 0,
      this.content = '',
      this.zapAmount = 0,
      this.associatedNoteId = ''});

  @override
  Map<String, Object?> toMap() {
    return _notificationInfoToMap(this);
  }

  static NotificationDB fromMap(Map<String, Object?> map) {
    return _notificationInfoFromMap(map);
  }

  static String? tableName() {
    return "NotificationDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['notificationId'];
  }

  static NotificationDB notificationDBFromNoteDB(NoteDB note) {
    int kind = 0;
    String associatedNoteId = '';
    if(note.reply != null){
      kind = 1;
      associatedNoteId = note.reply!;
    }
    else if(note.repostId != null){
      kind = 6;
      associatedNoteId = note.repostId!;
    }
    else if(note.quoteRepostId != null){
      kind = 2;
      associatedNoteId = note.quoteRepostId!;
    }
    else if(note.reactedId != null){
      kind = 7;
      associatedNoteId = note.reactedId!;
    }
    return NotificationDB(
        notificationId: note.noteId,
        kind: kind,
        author: note.author,
        createAt: note.createAt,
        content: note.content,
        zapAmount: 0,
        associatedNoteId: associatedNoteId);
  }
}

Map<String, dynamic> _notificationInfoToMap(NotificationDB instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'kind': instance.kind,
      'author': instance.author,
      'createAt': instance.createAt,
      'content': instance.content,
      'zapAmount': instance.zapAmount,
      'associatedNoteId': instance.associatedNoteId,
    };

NotificationDB _notificationInfoFromMap(Map<String, dynamic> map) {
  return NotificationDB(
    notificationId: map['notificationId'].toString(),
    kind: map['kind'],
    author: map['author'].toString(),
    createAt: map['createAt'],
    content: map['content'].toString(),
    zapAmount: map['zapAmount'],
    associatedNoteId: map['associatedNoteId'].toString(),
  );
}
