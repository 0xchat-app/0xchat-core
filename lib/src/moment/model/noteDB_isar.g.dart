// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noteDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetNoteDBISARCollection on Isar {
  IsarCollection<int, NoteDBISAR> get noteDBISARs => this.collection();
}

const NoteDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'NoteDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'noteId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'groupId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'author',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'createAt',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'content',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'root',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'rootRelay',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'reply',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'replyRelay',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'mentions',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'pTags',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'hashTags',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'private',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'read',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'warning',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'repostId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'quoteRepostId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'reactedId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'reactedKind',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'emojiShortcode',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'emojiURL',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'findEvent',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'replyCount',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'repostCount',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'quoteRepostCount',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'reactionCount',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'zapCount',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'zapAmount',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'replyCountByMe',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'repostCountByMe',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'quoteRepostCountByMe',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'reactionCountByMe',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'zapCountByMe',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'zapAmountByMe',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'rawEvent',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'replyEventIds',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'repostEventIds',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'quoteRepostEventIds',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'reactionEventIds',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'zapEventIds',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'lastUpdatedTimeString',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'encodedNoteId',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'noteId',
        properties: [
          "noteId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, NoteDBISAR>(
    serialize: serializeNoteDBISAR,
    deserialize: deserializeNoteDBISAR,
    deserializeProperty: deserializeNoteDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeNoteDBISAR(IsarWriter writer, NoteDBISAR object) {
  IsarCore.writeString(writer, 1, object.noteId);
  IsarCore.writeString(writer, 2, object.groupId);
  IsarCore.writeString(writer, 3, object.author);
  IsarCore.writeLong(writer, 4, object.createAt);
  IsarCore.writeString(writer, 5, object.content);
  {
    final value = object.root;
    if (value == null) {
      IsarCore.writeNull(writer, 6);
    } else {
      IsarCore.writeString(writer, 6, value);
    }
  }
  {
    final value = object.rootRelay;
    if (value == null) {
      IsarCore.writeNull(writer, 7);
    } else {
      IsarCore.writeString(writer, 7, value);
    }
  }
  {
    final value = object.reply;
    if (value == null) {
      IsarCore.writeNull(writer, 8);
    } else {
      IsarCore.writeString(writer, 8, value);
    }
  }
  {
    final value = object.replyRelay;
    if (value == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      IsarCore.writeString(writer, 9, value);
    }
  }
  {
    final list = object.mentions;
    if (list == null) {
      IsarCore.writeNull(writer, 10);
    } else {
      final listWriter = IsarCore.beginList(writer, 10, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.pTags;
    if (list == null) {
      IsarCore.writeNull(writer, 11);
    } else {
      final listWriter = IsarCore.beginList(writer, 11, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.hashTags;
    if (list == null) {
      IsarCore.writeNull(writer, 12);
    } else {
      final listWriter = IsarCore.beginList(writer, 12, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  IsarCore.writeBool(writer, 13, object.private);
  IsarCore.writeBool(writer, 14, object.read);
  {
    final value = object.warning;
    if (value == null) {
      IsarCore.writeNull(writer, 15);
    } else {
      IsarCore.writeString(writer, 15, value);
    }
  }
  {
    final value = object.repostId;
    if (value == null) {
      IsarCore.writeNull(writer, 16);
    } else {
      IsarCore.writeString(writer, 16, value);
    }
  }
  {
    final value = object.quoteRepostId;
    if (value == null) {
      IsarCore.writeNull(writer, 17);
    } else {
      IsarCore.writeString(writer, 17, value);
    }
  }
  {
    final value = object.reactedId;
    if (value == null) {
      IsarCore.writeNull(writer, 18);
    } else {
      IsarCore.writeString(writer, 18, value);
    }
  }
  {
    final value = object.reactedKind;
    if (value == null) {
      IsarCore.writeNull(writer, 19);
    } else {
      IsarCore.writeString(writer, 19, value);
    }
  }
  {
    final value = object.emojiShortcode;
    if (value == null) {
      IsarCore.writeNull(writer, 20);
    } else {
      IsarCore.writeString(writer, 20, value);
    }
  }
  {
    final value = object.emojiURL;
    if (value == null) {
      IsarCore.writeNull(writer, 21);
    } else {
      IsarCore.writeString(writer, 21, value);
    }
  }
  IsarCore.writeBool(writer, 22, object.findEvent);
  IsarCore.writeLong(writer, 23, object.replyCount);
  IsarCore.writeLong(writer, 24, object.repostCount);
  IsarCore.writeLong(writer, 25, object.quoteRepostCount);
  IsarCore.writeLong(writer, 26, object.reactionCount);
  IsarCore.writeLong(writer, 27, object.zapCount);
  IsarCore.writeLong(writer, 28, object.zapAmount);
  IsarCore.writeLong(writer, 29, object.replyCountByMe);
  IsarCore.writeLong(writer, 30, object.repostCountByMe);
  IsarCore.writeLong(writer, 31, object.quoteRepostCountByMe);
  IsarCore.writeLong(writer, 32, object.reactionCountByMe);
  IsarCore.writeLong(writer, 33, object.zapCountByMe);
  IsarCore.writeLong(writer, 34, object.zapAmountByMe);
  {
    final value = object.rawEvent;
    if (value == null) {
      IsarCore.writeNull(writer, 35);
    } else {
      IsarCore.writeString(writer, 35, value);
    }
  }
  {
    final list = object.replyEventIds;
    if (list == null) {
      IsarCore.writeNull(writer, 36);
    } else {
      final listWriter = IsarCore.beginList(writer, 36, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.repostEventIds;
    if (list == null) {
      IsarCore.writeNull(writer, 37);
    } else {
      final listWriter = IsarCore.beginList(writer, 37, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.quoteRepostEventIds;
    if (list == null) {
      IsarCore.writeNull(writer, 38);
    } else {
      final listWriter = IsarCore.beginList(writer, 38, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.reactionEventIds;
    if (list == null) {
      IsarCore.writeNull(writer, 39);
    } else {
      final listWriter = IsarCore.beginList(writer, 39, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.zapEventIds;
    if (list == null) {
      IsarCore.writeNull(writer, 40);
    } else {
      final listWriter = IsarCore.beginList(writer, 40, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final value = object.lastUpdatedTimeString;
    if (value == null) {
      IsarCore.writeNull(writer, 41);
    } else {
      IsarCore.writeString(writer, 41, value);
    }
  }
  IsarCore.writeString(writer, 42, object.encodedNoteId);
  return object.id;
}

@isarProtected
NoteDBISAR deserializeNoteDBISAR(IsarReader reader) {
  final String _noteId;
  _noteId = IsarCore.readString(reader, 1) ?? '';
  final String _groupId;
  _groupId = IsarCore.readString(reader, 2) ?? '';
  final String _author;
  _author = IsarCore.readString(reader, 3) ?? '';
  final int _createAt;
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      _createAt = 0;
    } else {
      _createAt = value;
    }
  }
  final String _content;
  _content = IsarCore.readString(reader, 5) ?? '';
  final String? _root;
  _root = IsarCore.readString(reader, 6) ?? '';
  final String? _rootRelay;
  _rootRelay = IsarCore.readString(reader, 7);
  final String? _reply;
  _reply = IsarCore.readString(reader, 8);
  final String? _replyRelay;
  _replyRelay = IsarCore.readString(reader, 9);
  final List<String>? _mentions;
  {
    final length = IsarCore.readList(reader, 10, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _mentions = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _mentions = list;
      }
    }
  }
  final List<String>? _pTags;
  {
    final length = IsarCore.readList(reader, 11, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _pTags = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _pTags = list;
      }
    }
  }
  final List<String>? _hashTags;
  {
    final length = IsarCore.readList(reader, 12, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _hashTags = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _hashTags = list;
      }
    }
  }
  final bool _private;
  _private = IsarCore.readBool(reader, 13);
  final bool _read;
  _read = IsarCore.readBool(reader, 14);
  final String? _warning;
  _warning = IsarCore.readString(reader, 15);
  final String? _repostId;
  _repostId = IsarCore.readString(reader, 16) ?? '';
  final String? _quoteRepostId;
  _quoteRepostId = IsarCore.readString(reader, 17) ?? '';
  final String? _reactedId;
  _reactedId = IsarCore.readString(reader, 18) ?? '';
  final String? _reactedKind;
  _reactedKind = IsarCore.readString(reader, 19) ?? '';
  final String? _emojiShortcode;
  _emojiShortcode = IsarCore.readString(reader, 20) ?? '';
  final String? _emojiURL;
  _emojiURL = IsarCore.readString(reader, 21) ?? '';
  final bool _findEvent;
  _findEvent = IsarCore.readBool(reader, 22);
  final int _replyCount;
  {
    final value = IsarCore.readLong(reader, 23);
    if (value == -9223372036854775808) {
      _replyCount = 0;
    } else {
      _replyCount = value;
    }
  }
  final int _repostCount;
  {
    final value = IsarCore.readLong(reader, 24);
    if (value == -9223372036854775808) {
      _repostCount = 0;
    } else {
      _repostCount = value;
    }
  }
  final int _quoteRepostCount;
  {
    final value = IsarCore.readLong(reader, 25);
    if (value == -9223372036854775808) {
      _quoteRepostCount = 0;
    } else {
      _quoteRepostCount = value;
    }
  }
  final int _reactionCount;
  {
    final value = IsarCore.readLong(reader, 26);
    if (value == -9223372036854775808) {
      _reactionCount = 0;
    } else {
      _reactionCount = value;
    }
  }
  final int _zapCount;
  {
    final value = IsarCore.readLong(reader, 27);
    if (value == -9223372036854775808) {
      _zapCount = 0;
    } else {
      _zapCount = value;
    }
  }
  final int _zapAmount;
  {
    final value = IsarCore.readLong(reader, 28);
    if (value == -9223372036854775808) {
      _zapAmount = 0;
    } else {
      _zapAmount = value;
    }
  }
  final int _replyCountByMe;
  {
    final value = IsarCore.readLong(reader, 29);
    if (value == -9223372036854775808) {
      _replyCountByMe = 0;
    } else {
      _replyCountByMe = value;
    }
  }
  final int _repostCountByMe;
  {
    final value = IsarCore.readLong(reader, 30);
    if (value == -9223372036854775808) {
      _repostCountByMe = 0;
    } else {
      _repostCountByMe = value;
    }
  }
  final int _quoteRepostCountByMe;
  {
    final value = IsarCore.readLong(reader, 31);
    if (value == -9223372036854775808) {
      _quoteRepostCountByMe = 0;
    } else {
      _quoteRepostCountByMe = value;
    }
  }
  final int _reactionCountByMe;
  {
    final value = IsarCore.readLong(reader, 32);
    if (value == -9223372036854775808) {
      _reactionCountByMe = 0;
    } else {
      _reactionCountByMe = value;
    }
  }
  final int _zapCountByMe;
  {
    final value = IsarCore.readLong(reader, 33);
    if (value == -9223372036854775808) {
      _zapCountByMe = 0;
    } else {
      _zapCountByMe = value;
    }
  }
  final int _zapAmountByMe;
  {
    final value = IsarCore.readLong(reader, 34);
    if (value == -9223372036854775808) {
      _zapAmountByMe = 0;
    } else {
      _zapAmountByMe = value;
    }
  }
  final String? _rawEvent;
  _rawEvent = IsarCore.readString(reader, 35) ?? '';
  final List<String>? _replyEventIds;
  {
    final length = IsarCore.readList(reader, 36, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _replyEventIds = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _replyEventIds = list;
      }
    }
  }
  final List<String>? _repostEventIds;
  {
    final length = IsarCore.readList(reader, 37, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _repostEventIds = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _repostEventIds = list;
      }
    }
  }
  final List<String>? _quoteRepostEventIds;
  {
    final length = IsarCore.readList(reader, 38, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _quoteRepostEventIds = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _quoteRepostEventIds = list;
      }
    }
  }
  final List<String>? _reactionEventIds;
  {
    final length = IsarCore.readList(reader, 39, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _reactionEventIds = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _reactionEventIds = list;
      }
    }
  }
  final List<String>? _zapEventIds;
  {
    final length = IsarCore.readList(reader, 40, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _zapEventIds = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _zapEventIds = list;
      }
    }
  }
  final String? _lastUpdatedTimeString;
  _lastUpdatedTimeString = IsarCore.readString(reader, 41);
  final object = NoteDBISAR(
    noteId: _noteId,
    groupId: _groupId,
    author: _author,
    createAt: _createAt,
    content: _content,
    root: _root,
    rootRelay: _rootRelay,
    reply: _reply,
    replyRelay: _replyRelay,
    mentions: _mentions,
    pTags: _pTags,
    hashTags: _hashTags,
    private: _private,
    read: _read,
    warning: _warning,
    repostId: _repostId,
    quoteRepostId: _quoteRepostId,
    reactedId: _reactedId,
    reactedKind: _reactedKind,
    emojiShortcode: _emojiShortcode,
    emojiURL: _emojiURL,
    findEvent: _findEvent,
    replyCount: _replyCount,
    repostCount: _repostCount,
    quoteRepostCount: _quoteRepostCount,
    reactionCount: _reactionCount,
    zapCount: _zapCount,
    zapAmount: _zapAmount,
    replyCountByMe: _replyCountByMe,
    repostCountByMe: _repostCountByMe,
    quoteRepostCountByMe: _quoteRepostCountByMe,
    reactionCountByMe: _reactionCountByMe,
    zapCountByMe: _zapCountByMe,
    zapAmountByMe: _zapAmountByMe,
    rawEvent: _rawEvent,
    replyEventIds: _replyEventIds,
    repostEventIds: _repostEventIds,
    quoteRepostEventIds: _quoteRepostEventIds,
    reactionEventIds: _reactionEventIds,
    zapEventIds: _zapEventIds,
    lastUpdatedTimeString: _lastUpdatedTimeString,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeNoteDBISARProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      {
        final value = IsarCore.readLong(reader, 4);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      return IsarCore.readString(reader, 7);
    case 8:
      return IsarCore.readString(reader, 8);
    case 9:
      return IsarCore.readString(reader, 9);
    case 10:
      {
        final length = IsarCore.readList(reader, 10, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 11:
      {
        final length = IsarCore.readList(reader, 11, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 12:
      {
        final length = IsarCore.readList(reader, 12, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 13:
      return IsarCore.readBool(reader, 13);
    case 14:
      return IsarCore.readBool(reader, 14);
    case 15:
      return IsarCore.readString(reader, 15);
    case 16:
      return IsarCore.readString(reader, 16) ?? '';
    case 17:
      return IsarCore.readString(reader, 17) ?? '';
    case 18:
      return IsarCore.readString(reader, 18) ?? '';
    case 19:
      return IsarCore.readString(reader, 19) ?? '';
    case 20:
      return IsarCore.readString(reader, 20) ?? '';
    case 21:
      return IsarCore.readString(reader, 21) ?? '';
    case 22:
      return IsarCore.readBool(reader, 22);
    case 23:
      {
        final value = IsarCore.readLong(reader, 23);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 24:
      {
        final value = IsarCore.readLong(reader, 24);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 25:
      {
        final value = IsarCore.readLong(reader, 25);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 26:
      {
        final value = IsarCore.readLong(reader, 26);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 27:
      {
        final value = IsarCore.readLong(reader, 27);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 28:
      {
        final value = IsarCore.readLong(reader, 28);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 29:
      {
        final value = IsarCore.readLong(reader, 29);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 30:
      {
        final value = IsarCore.readLong(reader, 30);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 31:
      {
        final value = IsarCore.readLong(reader, 31);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 32:
      {
        final value = IsarCore.readLong(reader, 32);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 33:
      {
        final value = IsarCore.readLong(reader, 33);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 34:
      {
        final value = IsarCore.readLong(reader, 34);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 35:
      return IsarCore.readString(reader, 35) ?? '';
    case 36:
      {
        final length = IsarCore.readList(reader, 36, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 37:
      {
        final length = IsarCore.readList(reader, 37, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 38:
      {
        final length = IsarCore.readList(reader, 38, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 39:
      {
        final length = IsarCore.readList(reader, 39, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 40:
      {
        final length = IsarCore.readList(reader, 40, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 41:
      return IsarCore.readString(reader, 41);
    case 42:
      return IsarCore.readString(reader, 42) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _NoteDBISARUpdate {
  bool call({
    required int id,
    String? noteId,
    String? groupId,
    String? author,
    int? createAt,
    String? content,
    String? root,
    String? rootRelay,
    String? reply,
    String? replyRelay,
    bool? private,
    bool? read,
    String? warning,
    String? repostId,
    String? quoteRepostId,
    String? reactedId,
    String? reactedKind,
    String? emojiShortcode,
    String? emojiURL,
    bool? findEvent,
    int? replyCount,
    int? repostCount,
    int? quoteRepostCount,
    int? reactionCount,
    int? zapCount,
    int? zapAmount,
    int? replyCountByMe,
    int? repostCountByMe,
    int? quoteRepostCountByMe,
    int? reactionCountByMe,
    int? zapCountByMe,
    int? zapAmountByMe,
    String? rawEvent,
    String? lastUpdatedTimeString,
    String? encodedNoteId,
  });
}

class _NoteDBISARUpdateImpl implements _NoteDBISARUpdate {
  const _NoteDBISARUpdateImpl(this.collection);

  final IsarCollection<int, NoteDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? noteId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createAt = ignore,
    Object? content = ignore,
    Object? root = ignore,
    Object? rootRelay = ignore,
    Object? reply = ignore,
    Object? replyRelay = ignore,
    Object? private = ignore,
    Object? read = ignore,
    Object? warning = ignore,
    Object? repostId = ignore,
    Object? quoteRepostId = ignore,
    Object? reactedId = ignore,
    Object? reactedKind = ignore,
    Object? emojiShortcode = ignore,
    Object? emojiURL = ignore,
    Object? findEvent = ignore,
    Object? replyCount = ignore,
    Object? repostCount = ignore,
    Object? quoteRepostCount = ignore,
    Object? reactionCount = ignore,
    Object? zapCount = ignore,
    Object? zapAmount = ignore,
    Object? replyCountByMe = ignore,
    Object? repostCountByMe = ignore,
    Object? quoteRepostCountByMe = ignore,
    Object? reactionCountByMe = ignore,
    Object? zapCountByMe = ignore,
    Object? zapAmountByMe = ignore,
    Object? rawEvent = ignore,
    Object? lastUpdatedTimeString = ignore,
    Object? encodedNoteId = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (noteId != ignore) 1: noteId as String?,
          if (groupId != ignore) 2: groupId as String?,
          if (author != ignore) 3: author as String?,
          if (createAt != ignore) 4: createAt as int?,
          if (content != ignore) 5: content as String?,
          if (root != ignore) 6: root as String?,
          if (rootRelay != ignore) 7: rootRelay as String?,
          if (reply != ignore) 8: reply as String?,
          if (replyRelay != ignore) 9: replyRelay as String?,
          if (private != ignore) 13: private as bool?,
          if (read != ignore) 14: read as bool?,
          if (warning != ignore) 15: warning as String?,
          if (repostId != ignore) 16: repostId as String?,
          if (quoteRepostId != ignore) 17: quoteRepostId as String?,
          if (reactedId != ignore) 18: reactedId as String?,
          if (reactedKind != ignore) 19: reactedKind as String?,
          if (emojiShortcode != ignore) 20: emojiShortcode as String?,
          if (emojiURL != ignore) 21: emojiURL as String?,
          if (findEvent != ignore) 22: findEvent as bool?,
          if (replyCount != ignore) 23: replyCount as int?,
          if (repostCount != ignore) 24: repostCount as int?,
          if (quoteRepostCount != ignore) 25: quoteRepostCount as int?,
          if (reactionCount != ignore) 26: reactionCount as int?,
          if (zapCount != ignore) 27: zapCount as int?,
          if (zapAmount != ignore) 28: zapAmount as int?,
          if (replyCountByMe != ignore) 29: replyCountByMe as int?,
          if (repostCountByMe != ignore) 30: repostCountByMe as int?,
          if (quoteRepostCountByMe != ignore) 31: quoteRepostCountByMe as int?,
          if (reactionCountByMe != ignore) 32: reactionCountByMe as int?,
          if (zapCountByMe != ignore) 33: zapCountByMe as int?,
          if (zapAmountByMe != ignore) 34: zapAmountByMe as int?,
          if (rawEvent != ignore) 35: rawEvent as String?,
          if (lastUpdatedTimeString != ignore)
            41: lastUpdatedTimeString as String?,
          if (encodedNoteId != ignore) 42: encodedNoteId as String?,
        }) >
        0;
  }
}

sealed class _NoteDBISARUpdateAll {
  int call({
    required List<int> id,
    String? noteId,
    String? groupId,
    String? author,
    int? createAt,
    String? content,
    String? root,
    String? rootRelay,
    String? reply,
    String? replyRelay,
    bool? private,
    bool? read,
    String? warning,
    String? repostId,
    String? quoteRepostId,
    String? reactedId,
    String? reactedKind,
    String? emojiShortcode,
    String? emojiURL,
    bool? findEvent,
    int? replyCount,
    int? repostCount,
    int? quoteRepostCount,
    int? reactionCount,
    int? zapCount,
    int? zapAmount,
    int? replyCountByMe,
    int? repostCountByMe,
    int? quoteRepostCountByMe,
    int? reactionCountByMe,
    int? zapCountByMe,
    int? zapAmountByMe,
    String? rawEvent,
    String? lastUpdatedTimeString,
    String? encodedNoteId,
  });
}

class _NoteDBISARUpdateAllImpl implements _NoteDBISARUpdateAll {
  const _NoteDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, NoteDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? noteId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createAt = ignore,
    Object? content = ignore,
    Object? root = ignore,
    Object? rootRelay = ignore,
    Object? reply = ignore,
    Object? replyRelay = ignore,
    Object? private = ignore,
    Object? read = ignore,
    Object? warning = ignore,
    Object? repostId = ignore,
    Object? quoteRepostId = ignore,
    Object? reactedId = ignore,
    Object? reactedKind = ignore,
    Object? emojiShortcode = ignore,
    Object? emojiURL = ignore,
    Object? findEvent = ignore,
    Object? replyCount = ignore,
    Object? repostCount = ignore,
    Object? quoteRepostCount = ignore,
    Object? reactionCount = ignore,
    Object? zapCount = ignore,
    Object? zapAmount = ignore,
    Object? replyCountByMe = ignore,
    Object? repostCountByMe = ignore,
    Object? quoteRepostCountByMe = ignore,
    Object? reactionCountByMe = ignore,
    Object? zapCountByMe = ignore,
    Object? zapAmountByMe = ignore,
    Object? rawEvent = ignore,
    Object? lastUpdatedTimeString = ignore,
    Object? encodedNoteId = ignore,
  }) {
    return collection.updateProperties(id, {
      if (noteId != ignore) 1: noteId as String?,
      if (groupId != ignore) 2: groupId as String?,
      if (author != ignore) 3: author as String?,
      if (createAt != ignore) 4: createAt as int?,
      if (content != ignore) 5: content as String?,
      if (root != ignore) 6: root as String?,
      if (rootRelay != ignore) 7: rootRelay as String?,
      if (reply != ignore) 8: reply as String?,
      if (replyRelay != ignore) 9: replyRelay as String?,
      if (private != ignore) 13: private as bool?,
      if (read != ignore) 14: read as bool?,
      if (warning != ignore) 15: warning as String?,
      if (repostId != ignore) 16: repostId as String?,
      if (quoteRepostId != ignore) 17: quoteRepostId as String?,
      if (reactedId != ignore) 18: reactedId as String?,
      if (reactedKind != ignore) 19: reactedKind as String?,
      if (emojiShortcode != ignore) 20: emojiShortcode as String?,
      if (emojiURL != ignore) 21: emojiURL as String?,
      if (findEvent != ignore) 22: findEvent as bool?,
      if (replyCount != ignore) 23: replyCount as int?,
      if (repostCount != ignore) 24: repostCount as int?,
      if (quoteRepostCount != ignore) 25: quoteRepostCount as int?,
      if (reactionCount != ignore) 26: reactionCount as int?,
      if (zapCount != ignore) 27: zapCount as int?,
      if (zapAmount != ignore) 28: zapAmount as int?,
      if (replyCountByMe != ignore) 29: replyCountByMe as int?,
      if (repostCountByMe != ignore) 30: repostCountByMe as int?,
      if (quoteRepostCountByMe != ignore) 31: quoteRepostCountByMe as int?,
      if (reactionCountByMe != ignore) 32: reactionCountByMe as int?,
      if (zapCountByMe != ignore) 33: zapCountByMe as int?,
      if (zapAmountByMe != ignore) 34: zapAmountByMe as int?,
      if (rawEvent != ignore) 35: rawEvent as String?,
      if (lastUpdatedTimeString != ignore) 41: lastUpdatedTimeString as String?,
      if (encodedNoteId != ignore) 42: encodedNoteId as String?,
    });
  }
}

extension NoteDBISARUpdate on IsarCollection<int, NoteDBISAR> {
  _NoteDBISARUpdate get update => _NoteDBISARUpdateImpl(this);

  _NoteDBISARUpdateAll get updateAll => _NoteDBISARUpdateAllImpl(this);
}

sealed class _NoteDBISARQueryUpdate {
  int call({
    String? noteId,
    String? groupId,
    String? author,
    int? createAt,
    String? content,
    String? root,
    String? rootRelay,
    String? reply,
    String? replyRelay,
    bool? private,
    bool? read,
    String? warning,
    String? repostId,
    String? quoteRepostId,
    String? reactedId,
    String? reactedKind,
    String? emojiShortcode,
    String? emojiURL,
    bool? findEvent,
    int? replyCount,
    int? repostCount,
    int? quoteRepostCount,
    int? reactionCount,
    int? zapCount,
    int? zapAmount,
    int? replyCountByMe,
    int? repostCountByMe,
    int? quoteRepostCountByMe,
    int? reactionCountByMe,
    int? zapCountByMe,
    int? zapAmountByMe,
    String? rawEvent,
    String? lastUpdatedTimeString,
    String? encodedNoteId,
  });
}

class _NoteDBISARQueryUpdateImpl implements _NoteDBISARQueryUpdate {
  const _NoteDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<NoteDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? noteId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createAt = ignore,
    Object? content = ignore,
    Object? root = ignore,
    Object? rootRelay = ignore,
    Object? reply = ignore,
    Object? replyRelay = ignore,
    Object? private = ignore,
    Object? read = ignore,
    Object? warning = ignore,
    Object? repostId = ignore,
    Object? quoteRepostId = ignore,
    Object? reactedId = ignore,
    Object? reactedKind = ignore,
    Object? emojiShortcode = ignore,
    Object? emojiURL = ignore,
    Object? findEvent = ignore,
    Object? replyCount = ignore,
    Object? repostCount = ignore,
    Object? quoteRepostCount = ignore,
    Object? reactionCount = ignore,
    Object? zapCount = ignore,
    Object? zapAmount = ignore,
    Object? replyCountByMe = ignore,
    Object? repostCountByMe = ignore,
    Object? quoteRepostCountByMe = ignore,
    Object? reactionCountByMe = ignore,
    Object? zapCountByMe = ignore,
    Object? zapAmountByMe = ignore,
    Object? rawEvent = ignore,
    Object? lastUpdatedTimeString = ignore,
    Object? encodedNoteId = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (noteId != ignore) 1: noteId as String?,
      if (groupId != ignore) 2: groupId as String?,
      if (author != ignore) 3: author as String?,
      if (createAt != ignore) 4: createAt as int?,
      if (content != ignore) 5: content as String?,
      if (root != ignore) 6: root as String?,
      if (rootRelay != ignore) 7: rootRelay as String?,
      if (reply != ignore) 8: reply as String?,
      if (replyRelay != ignore) 9: replyRelay as String?,
      if (private != ignore) 13: private as bool?,
      if (read != ignore) 14: read as bool?,
      if (warning != ignore) 15: warning as String?,
      if (repostId != ignore) 16: repostId as String?,
      if (quoteRepostId != ignore) 17: quoteRepostId as String?,
      if (reactedId != ignore) 18: reactedId as String?,
      if (reactedKind != ignore) 19: reactedKind as String?,
      if (emojiShortcode != ignore) 20: emojiShortcode as String?,
      if (emojiURL != ignore) 21: emojiURL as String?,
      if (findEvent != ignore) 22: findEvent as bool?,
      if (replyCount != ignore) 23: replyCount as int?,
      if (repostCount != ignore) 24: repostCount as int?,
      if (quoteRepostCount != ignore) 25: quoteRepostCount as int?,
      if (reactionCount != ignore) 26: reactionCount as int?,
      if (zapCount != ignore) 27: zapCount as int?,
      if (zapAmount != ignore) 28: zapAmount as int?,
      if (replyCountByMe != ignore) 29: replyCountByMe as int?,
      if (repostCountByMe != ignore) 30: repostCountByMe as int?,
      if (quoteRepostCountByMe != ignore) 31: quoteRepostCountByMe as int?,
      if (reactionCountByMe != ignore) 32: reactionCountByMe as int?,
      if (zapCountByMe != ignore) 33: zapCountByMe as int?,
      if (zapAmountByMe != ignore) 34: zapAmountByMe as int?,
      if (rawEvent != ignore) 35: rawEvent as String?,
      if (lastUpdatedTimeString != ignore) 41: lastUpdatedTimeString as String?,
      if (encodedNoteId != ignore) 42: encodedNoteId as String?,
    });
  }
}

extension NoteDBISARQueryUpdate on IsarQuery<NoteDBISAR> {
  _NoteDBISARQueryUpdate get updateFirst =>
      _NoteDBISARQueryUpdateImpl(this, limit: 1);

  _NoteDBISARQueryUpdate get updateAll => _NoteDBISARQueryUpdateImpl(this);
}

class _NoteDBISARQueryBuilderUpdateImpl implements _NoteDBISARQueryUpdate {
  const _NoteDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<NoteDBISAR, NoteDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? noteId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createAt = ignore,
    Object? content = ignore,
    Object? root = ignore,
    Object? rootRelay = ignore,
    Object? reply = ignore,
    Object? replyRelay = ignore,
    Object? private = ignore,
    Object? read = ignore,
    Object? warning = ignore,
    Object? repostId = ignore,
    Object? quoteRepostId = ignore,
    Object? reactedId = ignore,
    Object? reactedKind = ignore,
    Object? emojiShortcode = ignore,
    Object? emojiURL = ignore,
    Object? findEvent = ignore,
    Object? replyCount = ignore,
    Object? repostCount = ignore,
    Object? quoteRepostCount = ignore,
    Object? reactionCount = ignore,
    Object? zapCount = ignore,
    Object? zapAmount = ignore,
    Object? replyCountByMe = ignore,
    Object? repostCountByMe = ignore,
    Object? quoteRepostCountByMe = ignore,
    Object? reactionCountByMe = ignore,
    Object? zapCountByMe = ignore,
    Object? zapAmountByMe = ignore,
    Object? rawEvent = ignore,
    Object? lastUpdatedTimeString = ignore,
    Object? encodedNoteId = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (noteId != ignore) 1: noteId as String?,
        if (groupId != ignore) 2: groupId as String?,
        if (author != ignore) 3: author as String?,
        if (createAt != ignore) 4: createAt as int?,
        if (content != ignore) 5: content as String?,
        if (root != ignore) 6: root as String?,
        if (rootRelay != ignore) 7: rootRelay as String?,
        if (reply != ignore) 8: reply as String?,
        if (replyRelay != ignore) 9: replyRelay as String?,
        if (private != ignore) 13: private as bool?,
        if (read != ignore) 14: read as bool?,
        if (warning != ignore) 15: warning as String?,
        if (repostId != ignore) 16: repostId as String?,
        if (quoteRepostId != ignore) 17: quoteRepostId as String?,
        if (reactedId != ignore) 18: reactedId as String?,
        if (reactedKind != ignore) 19: reactedKind as String?,
        if (emojiShortcode != ignore) 20: emojiShortcode as String?,
        if (emojiURL != ignore) 21: emojiURL as String?,
        if (findEvent != ignore) 22: findEvent as bool?,
        if (replyCount != ignore) 23: replyCount as int?,
        if (repostCount != ignore) 24: repostCount as int?,
        if (quoteRepostCount != ignore) 25: quoteRepostCount as int?,
        if (reactionCount != ignore) 26: reactionCount as int?,
        if (zapCount != ignore) 27: zapCount as int?,
        if (zapAmount != ignore) 28: zapAmount as int?,
        if (replyCountByMe != ignore) 29: replyCountByMe as int?,
        if (repostCountByMe != ignore) 30: repostCountByMe as int?,
        if (quoteRepostCountByMe != ignore) 31: quoteRepostCountByMe as int?,
        if (reactionCountByMe != ignore) 32: reactionCountByMe as int?,
        if (zapCountByMe != ignore) 33: zapCountByMe as int?,
        if (zapAmountByMe != ignore) 34: zapAmountByMe as int?,
        if (rawEvent != ignore) 35: rawEvent as String?,
        if (lastUpdatedTimeString != ignore)
          41: lastUpdatedTimeString as String?,
        if (encodedNoteId != ignore) 42: encodedNoteId as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension NoteDBISARQueryBuilderUpdate
    on QueryBuilder<NoteDBISAR, NoteDBISAR, QOperations> {
  _NoteDBISARQueryUpdate get updateFirst =>
      _NoteDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _NoteDBISARQueryUpdate get updateAll =>
      _NoteDBISARQueryBuilderUpdateImpl(this);
}

extension NoteDBISARQueryFilter
    on QueryBuilder<NoteDBISAR, NoteDBISAR, QFilterCondition> {
  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      noteIdGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      noteIdLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> noteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      noteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> groupIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      groupIdGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      groupIdGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> groupIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      groupIdLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> groupIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> groupIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> groupIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> groupIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> groupIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> groupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      groupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      authorGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      authorLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> authorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      authorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> createAtEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      createAtGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      createAtGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> createAtLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      createAtLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> createAtBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      contentGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      contentGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> contentLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      contentLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 6,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootRelayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootRelayIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootRelayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootRelayGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootRelayGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootRelayLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootRelayLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootRelayBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootRelayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootRelayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootRelayContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rootRelayMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 7,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootRelayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rootRelayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 8,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 8,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyRelayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyRelayBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyRelayMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 9,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyRelayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> mentionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 10,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsIsEmpty() {
    return not().group(
      (q) => q.mentionsIsNull().or().mentionsIsNotEmpty(),
    );
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      mentionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 10, value: null),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> pTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> pTagsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 11,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 11,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> pTagsIsEmpty() {
    return not().group(
      (q) => q.pTagsIsNull().or().pTagsIsNotEmpty(),
    );
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      pTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 11, value: null),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> hashTagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 12,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 12,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsIsEmpty() {
    return not().group(
      (q) => q.hashTagsIsNull().or().hashTagsIsNotEmpty(),
    );
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      hashTagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 12, value: null),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> privateEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> readEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      warningIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      warningGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      warningGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      warningLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 15,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 15,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 15,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> warningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      warningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> repostIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> repostIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostIdGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> repostIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostIdLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> repostIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 16,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> repostIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> repostIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> repostIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 16,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 17,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 17,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 17,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 17,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 18));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 18));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> reactedIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedIdGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> reactedIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedIdLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> reactedIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 18,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> reactedIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> reactedIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> reactedIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 18,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 18,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 18,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 19));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 19));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 19,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 19,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 19,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 19,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactedKindIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 19,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 20));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 20));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 20,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 20,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 20,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiShortcodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 20,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> emojiURLIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 21));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiURLIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 21));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> emojiURLEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiURLGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiURLGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> emojiURLLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiURLLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> emojiURLBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 21,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiURLStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> emojiURLEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> emojiURLContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> emojiURLMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 21,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiURLIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 21,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      emojiURLIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 21,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> findEventEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 22,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyCountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 23,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> replyCountBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 23,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 24,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 24,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 25,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 25,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 26,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 26,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> zapCountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> zapCountLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 27,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> zapCountBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 27,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> zapAmountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> zapAmountLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 28,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> zapAmountBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 28,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountByMeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountByMeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountByMeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountByMeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountByMeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 29,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyCountByMeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 29,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountByMeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 30,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountByMeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 30,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountByMeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 30,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountByMeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 30,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountByMeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 30,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostCountByMeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 30,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountByMeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 31,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountByMeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 31,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountByMeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 31,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountByMeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 31,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountByMeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 31,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostCountByMeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 31,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountByMeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 32,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountByMeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 32,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountByMeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 32,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountByMeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 32,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountByMeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 32,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionCountByMeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 32,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountByMeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 33,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountByMeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 33,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountByMeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 33,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountByMeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 33,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountByMeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 33,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapCountByMeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 33,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountByMeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountByMeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountByMeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountByMeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountByMeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 34,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapAmountByMeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 34,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rawEventIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 35));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rawEventIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 35));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rawEventEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 35,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rawEventGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 35,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rawEventGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 35,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rawEventLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 35,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rawEventLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 35,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rawEventBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 35,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rawEventStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 35,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rawEventEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 35,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rawEventContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 35,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition> rawEventMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 35,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rawEventIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 35,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      rawEventIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 35,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 36));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 36));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 36,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 36,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 36,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 36,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 36,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 36,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 36,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 36,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 36,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 36,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 36,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 36,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsIsEmpty() {
    return not().group(
      (q) => q.replyEventIdsIsNull().or().replyEventIdsIsNotEmpty(),
    );
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      replyEventIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 36, value: null),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 37));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 37));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 37,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 37,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 37,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 37,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 37,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 37,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 37,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 37,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 37,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 37,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 37,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 37,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsIsEmpty() {
    return not().group(
      (q) => q.repostEventIdsIsNull().or().repostEventIdsIsNotEmpty(),
    );
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      repostEventIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 37, value: null),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 38));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 38));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 38,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 38,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 38,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 38,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 38,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 38,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 38,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 38,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 38,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 38,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 38,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 38,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsIsEmpty() {
    return not().group(
      (q) => q.quoteRepostEventIdsIsNull().or().quoteRepostEventIdsIsNotEmpty(),
    );
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      quoteRepostEventIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 38, value: null),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 39));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 39));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 39,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 39,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 39,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 39,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 39,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 39,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 39,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 39,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 39,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 39,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 39,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 39,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsIsEmpty() {
    return not().group(
      (q) => q.reactionEventIdsIsNull().or().reactionEventIdsIsNotEmpty(),
    );
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      reactionEventIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 39, value: null),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 40));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 40));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 40,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 40,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 40,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 40,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 40,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 40,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 40,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 40,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 40,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 40,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 40,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 40,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsIsEmpty() {
    return not().group(
      (q) => q.zapEventIdsIsNull().or().zapEventIdsIsNotEmpty(),
    );
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      zapEventIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 40, value: null),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 41));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 41));
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 41,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 41,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 41,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 41,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 41,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 41,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 41,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 41,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 41,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 41,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 41,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      lastUpdatedTimeStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 41,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 42,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 42,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 42,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 42,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 42,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 42,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 42,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 42,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 42,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 42,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 42,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterFilterCondition>
      encodedNoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 42,
          value: '',
        ),
      );
    });
  }
}

