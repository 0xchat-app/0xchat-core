// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badgeDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetBadgeDBISARCollection on Isar {
  IsarCollection<int, BadgeDBISAR> get badgeDBISARs => this.collection();
}

const BadgeDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'BadgeDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'badgeID',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'd',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'description',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'image',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'thumb',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'creator',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'createTime',
        type: IsarType.long,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'badgeID',
        properties: [
          "badgeID",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, BadgeDBISAR>(
    serialize: serializeBadgeDBISAR,
    deserialize: deserializeBadgeDBISAR,
    deserializeProperty: deserializeBadgeDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeBadgeDBISAR(IsarWriter writer, BadgeDBISAR object) {
  IsarCore.writeString(writer, 1, object.badgeID);
  IsarCore.writeString(writer, 2, object.d);
  IsarCore.writeString(writer, 3, object.name);
  IsarCore.writeString(writer, 4, object.description);
  IsarCore.writeString(writer, 5, object.image);
  IsarCore.writeString(writer, 6, object.thumb);
  IsarCore.writeString(writer, 7, object.creator);
  IsarCore.writeLong(writer, 8, object.createTime);
  return object.id;
}

@isarProtected
BadgeDBISAR deserializeBadgeDBISAR(IsarReader reader) {
  final String _badgeID;
  _badgeID = IsarCore.readString(reader, 1) ?? '';
  final String _d;
  _d = IsarCore.readString(reader, 2) ?? '';
  final String _name;
  _name = IsarCore.readString(reader, 3) ?? '';
  final String _description;
  _description = IsarCore.readString(reader, 4) ?? '';
  final String _image;
  _image = IsarCore.readString(reader, 5) ?? '';
  final String _thumb;
  _thumb = IsarCore.readString(reader, 6) ?? '';
  final String _creator;
  _creator = IsarCore.readString(reader, 7) ?? '';
  final int _createTime;
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      _createTime = 0;
    } else {
      _createTime = value;
    }
  }
  final object = BadgeDBISAR(
    badgeID: _badgeID,
    d: _d,
    name: _name,
    description: _description,
    image: _image,
    thumb: _thumb,
    creator: _creator,
    createTime: _createTime,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeBadgeDBISARProp(IsarReader reader, int property) {
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
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      {
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _BadgeDBISARUpdate {
  bool call({
    required int id,
    String? badgeID,
    String? d,
    String? name,
    String? description,
    String? image,
    String? thumb,
    String? creator,
    int? createTime,
  });
}

class _BadgeDBISARUpdateImpl implements _BadgeDBISARUpdate {
  const _BadgeDBISARUpdateImpl(this.collection);

  final IsarCollection<int, BadgeDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? badgeID = ignore,
    Object? d = ignore,
    Object? name = ignore,
    Object? description = ignore,
    Object? image = ignore,
    Object? thumb = ignore,
    Object? creator = ignore,
    Object? createTime = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (badgeID != ignore) 1: badgeID as String?,
          if (d != ignore) 2: d as String?,
          if (name != ignore) 3: name as String?,
          if (description != ignore) 4: description as String?,
          if (image != ignore) 5: image as String?,
          if (thumb != ignore) 6: thumb as String?,
          if (creator != ignore) 7: creator as String?,
          if (createTime != ignore) 8: createTime as int?,
        }) >
        0;
  }
}

sealed class _BadgeDBISARUpdateAll {
  int call({
    required List<int> id,
    String? badgeID,
    String? d,
    String? name,
    String? description,
    String? image,
    String? thumb,
    String? creator,
    int? createTime,
  });
}

class _BadgeDBISARUpdateAllImpl implements _BadgeDBISARUpdateAll {
  const _BadgeDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, BadgeDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? badgeID = ignore,
    Object? d = ignore,
    Object? name = ignore,
    Object? description = ignore,
    Object? image = ignore,
    Object? thumb = ignore,
    Object? creator = ignore,
    Object? createTime = ignore,
  }) {
    return collection.updateProperties(id, {
      if (badgeID != ignore) 1: badgeID as String?,
      if (d != ignore) 2: d as String?,
      if (name != ignore) 3: name as String?,
      if (description != ignore) 4: description as String?,
      if (image != ignore) 5: image as String?,
      if (thumb != ignore) 6: thumb as String?,
      if (creator != ignore) 7: creator as String?,
      if (createTime != ignore) 8: createTime as int?,
    });
  }
}

extension BadgeDBISARUpdate on IsarCollection<int, BadgeDBISAR> {
  _BadgeDBISARUpdate get update => _BadgeDBISARUpdateImpl(this);

  _BadgeDBISARUpdateAll get updateAll => _BadgeDBISARUpdateAllImpl(this);
}

sealed class _BadgeDBISARQueryUpdate {
  int call({
    String? badgeID,
    String? d,
    String? name,
    String? description,
    String? image,
    String? thumb,
    String? creator,
    int? createTime,
  });
}

class _BadgeDBISARQueryUpdateImpl implements _BadgeDBISARQueryUpdate {
  const _BadgeDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<BadgeDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? badgeID = ignore,
    Object? d = ignore,
    Object? name = ignore,
    Object? description = ignore,
    Object? image = ignore,
    Object? thumb = ignore,
    Object? creator = ignore,
    Object? createTime = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (badgeID != ignore) 1: badgeID as String?,
      if (d != ignore) 2: d as String?,
      if (name != ignore) 3: name as String?,
      if (description != ignore) 4: description as String?,
      if (image != ignore) 5: image as String?,
      if (thumb != ignore) 6: thumb as String?,
      if (creator != ignore) 7: creator as String?,
      if (createTime != ignore) 8: createTime as int?,
    });
  }
}

