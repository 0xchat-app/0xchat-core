// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relayGroupDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetRelayGroupDBISARCollection on Isar {
  IsarCollection<int, RelayGroupDBISAR> get relayGroupDBISARs =>
      this.collection();
}

const RelayGroupDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'RelayGroupDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'groupId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'author',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'relay',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'relayPubkey',
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
        name: 'lastUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastMembersUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'lastAdminsUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'mute',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'adminsString',
        type: IsarType.string,
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
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'members',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'level',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'point',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'identifier',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'groupId',
        properties: [
          "groupId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, RelayGroupDBISAR>(
    serialize: serializeRelayGroupDBISAR,
    deserialize: deserializeRelayGroupDBISAR,
    deserializeProperty: deserializeRelayGroupDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeRelayGroupDBISAR(IsarWriter writer, RelayGroupDBISAR object) {
  IsarCore.writeString(writer, 1, object.groupId);
  IsarCore.writeString(writer, 2, object.author);
  IsarCore.writeString(writer, 3, object.relay);
  IsarCore.writeString(writer, 4, object.relayPubkey);
  IsarCore.writeBool(writer, 5, object.private);
  IsarCore.writeBool(writer, 6, object.closed);
  IsarCore.writeLong(writer, 7, object.lastUpdatedTime);
  IsarCore.writeLong(writer, 8, object.lastMembersUpdatedTime);
  IsarCore.writeLong(writer, 9, object.lastAdminsUpdatedTime);
  IsarCore.writeBool(writer, 10, object.mute);
  {
    final value = object.adminsString;
    if (value == null) {
      IsarCore.writeNull(writer, 11);
    } else {
      IsarCore.writeString(writer, 11, value);
    }
  }
  IsarCore.writeString(writer, 12, object.name);
  IsarCore.writeString(writer, 13, object.about);
  IsarCore.writeString(writer, 14, object.picture);
  {
    final list = object.pinned;
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
  {
    final list = object.members;
    if (list == null) {
      IsarCore.writeNull(writer, 16);
    } else {
      final listWriter = IsarCore.beginList(writer, 16, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  IsarCore.writeLong(writer, 17, object.level);
  IsarCore.writeLong(writer, 18, object.point);
  IsarCore.writeString(writer, 19, object.identifier);
  return object.id;
}

@isarProtected
RelayGroupDBISAR deserializeRelayGroupDBISAR(IsarReader reader) {
  final String _groupId;
  _groupId = IsarCore.readString(reader, 1) ?? '';
  final String _author;
  _author = IsarCore.readString(reader, 2) ?? '';
  final String _relay;
  _relay = IsarCore.readString(reader, 3) ?? '';
  final String _relayPubkey;
  _relayPubkey = IsarCore.readString(reader, 4) ?? '';
  final bool _private;
  _private = IsarCore.readBool(reader, 5);
  final bool _closed;
  _closed = IsarCore.readBool(reader, 6);
  final int _lastUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 7);
    if (value == -9223372036854775808) {
      _lastUpdatedTime = 0;
    } else {
      _lastUpdatedTime = value;
    }
  }
  final int _lastMembersUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      _lastMembersUpdatedTime = 0;
    } else {
      _lastMembersUpdatedTime = value;
    }
  }
  final int _lastAdminsUpdatedTime;
  {
    final value = IsarCore.readLong(reader, 9);
    if (value == -9223372036854775808) {
      _lastAdminsUpdatedTime = 0;
    } else {
      _lastAdminsUpdatedTime = value;
    }
  }
  final bool _mute;
  _mute = IsarCore.readBool(reader, 10);
  final String? _adminsString;
  _adminsString = IsarCore.readString(reader, 11);
  final String _name;
  _name = IsarCore.readString(reader, 12) ?? '';
  final String _about;
  _about = IsarCore.readString(reader, 13) ?? '';
  final String _picture;
  _picture = IsarCore.readString(reader, 14) ?? '';
  final List<String>? _pinned;
  {
    final length = IsarCore.readList(reader, 15, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _pinned = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _pinned = list;
      }
    }
  }
  final List<String>? _members;
  {
    final length = IsarCore.readList(reader, 16, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _members = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _members = list;
      }
    }
  }
  final int _level;
  {
    final value = IsarCore.readLong(reader, 17);
    if (value == -9223372036854775808) {
      _level = 0;
    } else {
      _level = value;
    }
  }
  final int _point;
  {
    final value = IsarCore.readLong(reader, 18);
    if (value == -9223372036854775808) {
      _point = 0;
    } else {
      _point = value;
    }
  }
  final object = RelayGroupDBISAR(
    groupId: _groupId,
    author: _author,
    relay: _relay,
    relayPubkey: _relayPubkey,
    private: _private,
    closed: _closed,
    lastUpdatedTime: _lastUpdatedTime,
    lastMembersUpdatedTime: _lastMembersUpdatedTime,
    lastAdminsUpdatedTime: _lastAdminsUpdatedTime,
    mute: _mute,
    adminsString: _adminsString,
    name: _name,
    about: _about,
    picture: _picture,
    pinned: _pinned,
    members: _members,
    level: _level,
    point: _point,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeRelayGroupDBISARProp(IsarReader reader, int property) {
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
      return IsarCore.readBool(reader, 5);
    case 6:
      return IsarCore.readBool(reader, 6);
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
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
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
      return IsarCore.readString(reader, 11);
    case 12:
      return IsarCore.readString(reader, 12) ?? '';
    case 13:
      return IsarCore.readString(reader, 13) ?? '';
    case 14:
      return IsarCore.readString(reader, 14) ?? '';
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
      {
        final length = IsarCore.readList(reader, 16, IsarCore.readerPtrPtr);
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
    case 17:
      {
        final value = IsarCore.readLong(reader, 17);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 18:
      {
        final value = IsarCore.readLong(reader, 18);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 19:
      return IsarCore.readString(reader, 19) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _RelayGroupDBISARUpdate {
  bool call({
    required int id,
    String? groupId,
    String? author,
    String? relay,
    String? relayPubkey,
    bool? private,
    bool? closed,
    int? lastUpdatedTime,
    int? lastMembersUpdatedTime,
    int? lastAdminsUpdatedTime,
    bool? mute,
    String? adminsString,
    String? name,
    String? about,
    String? picture,
    int? level,
    int? point,
    String? identifier,
  });
}

class _RelayGroupDBISARUpdateImpl implements _RelayGroupDBISARUpdate {
  const _RelayGroupDBISARUpdateImpl(this.collection);

  final IsarCollection<int, RelayGroupDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? relay = ignore,
    Object? relayPubkey = ignore,
    Object? private = ignore,
    Object? closed = ignore,
    Object? lastUpdatedTime = ignore,
    Object? lastMembersUpdatedTime = ignore,
    Object? lastAdminsUpdatedTime = ignore,
    Object? mute = ignore,
    Object? adminsString = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? level = ignore,
    Object? point = ignore,
    Object? identifier = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (groupId != ignore) 1: groupId as String?,
          if (author != ignore) 2: author as String?,
          if (relay != ignore) 3: relay as String?,
          if (relayPubkey != ignore) 4: relayPubkey as String?,
          if (private != ignore) 5: private as bool?,
          if (closed != ignore) 6: closed as bool?,
          if (lastUpdatedTime != ignore) 7: lastUpdatedTime as int?,
          if (lastMembersUpdatedTime != ignore)
            8: lastMembersUpdatedTime as int?,
          if (lastAdminsUpdatedTime != ignore) 9: lastAdminsUpdatedTime as int?,
          if (mute != ignore) 10: mute as bool?,
          if (adminsString != ignore) 11: adminsString as String?,
          if (name != ignore) 12: name as String?,
          if (about != ignore) 13: about as String?,
          if (picture != ignore) 14: picture as String?,
          if (level != ignore) 17: level as int?,
          if (point != ignore) 18: point as int?,
          if (identifier != ignore) 19: identifier as String?,
        }) >
        0;
  }
}

sealed class _RelayGroupDBISARUpdateAll {
  int call({
    required List<int> id,
    String? groupId,
    String? author,
    String? relay,
    String? relayPubkey,
    bool? private,
    bool? closed,
    int? lastUpdatedTime,
    int? lastMembersUpdatedTime,
    int? lastAdminsUpdatedTime,
    bool? mute,
    String? adminsString,
    String? name,
    String? about,
    String? picture,
    int? level,
    int? point,
    String? identifier,
  });
}

class _RelayGroupDBISARUpdateAllImpl implements _RelayGroupDBISARUpdateAll {
  const _RelayGroupDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, RelayGroupDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? relay = ignore,
    Object? relayPubkey = ignore,
    Object? private = ignore,
    Object? closed = ignore,
    Object? lastUpdatedTime = ignore,
    Object? lastMembersUpdatedTime = ignore,
    Object? lastAdminsUpdatedTime = ignore,
    Object? mute = ignore,
    Object? adminsString = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? level = ignore,
    Object? point = ignore,
    Object? identifier = ignore,
  }) {
    return collection.updateProperties(id, {
      if (groupId != ignore) 1: groupId as String?,
      if (author != ignore) 2: author as String?,
      if (relay != ignore) 3: relay as String?,
      if (relayPubkey != ignore) 4: relayPubkey as String?,
      if (private != ignore) 5: private as bool?,
      if (closed != ignore) 6: closed as bool?,
      if (lastUpdatedTime != ignore) 7: lastUpdatedTime as int?,
      if (lastMembersUpdatedTime != ignore) 8: lastMembersUpdatedTime as int?,
      if (lastAdminsUpdatedTime != ignore) 9: lastAdminsUpdatedTime as int?,
      if (mute != ignore) 10: mute as bool?,
      if (adminsString != ignore) 11: adminsString as String?,
      if (name != ignore) 12: name as String?,
      if (about != ignore) 13: about as String?,
      if (picture != ignore) 14: picture as String?,
      if (level != ignore) 17: level as int?,
      if (point != ignore) 18: point as int?,
      if (identifier != ignore) 19: identifier as String?,
    });
  }
}

