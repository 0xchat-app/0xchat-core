// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messageDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetMessageDBISARCollection on Isar {
  IsarCollection<int, MessageDBISAR> get messageDBISARs => this.collection();
}

const MessageDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'MessageDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'messageId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'sender',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'receiver',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'groupId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'sessionId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'kind',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'tags',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'content',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'createTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'read',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'replyId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'decryptContent',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'type',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'status',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'reportList',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'plaintEvent',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'chatType',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'subType',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'previewData',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'expiration',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'decryptSecret',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'decryptNonce',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'decryptAlgo',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'reactionEventIds',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'zapEventIds',
        type: IsarType.stringList,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'messageId',
        properties: [
          "messageId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, MessageDBISAR>(
    serialize: serializeMessageDBISAR,
    deserialize: deserializeMessageDBISAR,
    deserializeProperty: deserializeMessageDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeMessageDBISAR(IsarWriter writer, MessageDBISAR object) {
  IsarCore.writeString(writer, 1, object.messageId);
  IsarCore.writeString(writer, 2, object.sender);
  IsarCore.writeString(writer, 3, object.receiver);
  IsarCore.writeString(writer, 4, object.groupId);
  IsarCore.writeString(writer, 5, object.sessionId);
  IsarCore.writeLong(writer, 6, object.kind);
  IsarCore.writeString(writer, 7, object.tags);
  IsarCore.writeString(writer, 8, object.content);
  IsarCore.writeLong(writer, 9, object.createTime);
  IsarCore.writeBool(writer, 10, object.read);
  IsarCore.writeString(writer, 11, object.replyId);
  IsarCore.writeString(writer, 12, object.decryptContent);
  IsarCore.writeString(writer, 13, object.type);
  IsarCore.writeLong(writer, 14, object.status ?? -9223372036854775808);
  {
    final list = object.reportList;
    if (list == null) {
      IsarCore.writeNull(writer, 15);
    } else {
      final listWriter = IsarCore.beginList(writer, 15, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  IsarCore.writeString(writer, 16, object.plaintEvent);
  IsarCore.writeLong(writer, 17, object.chatType ?? -9223372036854775808);
  {
    final value = object.subType;
    if (value == null) {
      IsarCore.writeNull(writer, 18);
    } else {
      IsarCore.writeString(writer, 18, value);
    }
  }
  {
    final value = object.previewData;
    if (value == null) {
      IsarCore.writeNull(writer, 19);
    } else {
      IsarCore.writeString(writer, 19, value);
    }
  }
  IsarCore.writeLong(writer, 20, object.expiration ?? -9223372036854775808);
  {
    final value = object.decryptSecret;
    if (value == null) {
      IsarCore.writeNull(writer, 21);
    } else {
      IsarCore.writeString(writer, 21, value);
    }
  }
  {
    final value = object.decryptNonce;
    if (value == null) {
      IsarCore.writeNull(writer, 22);
    } else {
      IsarCore.writeString(writer, 22, value);
    }
  }
  {
    final value = object.decryptAlgo;
    if (value == null) {
      IsarCore.writeNull(writer, 23);
    } else {
      IsarCore.writeString(writer, 23, value);
    }
  }
  {
    final list = object.reactionEventIds;
    if (list == null) {
      IsarCore.writeNull(writer, 24);
    } else {
      final listWriter = IsarCore.beginList(writer, 24, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.zapEventIds;
    if (list == null) {
      IsarCore.writeNull(writer, 25);
    } else {
      final listWriter = IsarCore.beginList(writer, 25, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  return object.id;
}

@isarProtected
MessageDBISAR deserializeMessageDBISAR(IsarReader reader) {
  final String _messageId;
  _messageId = IsarCore.readString(reader, 1) ?? '';
  final String _sender;
  _sender = IsarCore.readString(reader, 2) ?? '';
  final String _receiver;
  _receiver = IsarCore.readString(reader, 3) ?? '';
  final String _groupId;
  _groupId = IsarCore.readString(reader, 4) ?? '';
  final String _sessionId;
  _sessionId = IsarCore.readString(reader, 5) ?? '';
  final int _kind;
  {
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      _kind = 0;
    } else {
      _kind = value;
    }
  }
  final String _tags;
  _tags = IsarCore.readString(reader, 7) ?? '';
  final String _content;
  _content = IsarCore.readString(reader, 8) ?? '';
  final int _createTime;
  {
    final value = IsarCore.readLong(reader, 9);
    if (value == -9223372036854775808) {
      _createTime = 0;
    } else {
      _createTime = value;
    }
  }
  final bool _read;
  _read = IsarCore.readBool(reader, 10);
  final String _replyId;
  _replyId = IsarCore.readString(reader, 11) ?? '';
  final String _decryptContent;
  _decryptContent = IsarCore.readString(reader, 12) ?? '';
  final String _type;
  _type = IsarCore.readString(reader, 13) ?? 'text';
  final int? _status;
  {
    final value = IsarCore.readLong(reader, 14);
    if (value == -9223372036854775808) {
      _status = 1;
    } else {
      _status = value;
    }
  }
  final String _plaintEvent;
  _plaintEvent = IsarCore.readString(reader, 16) ?? '';
  final int? _chatType;
  {
    final value = IsarCore.readLong(reader, 17);
    if (value == -9223372036854775808) {
      _chatType = null;
    } else {
      _chatType = value;
    }
  }
  final String? _subType;
  _subType = IsarCore.readString(reader, 18);
  final String? _previewData;
  _previewData = IsarCore.readString(reader, 19);
  final int? _expiration;
  {
    final value = IsarCore.readLong(reader, 20);
    if (value == -9223372036854775808) {
      _expiration = null;
    } else {
      _expiration = value;
    }
  }
  final String? _decryptSecret;
  _decryptSecret = IsarCore.readString(reader, 21);
  final String? _decryptNonce;
  _decryptNonce = IsarCore.readString(reader, 22);
  final String? _decryptAlgo;
  _decryptAlgo = IsarCore.readString(reader, 23);
  final List<String>? _reactionEventIds;
  {
    final length = IsarCore.readList(reader, 24, IsarCore.readerPtrPtr);
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
    final length = IsarCore.readList(reader, 25, IsarCore.readerPtrPtr);
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
  final object = MessageDBISAR(
    messageId: _messageId,
    sender: _sender,
    receiver: _receiver,
    groupId: _groupId,
    sessionId: _sessionId,
    kind: _kind,
    tags: _tags,
    content: _content,
    createTime: _createTime,
    read: _read,
    replyId: _replyId,
    decryptContent: _decryptContent,
    type: _type,
    status: _status,
    plaintEvent: _plaintEvent,
    chatType: _chatType,
    subType: _subType,
    previewData: _previewData,
    expiration: _expiration,
    decryptSecret: _decryptSecret,
    decryptNonce: _decryptNonce,
    decryptAlgo: _decryptAlgo,
    reactionEventIds: _reactionEventIds,
    zapEventIds: _zapEventIds,
  );
  object.id = IsarCore.readId(reader);
  {
    final length = IsarCore.readList(reader, 15, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        object.reportList = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        object.reportList = list;
      }
    }
  }
  return object;
}

@isarProtected
dynamic deserializeMessageDBISARProp(IsarReader reader, int property) {
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
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      {
        final value = IsarCore.readLong(reader, 6);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      return IsarCore.readString(reader, 8) ?? '';
    case 9:
      {
        final value = IsarCore.readLong(reader, 9);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 10:
      return IsarCore.readBool(reader, 10);
    case 11:
      return IsarCore.readString(reader, 11) ?? '';
    case 12:
      return IsarCore.readString(reader, 12) ?? '';
    case 13:
      return IsarCore.readString(reader, 13) ?? 'text';
    case 14:
      {
        final value = IsarCore.readLong(reader, 14);
        if (value == -9223372036854775808) {
          return 1;
        } else {
          return value;
        }
      }
    case 15:
      {
        final length = IsarCore.readList(reader, 15, IsarCore.readerPtrPtr);
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
    case 16:
      return IsarCore.readString(reader, 16) ?? '';
    case 17:
      {
        final value = IsarCore.readLong(reader, 17);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return value;
        }
      }
    case 18:
      return IsarCore.readString(reader, 18);
    case 19:
      return IsarCore.readString(reader, 19);
    case 20:
      {
        final value = IsarCore.readLong(reader, 20);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return value;
        }
      }
    case 21:
      return IsarCore.readString(reader, 21);
    case 22:
      return IsarCore.readString(reader, 22);
    case 23:
      return IsarCore.readString(reader, 23);
    case 24:
      {
        final length = IsarCore.readList(reader, 24, IsarCore.readerPtrPtr);
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
    case 25:
      {
        final length = IsarCore.readList(reader, 25, IsarCore.readerPtrPtr);
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
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _MessageDBISARUpdate {
  bool call({
    required int id,
    String? messageId,
    String? sender,
    String? receiver,
    String? groupId,
    String? sessionId,
    int? kind,
    String? tags,
    String? content,
    int? createTime,
    bool? read,
    String? replyId,
    String? decryptContent,
    String? type,
    int? status,
    String? plaintEvent,
    int? chatType,
    String? subType,
    String? previewData,
    int? expiration,
    String? decryptSecret,
    String? decryptNonce,
    String? decryptAlgo,
  });
}

class _MessageDBISARUpdateImpl implements _MessageDBISARUpdate {
  const _MessageDBISARUpdateImpl(this.collection);

  final IsarCollection<int, MessageDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? messageId = ignore,
    Object? sender = ignore,
    Object? receiver = ignore,
    Object? groupId = ignore,
    Object? sessionId = ignore,
    Object? kind = ignore,
    Object? tags = ignore,
    Object? content = ignore,
    Object? createTime = ignore,
    Object? read = ignore,
    Object? replyId = ignore,
    Object? decryptContent = ignore,
    Object? type = ignore,
    Object? status = ignore,
    Object? plaintEvent = ignore,
    Object? chatType = ignore,
    Object? subType = ignore,
    Object? previewData = ignore,
    Object? expiration = ignore,
    Object? decryptSecret = ignore,
    Object? decryptNonce = ignore,
    Object? decryptAlgo = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (messageId != ignore) 1: messageId as String?,
          if (sender != ignore) 2: sender as String?,
          if (receiver != ignore) 3: receiver as String?,
          if (groupId != ignore) 4: groupId as String?,
          if (sessionId != ignore) 5: sessionId as String?,
          if (kind != ignore) 6: kind as int?,
          if (tags != ignore) 7: tags as String?,
          if (content != ignore) 8: content as String?,
          if (createTime != ignore) 9: createTime as int?,
          if (read != ignore) 10: read as bool?,
          if (replyId != ignore) 11: replyId as String?,
          if (decryptContent != ignore) 12: decryptContent as String?,
          if (type != ignore) 13: type as String?,
          if (status != ignore) 14: status as int?,
          if (plaintEvent != ignore) 16: plaintEvent as String?,
          if (chatType != ignore) 17: chatType as int?,
          if (subType != ignore) 18: subType as String?,
          if (previewData != ignore) 19: previewData as String?,
          if (expiration != ignore) 20: expiration as int?,
          if (decryptSecret != ignore) 21: decryptSecret as String?,
          if (decryptNonce != ignore) 22: decryptNonce as String?,
          if (decryptAlgo != ignore) 23: decryptAlgo as String?,
        }) >
        0;
  }
}

sealed class _MessageDBISARUpdateAll {
  int call({
    required List<int> id,
    String? messageId,
    String? sender,
    String? receiver,
    String? groupId,
    String? sessionId,
    int? kind,
    String? tags,
    String? content,
    int? createTime,
    bool? read,
    String? replyId,
    String? decryptContent,
    String? type,
    int? status,
    String? plaintEvent,
    int? chatType,
    String? subType,
    String? previewData,
    int? expiration,
    String? decryptSecret,
    String? decryptNonce,
    String? decryptAlgo,
  });
}

class _MessageDBISARUpdateAllImpl implements _MessageDBISARUpdateAll {
  const _MessageDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, MessageDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? messageId = ignore,
    Object? sender = ignore,
    Object? receiver = ignore,
    Object? groupId = ignore,
    Object? sessionId = ignore,
    Object? kind = ignore,
    Object? tags = ignore,
    Object? content = ignore,
    Object? createTime = ignore,
    Object? read = ignore,
    Object? replyId = ignore,
    Object? decryptContent = ignore,
    Object? type = ignore,
    Object? status = ignore,
    Object? plaintEvent = ignore,
    Object? chatType = ignore,
    Object? subType = ignore,
    Object? previewData = ignore,
    Object? expiration = ignore,
    Object? decryptSecret = ignore,
    Object? decryptNonce = ignore,
    Object? decryptAlgo = ignore,
  }) {
    return collection.updateProperties(id, {
      if (messageId != ignore) 1: messageId as String?,
      if (sender != ignore) 2: sender as String?,
      if (receiver != ignore) 3: receiver as String?,
      if (groupId != ignore) 4: groupId as String?,
      if (sessionId != ignore) 5: sessionId as String?,
      if (kind != ignore) 6: kind as int?,
      if (tags != ignore) 7: tags as String?,
      if (content != ignore) 8: content as String?,
      if (createTime != ignore) 9: createTime as int?,
      if (read != ignore) 10: read as bool?,
      if (replyId != ignore) 11: replyId as String?,
      if (decryptContent != ignore) 12: decryptContent as String?,
      if (type != ignore) 13: type as String?,
      if (status != ignore) 14: status as int?,
      if (plaintEvent != ignore) 16: plaintEvent as String?,
      if (chatType != ignore) 17: chatType as int?,
      if (subType != ignore) 18: subType as String?,
      if (previewData != ignore) 19: previewData as String?,
      if (expiration != ignore) 20: expiration as int?,
      if (decryptSecret != ignore) 21: decryptSecret as String?,
      if (decryptNonce != ignore) 22: decryptNonce as String?,
      if (decryptAlgo != ignore) 23: decryptAlgo as String?,
    });
  }
}

extension MessageDBISARUpdate on IsarCollection<int, MessageDBISAR> {
  _MessageDBISARUpdate get update => _MessageDBISARUpdateImpl(this);

  _MessageDBISARUpdateAll get updateAll => _MessageDBISARUpdateAllImpl(this);
}

sealed class _MessageDBISARQueryUpdate {
  int call({
    String? messageId,
    String? sender,
    String? receiver,
    String? groupId,
    String? sessionId,
    int? kind,
    String? tags,
    String? content,
    int? createTime,
    bool? read,
    String? replyId,
    String? decryptContent,
    String? type,
    int? status,
    String? plaintEvent,
    int? chatType,
    String? subType,
    String? previewData,
    int? expiration,
    String? decryptSecret,
    String? decryptNonce,
    String? decryptAlgo,
  });
}

class _MessageDBISARQueryUpdateImpl implements _MessageDBISARQueryUpdate {
  const _MessageDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<MessageDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? messageId = ignore,
    Object? sender = ignore,
    Object? receiver = ignore,
    Object? groupId = ignore,
    Object? sessionId = ignore,
    Object? kind = ignore,
    Object? tags = ignore,
    Object? content = ignore,
    Object? createTime = ignore,
    Object? read = ignore,
    Object? replyId = ignore,
    Object? decryptContent = ignore,
    Object? type = ignore,
    Object? status = ignore,
    Object? plaintEvent = ignore,
    Object? chatType = ignore,
    Object? subType = ignore,
    Object? previewData = ignore,
    Object? expiration = ignore,
    Object? decryptSecret = ignore,
    Object? decryptNonce = ignore,
    Object? decryptAlgo = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (messageId != ignore) 1: messageId as String?,
      if (sender != ignore) 2: sender as String?,
      if (receiver != ignore) 3: receiver as String?,
      if (groupId != ignore) 4: groupId as String?,
      if (sessionId != ignore) 5: sessionId as String?,
      if (kind != ignore) 6: kind as int?,
      if (tags != ignore) 7: tags as String?,
      if (content != ignore) 8: content as String?,
      if (createTime != ignore) 9: createTime as int?,
      if (read != ignore) 10: read as bool?,
      if (replyId != ignore) 11: replyId as String?,
      if (decryptContent != ignore) 12: decryptContent as String?,
      if (type != ignore) 13: type as String?,
      if (status != ignore) 14: status as int?,
      if (plaintEvent != ignore) 16: plaintEvent as String?,
      if (chatType != ignore) 17: chatType as int?,
      if (subType != ignore) 18: subType as String?,
      if (previewData != ignore) 19: previewData as String?,
      if (expiration != ignore) 20: expiration as int?,
      if (decryptSecret != ignore) 21: decryptSecret as String?,
      if (decryptNonce != ignore) 22: decryptNonce as String?,
      if (decryptAlgo != ignore) 23: decryptAlgo as String?,
    });
  }
}

extension MessageDBISARQueryUpdate on IsarQuery<MessageDBISAR> {
  _MessageDBISARQueryUpdate get updateFirst =>
      _MessageDBISARQueryUpdateImpl(this, limit: 1);

  _MessageDBISARQueryUpdate get updateAll =>
      _MessageDBISARQueryUpdateImpl(this);
}

class _MessageDBISARQueryBuilderUpdateImpl
    implements _MessageDBISARQueryUpdate {
  const _MessageDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<MessageDBISAR, MessageDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? messageId = ignore,
    Object? sender = ignore,
    Object? receiver = ignore,
    Object? groupId = ignore,
    Object? sessionId = ignore,
    Object? kind = ignore,
    Object? tags = ignore,
    Object? content = ignore,
    Object? createTime = ignore,
    Object? read = ignore,
    Object? replyId = ignore,
    Object? decryptContent = ignore,
    Object? type = ignore,
    Object? status = ignore,
    Object? plaintEvent = ignore,
    Object? chatType = ignore,
    Object? subType = ignore,
    Object? previewData = ignore,
    Object? expiration = ignore,
    Object? decryptSecret = ignore,
    Object? decryptNonce = ignore,
    Object? decryptAlgo = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (messageId != ignore) 1: messageId as String?,
        if (sender != ignore) 2: sender as String?,
        if (receiver != ignore) 3: receiver as String?,
        if (groupId != ignore) 4: groupId as String?,
        if (sessionId != ignore) 5: sessionId as String?,
        if (kind != ignore) 6: kind as int?,
        if (tags != ignore) 7: tags as String?,
        if (content != ignore) 8: content as String?,
        if (createTime != ignore) 9: createTime as int?,
        if (read != ignore) 10: read as bool?,
        if (replyId != ignore) 11: replyId as String?,
        if (decryptContent != ignore) 12: decryptContent as String?,
        if (type != ignore) 13: type as String?,
        if (status != ignore) 14: status as int?,
        if (plaintEvent != ignore) 16: plaintEvent as String?,
        if (chatType != ignore) 17: chatType as int?,
        if (subType != ignore) 18: subType as String?,
        if (previewData != ignore) 19: previewData as String?,
        if (expiration != ignore) 20: expiration as int?,
        if (decryptSecret != ignore) 21: decryptSecret as String?,
        if (decryptNonce != ignore) 22: decryptNonce as String?,
        if (decryptAlgo != ignore) 23: decryptAlgo as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension MessageDBISARQueryBuilderUpdate
    on QueryBuilder<MessageDBISAR, MessageDBISAR, QOperations> {
  _MessageDBISARQueryUpdate get updateFirst =>
      _MessageDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _MessageDBISARQueryUpdate get updateAll =>
      _MessageDBISARQueryBuilderUpdateImpl(this);
}

extension MessageDBISARQueryFilter
    on QueryBuilder<MessageDBISAR, MessageDBISAR, QFilterCondition> {
  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      messageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      senderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      receiverIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      groupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      sessionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> kindEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      kindGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      kindGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      kindLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      kindLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> kindBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> tagsEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsGreaterThan(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsLessThan(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> tagsBetween(
    String lower,
    String upper, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> tagsMatches(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentGreaterThan(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentLessThan(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentBetween(
    String lower,
    String upper, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      createTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      createTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      createTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      createTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      createTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      createTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> readEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      replyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptContentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 13,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 13,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 13,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 13,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 13,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      statusEqualTo(
    int? value,
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      statusGreaterThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      statusGreaterThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      statusLessThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      statusLessThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      statusBetween(
    int? lower,
    int? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementGreaterThan(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementLessThan(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListIsEmpty() {
    return not().group(
      (q) => q.reportListIsNull().or().reportListIsNotEmpty(),
    );
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reportListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 15, value: null),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventGreaterThan(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventLessThan(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventBetween(
    String lower,
    String upper, {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      plaintEventIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      chatTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      chatTypeIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      chatTypeEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      chatTypeGreaterThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      chatTypeGreaterThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      chatTypeLessThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      chatTypeLessThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 17,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      chatTypeBetween(
    int? lower,
    int? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 17,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 18));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 18));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 18,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      subTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 18,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 19));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 19));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 19,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      previewDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 19,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      expirationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 20));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      expirationIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 20));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      expirationEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      expirationGreaterThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      expirationGreaterThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      expirationLessThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      expirationLessThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 20,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      expirationBetween(
    int? lower,
    int? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 20,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 21));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 21));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretGreaterThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretGreaterThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretLessThan(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretLessThanOrEqualTo(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretBetween(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretStartsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretEndsWith(
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 21,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptSecretIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 21,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 22));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 22));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 22,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 22,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 22,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 22,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptNonceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 22,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 23));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 23));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 23,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 23,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 23,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 23,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      decryptAlgoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 23,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 24));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 24));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 24,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 24,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 24,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 24,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 24,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsIsEmpty() {
    return not().group(
      (q) => q.reactionEventIdsIsNull().or().reactionEventIdsIsNotEmpty(),
    );
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      reactionEventIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 24, value: null),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 25));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 25));
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 25,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 25,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 25,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 25,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 25,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsIsEmpty() {
    return not().group(
      (q) => q.zapEventIdsIsNull().or().zapEventIdsIsNotEmpty(),
    );
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterFilterCondition>
      zapEventIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 25, value: null),
      );
    });
  }
}

