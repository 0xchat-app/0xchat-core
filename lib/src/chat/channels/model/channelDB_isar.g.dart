// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channelDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetChannelDBISARCollection on Isar {
  IsarCollection<int, ChannelDBISAR> get channelDBISARs => this.collection();
}

const ChannelDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ChannelDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'channelId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'createTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'updateTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'creator',
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
        name: 'badges',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'relayURL',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'mute',
        type: IsarType.bool,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'channelId',
        properties: [
          "channelId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, ChannelDBISAR>(
    serialize: serializeChannelDBISAR,
    deserialize: deserializeChannelDBISAR,
    deserializeProperty: deserializeChannelDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeChannelDBISAR(IsarWriter writer, ChannelDBISAR object) {
  IsarCore.writeString(writer, 1, object.channelId);
  IsarCore.writeLong(writer, 2, object.createTime);
  IsarCore.writeLong(writer, 3, object.updateTime);
  IsarCore.writeString(writer, 4, object.creator);
  {
    final value = object.name;
    if (value == null) {
      IsarCore.writeNull(writer, 5);
    } else {
      IsarCore.writeString(writer, 5, value);
    }
  }
  {
    final value = object.about;
    if (value == null) {
      IsarCore.writeNull(writer, 6);
    } else {
      IsarCore.writeString(writer, 6, value);
    }
  }
  {
    final value = object.picture;
    if (value == null) {
      IsarCore.writeNull(writer, 7);
    } else {
      IsarCore.writeString(writer, 7, value);
    }
  }
  {
    final value = object.badges;
    if (value == null) {
      IsarCore.writeNull(writer, 8);
    } else {
      IsarCore.writeString(writer, 8, value);
    }
  }
  {
    final value = object.relayURL;
    if (value == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      IsarCore.writeString(writer, 9, value);
    }
  }
  {
    final value = object.mute;
    if (value == null) {
      IsarCore.writeNull(writer, 10);
    } else {
      IsarCore.writeBool(writer, 10, value);
    }
  }
  return object.id;
}

@isarProtected
ChannelDBISAR deserializeChannelDBISAR(IsarReader reader) {
  final String _channelId;
  _channelId = IsarCore.readString(reader, 1) ?? '';
  final int _createTime;
  {
    final value = IsarCore.readLong(reader, 2);
    if (value == -9223372036854775808) {
      _createTime = 0;
    } else {
      _createTime = value;
    }
  }
  final int _updateTime;
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _updateTime = 0;
    } else {
      _updateTime = value;
    }
  }
  final String _creator;
  _creator = IsarCore.readString(reader, 4) ?? '';
  final String? _name;
  _name = IsarCore.readString(reader, 5) ?? '';
  final String? _about;
  _about = IsarCore.readString(reader, 6) ?? '';
  final String? _picture;
  _picture = IsarCore.readString(reader, 7) ?? '';
  final String? _badges;
  _badges = IsarCore.readString(reader, 8) ?? '';
  final String? _relayURL;
  _relayURL = IsarCore.readString(reader, 9) ?? '';
  final bool? _mute;
  _mute = IsarCore.readBool(reader, 10);
  final object = ChannelDBISAR(
    channelId: _channelId,
    createTime: _createTime,
    updateTime: _updateTime,
    creator: _creator,
    name: _name,
    about: _about,
    picture: _picture,
    badges: _badges,
    relayURL: _relayURL,
    mute: _mute,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeChannelDBISARProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      {
        final value = IsarCore.readLong(reader, 2);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
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
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      return IsarCore.readString(reader, 8) ?? '';
    case 9:
      return IsarCore.readString(reader, 9) ?? '';
    case 10:
      return IsarCore.readBool(reader, 10);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ChannelDBISARUpdate {
  bool call({
    required int id,
    String? channelId,
    int? createTime,
    int? updateTime,
    String? creator,
    String? name,
    String? about,
    String? picture,
    String? badges,
    String? relayURL,
    bool? mute,
  });
}

class _ChannelDBISARUpdateImpl implements _ChannelDBISARUpdate {
  const _ChannelDBISARUpdateImpl(this.collection);

  final IsarCollection<int, ChannelDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? channelId = ignore,
    Object? createTime = ignore,
    Object? updateTime = ignore,
    Object? creator = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? badges = ignore,
    Object? relayURL = ignore,
    Object? mute = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (channelId != ignore) 1: channelId as String?,
          if (createTime != ignore) 2: createTime as int?,
          if (updateTime != ignore) 3: updateTime as int?,
          if (creator != ignore) 4: creator as String?,
          if (name != ignore) 5: name as String?,
          if (about != ignore) 6: about as String?,
          if (picture != ignore) 7: picture as String?,
          if (badges != ignore) 8: badges as String?,
          if (relayURL != ignore) 9: relayURL as String?,
          if (mute != ignore) 10: mute as bool?,
        }) >
        0;
  }
}

