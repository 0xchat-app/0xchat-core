// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moderationDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetModerationDBISARCollection on Isar {
  IsarCollection<int, ModerationDBISAR> get moderationDBISARs =>
      this.collection();
}

const ModerationDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ModerationDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'moderationId',
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
        name: 'createdAt',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'content',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'previous',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'actionKind',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'users',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'permissions',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'permission',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'eventId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'private',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'closed',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'about',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'picture',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'pinned',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'moderationId',
        properties: [
          "moderationId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, ModerationDBISAR>(
    serialize: serializeModerationDBISAR,
    deserialize: deserializeModerationDBISAR,
    deserializeProperty: deserializeModerationDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeModerationDBISAR(IsarWriter writer, ModerationDBISAR object) {
  IsarCore.writeString(writer, 1, object.moderationId);
  IsarCore.writeString(writer, 2, object.groupId);
  IsarCore.writeString(writer, 3, object.author);
  IsarCore.writeLong(writer, 4, object.createdAt);
  IsarCore.writeString(writer, 5, object.content);
  {
    final list = object.previous;
    if (list == null) {
      IsarCore.writeNull(writer, 6);
    } else {
      final listWriter = IsarCore.beginList(writer, 6, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  IsarCore.writeLong(writer, 7, object.actionKind);
  {
    final list = object.users;
    if (list == null) {
      IsarCore.writeNull(writer, 8);
    } else {
      final listWriter = IsarCore.beginList(writer, 8, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.permissions;
    if (list == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      final listWriter = IsarCore.beginList(writer, 9, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  IsarCore.writeString(writer, 10, object.permission);
  IsarCore.writeString(writer, 11, object.eventId);
  IsarCore.writeBool(writer, 12, object.private);
  IsarCore.writeBool(writer, 13, object.closed);
  IsarCore.writeString(writer, 14, object.name);
  IsarCore.writeString(writer, 15, object.about);
  IsarCore.writeString(writer, 16, object.picture);
  IsarCore.writeString(writer, 17, object.pinned);
  return object.id;
}

@isarProtected
ModerationDBISAR deserializeModerationDBISAR(IsarReader reader) {
  final String _moderationId;
  _moderationId = IsarCore.readString(reader, 1) ?? '';
  final String _groupId;
  _groupId = IsarCore.readString(reader, 2) ?? '';
  final String _author;
  _author = IsarCore.readString(reader, 3) ?? '';
  final int _createdAt;
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      _createdAt = 0;
    } else {
      _createdAt = value;
    }
  }
  final String _content;
  _content = IsarCore.readString(reader, 5) ?? '';
  final List<String>? _previous;
  {
    final length = IsarCore.readList(reader, 6, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _previous = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _previous = list;
      }
    }
  }
  final int _actionKind;
  {
    final value = IsarCore.readLong(reader, 7);
    if (value == -9223372036854775808) {
      _actionKind = 0;
    } else {
      _actionKind = value;
    }
  }
  final List<String>? _users;
  {
    final length = IsarCore.readList(reader, 8, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _users = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _users = list;
      }
    }
  }
  final List<String>? _permissions;
  {
    final length = IsarCore.readList(reader, 9, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _permissions = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _permissions = list;
      }
    }
  }
  final String _permission;
  _permission = IsarCore.readString(reader, 10) ?? '';
  final String _eventId;
  _eventId = IsarCore.readString(reader, 11) ?? '';
  final bool _private;
  _private = IsarCore.readBool(reader, 12);
  final bool _closed;
  _closed = IsarCore.readBool(reader, 13);
  final String _name;
  _name = IsarCore.readString(reader, 14) ?? '';
  final String _about;
  _about = IsarCore.readString(reader, 15) ?? '';
  final String _picture;
  _picture = IsarCore.readString(reader, 16) ?? '';
  final String _pinned;
  _pinned = IsarCore.readString(reader, 17) ?? '';
  final object = ModerationDBISAR(
    moderationId: _moderationId,
    groupId: _groupId,
    author: _author,
    createdAt: _createdAt,
    content: _content,
    previous: _previous,
    actionKind: _actionKind,
    users: _users,
    permissions: _permissions,
    permission: _permission,
    eventId: _eventId,
    private: _private,
    closed: _closed,
    name: _name,
    about: _about,
    picture: _picture,
    pinned: _pinned,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeModerationDBISARProp(IsarReader reader, int property) {
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
      {
        final length = IsarCore.readList(reader, 6, IsarCore.readerPtrPtr);
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
    case 7:
      {
        final value = IsarCore.readLong(reader, 7);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 8:
      {
        final length = IsarCore.readList(reader, 8, IsarCore.readerPtrPtr);
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
    case 9:
      {
        final length = IsarCore.readList(reader, 9, IsarCore.readerPtrPtr);
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
    case 10:
      return IsarCore.readString(reader, 10) ?? '';
    case 11:
      return IsarCore.readString(reader, 11) ?? '';
    case 12:
      return IsarCore.readBool(reader, 12);
    case 13:
      return IsarCore.readBool(reader, 13);
    case 14:
      return IsarCore.readString(reader, 14) ?? '';
    case 15:
      return IsarCore.readString(reader, 15) ?? '';
    case 16:
      return IsarCore.readString(reader, 16) ?? '';
    case 17:
      return IsarCore.readString(reader, 17) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ModerationDBISARUpdate {
  bool call({
    required int id,
    String? moderationId,
    String? groupId,
    String? author,
    int? createdAt,
    String? content,
    int? actionKind,
    String? permission,
    String? eventId,
    bool? private,
    bool? closed,
    String? name,
    String? about,
    String? picture,
    String? pinned,
  });
}

class _ModerationDBISARUpdateImpl implements _ModerationDBISARUpdate {
  const _ModerationDBISARUpdateImpl(this.collection);

  final IsarCollection<int, ModerationDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? moderationId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createdAt = ignore,
    Object? content = ignore,
    Object? actionKind = ignore,
    Object? permission = ignore,
    Object? eventId = ignore,
    Object? private = ignore,
    Object? closed = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? pinned = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (moderationId != ignore) 1: moderationId as String?,
          if (groupId != ignore) 2: groupId as String?,
          if (author != ignore) 3: author as String?,
          if (createdAt != ignore) 4: createdAt as int?,
          if (content != ignore) 5: content as String?,
          if (actionKind != ignore) 7: actionKind as int?,
          if (permission != ignore) 10: permission as String?,
          if (eventId != ignore) 11: eventId as String?,
          if (private != ignore) 12: private as bool?,
          if (closed != ignore) 13: closed as bool?,
          if (name != ignore) 14: name as String?,
          if (about != ignore) 15: about as String?,
          if (picture != ignore) 16: picture as String?,
          if (pinned != ignore) 17: pinned as String?,
        }) >
        0;
  }
}

sealed class _ModerationDBISARUpdateAll {
  int call({
    required List<int> id,
    String? moderationId,
    String? groupId,
    String? author,
    int? createdAt,
    String? content,
    int? actionKind,
    String? permission,
    String? eventId,
    bool? private,
    bool? closed,
    String? name,
    String? about,
    String? picture,
    String? pinned,
  });
}

class _ModerationDBISARUpdateAllImpl implements _ModerationDBISARUpdateAll {
  const _ModerationDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, ModerationDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? moderationId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createdAt = ignore,
    Object? content = ignore,
    Object? actionKind = ignore,
    Object? permission = ignore,
    Object? eventId = ignore,
    Object? private = ignore,
    Object? closed = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? pinned = ignore,
  }) {
    return collection.updateProperties(id, {
      if (moderationId != ignore) 1: moderationId as String?,
      if (groupId != ignore) 2: groupId as String?,
      if (author != ignore) 3: author as String?,
      if (createdAt != ignore) 4: createdAt as int?,
      if (content != ignore) 5: content as String?,
      if (actionKind != ignore) 7: actionKind as int?,
      if (permission != ignore) 10: permission as String?,
      if (eventId != ignore) 11: eventId as String?,
      if (private != ignore) 12: private as bool?,
      if (closed != ignore) 13: closed as bool?,
      if (name != ignore) 14: name as String?,
      if (about != ignore) 15: about as String?,
      if (picture != ignore) 16: picture as String?,
      if (pinned != ignore) 17: pinned as String?,
    });
  }
}

extension ModerationDBISARUpdate on IsarCollection<int, ModerationDBISAR> {
  _ModerationDBISARUpdate get update => _ModerationDBISARUpdateImpl(this);

  _ModerationDBISARUpdateAll get updateAll =>
      _ModerationDBISARUpdateAllImpl(this);
}

sealed class _ModerationDBISARQueryUpdate {
  int call({
    String? moderationId,
    String? groupId,
    String? author,
    int? createdAt,
    String? content,
    int? actionKind,
    String? permission,
    String? eventId,
    bool? private,
    bool? closed,
    String? name,
    String? about,
    String? picture,
    String? pinned,
  });
}

class _ModerationDBISARQueryUpdateImpl implements _ModerationDBISARQueryUpdate {
  const _ModerationDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ModerationDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? moderationId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createdAt = ignore,
    Object? content = ignore,
    Object? actionKind = ignore,
    Object? permission = ignore,
    Object? eventId = ignore,
    Object? private = ignore,
    Object? closed = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? pinned = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (moderationId != ignore) 1: moderationId as String?,
      if (groupId != ignore) 2: groupId as String?,
      if (author != ignore) 3: author as String?,
      if (createdAt != ignore) 4: createdAt as int?,
      if (content != ignore) 5: content as String?,
      if (actionKind != ignore) 7: actionKind as int?,
      if (permission != ignore) 10: permission as String?,
      if (eventId != ignore) 11: eventId as String?,
      if (private != ignore) 12: private as bool?,
      if (closed != ignore) 13: closed as bool?,
      if (name != ignore) 14: name as String?,
      if (about != ignore) 15: about as String?,
      if (picture != ignore) 16: picture as String?,
      if (pinned != ignore) 17: pinned as String?,
    });
  }
}

extension ModerationDBISARQueryUpdate on IsarQuery<ModerationDBISAR> {
  _ModerationDBISARQueryUpdate get updateFirst =>
      _ModerationDBISARQueryUpdateImpl(this, limit: 1);

  _ModerationDBISARQueryUpdate get updateAll =>
      _ModerationDBISARQueryUpdateImpl(this);
}

class _ModerationDBISARQueryBuilderUpdateImpl
    implements _ModerationDBISARQueryUpdate {
  const _ModerationDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ModerationDBISAR, ModerationDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? moderationId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createdAt = ignore,
    Object? content = ignore,
    Object? actionKind = ignore,
    Object? permission = ignore,
    Object? eventId = ignore,
    Object? private = ignore,
    Object? closed = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? pinned = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (moderationId != ignore) 1: moderationId as String?,
        if (groupId != ignore) 2: groupId as String?,
        if (author != ignore) 3: author as String?,
        if (createdAt != ignore) 4: createdAt as int?,
        if (content != ignore) 5: content as String?,
        if (actionKind != ignore) 7: actionKind as int?,
        if (permission != ignore) 10: permission as String?,
        if (eventId != ignore) 11: eventId as String?,
        if (private != ignore) 12: private as bool?,
        if (closed != ignore) 13: closed as bool?,
        if (name != ignore) 14: name as String?,
        if (about != ignore) 15: about as String?,
        if (picture != ignore) 16: picture as String?,
        if (pinned != ignore) 17: pinned as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension ModerationDBISARQueryBuilderUpdate
    on QueryBuilder<ModerationDBISAR, ModerationDBISAR, QOperations> {
  _ModerationDBISARQueryUpdate get updateFirst =>
      _ModerationDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _ModerationDBISARQueryUpdate get updateAll =>
      _ModerationDBISARQueryBuilderUpdateImpl(this);
}

extension ModerationDBISARQueryFilter
    on QueryBuilder<ModerationDBISAR, ModerationDBISAR, QFilterCondition> {
  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      idEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdGreaterThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdGreaterThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdLessThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      moderationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      groupIdEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      groupIdLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      groupIdBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      groupIdStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      groupIdEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      groupIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      groupIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      groupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorGreaterThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      authorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      createdAtEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      createdAtGreaterThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      createdAtGreaterThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      createdAtLessThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      contentEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      contentLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      contentBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      contentStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      contentEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementGreaterThan(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementLessThan(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousIsEmpty() {
    return not().group(
      (q) => q.previousIsNull().or().previousIsNotEmpty(),
    );
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      previousIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 6, value: null),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      actionKindEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      actionKindGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      actionKindGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      actionKindLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      actionKindLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      actionKindBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementGreaterThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementGreaterThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementLessThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersIsEmpty() {
    return not().group(
      (q) => q.usersIsNull().or().usersIsNotEmpty(),
    );
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      usersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 8, value: null),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementGreaterThan(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementLessThan(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsIsEmpty() {
    return not().group(
      (q) => q.permissionsIsNull().or().permissionsIsNotEmpty(),
    );
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 9, value: null),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionGreaterThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionGreaterThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionLessThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      permissionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdGreaterThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdGreaterThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdLessThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      eventIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      privateEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 12,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      closedEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 14,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 14,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 14,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutGreaterThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutGreaterThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutLessThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      aboutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureGreaterThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureGreaterThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureLessThan(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureLessThanOrEqualTo(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureBetween(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pictureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedGreaterThan(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedLessThan(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedBetween(
    String lower,
    String upper, {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedStartsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedEndsWith(
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 17,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterFilterCondition>
      pinnedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 17,
          value: '',
        ),
      );
    });
  }
}

extension ModerationDBISARQueryObject
    on QueryBuilder<ModerationDBISAR, ModerationDBISAR, QFilterCondition> {}

extension ModerationDBISARQuerySortBy
    on QueryBuilder<ModerationDBISAR, ModerationDBISAR, QSortBy> {
  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByModerationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByModerationIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByActionKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByActionKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByPermission({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByPermissionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByPrivateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        14,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        14,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        15,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByAboutDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        15,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByPictureDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> sortByPinned(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        17,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      sortByPinnedDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        17,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension ModerationDBISARQuerySortThenBy
    on QueryBuilder<ModerationDBISAR, ModerationDBISAR, QSortThenBy> {
  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByModerationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByModerationIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByActionKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByActionKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByPermission({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByPermissionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByPrivateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByAboutDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByPictureDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy> thenByPinned(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterSortBy>
      thenByPinnedDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension ModerationDBISARQueryWhereDistinct
    on QueryBuilder<ModerationDBISAR, ModerationDBISAR, QDistinct> {
  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByModerationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByAuthor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByPrevious() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByActionKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByUsers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByPermissions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByPermission({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByAbout({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByPicture({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModerationDBISAR, ModerationDBISAR, QAfterDistinct>
      distinctByPinned({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17, caseSensitive: caseSensitive);
    });
  }
}

extension ModerationDBISARQueryProperty1
    on QueryBuilder<ModerationDBISAR, ModerationDBISAR, QProperty> {
  QueryBuilder<ModerationDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty>
      moderationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ModerationDBISAR, int, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ModerationDBISAR, List<String>?, QAfterProperty>
      previousProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ModerationDBISAR, int, QAfterProperty> actionKindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ModerationDBISAR, List<String>?, QAfterProperty>
      usersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ModerationDBISAR, List<String>?, QAfterProperty>
      permissionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> permissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<ModerationDBISAR, bool, QAfterProperty> privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<ModerationDBISAR, bool, QAfterProperty> closedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<ModerationDBISAR, String, QAfterProperty> pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}

extension ModerationDBISARQueryProperty2<R>
    on QueryBuilder<ModerationDBISAR, R, QAfterProperty> {
  QueryBuilder<ModerationDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty>
      moderationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty>
      groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, int), QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, List<String>?), QAfterProperty>
      previousProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, int), QAfterProperty>
      actionKindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, List<String>?), QAfterProperty>
      usersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, List<String>?), QAfterProperty>
      permissionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty>
      permissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, bool), QAfterProperty> privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, bool), QAfterProperty> closedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty>
      pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<ModerationDBISAR, (R, String), QAfterProperty> pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}

extension ModerationDBISARQueryProperty3<R1, R2>
    on QueryBuilder<ModerationDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<ModerationDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      moderationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, int), QOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, List<String>?), QOperations>
      previousProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, int), QOperations>
      actionKindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, List<String>?), QOperations>
      usersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, List<String>?), QOperations>
      permissionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      permissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, bool), QOperations>
      privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, bool), QOperations> closedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<ModerationDBISAR, (R1, R2, String), QOperations>
      pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}