extension NoteDBISARQueryObject
    on QueryBuilder<NoteDBISAR, NoteDBISAR, QFilterCondition> {}

extension NoteDBISARQuerySortBy
    on QueryBuilder<NoteDBISAR, NoteDBISAR, QSortBy> {
  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByNoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByNoteIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByGroupIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByAuthorDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByContentDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRoot(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRootDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRootRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRootRelayDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReply(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReplyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReplyRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReplyRelayDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByPrivateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByWarning(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        15,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByWarningDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        15,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRepostId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRepostIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByQuoteRepostId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        17,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByQuoteRepostIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        17,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReactedId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        18,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReactedIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        18,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReactedKind(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        19,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReactedKindDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        19,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByEmojiShortcode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        20,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByEmojiShortcodeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        20,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByEmojiURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        21,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByEmojiURLDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        21,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByFindEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByFindEventDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReplyCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReplyCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRepostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRepostCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByQuoteRepostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      sortByQuoteRepostCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReactionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(26);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReactionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(26, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByZapCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(27);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByZapCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(27, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByZapAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(28);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByZapAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(28, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReplyCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(29);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      sortByReplyCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(29, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRepostCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(30);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      sortByRepostCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(30, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      sortByQuoteRepostCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(31);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      sortByQuoteRepostCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(31, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByReactionCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(32);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      sortByReactionCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(32, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByZapCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(33);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByZapCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(33, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByZapAmountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(34);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByZapAmountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(34, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRawEvent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        35,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByRawEventDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        35,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      sortByLastUpdatedTimeString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        41,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      sortByLastUpdatedTimeStringDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        41,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByEncodedNoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        42,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> sortByEncodedNoteIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        42,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension NoteDBISARQuerySortThenBy
    on QueryBuilder<NoteDBISAR, NoteDBISAR, QSortThenBy> {
  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByNoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByNoteIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByGroupIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByAuthorDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByContentDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRoot(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRootDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRootRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRootRelayDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReply(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReplyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReplyRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReplyRelayDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByPrivateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByWarning(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByWarningDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRepostId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRepostIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByQuoteRepostId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByQuoteRepostIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReactedId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReactedIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReactedKind(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReactedKindDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByEmojiShortcode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByEmojiShortcodeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByEmojiURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByEmojiURLDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByFindEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByFindEventDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReplyCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReplyCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRepostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRepostCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByQuoteRepostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      thenByQuoteRepostCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReactionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(26);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReactionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(26, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByZapCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(27);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByZapCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(27, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByZapAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(28);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByZapAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(28, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReplyCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(29);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      thenByReplyCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(29, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRepostCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(30);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      thenByRepostCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(30, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      thenByQuoteRepostCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(31);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      thenByQuoteRepostCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(31, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByReactionCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(32);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      thenByReactionCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(32, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByZapCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(33);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByZapCountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(33, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByZapAmountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(34);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByZapAmountByMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(34, sort: Sort.desc);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRawEvent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(35, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByRawEventDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(35, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      thenByLastUpdatedTimeString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(41, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy>
      thenByLastUpdatedTimeStringDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(41, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByEncodedNoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(42, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterSortBy> thenByEncodedNoteIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(42, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension NoteDBISARQueryWhereDistinct
    on QueryBuilder<NoteDBISAR, NoteDBISAR, QDistinct> {
  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByNoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByRoot(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByRootRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByReply(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByReplyRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByMentions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByPTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByHashTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByWarning(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByRepostId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByQuoteRepostId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByReactedId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByReactedKind(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(19, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByEmojiShortcode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(20, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByEmojiURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(21, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByFindEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(22);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByReplyCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(23);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByRepostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(24);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByQuoteRepostCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(25);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByReactionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(26);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByZapCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(27);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByZapAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(28);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByReplyCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(29);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByRepostCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(30);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByQuoteRepostCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(31);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByReactionCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(32);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByZapCountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(33);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByZapAmountByMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(34);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByRawEvent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(35, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByReplyEventIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(36);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByRepostEventIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(37);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByQuoteRepostEventIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(38);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByReactionEventIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(39);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByZapEventIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(40);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct>
      distinctByLastUpdatedTimeString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(41, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NoteDBISAR, NoteDBISAR, QAfterDistinct> distinctByEncodedNoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(42, caseSensitive: caseSensitive);
    });
  }
}

extension NoteDBISARQueryProperty1
    on QueryBuilder<NoteDBISAR, NoteDBISAR, QProperty> {
  QueryBuilder<NoteDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<NoteDBISAR, String, QAfterProperty> noteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<NoteDBISAR, String, QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<NoteDBISAR, String, QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<NoteDBISAR, String, QAfterProperty> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> rootProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> rootRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> replyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> replyRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<NoteDBISAR, List<String>?, QAfterProperty> mentionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<NoteDBISAR, List<String>?, QAfterProperty> pTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<NoteDBISAR, List<String>?, QAfterProperty> hashTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<NoteDBISAR, bool, QAfterProperty> privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<NoteDBISAR, bool, QAfterProperty> readProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> warningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> repostIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> quoteRepostIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> reactedIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> reactedKindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> emojiShortcodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> emojiURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<NoteDBISAR, bool, QAfterProperty> findEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> replyCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> repostCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> quoteRepostCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> reactionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> zapCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> zapAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> replyCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> repostCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(30);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> quoteRepostCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(31);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> reactionCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(32);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> zapCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(33);
    });
  }

  QueryBuilder<NoteDBISAR, int, QAfterProperty> zapAmountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(34);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty> rawEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(35);
    });
  }

  QueryBuilder<NoteDBISAR, List<String>?, QAfterProperty>
      replyEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(36);
    });
  }

  QueryBuilder<NoteDBISAR, List<String>?, QAfterProperty>
      repostEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(37);
    });
  }

  QueryBuilder<NoteDBISAR, List<String>?, QAfterProperty>
      quoteRepostEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(38);
    });
  }

  QueryBuilder<NoteDBISAR, List<String>?, QAfterProperty>
      reactionEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(39);
    });
  }

  QueryBuilder<NoteDBISAR, List<String>?, QAfterProperty>
      zapEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(40);
    });
  }

  QueryBuilder<NoteDBISAR, String?, QAfterProperty>
      lastUpdatedTimeStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(41);
    });
  }

  QueryBuilder<NoteDBISAR, String, QAfterProperty> encodedNoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(42);
    });
  }
}

extension NoteDBISARQueryProperty2<R>
    on QueryBuilder<NoteDBISAR, R, QAfterProperty> {
  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String), QAfterProperty> noteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String), QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String), QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String), QAfterProperty> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> rootProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> rootRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> replyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> replyRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<NoteDBISAR, (R, List<String>?), QAfterProperty>
      mentionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<NoteDBISAR, (R, List<String>?), QAfterProperty> pTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<NoteDBISAR, (R, List<String>?), QAfterProperty>
      hashTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<NoteDBISAR, (R, bool), QAfterProperty> privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<NoteDBISAR, (R, bool), QAfterProperty> readProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> warningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> repostIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty>
      quoteRepostIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> reactedIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> reactedKindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty>
      emojiShortcodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> emojiURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<NoteDBISAR, (R, bool), QAfterProperty> findEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> replyCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> repostCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty>
      quoteRepostCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> reactionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> zapCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> zapAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> replyCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> repostCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(30);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty>
      quoteRepostCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(31);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty>
      reactionCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(32);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> zapCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(33);
    });
  }

  QueryBuilder<NoteDBISAR, (R, int), QAfterProperty> zapAmountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(34);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty> rawEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(35);
    });
  }

  QueryBuilder<NoteDBISAR, (R, List<String>?), QAfterProperty>
      replyEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(36);
    });
  }

  QueryBuilder<NoteDBISAR, (R, List<String>?), QAfterProperty>
      repostEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(37);
    });
  }

  QueryBuilder<NoteDBISAR, (R, List<String>?), QAfterProperty>
      quoteRepostEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(38);
    });
  }

  QueryBuilder<NoteDBISAR, (R, List<String>?), QAfterProperty>
      reactionEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(39);
    });
  }

  QueryBuilder<NoteDBISAR, (R, List<String>?), QAfterProperty>
      zapEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(40);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String?), QAfterProperty>
      lastUpdatedTimeStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(41);
    });
  }

  QueryBuilder<NoteDBISAR, (R, String), QAfterProperty>
      encodedNoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(42);
    });
  }
}