extension BadgeDBISARQueryUpdate on IsarQuery<BadgeDBISAR> {
  _BadgeDBISARQueryUpdate get updateFirst =>
      _BadgeDBISARQueryUpdateImpl(this, limit: 1);

  _BadgeDBISARQueryUpdate get updateAll => _BadgeDBISARQueryUpdateImpl(this);
}

class _BadgeDBISARQueryBuilderUpdateImpl implements _BadgeDBISARQueryUpdate {
  const _BadgeDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<BadgeDBISAR, BadgeDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? badgeID = ignore,
    Object? d = ignore,
    Object? name = ignore,
    Object? description = ignore,
    Object? image = ignore,
    Object? thumb = ignore,
    Object? creator = ignore,
    Object? createTime = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (badgeID != ignore) 1: badgeID as String?,
        if (d != ignore) 2: d as String?,
        if (name != ignore) 3: name as String?,
        if (description != ignore) 4: description as String?,
        if (image != ignore) 5: image as String?,
        if (thumb != ignore) 6: thumb as String?,
        if (creator != ignore) 7: creator as String?,
        if (createTime != ignore) 8: createTime as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension BadgeDBISARQueryBuilderUpdate
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QOperations> {
  _BadgeDBISARQueryUpdate get updateFirst =>
      _BadgeDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _BadgeDBISARQueryUpdate get updateAll =>
      _BadgeDBISARQueryBuilderUpdateImpl(this);
}

extension BadgeDBISARQueryFilter
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QFilterCondition> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> badgeIDEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      badgeIDGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      badgeIDGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> badgeIDLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      badgeIDLessThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> badgeIDBetween(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      badgeIDStartsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> badgeIDEndsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> badgeIDContains(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> badgeIDMatches(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      badgeIDIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      badgeIDIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      dGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      dLessThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dBetween(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dStartsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dEndsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dContains(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dMatches(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      nameLessThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameContains(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionLessThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionBetween(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionStartsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionEndsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      imageGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      imageGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      imageLessThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageBetween(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageStartsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageEndsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageContains(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageMatches(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      thumbGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      thumbGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      thumbLessThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbBetween(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbStartsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbEndsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbContains(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbMatches(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      thumbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorLessThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorBetween(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorStartsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorEndsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorContains(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorMatches(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeGreaterThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeGreaterThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeLessThan(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeLessThanOrEqualTo(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeBetween(
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
}

extension BadgeDBISARQueryObject
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QFilterCondition> {}

extension BadgeDBISARQuerySortBy
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QSortBy> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByBadgeID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByBadgeIDDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByD(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByDDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByDescriptionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByImageDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByThumb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByThumbDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByCreatorDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }
}

extension BadgeDBISARQuerySortThenBy
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QSortThenBy> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByBadgeID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByBadgeIDDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByD(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByDDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByDescriptionDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByImageDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByThumb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByThumbDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByCreatorDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }
}

extension BadgeDBISARQueryWhereDistinct
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterDistinct> distinctByBadgeID(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterDistinct> distinctByD(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterDistinct> distinctByThumb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterDistinct> distinctByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterDistinct>
      distinctByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }
}

extension BadgeDBISARQueryProperty1
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QProperty> {
  QueryBuilder<BadgeDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BadgeDBISAR, String, QAfterProperty> badgeIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BadgeDBISAR, String, QAfterProperty> dProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BadgeDBISAR, String, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BadgeDBISAR, String, QAfterProperty> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BadgeDBISAR, String, QAfterProperty> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BadgeDBISAR, String, QAfterProperty> thumbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BadgeDBISAR, String, QAfterProperty> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<BadgeDBISAR, int, QAfterProperty> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }
}

extension BadgeDBISARQueryProperty2<R>
    on QueryBuilder<BadgeDBISAR, R, QAfterProperty> {
  QueryBuilder<BadgeDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BadgeDBISAR, (R, String), QAfterProperty> badgeIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BadgeDBISAR, (R, String), QAfterProperty> dProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BadgeDBISAR, (R, String), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BadgeDBISAR, (R, String), QAfterProperty> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BadgeDBISAR, (R, String), QAfterProperty> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BadgeDBISAR, (R, String), QAfterProperty> thumbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BadgeDBISAR, (R, String), QAfterProperty> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<BadgeDBISAR, (R, int), QAfterProperty> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }
}

extension BadgeDBISARQueryProperty3<R1, R2>
    on QueryBuilder<BadgeDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<BadgeDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<BadgeDBISAR, (R1, R2, String), QOperations> badgeIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<BadgeDBISAR, (R1, R2, String), QOperations> dProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<BadgeDBISAR, (R1, R2, String), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<BadgeDBISAR, (R1, R2, String), QOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<BadgeDBISAR, (R1, R2, String), QOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<BadgeDBISAR, (R1, R2, String), QOperations> thumbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<BadgeDBISAR, (R1, R2, String), QOperations> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<BadgeDBISAR, (R1, R2, int), QOperations> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }
}
