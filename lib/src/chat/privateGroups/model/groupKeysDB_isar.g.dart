// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupKeysDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetGroupKeysDBISARCollection on Isar {
  IsarCollection<int, GroupKeysDBISAR> get groupKeysDBISARs =>
      this.collection();
}

const GroupKeysDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'GroupKeysDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'groupId',
        type: IsarType.string,
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
        name: 'secretKey',
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
  converter: IsarObjectConverter<int, GroupKeysDBISAR>(
    serialize: serializeGroupKeysDBISAR,
    deserialize: deserializeGroupKeysDBISAR,
    deserializeProperty: deserializeGroupKeysDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeGroupKeysDBISAR(IsarWriter writer, GroupKeysDBISAR object) {
  IsarCore.writeString(writer, 1, object.groupId);
  {
    final list = object.mlsGroupId;
    if (list == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      final listWriter = IsarCore.beginList(writer, 2, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeLong(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  IsarCore.writeLong(writer, 3, object.epoch);
  IsarCore.writeString(writer, 4, object.secretKey);
  return object.id;
}

@isarProtected
GroupKeysDBISAR deserializeGroupKeysDBISAR(IsarReader reader) {
  final String _groupId;
  _groupId = IsarCore.readString(reader, 1) ?? '';
  final List<int>? _mlsGroupId;
  {
    final length = IsarCore.readList(reader, 2, IsarCore.readerPtrPtr);
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
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _epoch = 0;
    } else {
      _epoch = value;
    }
  }
  final String _secretKey;
  _secretKey = IsarCore.readString(reader, 4) ?? '';
  final object = GroupKeysDBISAR(
    groupId: _groupId,
    mlsGroupId: _mlsGroupId,
    epoch: _epoch,
    secretKey: _secretKey,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeGroupKeysDBISARProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      {
        final length = IsarCore.readList(reader, 2, IsarCore.readerPtrPtr);
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
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _GroupKeysDBISARUpdate {
  bool call({
    required int id,
    String? groupId,
    int? epoch,
    String? secretKey,
  });
}

class _GroupKeysDBISARUpdateImpl implements _GroupKeysDBISARUpdate {
  const _GroupKeysDBISARUpdateImpl(this.collection);

  final IsarCollection<int, GroupKeysDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? groupId = ignore,
    Object? epoch = ignore,
    Object? secretKey = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (groupId != ignore) 1: groupId as String?,
          if (epoch != ignore) 3: epoch as int?,
          if (secretKey != ignore) 4: secretKey as String?,
        }) >
        0;
  }
}

sealed class _GroupKeysDBISARUpdateAll {
  int call({
    required List<int> id,
    String? groupId,
    int? epoch,
    String? secretKey,
  });
}

class _GroupKeysDBISARUpdateAllImpl implements _GroupKeysDBISARUpdateAll {
  const _GroupKeysDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, GroupKeysDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? groupId = ignore,
    Object? epoch = ignore,
    Object? secretKey = ignore,
  }) {
    return collection.updateProperties(id, {
      if (groupId != ignore) 1: groupId as String?,
      if (epoch != ignore) 3: epoch as int?,
      if (secretKey != ignore) 4: secretKey as String?,
    });
  }
}

extension GroupKeysDBISARUpdate on IsarCollection<int, GroupKeysDBISAR> {
  _GroupKeysDBISARUpdate get update => _GroupKeysDBISARUpdateImpl(this);

  _GroupKeysDBISARUpdateAll get updateAll =>
      _GroupKeysDBISARUpdateAllImpl(this);
}

sealed class _GroupKeysDBISARQueryUpdate {
  int call({
    String? groupId,
    int? epoch,
    String? secretKey,
  });
}

class _GroupKeysDBISARQueryUpdateImpl implements _GroupKeysDBISARQueryUpdate {
  const _GroupKeysDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<GroupKeysDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? groupId = ignore,
    Object? epoch = ignore,
    Object? secretKey = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (groupId != ignore) 1: groupId as String?,
      if (epoch != ignore) 3: epoch as int?,
      if (secretKey != ignore) 4: secretKey as String?,
    });
  }
}

