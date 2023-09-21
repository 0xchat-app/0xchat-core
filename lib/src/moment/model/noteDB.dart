import 'dart:convert';
import 'package:chatcore/chat-core.dart';

@reflector
class NoteDB extends DBObject {
  String noteId; //event id
  String author;
  int createAt;
  String content;
  String root;
  String? rootRelay;
  String? reply;
  String? replyRelay;
  List<String>? mentions;
  List<String>? pTags;

  /// actions count
  int replyCount;
  int repostCount;
  int reactionCount;
  int zapCount;
  int zapAmount;

  /// actions event ids
  List<String>? replyEventIds;
  List<String>? repostEventIds;
  List<String>? quoteRepostEventIds;
  List<String>? reactionEventIds;
  List<String>? zapEventIds;

  NoteDB({
    this.noteId = '',
    this.author = '',
    this.createAt = 0,
    this.content = '',
    this.root = '',
    this.rootRelay,
    this.reply,
    this.replyRelay,
    this.mentions,
    this.pTags,
    this.replyCount = 0,
    this.repostCount = 0,
    this.reactionCount = 0,
    this.zapCount = 0,
    this.zapAmount = 0,
    this.replyEventIds,
    this.repostEventIds,
    this.quoteRepostEventIds,
    this.reactionEventIds,
    this.zapEventIds,
  });

  @override
  Map<String, Object?> toMap() {
    return _noteInfoToMap(this);
  }

  static NoteDB fromMap(Map<String, Object?> map) {
    return _noteInfoFromMap(map);
  }

  static String? tableName() {
    return "NoteDB";
  }

  //primaryKey
  static List<String?> primaryKey() {
    return ['noteId'];
  }

  static List<String>? decodeStringList(String? list) {
    if (list == null) return null;
    try {
      List<dynamic> result = jsonDecode(list);
      return result.map((e) => e.toString()).toList();
    } catch (e) {
      return null;
    }
  }
}

Map<String, dynamic> _noteInfoToMap(NoteDB instance) => <String, dynamic>{
      'noteId': instance.noteId,
      'author': instance.author,
      'createAt': instance.createAt,
      'content': instance.content,
      'root': instance.root,
      'rootRelay': instance.rootRelay,
      'reply': instance.reply,
      'replyRelay': instance.replyRelay,
      'mentions': jsonEncode(instance.mentions),
      'pTags': jsonEncode(instance.pTags),
      'replyCount': instance.replyCount,
      'repostCount': instance.repostCount,
      'reactionCount': instance.reactionCount,
      'zapCount': instance.zapCount,
      'zapAmount': instance.zapAmount,
      'replyEventIds': jsonEncode(instance.replyEventIds),
      'repostEventIds': jsonEncode(instance.repostEventIds),
      'quoteRepostEventIds': jsonEncode(instance.quoteRepostEventIds),
      'reactionEventIds': jsonEncode(instance.reactionEventIds),
      'zapEventIds': jsonEncode(instance.zapEventIds),
    };

NoteDB _noteInfoFromMap(Map<String, dynamic> map) {
  return NoteDB(
    noteId: map['noteId'].toString(),
    author: map['author'].toString(),
    createAt: map['createAt'],
    content: map['content'].toString(),
    root: map['root'].toString(),
    rootRelay: map['rootRelay']?.toString(),
    reply: map['reply']?.toString(),
    replyRelay: map['replyRelay']?.toString(),
    mentions: NoteDB.decodeStringList(map['mentions']?.toString()),
    pTags: NoteDB.decodeStringList(map['pTags']?.toString()),
    replyCount: map['replyCount'],
    repostCount: map['repostCount'],
    reactionCount: map['reactionCount'],
    zapCount: map['zapCount'],
    zapAmount: map['zapAmount'],
    replyEventIds: NoteDB.decodeStringList(map['replyEventIds']?.toString()),
    repostEventIds: NoteDB.decodeStringList(map['repostEventIds']?.toString()),
    quoteRepostEventIds:
        NoteDB.decodeStringList(map['quoteRepostEventIds']?.toString()),
    reactionEventIds:
        NoteDB.decodeStringList(map['reactionEventIds']?.toString()),
    zapEventIds: NoteDB.decodeStringList(map['zapEventIds']?.toString()),
  );
}