extension RelayGroupDBISARUpdate on IsarCollection<int, RelayGroupDBISAR> {
  _RelayGroupDBISARUpdate get update => _RelayGroupDBISARUpdateImpl(this);

  _RelayGroupDBISARUpdateAll get updateAll =>
      _RelayGroupDBISARUpdateAllImpl(this);
}

sealed class _RelayGroupDBISARQueryUpdate {
  int call({
    String? groupId,
    String? author,
    String? relay,
    String? relayPubkey,
    bool? private,
    bool? closed,
    int? lastUpdatedTime,
    int? lastMembersUpdatedTime,
    int? lastAdminsUpdatedTime,
    bool? mute,
    String? adminsString,
    String? name,
    String? about,
    String? picture,
    int? level,
    int? point,
    String? identifier,
  });
}

class _RelayGroupDBISARQueryUpdateImpl implements _RelayGroupDBISARQueryUpdate {
  const _RelayGroupDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<RelayGroupDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? groupId = ignore,
    Object? author = ignore,
    Object? relay = ignore,
    Object? relayPubkey = ignore,
    Object? private = ignore,
    Object? closed = ignore,
    Object? lastUpdatedTime = ignore,
    Object? lastMembersUpdatedTime = ignore,
    Object? lastAdminsUpdatedTime = ignore,
    Object? mute = ignore,
    Object? adminsString = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? level = ignore,
    Object? point = ignore,
    Object? identifier = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (groupId != ignore) 1: groupId as String?,
      if (author != ignore) 2: author as String?,
      if (relay != ignore) 3: relay as String?,
      if (relayPubkey != ignore) 4: relayPubkey as String?,
      if (private != ignore) 5: private as bool?,
      if (closed != ignore) 6: closed as bool?,
      if (lastUpdatedTime != ignore) 7: lastUpdatedTime as int?,
      if (lastMembersUpdatedTime != ignore) 8: lastMembersUpdatedTime as int?,
      if (lastAdminsUpdatedTime != ignore) 9: lastAdminsUpdatedTime as int?,
      if (mute != ignore) 10: mute as bool?,
      if (adminsString != ignore) 11: adminsString as String?,
      if (name != ignore) 12: name as String?,
      if (about != ignore) 13: about as String?,
      if (picture != ignore) 14: picture as String?,
      if (level != ignore) 17: level as int?,
      if (point != ignore) 18: point as int?,
      if (identifier != ignore) 19: identifier as String?,
    });
  }
}