extension NoteDBISARQueryProperty3<R1, R2>
    on QueryBuilder<NoteDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String), QOperations> noteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String), QOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String), QOperations> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String), QOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations> rootProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations> rootRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations> replyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations>
      replyRelayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, List<String>?), QOperations>
      mentionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, List<String>?), QOperations>
      pTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, List<String>?), QOperations>
      hashTagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, bool), QOperations> privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, bool), QOperations> readProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations> warningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations> repostIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations>
      quoteRepostIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations> reactedIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations>
      reactedKindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations>
      emojiShortcodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations> emojiURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, bool), QOperations> findEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> replyCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> repostCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations>
      quoteRepostCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> reactionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(26);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> zapCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(27);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> zapAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(28);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations>
      replyCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(29);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations>
      repostCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(30);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations>
      quoteRepostCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(31);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations>
      reactionCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(32);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> zapCountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(33);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, int), QOperations> zapAmountByMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(34);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations> rawEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(35);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, List<String>?), QOperations>
      replyEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(36);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, List<String>?), QOperations>
      repostEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(37);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, List<String>?), QOperations>
      quoteRepostEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(38);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, List<String>?), QOperations>
      reactionEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(39);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, List<String>?), QOperations>
      zapEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(40);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String?), QOperations>
      lastUpdatedTimeStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(41);
    });
  }

  QueryBuilder<NoteDBISAR, (R1, R2, String), QOperations>
      encodedNoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(42);
    });
  }
}
