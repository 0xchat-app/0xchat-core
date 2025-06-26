// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notificationDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetNotificationDBISARCollection on Isar {
  IsarCollection<int, NotificationDBISAR> get notificationDBISARs =>
      this.collection();
}

const NotificationDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'NotificationDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'notificationId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'kind',
        type: IsarType.long,
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
        name: 'zapAmount',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'associatedNoteId',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'notificationId',
        properties: [
          "notificationId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, NotificationDBISAR>(
    serialize: serializeNotificationDBISAR,
    deserialize: deserializeNotificationDBISAR,
    deserializeProperty: deserializeNotificationDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeNotificationDBISAR(IsarWriter writer, NotificationDBISAR object) {
  IsarCore.writeString(writer, 1, object.notificationId);
  IsarCore.writeLong(writer, 2, object.kind);
  IsarCore.writeString(writer, 3, object.author);
  IsarCore.writeLong(writer, 4, object.createAt);
  IsarCore.writeString(writer, 5, object.content);
  IsarCore.writeLong(writer, 6, object.zapAmount);
  IsarCore.writeString(writer, 7, object.associatedNoteId);
  return object.id;
}

@isarProtected
NotificationDBISAR deserializeNotificationDBISAR(IsarReader reader) {
  final String _notificationId;
  _notificationId = IsarCore.readString(reader, 1) ?? '';
  final int _kind;
  {
    final value = IsarCore.readLong(reader, 2);
    if (value == -9223372036854775808) {
      _kind = 0;
    } else {
      _kind = value;
    }
  }
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
  final int _zapAmount;
  {
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      _zapAmount = 0;
    } else {
      _zapAmount = value;
    }
  }
  final String _associatedNoteId;
  _associatedNoteId = IsarCore.readString(reader, 7) ?? '';
  final object = NotificationDBISAR(
    notificationId: _notificationId,
    kind: _kind,
    author: _author,
    createAt: _createAt,
    content: _content,
    zapAmount: _zapAmount,
    associatedNoteId: _associatedNoteId,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeNotificationDBISARProp(IsarReader reader, int property) {
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
        final value = IsarCore.readLong(reader, 6);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _NotificationDBISARUpdate {
  bool call({
    required int id,
    String? notificationId,
    int? kind,
    String? author,
    int? createAt,
    String? content,
    int? zapAmount,
    String? associatedNoteId,
  });
}

class _NotificationDBISARUpdateImpl implements _NotificationDBISARUpdate {
  const _NotificationDBISARUpdateImpl(this.collection);

  final IsarCollection<int, NotificationDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? notificationId = ignore,
    Object? kind = ignore,
    Object? author = ignore,
    Object? createAt = ignore,
    Object? content = ignore,
    Object? zapAmount = ignore,
    Object? associatedNoteId = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (notificationId != ignore) 1: notificationId as String?,
          if (kind != ignore) 2: kind as int?,
          if (author != ignore) 3: author as String?,
          if (createAt != ignore) 4: createAt as int?,
          if (content != ignore) 5: content as String?,
          if (zapAmount != ignore) 6: zapAmount as int?,
          if (associatedNoteId != ignore) 7: associatedNoteId as String?,
        }) >
        0;
  }
}

sealed class _NotificationDBISARUpdateAll {
  int call({
    required List<int> id,
    String? notificationId,
    int? kind,
    String? author,
    int? createAt,
    String? content,
    int? zapAmount,
    String? associatedNoteId,
  });
}

class _NotificationDBISARUpdateAllImpl implements _NotificationDBISARUpdateAll {
  const _NotificationDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, NotificationDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? notificationId = ignore,
    Object? kind = ignore,
    Object? author = ignore,
    Object? createAt = ignore,
    Object? content = ignore,
    Object? zapAmount = ignore,
    Object? associatedNoteId = ignore,
  }) {
    return collection.updateProperties(id, {
      if (notificationId != ignore) 1: notificationId as String?,
      if (kind != ignore) 2: kind as int?,
      if (author != ignore) 3: author as String?,
      if (createAt != ignore) 4: createAt as int?,
      if (content != ignore) 5: content as String?,
      if (zapAmount != ignore) 6: zapAmount as int?,
      if (associatedNoteId != ignore) 7: associatedNoteId as String?,
    });
  }
}

extension NotificationDBISARUpdate on IsarCollection<int, NotificationDBISAR> {
  _NotificationDBISARUpdate get update => _NotificationDBISARUpdateImpl(this);

  _NotificationDBISARUpdateAll get updateAll =>
      _NotificationDBISARUpdateAllImpl(this);
}

sealed class _NotificationDBISARQueryUpdate {
  int call({
    String? notificationId,
    int? kind,
    String? author,
    int? createAt,
    String? content,
    int? zapAmount,
    String? associatedNoteId,
  });
}

class _NotificationDBISARQueryUpdateImpl
    implements _NotificationDBISARQueryUpdate {
  const _NotificationDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<NotificationDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? notificationId = ignore,
    Object? kind = ignore,
    Object? author = ignore,
    Object? createAt = ignore,
    Object? content = ignore,
    Object? zapAmount = ignore,
    Object? associatedNoteId = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (notificationId != ignore) 1: notificationId as String?,
      if (kind != ignore) 2: kind as int?,
      if (author != ignore) 3: author as String?,
      if (createAt != ignore) 4: createAt as int?,
      if (content != ignore) 5: content as String?,
      if (zapAmount != ignore) 6: zapAmount as int?,
      if (associatedNoteId != ignore) 7: associatedNoteId as String?,
    });
  }
}