sealed class _ChannelDBISARUpdateAll {
  int call({
    required List<int> id,
    String? channelId,
    int? createTime,
    int? updateTime,
    String? creator,
    String? name,
    String? about,
    String? picture,
    String? badges,
    String? relayURL,
    bool? mute,
  });
}

class _ChannelDBISARUpdateAllImpl implements _ChannelDBISARUpdateAll {
  const _ChannelDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, ChannelDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? channelId = ignore,
    Object? createTime = ignore,
    Object? updateTime = ignore,
    Object? creator = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? badges = ignore,
    Object? relayURL = ignore,
    Object? mute = ignore,
  }) {
    return collection.updateProperties(id, {
      if (channelId != ignore) 1: channelId as String?,
      if (createTime != ignore) 2: createTime as int?,
      if (updateTime != ignore) 3: updateTime as int?,
      if (creator != ignore) 4: creator as String?,
      if (name != ignore) 5: name as String?,
      if (about != ignore) 6: about as String?,
      if (picture != ignore) 7: picture as String?,
      if (badges != ignore) 8: badges as String?,
      if (relayURL != ignore) 9: relayURL as String?,
      if (mute != ignore) 10: mute as bool?,
    });
  }
}

extension ChannelDBISARUpdate on IsarCollection<int, ChannelDBISAR> {
  _ChannelDBISARUpdate get update => _ChannelDBISARUpdateImpl(this);

  _ChannelDBISARUpdateAll get updateAll => _ChannelDBISARUpdateAllImpl(this);
}

sealed class _ChannelDBISARQueryUpdate {
  int call({
    String? channelId,
    int? createTime,
    int? updateTime,
    String? creator,
    String? name,
    String? about,
    String? picture,
    String? badges,
    String? relayURL,
    bool? mute,
  });
}

class _ChannelDBISARQueryUpdateImpl implements _ChannelDBISARQueryUpdate {
  const _ChannelDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ChannelDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? channelId = ignore,
    Object? createTime = ignore,
    Object? updateTime = ignore,
    Object? creator = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? badges = ignore,
    Object? relayURL = ignore,
    Object? mute = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (channelId != ignore) 1: channelId as String?,
      if (createTime != ignore) 2: createTime as int?,
      if (updateTime != ignore) 3: updateTime as int?,
      if (creator != ignore) 4: creator as String?,
      if (name != ignore) 5: name as String?,
      if (about != ignore) 6: about as String?,
      if (picture != ignore) 7: picture as String?,
      if (badges != ignore) 8: badges as String?,
      if (relayURL != ignore) 9: relayURL as String?,
      if (mute != ignore) 10: mute as bool?,
    });
  }
}

extension ChannelDBISARQueryUpdate on IsarQuery<ChannelDBISAR> {
  _ChannelDBISARQueryUpdate get updateFirst =>
      _ChannelDBISARQueryUpdateImpl(this, limit: 1);

  _ChannelDBISARQueryUpdate get updateAll =>
      _ChannelDBISARQueryUpdateImpl(this);
}

