// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joinRequestDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetJoinRequestDBISARCollection on Isar {
  IsarCollection<int, JoinRequestDBISAR> get joinRequestDBISARs =>
      this.collection();
}

const JoinRequestDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'JoinRequestDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'requestId',
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
    ],
    indexes: [
      IsarIndexSchema(
        name: 'requestId',
        properties: [
          "requestId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, JoinRequestDBISAR>(
    serialize: serializeJoinRequestDBISAR,
    deserialize: deserializeJoinRequestDBISAR,
    deserializeProperty: deserializeJoinRequestDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeJoinRequestDBISAR(IsarWriter writer, JoinRequestDBISAR object) {
  IsarCore.writeString(writer, 1, object.requestId);
  IsarCore.writeString(writer, 2, object.groupId);
  IsarCore.writeString(writer, 3, object.author);
  IsarCore.writeLong(writer, 4, object.createdAt);
  IsarCore.writeString(writer, 5, object.content);
  return object.id;
}

@isarProtected
JoinRequestDBISAR deserializeJoinRequestDBISAR(IsarReader reader) {
  final String _requestId;
  _requestId = IsarCore.readString(reader, 1) ?? '';
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
  final object = JoinRequestDBISAR(
    requestId: _requestId,
    groupId: _groupId,
    author: _author,
    createdAt: _createdAt,
    content: _content,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeJoinRequestDBISARProp(IsarReader reader, int property) {
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
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _JoinRequestDBISARUpdate {
  bool call({
    required int id,
    String? requestId,
    String? groupId,
    String? author,
    int? createdAt,
    String? content,
  });
}

class _JoinRequestDBISARUpdateImpl implements _JoinRequestDBISARUpdate {
  const _JoinRequestDBISARUpdateImpl(this.collection);

  final IsarCollection<int, JoinRequestDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? requestId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createdAt = ignore,
    Object? content = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (requestId != ignore) 1: requestId as String?,
          if (groupId != ignore) 2: groupId as String?,
          if (author != ignore) 3: author as String?,
          if (createdAt != ignore) 4: createdAt as int?,
          if (content != ignore) 5: content as String?,
        }) >
        0;
  }
}

sealed class _JoinRequestDBISARUpdateAll {
  int call({
    required List<int> id,
    String? requestId,
    String? groupId,
    String? author,
    int? createdAt,
    String? content,
  });
}

class _JoinRequestDBISARUpdateAllImpl implements _JoinRequestDBISARUpdateAll {
  const _JoinRequestDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, JoinRequestDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? requestId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createdAt = ignore,
    Object? content = ignore,
  }) {
    return collection.updateProperties(id, {
      if (requestId != ignore) 1: requestId as String?,
      if (groupId != ignore) 2: groupId as String?,
      if (author != ignore) 3: author as String?,
      if (createdAt != ignore) 4: createdAt as int?,
      if (content != ignore) 5: content as String?,
    });
  }
}

extension JoinRequestDBISARUpdate on IsarCollection<int, JoinRequestDBISAR> {
  _JoinRequestDBISARUpdate get update => _JoinRequestDBISARUpdateImpl(this);

  _JoinRequestDBISARUpdateAll get updateAll =>
      _JoinRequestDBISARUpdateAllImpl(this);
}

sealed class _JoinRequestDBISARQueryUpdate {
  int call({
    String? requestId,
    String? groupId,
    String? author,
    int? createdAt,
    String? content,
  });
}

class _JoinRequestDBISARQueryUpdateImpl
    implements _JoinRequestDBISARQueryUpdate {
  const _JoinRequestDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<JoinRequestDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? requestId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createdAt = ignore,
    Object? content = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (requestId != ignore) 1: requestId as String?,
      if (groupId != ignore) 2: groupId as String?,
      if (author != ignore) 3: author as String?,
      if (createdAt != ignore) 4: createdAt as int?,
      if (content != ignore) 5: content as String?,
    });
  }
}

extension JoinRequestDBISARQueryUpdate on IsarQuery<JoinRequestDBISAR> {
  _JoinRequestDBISARQueryUpdate get updateFirst =>
      _JoinRequestDBISARQueryUpdateImpl(this, limit: 1);

  _JoinRequestDBISARQueryUpdate get updateAll =>
      _JoinRequestDBISARQueryUpdateImpl(this);
}

class _JoinRequestDBISARQueryBuilderUpdateImpl
    implements _JoinRequestDBISARQueryUpdate {
  const _JoinRequestDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? requestId = ignore,
    Object? groupId = ignore,
    Object? author = ignore,
    Object? createdAt = ignore,
    Object? content = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (requestId != ignore) 1: requestId as String?,
        if (groupId != ignore) 2: groupId as String?,
        if (author != ignore) 3: author as String?,
        if (createdAt != ignore) 4: createdAt as int?,
        if (content != ignore) 5: content as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension JoinRequestDBISARQueryBuilderUpdate
    on QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QOperations> {
  _JoinRequestDBISARQueryUpdate get updateFirst =>
      _JoinRequestDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _JoinRequestDBISARQueryUpdate get updateAll =>
      _JoinRequestDBISARQueryBuilderUpdateImpl(this);
}

extension JoinRequestDBISARQueryFilter
    on QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QFilterCondition> {
  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdEqualTo(
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdGreaterThan(
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdGreaterThanOrEqualTo(
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdLessThan(
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdLessThanOrEqualTo(
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdBetween(
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdStartsWith(
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdEndsWith(
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
      requestIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterFilterCondition>
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
}

extension JoinRequestDBISARQueryObject
    on QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QFilterCondition> {}

extension JoinRequestDBISARQuerySortBy
    on QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QSortBy> {
  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByRequestId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByRequestIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy> sortByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      sortByContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension JoinRequestDBISARQuerySortThenBy
    on QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QSortThenBy> {
  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByRequestId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByRequestIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy> thenByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterSortBy>
      thenByContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension JoinRequestDBISARQueryWhereDistinct
    on QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QDistinct> {
  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterDistinct>
      distinctByRequestId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterDistinct>
      distinctByGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterDistinct>
      distinctByAuthor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QAfterDistinct>
      distinctByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }
}

extension JoinRequestDBISARQueryProperty1
    on QueryBuilder<JoinRequestDBISAR, JoinRequestDBISAR, QProperty> {
  QueryBuilder<JoinRequestDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<JoinRequestDBISAR, String, QAfterProperty> requestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<JoinRequestDBISAR, String, QAfterProperty> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<JoinRequestDBISAR, String, QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<JoinRequestDBISAR, int, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<JoinRequestDBISAR, String, QAfterProperty> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension JoinRequestDBISARQueryProperty2<R>
    on QueryBuilder<JoinRequestDBISAR, R, QAfterProperty> {
  QueryBuilder<JoinRequestDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R, String), QAfterProperty>
      requestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R, String), QAfterProperty>
      groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R, String), QAfterProperty>
      authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R, int), QAfterProperty>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R, String), QAfterProperty>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension JoinRequestDBISARQueryProperty3<R1, R2>
    on QueryBuilder<JoinRequestDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<JoinRequestDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R1, R2, String), QOperations>
      requestIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R1, R2, String), QOperations>
      groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R1, R2, String), QOperations>
      authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R1, R2, int), QOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<JoinRequestDBISAR, (R1, R2, String), QOperations>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}
