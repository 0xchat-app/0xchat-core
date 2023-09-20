import 'package:chatcore/chat-core.dart';

@reflector
class NoteDB extends DBObject {
  String noteId; //event id

  NoteDB({
    this.noteId = '',
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
}

Map<String, dynamic> _noteInfoToMap(NoteDB instance) => <String, dynamic>{
      'noteId': instance.noteId,
    };

NoteDB _noteInfoFromMap(Map<String, dynamic> map) {
  return NoteDB(
    noteId: map['noteId'].toString(),
  );
}
