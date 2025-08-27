// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stagedMessageDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetStagedMessageDBISARCollection on Isar {
  IsarCollection<int, StagedMessageDBISAR> get stagedMessageDBISARs =>
      this.collection();
}

const StagedMessageDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'StagedMessageDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'eventId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'nostrGroupId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'mlsGroupId',
        type: IsarType.longList,
      ),
      IsarPropertySchema(
        name: 'messageBytes',
        type: IsarType.longList,
      ),
      IsarPropertySchema(
        name: 'senderPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'createTime',
        type: IsarType.long,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'eventId',
        properties: [
          "eventId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, StagedMessageDBISAR>(
    serialize: serializeStagedMessageDBISAR,
    deserialize: deserializeStagedMessageDBISAR,
    deserializeProperty: deserializeStagedMessageDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeStagedMessageDBISAR(
    IsarWriter writer, StagedMessageDBISAR object) {
  IsarCore.writeString(writer, 1, object.eventId);
  IsarCore.writeString(writer, 2, object.nostrGroupId);
  {
    final list = object.mlsGroupId;
    if (list == null) {
      IsarCore.writeNull(writer, 3);
    } else {
      final listWriter = IsarCore.beginList(writer, 3, list.length);
      for (var i = 0; i < list.length; i++) {
        IsarCore.writeLong(listWriter, i, list[i]);
      }
      IsarCore.endList(writer, listWriter);
    }
  }
  {
    final list = object.messageBytes;
    final listWriter = IsarCore.beginList(writer, 4, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeLong(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  IsarCore.writeString(writer, 5, object.senderPubkey);
  IsarCore.writeLong(writer, 6, object.createTime);
  return object.id;
}

@isarProtected
StagedMessageDBISAR deserializeStagedMessageDBISAR(IsarReader reader) {
  final String _eventId;
  _eventId = IsarCore.readString(reader, 1) ?? '';
  final String _nostrGroupId;
  _nostrGroupId = IsarCore.readString(reader, 2) ?? '';
  final List<int>? _mlsGroupId;
  {
    final length = IsarCore.readList(reader, 3, IsarCore.readerPtrPtr);
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
  final List<int> _messageBytes;
  {
    final length = IsarCore.readList(reader, 4, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _messageBytes = const <int>[];
      } else {
        final list =
            List<int>.filled(length, -9223372036854775808, growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readLong(reader, i);
        }
        IsarCore.freeReader(reader);
        _messageBytes = list;
      }
    }
  }
  final String _senderPubkey;
  _senderPubkey = IsarCore.readString(reader, 5) ?? '';
  final int _createTime;
  _createTime = IsarCore.readLong(reader, 6);
  final object = StagedMessageDBISAR(
    eventId: _eventId,
    nostrGroupId: _nostrGroupId,
    mlsGroupId: _mlsGroupId,
    messageBytes: _messageBytes,
    senderPubkey: _senderPubkey,
    createTime: _createTime,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeStagedMessageDBISARProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      {
        final length = IsarCore.readList(reader, 3, IsarCore.readerPtrPtr);
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
    case 4:
      {
        final length = IsarCore.readList(reader, 4, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <int>[];
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
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      return IsarCore.readLong(reader, 6);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _StagedMessageDBISARUpdate {
  bool call({
    required int id,
    String? eventId,
    String? nostrGroupId,
    String? senderPubkey,
    int? createTime,
  });
}

class _StagedMessageDBISARUpdateImpl implements _StagedMessageDBISARUpdate {
  const _StagedMessageDBISARUpdateImpl(this.collection);

  final IsarCollection<int, StagedMessageDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? eventId = ignore,
    Object? nostrGroupId = ignore,
    Object? senderPubkey = ignore,
    Object? createTime = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (eventId != ignore) 1: eventId as String?,
          if (nostrGroupId != ignore) 2: nostrGroupId as String?,
          if (senderPubkey != ignore) 5: senderPubkey as String?,
          if (createTime != ignore) 6: createTime as int?,
        }) >
        0;
  }
}

sealed class _StagedMessageDBISARUpdateAll {
  int call({
    required List<int> id,
    String? eventId,
    String? nostrGroupId,
    String? senderPubkey,
    int? createTime,
  });
}

class _StagedMessageDBISARUpdateAllImpl
    implements _StagedMessageDBISARUpdateAll {
  const _StagedMessageDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, StagedMessageDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? eventId = ignore,
    Object? nostrGroupId = ignore,
    Object? senderPubkey = ignore,
    Object? createTime = ignore,
  }) {
    return collection.updateProperties(id, {
      if (eventId != ignore) 1: eventId as String?,
      if (nostrGroupId != ignore) 2: nostrGroupId as String?,
      if (senderPubkey != ignore) 5: senderPubkey as String?,
      if (createTime != ignore) 6: createTime as int?,
    });
  }
}

extension StagedMessageDBISARUpdate
    on IsarCollection<int, StagedMessageDBISAR> {
  _StagedMessageDBISARUpdate get update => _StagedMessageDBISARUpdateImpl(this);

  _StagedMessageDBISARUpdateAll get updateAll =>
      _StagedMessageDBISARUpdateAllImpl(this);
}

sealed class _StagedMessageDBISARQueryUpdate {
  int call({
    String? eventId,
    String? nostrGroupId,
    String? senderPubkey,
    int? createTime,
  });
}

class _StagedMessageDBISARQueryUpdateImpl
    implements _StagedMessageDBISARQueryUpdate {
  const _StagedMessageDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<StagedMessageDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? eventId = ignore,
    Object? nostrGroupId = ignore,
    Object? senderPubkey = ignore,
    Object? createTime = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (eventId != ignore) 1: eventId as String?,
      if (nostrGroupId != ignore) 2: nostrGroupId as String?,
      if (senderPubkey != ignore) 5: senderPubkey as String?,
      if (createTime != ignore) 6: createTime as int?,
    });
  }
}

extension StagedMessageDBISARQueryUpdate on IsarQuery<StagedMessageDBISAR> {
  _StagedMessageDBISARQueryUpdate get updateFirst =>
      _StagedMessageDBISARQueryUpdateImpl(this, limit: 1);

  _StagedMessageDBISARQueryUpdate get updateAll =>
      _StagedMessageDBISARQueryUpdateImpl(this);
}

class _StagedMessageDBISARQueryBuilderUpdateImpl
    implements _StagedMessageDBISARQueryUpdate {
  const _StagedMessageDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QOperations>
      query;
  final int? limit;

  @override
  int call({
    Object? eventId = ignore,
    Object? nostrGroupId = ignore,
    Object? senderPubkey = ignore,
    Object? createTime = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (eventId != ignore) 1: eventId as String?,
        if (nostrGroupId != ignore) 2: nostrGroupId as String?,
        if (senderPubkey != ignore) 5: senderPubkey as String?,
        if (createTime != ignore) 6: createTime as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension StagedMessageDBISARQueryBuilderUpdate
    on QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QOperations> {
  _StagedMessageDBISARQueryUpdate get updateFirst =>
      _StagedMessageDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _StagedMessageDBISARQueryUpdate get updateAll =>
      _StagedMessageDBISARQueryBuilderUpdateImpl(this);
}

extension StagedMessageDBISARQueryFilter on QueryBuilder<StagedMessageDBISAR,
    StagedMessageDBISAR, QFilterCondition> {
  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdGreaterThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdGreaterThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdLessThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdLessThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdBetween(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdStartsWith(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdEndsWith(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      eventIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdGreaterThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdGreaterThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdLessThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdLessThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdBetween(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdStartsWith(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdEndsWith(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      nostrGroupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdElementEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdElementGreaterThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdElementGreaterThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdElementLessThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdElementLessThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdElementBetween(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdIsEmpty() {
    return not().group(
      (q) => q.mlsGroupIdIsNull().or().mlsGroupIdIsNotEmpty(),
    );
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      mlsGroupIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 3, value: null),
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      messageBytesElementEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      messageBytesElementGreaterThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      messageBytesElementGreaterThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      messageBytesElementLessThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      messageBytesElementLessThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      messageBytesElementBetween(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      messageBytesIsEmpty() {
    return not().messageBytesIsNotEmpty();
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      messageBytesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 4, value: null),
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyGreaterThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyLessThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyLessThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyBetween(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyStartsWith(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyEndsWith(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      senderPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      createTimeEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      createTimeGreaterThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      createTimeGreaterThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      createTimeLessThan(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      createTimeLessThanOrEqualTo(
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

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterFilterCondition>
      createTimeBetween(
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
}

extension StagedMessageDBISARQueryObject on QueryBuilder<StagedMessageDBISAR,
    StagedMessageDBISAR, QFilterCondition> {}

extension StagedMessageDBISARQuerySortBy
    on QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QSortBy> {
  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortByEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortByEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortByNostrGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortByNostrGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortBySenderPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortBySenderPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      sortByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }
}

extension StagedMessageDBISARQuerySortThenBy
    on QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QSortThenBy> {
  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenByEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenByEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenByNostrGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenByNostrGroupIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenBySenderPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenBySenderPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterSortBy>
      thenByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }
}

extension StagedMessageDBISARQueryWhereDistinct
    on QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QDistinct> {
  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterDistinct>
      distinctByEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterDistinct>
      distinctByNostrGroupId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterDistinct>
      distinctByMlsGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterDistinct>
      distinctByMessageBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterDistinct>
      distinctBySenderPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QAfterDistinct>
      distinctByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }
}

extension StagedMessageDBISARQueryProperty1
    on QueryBuilder<StagedMessageDBISAR, StagedMessageDBISAR, QProperty> {
  QueryBuilder<StagedMessageDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<StagedMessageDBISAR, String, QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<StagedMessageDBISAR, String, QAfterProperty>
      nostrGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<StagedMessageDBISAR, List<int>?, QAfterProperty>
      mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<StagedMessageDBISAR, List<int>, QAfterProperty>
      messageBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<StagedMessageDBISAR, String, QAfterProperty>
      senderPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<StagedMessageDBISAR, int, QAfterProperty> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}

extension StagedMessageDBISARQueryProperty2<R>
    on QueryBuilder<StagedMessageDBISAR, R, QAfterProperty> {
  QueryBuilder<StagedMessageDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R, String), QAfterProperty>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R, String), QAfterProperty>
      nostrGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R, List<int>?), QAfterProperty>
      mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R, List<int>), QAfterProperty>
      messageBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R, String), QAfterProperty>
      senderPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R, int), QAfterProperty>
      createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}

extension StagedMessageDBISARQueryProperty3<R1, R2>
    on QueryBuilder<StagedMessageDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<StagedMessageDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R1, R2, String), QOperations>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R1, R2, String), QOperations>
      nostrGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R1, R2, List<int>?), QOperations>
      mlsGroupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R1, R2, List<int>), QOperations>
      messageBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R1, R2, String), QOperations>
      senderPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<StagedMessageDBISAR, (R1, R2, int), QOperations>
      createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}
