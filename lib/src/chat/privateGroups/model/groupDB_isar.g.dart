// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetGroupDBISARCollection on Isar {
  IsarCollection<int, GroupDBISAR> get groupDBISARs => this.collection();
}

const GroupDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'GroupDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'groupId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'owner',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'updateTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'mute',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'members',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'pinned',
        type: IsarType.stringList,
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
        name: 'relay',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'isMLSGroup',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'isDirectMessage',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'mlsGroupId',
        type: IsarType.longList,
      ),
      IsarPropertySchema(
        name: 'epoch',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'adminPubkeys',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'welcomeWrapperEventId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'welcomeEventString',
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
  converter: IsarObjectConverter<int, GroupDBISAR>(
    serialize: serializeGroupDBISAR,
    deserialize: deserializeGroupDBISAR,
    deserializeProperty: deserializeGroupDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeGroupDBISAR(IsarWriter writer, GroupDBISAR object) {
  IsarCore.writeString(writer, 1, object.groupId);
  IsarCore.writeString(writer, 2, object.owner);
  IsarCore.writeLong(writer, 3, object.updateTime);
  IsarCore.writeBool(writer, 4, object.mute);
  IsarCore.writeString(writer, 5, object.name);
  {
    final list = object.members;
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
  {
    final list = object.pinned;
    if (list == null) {
      IsarCore.writeNull(writer, 7);
    } else {
      final listWriter = IsarCore.beginList(writer, 7, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeString(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final value = object.about;
    if (value == null) {
      IsarCore.writeNull(writer, 8);
    } else {
      IsarCore.writeString(writer, 8, value);
    }
  }
  {
    final value = object.picture;
    if (value == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      IsarCore.writeString(writer, 9, value);
    }
  }
  {
    final value = object.relay;
    if (value == null) {
      IsarCore.writeNull(writer, 10);
    } else {
      IsarCore.writeString(writer, 10, value);
    }
  }
  IsarCore.writeBool(writer, 11, object.isMLSGroup);
  IsarCore.writeBool(writer, 12, object.isDirectMessage);
  {
    final list = object.mlsGroupId;
    if (list == null) {
      IsarCore.writeNull(writer, 13);
    } else {
      final listWriter = IsarCore.beginList(writer, 13, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeLong(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  IsarCore.writeLong(writer, 14, object.epoch);
  {
    final list = object.adminPubkeys;
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
    final value = object.welcomeWrapperEventId;
    if (value == null) {
      IsarCore.writeNull(writer, 16);
    } else {
      IsarCore.writeString(writer, 16, value);
    }
  }
  {
    final value = object.welcomeEventString;
    if (value == null) {
      IsarCore.writeNull(writer, 17);
    } else {
      IsarCore.writeString(writer, 17, value);
    }
  }
  return object.id;
}

@isarProtected
GroupDBISAR deserializeGroupDBISAR(IsarReader reader) {
  final String _groupId;
  _groupId = IsarCore.readString(reader, 1) ?? '';
  final String _owner;
  _owner = IsarCore.readString(reader, 2) ?? '';
  final int _updateTime;
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _updateTime = 0;
    } else {
      _updateTime = value;
    }
  }
  final bool _mute;
  _mute = IsarCore.readBool(reader, 4);
  final String _name;
  _name = IsarCore.readString(reader, 5) ?? '';
  final List<String>? _members;
  {
    final length = IsarCore.readList(reader, 6, IsarCore.readerPtrPtr);
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
  final List<String>? _pinned;
  {
    final length = IsarCore.readList(reader, 7, IsarCore.readerPtrPtr);
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
  final String? _about;
  _about = IsarCore.readString(reader, 8);
  final String? _picture;
  _picture = IsarCore.readString(reader, 9);
  final String? _relay;
  _relay = IsarCore.readString(reader, 10);
  final bool _isMLSGroup;
  _isMLSGroup = IsarCore.readBool(reader, 11);
  final bool _isDirectMessage;
  _isDirectMessage = IsarCore.readBool(reader, 12);
  final List<int>? _mlsGroupId;
  {
    final length = IsarCore.readList(reader, 13, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _mlsGroupId = null;
      } else {
        final list =
            List<int>.filled(length, -9223372036854775808, growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readLong(reader, i);
        }
        IsarCore.freeReader(reader);
        _mlsGroupId = list;
      }
    }
  }
  final int _epoch;
  {
    final value = IsarCore.readLong(reader, 14);
    if (value == -9223372036854775808) {
      _epoch = 0;
    } else {
      _epoch = value;
    }
  }
  final List<String>? _adminPubkeys;
  {
    final length = IsarCore.readList(reader, 15, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _adminPubkeys = null;
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _adminPubkeys = list;
      }
    }
  }
  final String? _welcomeWrapperEventId;
  _welcomeWrapperEventId = IsarCore.readString(reader, 16);
  final String? _welcomeEventString;
  _welcomeEventString = IsarCore.readString(reader, 17);
  final object = GroupDBISAR(
    groupId: _groupId,
    owner: _owner,
    updateTime: _updateTime,
    mute: _mute,
    name: _name,
    members: _members,
    pinned: _pinned,
    about: _about,
    picture: _picture,
    relay: _relay,
    isMLSGroup: _isMLSGroup,
    isDirectMessage: _isDirectMessage,
    mlsGroupId: _mlsGroupId,
    epoch: _epoch,
    adminPubkeys: _adminPubkeys,
    welcomeWrapperEventId: _welcomeWrapperEventId,
    welcomeEventString: _welcomeEventString,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeGroupDBISARProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      {
        final value = IsarCore.readLong(reader, 3);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 4:
      return IsarCore.readBool(reader, 4);
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
        final length = IsarCore.readList(reader, 7, IsarCore.readerPtrPtr);
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
    case 8:
      return IsarCore.readString(reader, 8);
    case 9:
      return IsarCore.readString(reader, 9);
    case 10:
      return IsarCore.readString(reader, 10);
    case 11:
      return IsarCore.readBool(reader, 11);
    case 12:
      return IsarCore.readBool(reader, 12);
    case 13:
      {
        final length = IsarCore.readList(reader, 13, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return null;
          } else {
            final list =
                List<int>.filled(length, -9223372036854775808, growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readLong(reader, i);
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 14:
      {
        final value = IsarCore.readLong(reader, 14);
        if (value == -9223372036854775808) {
          return 0;
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
      return IsarCore.readString(reader, 16);
    case 17:
      return IsarCore.readString(reader, 17);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _GroupDBISARUpdate {
  bool call({
    required int id,
    String? groupId,
    String? owner,
    int? updateTime,
    bool? mute,
    String? name,
    String? about,
    String? picture,
    String? relay,
    bool? isMLSGroup,
    bool? isDirectMessage,
    int? epoch,
    String? welcomeWrapperEventId,
    String? welcomeEventString,
  });
}

class _GroupDBISARUpdateImpl implements _GroupDBISARUpdate {
  const _GroupDBISARUpdateImpl(this.collection);

  final IsarCollection<int, GroupDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? groupId = ignore,
    Object? owner = ignore,
    Object? updateTime = ignore,
    Object? mute = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? relay = ignore,
    Object? isMLSGroup = ignore,
    Object? isDirectMessage = ignore,
    Object? epoch = ignore,
    Object? welcomeWrapperEventId = ignore,
    Object? welcomeEventString = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (groupId != ignore) 1: groupId as String?,
          if (owner != ignore) 2: owner as String?,
          if (updateTime != ignore) 3: updateTime as int?,
          if (mute != ignore) 4: mute as bool?,
          if (name != ignore) 5: name as String?,
          if (about != ignore) 8: about as String?,
          if (picture != ignore) 9: picture as String?,
          if (relay != ignore) 10: relay as String?,
          if (isMLSGroup != ignore) 11: isMLSGroup as bool?,
          if (isDirectMessage != ignore) 12: isDirectMessage as bool?,
          if (epoch != ignore) 14: epoch as int?,
          if (welcomeWrapperEventId != ignore)
            16: welcomeWrapperEventId as String?,
          if (welcomeEventString != ignore) 17: welcomeEventString as String?,
        }) >
        0;
  }
}

sealed class _GroupDBISARUpdateAll {
  int call({
    required List<int> id,
    String? groupId,
    String? owner,
    int? updateTime,
    bool? mute,
    String? name,
    String? about,
    String? picture,
    String? relay,
    bool? isMLSGroup,
    bool? isDirectMessage,
    int? epoch,
    String? welcomeWrapperEventId,
    String? welcomeEventString,
  });
}

class _GroupDBISARUpdateAllImpl implements _GroupDBISARUpdateAll {
  const _GroupDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, GroupDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? groupId = ignore,
    Object? owner = ignore,
    Object? updateTime = ignore,
    Object? mute = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? relay = ignore,
    Object? isMLSGroup = ignore,
    Object? isDirectMessage = ignore,
    Object? epoch = ignore,
    Object? welcomeWrapperEventId = ignore,
    Object? welcomeEventString = ignore,
  }) {
    return collection.updateProperties(id, {
      if (groupId != ignore) 1: groupId as String?,
      if (owner != ignore) 2: owner as String?,
      if (updateTime != ignore) 3: updateTime as int?,
      if (mute != ignore) 4: mute as bool?,
      if (name != ignore) 5: name as String?,
      if (about != ignore) 8: about as String?,
      if (picture != ignore) 9: picture as String?,
      if (relay != ignore) 10: relay as String?,
      if (isMLSGroup != ignore) 11: isMLSGroup as bool?,
      if (isDirectMessage != ignore) 12: isDirectMessage as bool?,
      if (epoch != ignore) 14: epoch as int?,
      if (welcomeWrapperEventId != ignore) 16: welcomeWrapperEventId as String?,
      if (welcomeEventString != ignore) 17: welcomeEventString as String?,
    });
  }
}

extension GroupDBISARUpdate on IsarCollection<int, GroupDBISAR> {
  _GroupDBISARUpdate get update => _GroupDBISARUpdateImpl(this);

  _GroupDBISARUpdateAll get updateAll => _GroupDBISARUpdateAllImpl(this);
}

sealed class _GroupDBISARQueryUpdate {
  int call({
    String? groupId,
    String? owner,
    int? updateTime,
    bool? mute,
    String? name,
    String? about,
    String? picture,
    String? relay,
    bool? isMLSGroup,
    bool? isDirectMessage,
    int? epoch,
    String? welcomeWrapperEventId,
    String? welcomeEventString,
  });
}

class _GroupDBISARQueryUpdateImpl implements _GroupDBISARQueryUpdate {
  const _GroupDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<GroupDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? groupId = ignore,
    Object? owner = ignore,
    Object? updateTime = ignore,
    Object? mute = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? relay = ignore,
    Object? isMLSGroup = ignore,
    Object? isDirectMessage = ignore,
    Object? epoch = ignore,
    Object? welcomeWrapperEventId = ignore,
    Object? welcomeEventString = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (groupId != ignore) 1: groupId as String?,
      if (owner != ignore) 2: owner as String?,
      if (updateTime != ignore) 3: updateTime as int?,
      if (mute != ignore) 4: mute as bool?,
      if (name != ignore) 5: name as String?,
      if (about != ignore) 8: about as String?,
      if (picture != ignore) 9: picture as String?,
      if (relay != ignore) 10: relay as String?,
      if (isMLSGroup != ignore) 11: isMLSGroup as bool?,
      if (isDirectMessage != ignore) 12: isDirectMessage as bool?,
      if (epoch != ignore) 14: epoch as int?,
      if (welcomeWrapperEventId != ignore) 16: welcomeWrapperEventId as String?,
      if (welcomeEventString != ignore) 17: welcomeEventString as String?,
    });
  }
}

extension GroupDBISARQueryUpdate on IsarQuery<GroupDBISAR> {
  _GroupDBISARQueryUpdate get updateFirst =>
      _GroupDBISARQueryUpdateImpl(this, limit: 1);

  _GroupDBISARQueryUpdate get updateAll => _GroupDBISARQueryUpdateImpl(this);
}

class _GroupDBISARQueryBuilderUpdateImpl implements _GroupDBISARQueryUpdate {
  const _GroupDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<GroupDBISAR, GroupDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? groupId = ignore,
    Object? owner = ignore,
    Object? updateTime = ignore,
    Object? mute = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? relay = ignore,
    Object? isMLSGroup = ignore,
    Object? isDirectMessage = ignore,
    Object? epoch = ignore,
    Object? welcomeWrapperEventId = ignore,
    Object? welcomeEventString = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (groupId != ignore) 1: groupId as String?,
        if (owner != ignore) 2: owner as String?,
        if (updateTime != ignore) 3: updateTime as int?,
        if (mute != ignore) 4: mute as bool?,
        if (name != ignore) 5: name as String?,
        if (about != ignore) 8: about as String?,
        if (picture != ignore) 9: picture as String?,
        if (relay != ignore) 10: relay as String?,
        if (isMLSGroup != ignore) 11: isMLSGroup as bool?,
        if (isDirectMessage != ignore) 12: isDirectMessage as bool?,
        if (epoch != ignore) 14: epoch as int?,
        if (welcomeWrapperEventId != ignore)
          16: welcomeWrapperEventId as String?,
        if (welcomeEventString != ignore) 17: welcomeEventString as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension GroupDBISARQueryBuilderUpdate
    on QueryBuilder<GroupDBISAR, GroupDBISAR, QOperations> {
  _GroupDBISARQueryUpdate get updateFirst =>
      _GroupDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _GroupDBISARQueryUpdate get updateAll =>
      _GroupDBISARQueryBuilderUpdateImpl(this);
}

extension GroupDBISARQueryFilter
    on QueryBuilder<GroupDBISAR, GroupDBISAR, QFilterCondition> {
  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> idBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> groupIdEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> groupIdLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> groupIdBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> groupIdEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> groupIdContains(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> groupIdMatches(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> ownerEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      ownerGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      ownerGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> ownerLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      ownerLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> ownerBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> ownerStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> ownerEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> ownerContains(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> ownerMatches(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> ownerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      ownerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      updateTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      updateTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      updateTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      updateTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      updateTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      updateTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> muteEqualTo(
    bool value,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      nameLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameContains(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersIsEmpty() {
    return not().group(
      (q) => q.membersIsNull().or().membersIsNotEmpty(),
    );
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      membersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 6, value: null),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> pinnedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedIsEmpty() {
    return not().group(
      (q) => q.pinnedIsNull().or().pinnedIsNotEmpty(),
    );
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pinnedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 7, value: null),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      aboutIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      aboutGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      aboutGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      aboutLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutContains(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutMatches(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> aboutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      aboutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pictureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pictureIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> pictureEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pictureGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pictureGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> pictureLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pictureLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> pictureBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pictureStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> pictureEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> pictureContains(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> pictureMatches(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pictureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      pictureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      relayIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayEqualTo(
    String? value, {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      relayGreaterThan(
    String? value, {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      relayGreaterThanOrEqualTo(
    String? value, {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayLessThan(
    String? value, {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      relayLessThanOrEqualTo(
    String? value, {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayContains(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayMatches(
      String pattern,
      {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> relayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      relayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      isMLSGroupEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      isDirectMessageEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdElementEqualTo(
    int value,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdElementGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdElementGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdElementLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdElementLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdElementBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 13,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdIsEmpty() {
    return not().group(
      (q) => q.mlsGroupIdIsNull().or().mlsGroupIdIsNotEmpty(),
    );
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 13, value: null),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> epochEqualTo(
    int value,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      epochGreaterThan(
    int value,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      epochGreaterThanOrEqualTo(
    int value,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> epochLessThan(
    int value,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      epochLessThanOrEqualTo(
    int value,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition> epochBetween(
    int lower,
    int upper,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 15,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysIsEmpty() {
    return not().group(
      (q) => q.adminPubkeysIsNull().or().adminPubkeysIsNotEmpty(),
    );
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      adminPubkeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 15, value: null),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdMatches(String pattern,
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeWrapperEventIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringGreaterThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringGreaterThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringLessThan(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringLessThanOrEqualTo(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringBetween(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringStartsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringEndsWith(
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 17,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterFilterCondition>
      welcomeEventStringIsNotEmpty() {
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

extension GroupDBISARQueryObject
    on QueryBuilder<GroupDBISAR, GroupDBISAR, QFilterCondition> {}

extension GroupDBISARQuerySortBy
    on QueryBuilder<GroupDBISAR, GroupDBISAR, QSortBy> {
  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByGroupIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByOwner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByOwnerDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByMuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByAboutDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByPictureDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByRelayDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByIsMLSGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByIsMLSGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByIsDirectMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy>
      sortByIsDirectMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy>
      sortByWelcomeWrapperEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy>
      sortByWelcomeWrapperEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> sortByWelcomeEventString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        17,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy>
      sortByWelcomeEventStringDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        17,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension GroupDBISARQuerySortThenBy
    on QueryBuilder<GroupDBISAR, GroupDBISAR, QSortThenBy> {
  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByGroupIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByOwner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByOwnerDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByMuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByAboutDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByPictureDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByRelayDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByIsMLSGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByIsMLSGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByIsDirectMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy>
      thenByIsDirectMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy>
      thenByWelcomeWrapperEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy>
      thenByWelcomeWrapperEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy> thenByWelcomeEventString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterSortBy>
      thenByWelcomeEventStringDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension GroupDBISARQueryWhereDistinct
    on QueryBuilder<GroupDBISAR, GroupDBISAR, QDistinct> {
  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByOwner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct>
      distinctByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByMembers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByPinned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct>
      distinctByIsMLSGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct>
      distinctByIsDirectMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct>
      distinctByMlsGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct> distinctByEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct>
      distinctByAdminPubkeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct>
      distinctByWelcomeWrapperEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupDBISAR, GroupDBISAR, QAfterDistinct>
      distinctByWelcomeEventString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17, caseSensitive: caseSensitive);
    });
  }
}

extension GroupDBISARQueryProperty1
    on QueryBuilder<GroupDBISAR, GroupDBISAR, QProperty> {
  QueryBuilder<GroupDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<GroupDBISAR, String, QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<GroupDBISAR, String, QAfterProperty> ownerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<GroupDBISAR, int, QAfterProperty> updateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<GroupDBISAR, bool, QAfterProperty> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<GroupDBISAR, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<GroupDBISAR, List<String>?, QAfterProperty> membersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<GroupDBISAR, List<String>?, QAfterProperty> pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<GroupDBISAR, String?, QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<GroupDBISAR, String?, QAfterProperty> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<GroupDBISAR, String?, QAfterProperty> relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<GroupDBISAR, bool, QAfterProperty> isMLSGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<GroupDBISAR, bool, QAfterProperty> isDirectMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<GroupDBISAR, List<int>?, QAfterProperty> mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<GroupDBISAR, int, QAfterProperty> epochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<GroupDBISAR, List<String>?, QAfterProperty>
      adminPubkeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<GroupDBISAR, String?, QAfterProperty>
      welcomeWrapperEventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<GroupDBISAR, String?, QAfterProperty>
      welcomeEventStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}

extension GroupDBISARQueryProperty2<R>
    on QueryBuilder<GroupDBISAR, R, QAfterProperty> {
  QueryBuilder<GroupDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<GroupDBISAR, (R, String), QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<GroupDBISAR, (R, String), QAfterProperty> ownerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<GroupDBISAR, (R, int), QAfterProperty> updateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<GroupDBISAR, (R, bool), QAfterProperty> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<GroupDBISAR, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<GroupDBISAR, (R, List<String>?), QAfterProperty>
      membersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<GroupDBISAR, (R, List<String>?), QAfterProperty>
      pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<GroupDBISAR, (R, String?), QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<GroupDBISAR, (R, String?), QAfterProperty> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<GroupDBISAR, (R, String?), QAfterProperty> relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<GroupDBISAR, (R, bool), QAfterProperty> isMLSGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<GroupDBISAR, (R, bool), QAfterProperty>
      isDirectMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<GroupDBISAR, (R, List<int>?), QAfterProperty>
      mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<GroupDBISAR, (R, int), QAfterProperty> epochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<GroupDBISAR, (R, List<String>?), QAfterProperty>
      adminPubkeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<GroupDBISAR, (R, String?), QAfterProperty>
      welcomeWrapperEventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<GroupDBISAR, (R, String?), QAfterProperty>
      welcomeEventStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}

extension GroupDBISARQueryProperty3<R1, R2>
    on QueryBuilder<GroupDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<GroupDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, String), QOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, String), QOperations> ownerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, int), QOperations> updateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, bool), QOperations> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, String), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, List<String>?), QOperations>
      membersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, List<String>?), QOperations>
      pinnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, String?), QOperations> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, String?), QOperations> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, String?), QOperations> relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, bool), QOperations> isMLSGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, bool), QOperations>
      isDirectMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, List<int>?), QOperations>
      mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, int), QOperations> epochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, List<String>?), QOperations>
      adminPubkeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, String?), QOperations>
      welcomeWrapperEventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<GroupDBISAR, (R1, R2, String?), QOperations>
      welcomeEventStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }
}