extension GroupKeysDBISARQueryUpdate on IsarQuery<GroupKeysDBISAR> {
  _GroupKeysDBISARQueryUpdate get updateFirst =>
      _GroupKeysDBISARQueryUpdateImpl(this, limit: 1);

  _GroupKeysDBISARQueryUpdate get updateAll =>
      _GroupKeysDBISARQueryUpdateImpl(this);
}

class _GroupKeysDBISARQueryBuilderUpdateImpl
    implements _GroupKeysDBISARQueryUpdate {
  const _GroupKeysDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? groupId = ignore,
    Object? epoch = ignore,
    Object? secretKey = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (groupId != ignore) 1: groupId as String?,
        if (epoch != ignore) 3: epoch as int?,
        if (secretKey != ignore) 4: secretKey as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension GroupKeysDBISARQueryBuilderUpdate
    on QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QOperations> {
  _GroupKeysDBISARQueryUpdate get updateFirst =>
      _GroupKeysDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _GroupKeysDBISARQueryUpdate get updateAll =>
      _GroupKeysDBISARQueryBuilderUpdateImpl(this);
}

extension GroupKeysDBISARQueryFilter
    on QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QFilterCondition> {
  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdElementEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdElementGreaterThan(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdElementGreaterThanOrEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdElementLessThan(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdElementLessThanOrEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdElementBetween(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdIsEmpty() {
    return not().group(
      (q) => q.mlsGroupIdIsNull().or().mlsGroupIdIsNotEmpty(),
    );
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 2, value: null),
      );
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      epochEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      epochGreaterThan(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      epochGreaterThanOrEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      epochLessThan(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      epochLessThanOrEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      epochBetween(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyGreaterThan(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyGreaterThanOrEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyLessThan(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyLessThanOrEqualTo(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyBetween(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyStartsWith(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyEndsWith(
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterFilterCondition>
      secretKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }
}

extension GroupKeysDBISARQueryObject
    on QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QFilterCondition> {}

extension GroupKeysDBISARQuerySortBy
    on QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QSortBy> {
  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> sortByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy>
      sortByGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> sortByEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy>
      sortByEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> sortBySecretKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy>
      sortBySecretKeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension GroupKeysDBISARQuerySortThenBy
    on QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QSortThenBy> {
  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> thenByGroupId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy>
      thenByGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> thenByEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy>
      thenByEpochDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy> thenBySecretKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterSortBy>
      thenBySecretKeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension GroupKeysDBISARQueryWhereDistinct
    on QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QDistinct> {
  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterDistinct>
      distinctByGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterDistinct>
      distinctByMlsGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterDistinct>
      distinctByEpoch() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QAfterDistinct>
      distinctBySecretKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }
}

extension GroupKeysDBISARQueryProperty1
    on QueryBuilder<GroupKeysDBISAR, GroupKeysDBISAR, QProperty> {
  QueryBuilder<GroupKeysDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<GroupKeysDBISAR, String, QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<GroupKeysDBISAR, List<int>?, QAfterProperty>
      mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<GroupKeysDBISAR, int, QAfterProperty> epochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<GroupKeysDBISAR, String, QAfterProperty> secretKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension GroupKeysDBISARQueryProperty2<R>
    on QueryBuilder<GroupKeysDBISAR, R, QAfterProperty> {
  QueryBuilder<GroupKeysDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<GroupKeysDBISAR, (R, String), QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<GroupKeysDBISAR, (R, List<int>?), QAfterProperty>
      mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<GroupKeysDBISAR, (R, int), QAfterProperty> epochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<GroupKeysDBISAR, (R, String), QAfterProperty>
      secretKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension GroupKeysDBISARQueryProperty3<R1, R2>
    on QueryBuilder<GroupKeysDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<GroupKeysDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<GroupKeysDBISAR, (R1, R2, String), QOperations>
      groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<GroupKeysDBISAR, (R1, R2, List<int>?), QOperations>
      mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<GroupKeysDBISAR, (R1, R2, int), QOperations> epochProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<GroupKeysDBISAR, (R1, R2, String), QOperations>
      secretKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