extension NotificationDBISARQueryUpdate on IsarQuery<NotificationDBISAR> {
  _NotificationDBISARQueryUpdate get updateFirst =>
      _NotificationDBISARQueryUpdateImpl(this, limit: 1);

  _NotificationDBISARQueryUpdate get updateAll =>
      _NotificationDBISARQueryUpdateImpl(this);
}

class _NotificationDBISARQueryBuilderUpdateImpl
    implements _NotificationDBISARQueryUpdate {
  const _NotificationDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<NotificationDBISAR, NotificationDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? notificationId = ignore,
    Object? kind = ignore,
    Object? author = ignore,
    Object? createAt = ignore,
    Object? content = ignore,
    Object? zapAmount = ignore,
    Object? associatedNoteId = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (notificationId != ignore) 1: notificationId as String?,
        if (kind != ignore) 2: kind as int?,
        if (author != ignore) 3: author as String?,
        if (createAt != ignore) 4: createAt as int?,
        if (content != ignore) 5: content as String?,
        if (zapAmount != ignore) 6: zapAmount as int?,
        if (associatedNoteId != ignore) 7: associatedNoteId as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension NotificationDBISARQueryBuilderUpdate
    on QueryBuilder<NotificationDBISAR, NotificationDBISAR, QOperations> {
  _NotificationDBISARQueryUpdate get updateFirst =>
      _NotificationDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _NotificationDBISARQueryUpdate get updateAll =>
      _NotificationDBISARQueryBuilderUpdateImpl(this);
}

extension NotificationDBISARQueryFilter
    on QueryBuilder<NotificationDBISAR, NotificationDBISAR, QFilterCondition> {
  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdGreaterThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdGreaterThanOrEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdLessThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdLessThanOrEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdBetween(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdStartsWith(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdEndsWith(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      notificationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      kindEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      kindGreaterThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      kindGreaterThanOrEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      kindLessThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      kindLessThanOrEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      kindBetween(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      createAtEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      createAtLessThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      createAtBetween(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      zapAmountEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      zapAmountGreaterThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      zapAmountGreaterThanOrEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      zapAmountLessThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      zapAmountLessThanOrEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      zapAmountBetween(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdGreaterThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdGreaterThanOrEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdLessThan(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdLessThanOrEqualTo(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdBetween(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdStartsWith(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdEndsWith(
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterFilterCondition>
      associatedNoteIdIsNotEmpty() {
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

extension NotificationDBISARQueryObject
    on QueryBuilder<NotificationDBISAR, NotificationDBISAR, QFilterCondition> {}

extension NotificationDBISARQuerySortBy
    on QueryBuilder<NotificationDBISAR, NotificationDBISAR, QSortBy> {
  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByNotificationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByNotificationIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByAuthor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByZapAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByZapAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByAssociatedNoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      sortByAssociatedNoteIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension NotificationDBISARQuerySortThenBy
    on QueryBuilder<NotificationDBISAR, NotificationDBISAR, QSortThenBy> {
  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByNotificationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByNotificationIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByKindDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByAuthor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByCreateAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByZapAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByZapAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByAssociatedNoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterSortBy>
      thenByAssociatedNoteIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension NotificationDBISARQueryWhereDistinct
    on QueryBuilder<NotificationDBISAR, NotificationDBISAR, QDistinct> {
  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterDistinct>
      distinctByNotificationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterDistinct>
      distinctByKind() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterDistinct>
      distinctByAuthor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterDistinct>
      distinctByCreateAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterDistinct>
      distinctByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterDistinct>
      distinctByZapAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<NotificationDBISAR, NotificationDBISAR, QAfterDistinct>
      distinctByAssociatedNoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }
}

extension NotificationDBISARQueryProperty1
    on QueryBuilder<NotificationDBISAR, NotificationDBISAR, QProperty> {
  QueryBuilder<NotificationDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<NotificationDBISAR, String, QAfterProperty>
      notificationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<NotificationDBISAR, int, QAfterProperty> kindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<NotificationDBISAR, String, QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<NotificationDBISAR, int, QAfterProperty> createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<NotificationDBISAR, String, QAfterProperty> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<NotificationDBISAR, int, QAfterProperty> zapAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<NotificationDBISAR, String, QAfterProperty>
      associatedNoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension NotificationDBISARQueryProperty2<R>
    on QueryBuilder<NotificationDBISAR, R, QAfterProperty> {
  QueryBuilder<NotificationDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<NotificationDBISAR, (R, String), QAfterProperty>
      notificationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<NotificationDBISAR, (R, int), QAfterProperty> kindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<NotificationDBISAR, (R, String), QAfterProperty>
      authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<NotificationDBISAR, (R, int), QAfterProperty>
      createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<NotificationDBISAR, (R, String), QAfterProperty>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<NotificationDBISAR, (R, int), QAfterProperty>
      zapAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<NotificationDBISAR, (R, String), QAfterProperty>
      associatedNoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension NotificationDBISARQueryProperty3<R1, R2>
    on QueryBuilder<NotificationDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<NotificationDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<NotificationDBISAR, (R1, R2, String), QOperations>
      notificationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<NotificationDBISAR, (R1, R2, int), QOperations> kindProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<NotificationDBISAR, (R1, R2, String), QOperations>
      authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<NotificationDBISAR, (R1, R2, int), QOperations>
      createAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<NotificationDBISAR, (R1, R2, String), QOperations>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<NotificationDBISAR, (R1, R2, int), QOperations>
      zapAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<NotificationDBISAR, (R1, R2, String), QOperations>
      associatedNoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}