extension RelayGroupDBISARQueryUpdate on IsarQuery<RelayGroupDBISAR> {
  _RelayGroupDBISARQueryUpdate get updateFirst =>
      _RelayGroupDBISARQueryUpdateImpl(this, limit: 1);

  _RelayGroupDBISARQueryUpdate get updateAll =>
      _RelayGroupDBISARQueryUpdateImpl(this);
}

class _RelayGroupDBISARQueryBuilderUpdateImpl
    implements _RelayGroupDBISARQueryUpdate {
  const _RelayGroupDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? groupId = ignore,
    Object? author = ignore,
    Object? relay = ignore,
    Object? relayPubkey = ignore,
    Object? private = ignore,
    Object? closed = ignore,
    Object? lastUpdatedTime = ignore,
    Object? lastMembersUpdatedTime = ignore,
    Object? lastAdminsUpdatedTime = ignore,
    Object? mute = ignore,
    Object? adminsString = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? level = ignore,
    Object? point = ignore,
    Object? identifier = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (groupId != ignore) 1: groupId as String?,
        if (author != ignore) 2: author as String?,
        if (relay != ignore) 3: relay as String?,
        if (relayPubkey != ignore) 4: relayPubkey as String?,
        if (private != ignore) 5: private as bool?,
        if (closed != ignore) 6: closed as bool?,
        if (lastUpdatedTime != ignore) 7: lastUpdatedTime as int?,
        if (lastMembersUpdatedTime != ignore) 8: lastMembersUpdatedTime as int?,
        if (lastAdminsUpdatedTime != ignore) 9: lastAdminsUpdatedTime as int?,
        if (mute != ignore) 10: mute as bool?,
        if (adminsString != ignore) 11: adminsString as String?,
        if (name != ignore) 12: name as String?,
        if (about != ignore) 13: about as String?,
        if (picture != ignore) 14: picture as String?,
        if (level != ignore) 17: level as int?,
        if (point != ignore) 18: point as int?,
        if (identifier != ignore) 19: identifier as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension RelayGroupDBISARQueryBuilderUpdate
    on QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QOperations> {
  _RelayGroupDBISARQueryUpdate get updateFirst =>
      _RelayGroupDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _RelayGroupDBISARQueryUpdate get updateAll =>
      _RelayGroupDBISARQueryBuilderUpdateImpl(this);
}

extension RelayGroupDBISARQueryFilter
    on QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QFilterCondition> {
  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      groupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      authorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      relayPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      privateEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      closedEqualTo(
    bool value,
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastUpdatedTimeEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastUpdatedTimeGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastUpdatedTimeGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastUpdatedTimeLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastUpdatedTimeLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastUpdatedTimeBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastMembersUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastMembersUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastMembersUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastMembersUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastMembersUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 8,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastMembersUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastAdminsUpdatedTimeEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastAdminsUpdatedTimeGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastAdminsUpdatedTimeGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastAdminsUpdatedTimeLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastAdminsUpdatedTimeLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      lastAdminsUpdatedTimeBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      muteEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringEqualTo(
    String? value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringGreaterThan(
    String? value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringGreaterThanOrEqualTo(
    String? value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringLessThan(
    String? value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringLessThanOrEqualTo(
    String? value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      adminsStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 13,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      aboutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 13,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 14,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pictureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 14,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedIsEmpty() {
    return not().group(
      (q) => q.pinnedIsNull().or().pinnedIsNotEmpty(),
    );
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pinnedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 15, value: null),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementGreaterThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementGreaterThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementLessThan(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementLessThanOrEqualTo(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementBetween(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersIsEmpty() {
    return not().group(
      (q) => q.membersIsNull().or().membersIsNotEmpty(),
    );
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      membersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 16, value: null),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      levelEqualTo(
    int value,
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      levelGreaterThan(
    int value,
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      levelGreaterThanOrEqualTo(
    int value,
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      levelLessThan(
    int value,
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      levelLessThanOrEqualTo(
    int value,
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      levelBetween(
    int lower,
    int upper,
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pointEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pointGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pointGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pointLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pointLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 18,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      pointBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 18,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierEqualTo(
    String value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierGreaterThan(
    String value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierLessThan(
    String value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierBetween(
    String lower,
    String upper, {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierStartsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierEndsWith(
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 19,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterFilterCondition>
      identifierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 19,
          value: '',
        ),
      );
    });
  }
}

extension RelayGroupDBISARQueryObject
    on QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QFilterCondition> {}

extension RelayGroupDBISARQuerySortBy
    on QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QSortBy> {
  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByRelayDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByRelayPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByRelayPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByPrivateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByLastUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByLastMembersUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByLastMembersUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByLastAdminsUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByLastAdminsUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByMuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByAdminsString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByAdminsStringDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        13,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByAboutDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        13,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        14,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByPictureDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        14,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> sortByPoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByPointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByIdentifier({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        19,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      sortByIdentifierDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        19,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension RelayGroupDBISARQuerySortThenBy
    on QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QSortThenBy> {
  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByRelayDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByRelayPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByRelayPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByPrivateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByLastUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByLastMembersUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByLastMembersUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByLastAdminsUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByLastAdminsUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByMuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByAdminsString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByAdminsStringDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByAboutDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByPictureDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy> thenByPoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByPointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByIdentifier({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterSortBy>
      thenByIdentifierDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension RelayGroupDBISARQueryWhereDistinct
    on QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QDistinct> {
  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByAuthor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByRelay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByRelayPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByPrivate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByLastMembersUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByLastAdminsUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByAdminsString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByAbout({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByPicture({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByMembers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByPoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(18);
    });
  }

  QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QAfterDistinct>
      distinctByIdentifier({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(19, caseSensitive: caseSensitive);
    });
  }
}

extension RelayGroupDBISARQueryProperty1
    on QueryBuilder<RelayGroupDBISAR, RelayGroupDBISAR, QProperty> {
  QueryBuilder<RelayGroupDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String, QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String, QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String, QAfterProperty> relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String, QAfterProperty> relayPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<RelayGroupDBISAR, bool, QAfterProperty> privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<RelayGroupDBISAR, bool, QAfterProperty> closedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<RelayGroupDBISAR, int, QAfterProperty>
      lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<RelayGroupDBISAR, int, QAfterProperty>
      lastMembersUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<RelayGroupDBISAR, int, QAfterProperty>
      lastAdminsUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<RelayGroupDBISAR, bool, QAfterProperty> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String?, QAfterProperty>
      adminsStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String, QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String, QAfterProperty> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<RelayGroupDBISAR, List<String>?, QAfterProperty>
      pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<RelayGroupDBISAR, List<String>?, QAfterProperty>
      membersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<RelayGroupDBISAR, int, QAfterProperty> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<RelayGroupDBISAR, int, QAfterProperty> pointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<RelayGroupDBISAR, String, QAfterProperty> identifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }
}

extension RelayGroupDBISARQueryProperty2<R>
    on QueryBuilder<RelayGroupDBISAR, R, QAfterProperty> {
  QueryBuilder<RelayGroupDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String), QAfterProperty>
      groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String), QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String), QAfterProperty> relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String), QAfterProperty>
      relayPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, bool), QAfterProperty> privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, bool), QAfterProperty> closedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, int), QAfterProperty>
      lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, int), QAfterProperty>
      lastMembersUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, int), QAfterProperty>
      lastAdminsUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, bool), QAfterProperty> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String?), QAfterProperty>
      adminsStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String), QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String), QAfterProperty>
      pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, List<String>?), QAfterProperty>
      pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, List<String>?), QAfterProperty>
      membersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, int), QAfterProperty> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, int), QAfterProperty> pointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R, String), QAfterProperty>
      identifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }
}

extension RelayGroupDBISARQueryProperty3<R1, R2>
    on QueryBuilder<RelayGroupDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<RelayGroupDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String), QOperations>
      groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String), QOperations>
      authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String), QOperations>
      relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String), QOperations>
      relayPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, bool), QOperations>
      privateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, bool), QOperations> closedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, int), QOperations>
      lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, int), QOperations>
      lastMembersUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, int), QOperations>
      lastAdminsUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, bool), QOperations> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String?), QOperations>
      adminsStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String), QOperations>
      aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String), QOperations>
      pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, List<String>?), QOperations>
      pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, List<String>?), QOperations>
      membersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, int), QOperations> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, int), QOperations> pointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<RelayGroupDBISAR, (R1, R2, String), QOperations>
      identifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }
}
