// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badgeAwardDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetBadgeAwardDBISARCollection on Isar {
  IsarCollection<int, BadgeAwardDBISAR> get badgeAwardDBISARs =>
      this.collection();
}

const BadgeAwardDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'BadgeAwardDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'awardId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'awardTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'identifies',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'creator',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'relay',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'badgeOwner',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'badgeId',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'awardId',
        properties: [
          "awardId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, BadgeAwardDBISAR>(
    serialize: serializeBadgeAwardDBISAR,
    deserialize: deserializeBadgeAwardDBISAR,
    deserializeProperty: deserializeBadgeAwardDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeBadgeAwardDBISAR(IsarWriter writer, BadgeAwardDBISAR object) {
  IsarCore.writeString(writer, 1, object.awardId);
  IsarCore.writeLong(writer, 2, object.awardTime);
  IsarCore.writeString(writer, 3, object.identifies);
  IsarCore.writeString(writer, 4, object.creator);
  IsarCore.writeString(writer, 5, object.relay);
  IsarCore.writeString(writer, 6, object.badgeOwner);
  IsarCore.writeString(writer, 7, object.badgeId);
  return object.id;
}

@isarProtected
BadgeAwardDBISAR deserializeBadgeAwardDBISAR(IsarReader reader) {
  final String _awardId;
  _awardId = IsarCore.readString(reader, 1) ?? '';
  final int _awardTime;
  {
    final value = IsarCore.readLong(reader, 2);
    if (value == -9223372036854775808) {
      _awardTime = 0;
    } else {
      _awardTime = value;
    }
  }
  final String _identifies;
  _identifies = IsarCore.readString(reader, 3) ?? '';
  final String _creator;
  _creator = IsarCore.readString(reader, 4) ?? '';
  final String _relay;
  _relay = IsarCore.readString(reader, 5) ?? '';
  final String _badgeOwner;
  _badgeOwner = IsarCore.readString(reader, 6) ?? '';
  final String _badgeId;
  _badgeId = IsarCore.readString(reader, 7) ?? '';
  final object = BadgeAwardDBISAR(
    awardId: _awardId,
    awardTime: _awardTime,
    identifies: _identifies,
    creator: _creator,
    relay: _relay,
    badgeOwner: _badgeOwner,
    badgeId: _badgeId,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeBadgeAwardDBISARProp(IsarReader reader, int property) {
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
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _BadgeAwardDBISARUpdate {
  bool call({
    required int id,
    String? awardId,
    int? awardTime,
    String? identifies,
    String? creator,
    String? relay,
    String? badgeOwner,
    String? badgeId,
  });
}

class _BadgeAwardDBISARUpdateImpl implements _BadgeAwardDBISARUpdate {
  const _BadgeAwardDBISARUpdateImpl(this.collection);

  final IsarCollection<int, BadgeAwardDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? awardId = ignore,
    Object? awardTime = ignore,
    Object? identifies = ignore,
    Object? creator = ignore,
    Object? relay = ignore,
    Object? badgeOwner = ignore,
    Object? badgeId = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (awardId != ignore) 1: awardId as String?,
          if (awardTime != ignore) 2: awardTime as int?,
          if (identifies != ignore) 3: identifies as String?,
          if (creator != ignore) 4: creator as String?,
          if (relay != ignore) 5: relay as String?,
          if (badgeOwner != ignore) 6: badgeOwner as String?,
          if (badgeId != ignore) 7: badgeId as String?,
        }) >
        0;
  }
}

sealed class _BadgeAwardDBISARUpdateAll {
  int call({
    required List<int> id,
    String? awardId,
    int? awardTime,
    String? identifies,
    String? creator,
    String? relay,
    String? badgeOwner,
    String? badgeId,
  });
}

class _BadgeAwardDBISARUpdateAllImpl implements _BadgeAwardDBISARUpdateAll {
  const _BadgeAwardDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, BadgeAwardDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? awardId = ignore,
    Object? awardTime = ignore,
    Object? identifies = ignore,
    Object? creator = ignore,
    Object? relay = ignore,
    Object? badgeOwner = ignore,
    Object? badgeId = ignore,
  }) {
    return collection.updateProperties(id, {
      if (awardId != ignore) 1: awardId as String?,
      if (awardTime != ignore) 2: awardTime as int?,
      if (identifies != ignore) 3: identifies as String?,
      if (creator != ignore) 4: creator as String?,
      if (relay != ignore) 5: relay as String?,
      if (badgeOwner != ignore) 6: badgeOwner as String?,
      if (badgeId != ignore) 7: badgeId as String?,
    });
  }
}

extension BadgeAwardDBISARUpdate on IsarCollection<int, BadgeAwardDBISAR> {
  _BadgeAwardDBISARUpdate get update => _BadgeAwardDBISARUpdateImpl(this);

  _BadgeAwardDBISARUpdateAll get updateAll =>
      _BadgeAwardDBISARUpdateAllImpl(this);
}

sealed class _BadgeAwardDBISARQueryUpdate {
  int call({
    String? awardId,
    int? awardTime,
    String? identifies,
    String? creator,
    String? relay,
    String? badgeOwner,
    String? badgeId,
  });
}