extension MessageDBISARQueryObject
    on QueryBuilder<MessageDBISAR, MessageDBISAR, QFilterCondition> {}

extension MessageDBISARQuerySortBy
    on QueryBuilder<MessageDBISAR, MessageDBISAR, QSortBy> {
  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByMessageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByMessageIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortBySender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortBySenderDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByReceiver(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByReceiverDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByGroupIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortBySessionId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortBySessionIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByTags(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByTagsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByContentDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByReplyId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByReplyIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByDecryptContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByDecryptContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        13,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByTypeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        13,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByPlaintEvent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByPlaintEventDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByChatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByChatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortBySubType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        18,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortBySubTypeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        18,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByPreviewData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        19,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByPreviewDataDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        19,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByDecryptSecret(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        21,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByDecryptSecretDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        21,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByDecryptNonce(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        22,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByDecryptNonceDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        22,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> sortByDecryptAlgo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        23,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      sortByDecryptAlgoDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        23,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension MessageDBISARQuerySortThenBy
    on QueryBuilder<MessageDBISAR, MessageDBISAR, QSortThenBy> {
  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByMessageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByMessageIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenBySender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenBySenderDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByReceiver(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByReceiverDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByGroupIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenBySessionId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenBySessionIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByTags(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByTagsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByContentDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByReplyId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByReplyIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByDecryptContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByDecryptContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByTypeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByPlaintEvent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByPlaintEventDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByChatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByChatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenBySubType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenBySubTypeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByPreviewData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByPreviewDataDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, sort: Sort.desc);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByDecryptSecret(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByDecryptSecretDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByDecryptNonce(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByDecryptNonceDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy> thenByDecryptAlgo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterSortBy>
      thenByDecryptAlgoDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension MessageDBISARQueryWhereDistinct
    on QueryBuilder<MessageDBISAR, MessageDBISAR, QDistinct> {
  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByMessageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctBySender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctByReceiver(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctBySessionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctByTags(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctByRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctByReplyId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByDecryptContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByReportList() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByPlaintEvent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByChatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct> distinctBySubType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByPreviewData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(19, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(20);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByDecryptSecret({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(21, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByDecryptNonce({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(22, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByDecryptAlgo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(23, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByReactionEventIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(24);
    });
  }

  QueryBuilder<MessageDBISAR, MessageDBISAR, QAfterDistinct>
      distinctByZapEventIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(25);
    });
  }
}

extension MessageDBISARQueryProperty1
    on QueryBuilder<MessageDBISAR, MessageDBISAR, QProperty> {
  QueryBuilder<MessageDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> receiverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MessageDBISAR, int, QAfterProperty> kindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MessageDBISAR, int, QAfterProperty> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MessageDBISAR, bool, QAfterProperty> readProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> replyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> decryptContentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<MessageDBISAR, int?, QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<MessageDBISAR, List<String>?, QAfterProperty>
      reportListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<MessageDBISAR, String, QAfterProperty> plaintEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<MessageDBISAR, int?, QAfterProperty> chatTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<MessageDBISAR, String?, QAfterProperty> subTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<MessageDBISAR, String?, QAfterProperty> previewDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<MessageDBISAR, int?, QAfterProperty> expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<MessageDBISAR, String?, QAfterProperty> decryptSecretProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<MessageDBISAR, String?, QAfterProperty> decryptNonceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<MessageDBISAR, String?, QAfterProperty> decryptAlgoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<MessageDBISAR, List<String>?, QAfterProperty>
      reactionEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<MessageDBISAR, List<String>?, QAfterProperty>
      zapEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }
}

extension MessageDBISARQueryProperty2<R>
    on QueryBuilder<MessageDBISAR, R, QAfterProperty> {
  QueryBuilder<MessageDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> receiverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MessageDBISAR, (R, int), QAfterProperty> kindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MessageDBISAR, (R, int), QAfterProperty> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MessageDBISAR, (R, bool), QAfterProperty> readProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> replyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty>
      decryptContentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<MessageDBISAR, (R, int?), QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<MessageDBISAR, (R, List<String>?), QAfterProperty>
      reportListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String), QAfterProperty>
      plaintEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<MessageDBISAR, (R, int?), QAfterProperty> chatTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String?), QAfterProperty> subTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String?), QAfterProperty>
      previewDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<MessageDBISAR, (R, int?), QAfterProperty> expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String?), QAfterProperty>
      decryptSecretProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String?), QAfterProperty>
      decryptNonceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<MessageDBISAR, (R, String?), QAfterProperty>
      decryptAlgoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<MessageDBISAR, (R, List<String>?), QAfterProperty>
      reactionEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<MessageDBISAR, (R, List<String>?), QAfterProperty>
      zapEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }
}

extension MessageDBISARQueryProperty3<R1, R2>
    on QueryBuilder<MessageDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<MessageDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations>
      messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations>
      receiverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations>
      sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, int), QOperations> kindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, int), QOperations> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, bool), QOperations> readProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations> replyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations>
      decryptContentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, int?), QOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, List<String>?), QOperations>
      reportListProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String), QOperations>
      plaintEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, int?), QOperations> chatTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String?), QOperations>
      subTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String?), QOperations>
      previewDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, int?), QOperations>
      expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String?), QOperations>
      decryptSecretProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String?), QOperations>
      decryptNonceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, String?), QOperations>
      decryptAlgoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, List<String>?), QOperations>
      reactionEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<MessageDBISAR, (R1, R2, List<String>?), QOperations>
      zapEventIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }
}