class _ChannelDBISARQueryBuilderUpdateImpl
    implements _ChannelDBISARQueryUpdate {
  const _ChannelDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ChannelDBISAR, ChannelDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? channelId = ignore,
    Object? createTime = ignore,
    Object? updateTime = ignore,
    Object? creator = ignore,
    Object? name = ignore,
    Object? about = ignore,
    Object? picture = ignore,
    Object? badges = ignore,
    Object? relayURL = ignore,
    Object? mute = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (channelId != ignore) 1: channelId as String?,
        if (createTime != ignore) 2: createTime as int?,
        if (updateTime != ignore) 3: updateTime as int?,
        if (creator != ignore) 4: creator as String?,
        if (name != ignore) 5: name as String?,
        if (about != ignore) 6: about as String?,
        if (picture != ignore) 7: picture as String?,
        if (badges != ignore) 8: badges as String?,
        if (relayURL != ignore) 9: relayURL as String?,
        if (mute != ignore) 10: mute as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension ChannelDBISARQueryBuilderUpdate
    on QueryBuilder<ChannelDBISAR, ChannelDBISAR, QOperations> {
  _ChannelDBISARQueryUpdate get updateFirst =>
      _ChannelDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _ChannelDBISARQueryUpdate get updateAll =>
      _ChannelDBISARQueryBuilderUpdateImpl(this);
}

extension ChannelDBISARQueryFilter
    on QueryBuilder<ChannelDBISAR, ChannelDBISAR, QFilterCondition> {
  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdGreaterThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdGreaterThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdLessThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdLessThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdBetween(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdStartsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdEndsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      channelIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      createTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      createTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      createTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      createTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      createTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      createTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorGreaterThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorGreaterThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorLessThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorLessThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorBetween(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorStartsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorEndsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      creatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition> nameEqualTo(
    String? value, {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
    String? value, {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameLessThan(
    String? value, {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameLessThanOrEqualTo(
    String? value, {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutGreaterThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutGreaterThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutLessThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutLessThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutBetween(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutStartsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutEndsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      aboutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureGreaterThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureGreaterThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureLessThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureLessThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureBetween(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureStartsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureEndsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      pictureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesGreaterThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesGreaterThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesLessThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesLessThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesBetween(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesStartsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesEndsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      badgesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLGreaterThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLGreaterThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLLessThan(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLLessThanOrEqualTo(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLBetween(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLStartsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLEndsWith(
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      relayURLIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      muteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition>
      muteIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterFilterCondition> muteEqualTo(
    bool? value,
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
}

extension ChannelDBISARQueryObject
    on QueryBuilder<ChannelDBISAR, ChannelDBISAR, QFilterCondition> {}

extension ChannelDBISARQuerySortBy
    on QueryBuilder<ChannelDBISAR, ChannelDBISAR, QSortBy> {
  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByChannelId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByChannelIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy>
      sortByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy>
      sortByUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByCreatorDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByAboutDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByPictureDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByBadges(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByBadgesDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByRelayURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByRelayURLDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> sortByMuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }
}

extension ChannelDBISARQuerySortThenBy
    on QueryBuilder<ChannelDBISAR, ChannelDBISAR, QSortThenBy> {
  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByChannelId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByChannelIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy>
      thenByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy>
      thenByUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByCreatorDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByAboutDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByPictureDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByBadges(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByBadgesDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByRelayURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByRelayURLDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterSortBy> thenByMuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }
}

extension ChannelDBISARQueryWhereDistinct
    on QueryBuilder<ChannelDBISAR, ChannelDBISAR, QDistinct> {
  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct>
      distinctByChannelId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct>
      distinctByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct>
      distinctByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct> distinctByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct> distinctByAbout(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct> distinctByPicture(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct> distinctByBadges(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct> distinctByRelayURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChannelDBISAR, ChannelDBISAR, QAfterDistinct> distinctByMute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }
}

extension ChannelDBISARQueryProperty1
    on QueryBuilder<ChannelDBISAR, ChannelDBISAR, QProperty> {
  QueryBuilder<ChannelDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ChannelDBISAR, String, QAfterProperty> channelIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ChannelDBISAR, int, QAfterProperty> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ChannelDBISAR, int, QAfterProperty> updateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ChannelDBISAR, String, QAfterProperty> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ChannelDBISAR, String?, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ChannelDBISAR, String?, QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ChannelDBISAR, String?, QAfterProperty> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ChannelDBISAR, String?, QAfterProperty> badgesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ChannelDBISAR, String?, QAfterProperty> relayURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ChannelDBISAR, bool?, QAfterProperty> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension ChannelDBISARQueryProperty2<R>
    on QueryBuilder<ChannelDBISAR, R, QAfterProperty> {
  QueryBuilder<ChannelDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, String), QAfterProperty> channelIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, int), QAfterProperty> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, int), QAfterProperty> updateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, String), QAfterProperty> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, String?), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, String?), QAfterProperty> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, String?), QAfterProperty> pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, String?), QAfterProperty> badgesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, String?), QAfterProperty> relayURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ChannelDBISAR, (R, bool?), QAfterProperty> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension ChannelDBISARQueryProperty3<R1, R2>
    on QueryBuilder<ChannelDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<ChannelDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, String), QOperations>
      channelIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, int), QOperations> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, int), QOperations> updateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, String), QOperations> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, String?), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, String?), QOperations> aboutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, String?), QOperations>
      pictureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, String?), QOperations> badgesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, String?), QOperations>
      relayURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ChannelDBISAR, (R1, R2, bool?), QOperations> muteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}