class _BadgeAwardDBISARQueryUpdateImpl implements _BadgeAwardDBISARQueryUpdate {
  const _BadgeAwardDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<BadgeAwardDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? awardId = ignore,
    Object? awardTime = ignore,
    Object? identifies = ignore,
    Object? creator = ignore,
    Object? relay = ignore,
    Object? badgeOwner = ignore,
    Object? badgeId = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (awardId != ignore) 1: awardId as String?,
      if (awardTime != ignore) 2: awardTime as int?,
      if (identifies != ignore) 3: identifies as String?,
      if (creator != ignore) 4: creator as String?,
      if (relay != ignore) 5: relay as String?,
      if (badgeOwner != ignore) 6: badgeOwner as String?,
      if (badgeId != ignore) 7: badgeId as String?,
    });
  }
}

extension BadgeAwardDBISARQueryUpdate on IsarQuery<BadgeAwardDBISAR> {
  _BadgeAwardDBISARQueryUpdate get updateFirst =>
      _BadgeAwardDBISARQueryUpdateImpl(this, limit: 1);

  _BadgeAwardDBISARQueryUpdate get updateAll =>
      _BadgeAwardDBISARQueryUpdateImpl(this);
}

class _BadgeAwardDBISARQueryBuilderUpdateImpl
    implements _BadgeAwardDBISARQueryUpdate {
  const _BadgeAwardDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? awardId = ignore,
    Object? awardTime = ignore,
    Object? identifies = ignore,
    Object? creator = ignore,
    Object? relay = ignore,
    Object? badgeOwner = ignore,
    Object? badgeId = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (awardId != ignore) 1: awardId as String?,
        if (awardTime != ignore) 2: awardTime as int?,
        if (identifies != ignore) 3: identifies as String?,
        if (creator != ignore) 4: creator as String?,
        if (relay != ignore) 5: relay as String?,
        if (badgeOwner != ignore) 6: badgeOwner as String?,
        if (badgeId != ignore) 7: badgeId as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension BadgeAwardDBISARQueryBuilderUpdate
    on QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QOperations> {
  _BadgeAwardDBISARQueryUpdate get updateFirst =>
      _BadgeAwardDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _BadgeAwardDBISARQueryUpdate get updateAll =>
      _BadgeAwardDBISARQueryBuilderUpdateImpl(this);
}

extension BadgeAwardDBISARQueryFilter
    on QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QFilterCondition> {
  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdGreaterThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdLessThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdLessThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdBetween(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdStartsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdEndsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardTimeEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardTimeGreaterThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardTimeGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardTimeLessThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardTimeLessThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      awardTimeBetween(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesGreaterThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesLessThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesLessThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesBetween(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesStartsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesEndsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      identifiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayGreaterThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayLessThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayLessThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayBetween(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayStartsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayEndsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      relayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerGreaterThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerLessThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerLessThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerBetween(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerStartsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerEndsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeOwnerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdGreaterThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdLessThan(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdLessThanOrEqualTo(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdBetween(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdStartsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdEndsWith(
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterFilterCondition>
      badgeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }
}

extension BadgeAwardDBISARQueryObject
    on QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QFilterCondition> {}

extension BadgeAwardDBISARQuerySortBy
    on QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QSortBy> {
  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> sortByAwardId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByAwardIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByAwardTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByAwardTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByIdentifies({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByIdentifiesDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> sortByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByCreatorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> sortByRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByRelayDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByBadgeOwner({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByBadgeOwnerDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> sortByBadgeId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      sortByBadgeIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension BadgeAwardDBISARQuerySortThenBy
    on QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QSortThenBy> {
  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> thenByAwardId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByAwardIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByAwardTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByAwardTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByIdentifies({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByIdentifiesDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> thenByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByCreatorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> thenByRelay(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByRelayDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByBadgeOwner({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByBadgeOwnerDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy> thenByBadgeId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterSortBy>
      thenByBadgeIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension BadgeAwardDBISARQueryWhereDistinct
    on QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QDistinct> {
  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterDistinct>
      distinctByAwardId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterDistinct>
      distinctByAwardTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterDistinct>
      distinctByIdentifies({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterDistinct>
      distinctByCreator({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterDistinct>
      distinctByRelay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterDistinct>
      distinctByBadgeOwner({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QAfterDistinct>
      distinctByBadgeId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }
}

extension BadgeAwardDBISARQueryProperty1
    on QueryBuilder<BadgeAwardDBISAR, BadgeAwardDBISAR, QProperty> {
  QueryBuilder<BadgeAwardDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, String, QAfterProperty> awardIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, int, QAfterProperty> awardTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, String, QAfterProperty> identifiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, String, QAfterProperty> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, String, QAfterProperty> relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, String, QAfterProperty> badgeOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, String, QAfterProperty> badgeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension BadgeAwardDBISARQueryProperty2<R>
    on QueryBuilder<BadgeAwardDBISAR, R, QAfterProperty> {
  QueryBuilder<BadgeAwardDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R, String), QAfterProperty>
      awardIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R, int), QAfterProperty> awardTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R, String), QAfterProperty>
      identifiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R, String), QAfterProperty>
      creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R, String), QAfterProperty> relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R, String), QAfterProperty>
      badgeOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R, String), QAfterProperty>
      badgeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension BadgeAwardDBISARQueryProperty3<R1, R2>
    on QueryBuilder<BadgeAwardDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<BadgeAwardDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R1, R2, String), QOperations>
      awardIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R1, R2, int), QOperations>
      awardTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R1, R2, String), QOperations>
      identifiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R1, R2, String), QOperations>
      creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R1, R2, String), QOperations>
      relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R1, R2, String), QOperations>
      badgeOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BadgeAwardDBISAR, (R1, R2, String), QOperations>
      badgeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}
