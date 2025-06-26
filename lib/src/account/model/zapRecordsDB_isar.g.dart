// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zapRecordsDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetZapRecordsDBISARCollection on Isar {
  IsarCollection<int, ZapRecordsDBISAR> get zapRecordsDBISARs =>
      this.collection();
}

const ZapRecordsDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ZapRecordsDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'bolt11',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'paidAt',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'zapper',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'preimage',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'description',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'recipient',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'sender',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'eventId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'content',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'findEvent',
        type: IsarType.bool,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'bolt11',
        properties: [
          "bolt11",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, ZapRecordsDBISAR>(
    serialize: serializeZapRecordsDBISAR,
    deserialize: deserializeZapRecordsDBISAR,
    deserializeProperty: deserializeZapRecordsDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeZapRecordsDBISAR(IsarWriter writer, ZapRecordsDBISAR object) {
  IsarCore.writeString(writer, 1, object.bolt11);
  IsarCore.writeLong(writer, 2, object.paidAt);
  IsarCore.writeString(writer, 3, object.zapper);
  IsarCore.writeString(writer, 4, object.preimage);
  IsarCore.writeString(writer, 5, object.description);
  IsarCore.writeString(writer, 6, object.recipient);
  IsarCore.writeString(writer, 7, object.sender);
  IsarCore.writeString(writer, 8, object.eventId);
  IsarCore.writeString(writer, 9, object.content);
  IsarCore.writeBool(writer, 10, object.findEvent);
  return object.id;
}

@isarProtected
ZapRecordsDBISAR deserializeZapRecordsDBISAR(IsarReader reader) {
  final String _bolt11;
  _bolt11 = IsarCore.readString(reader, 1) ?? '';
  final int _paidAt;
  {
    final value = IsarCore.readLong(reader, 2);
    if (value == -9223372036854775808) {
      _paidAt = 0;
    } else {
      _paidAt = value;
    }
  }
  final String _zapper;
  _zapper = IsarCore.readString(reader, 3) ?? '';
  final String _preimage;
  _preimage = IsarCore.readString(reader, 4) ?? '';
  final String _description;
  _description = IsarCore.readString(reader, 5) ?? '';
  final String _recipient;
  _recipient = IsarCore.readString(reader, 6) ?? '';
  final String _sender;
  _sender = IsarCore.readString(reader, 7) ?? '';
  final String _eventId;
  _eventId = IsarCore.readString(reader, 8) ?? '';
  final String _content;
  _content = IsarCore.readString(reader, 9) ?? '';
  final bool _findEvent;
  _findEvent = IsarCore.readBool(reader, 10);
  final object = ZapRecordsDBISAR(
    bolt11: _bolt11,
    paidAt: _paidAt,
    zapper: _zapper,
    preimage: _preimage,
    description: _description,
    recipient: _recipient,
    sender: _sender,
    eventId: _eventId,
    content: _content,
    findEvent: _findEvent,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeZapRecordsDBISARProp(IsarReader reader, int property) {
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

sealed class _ZapRecordsDBISARUpdate {
  bool call({
    required int id,
    String? bolt11,
    int? paidAt,
    String? zapper,
    String? preimage,
    String? description,
    String? recipient,
    String? sender,
    String? eventId,
    String? content,
    bool? findEvent,
  });
}

class _ZapRecordsDBISARUpdateImpl implements _ZapRecordsDBISARUpdate {
  const _ZapRecordsDBISARUpdateImpl(this.collection);

  final IsarCollection<int, ZapRecordsDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? bolt11 = ignore,
    Object? paidAt = ignore,
    Object? zapper = ignore,
    Object? preimage = ignore,
    Object? description = ignore,
    Object? recipient = ignore,
    Object? sender = ignore,
    Object? eventId = ignore,
    Object? content = ignore,
    Object? findEvent = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (bolt11 != ignore) 1: bolt11 as String?,
          if (paidAt != ignore) 2: paidAt as int?,
          if (zapper != ignore) 3: zapper as String?,
          if (preimage != ignore) 4: preimage as String?,
          if (description != ignore) 5: description as String?,
          if (recipient != ignore) 6: recipient as String?,
          if (sender != ignore) 7: sender as String?,
          if (eventId != ignore) 8: eventId as String?,
          if (content != ignore) 9: content as String?,
          if (findEvent != ignore) 10: findEvent as bool?,
        }) >
        0;
  }
}

sealed class _ZapRecordsDBISARUpdateAll {
  int call({
    required List<int> id,
    String? bolt11,
    int? paidAt,
    String? zapper,
    String? preimage,
    String? description,
    String? recipient,
    String? sender,
    String? eventId,
    String? content,
    bool? findEvent,
  });
}

class _ZapRecordsDBISARUpdateAllImpl implements _ZapRecordsDBISARUpdateAll {
  const _ZapRecordsDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, ZapRecordsDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? bolt11 = ignore,
    Object? paidAt = ignore,
    Object? zapper = ignore,
    Object? preimage = ignore,
    Object? description = ignore,
    Object? recipient = ignore,
    Object? sender = ignore,
    Object? eventId = ignore,
    Object? content = ignore,
    Object? findEvent = ignore,
  }) {
    return collection.updateProperties(id, {
      if (bolt11 != ignore) 1: bolt11 as String?,
      if (paidAt != ignore) 2: paidAt as int?,
      if (zapper != ignore) 3: zapper as String?,
      if (preimage != ignore) 4: preimage as String?,
      if (description != ignore) 5: description as String?,
      if (recipient != ignore) 6: recipient as String?,
      if (sender != ignore) 7: sender as String?,
      if (eventId != ignore) 8: eventId as String?,
      if (content != ignore) 9: content as String?,
      if (findEvent != ignore) 10: findEvent as bool?,
    });
  }
}

extension ZapRecordsDBISARUpdate on IsarCollection<int, ZapRecordsDBISAR> {
  _ZapRecordsDBISARUpdate get update => _ZapRecordsDBISARUpdateImpl(this);

  _ZapRecordsDBISARUpdateAll get updateAll =>
      _ZapRecordsDBISARUpdateAllImpl(this);
}

sealed class _ZapRecordsDBISARQueryUpdate {
  int call({
    String? bolt11,
    int? paidAt,
    String? zapper,
    String? preimage,
    String? description,
    String? recipient,
    String? sender,
    String? eventId,
    String? content,
    bool? findEvent,
  });
}

class _ZapRecordsDBISARQueryUpdateImpl implements _ZapRecordsDBISARQueryUpdate {
  const _ZapRecordsDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ZapRecordsDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? bolt11 = ignore,
    Object? paidAt = ignore,
    Object? zapper = ignore,
    Object? preimage = ignore,
    Object? description = ignore,
    Object? recipient = ignore,
    Object? sender = ignore,
    Object? eventId = ignore,
    Object? content = ignore,
    Object? findEvent = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (bolt11 != ignore) 1: bolt11 as String?,
      if (paidAt != ignore) 2: paidAt as int?,
      if (zapper != ignore) 3: zapper as String?,
      if (preimage != ignore) 4: preimage as String?,
      if (description != ignore) 5: description as String?,
      if (recipient != ignore) 6: recipient as String?,
      if (sender != ignore) 7: sender as String?,
      if (eventId != ignore) 8: eventId as String?,
      if (content != ignore) 9: content as String?,
      if (findEvent != ignore) 10: findEvent as bool?,
    });
  }
}

extension ZapRecordsDBISARQueryUpdate on IsarQuery<ZapRecordsDBISAR> {
  _ZapRecordsDBISARQueryUpdate get updateFirst =>
      _ZapRecordsDBISARQueryUpdateImpl(this, limit: 1);

  _ZapRecordsDBISARQueryUpdate get updateAll =>
      _ZapRecordsDBISARQueryUpdateImpl(this);
}

class _ZapRecordsDBISARQueryBuilderUpdateImpl
    implements _ZapRecordsDBISARQueryUpdate {
  const _ZapRecordsDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? bolt11 = ignore,
    Object? paidAt = ignore,
    Object? zapper = ignore,
    Object? preimage = ignore,
    Object? description = ignore,
    Object? recipient = ignore,
    Object? sender = ignore,
    Object? eventId = ignore,
    Object? content = ignore,
    Object? findEvent = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (bolt11 != ignore) 1: bolt11 as String?,
        if (paidAt != ignore) 2: paidAt as int?,
        if (zapper != ignore) 3: zapper as String?,
        if (preimage != ignore) 4: preimage as String?,
        if (description != ignore) 5: description as String?,
        if (recipient != ignore) 6: recipient as String?,
        if (sender != ignore) 7: sender as String?,
        if (eventId != ignore) 8: eventId as String?,
        if (content != ignore) 9: content as String?,
        if (findEvent != ignore) 10: findEvent as bool?,
      });
    } finally {
      q.close();
    }
  }
}

extension ZapRecordsDBISARQueryBuilderUpdate
    on QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QOperations> {
  _ZapRecordsDBISARQueryUpdate get updateFirst =>
      _ZapRecordsDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _ZapRecordsDBISARQueryUpdate get updateAll =>
      _ZapRecordsDBISARQueryBuilderUpdateImpl(this);
}

extension ZapRecordsDBISARQueryFilter
    on QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QFilterCondition> {
  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11EqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11GreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11GreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11LessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11LessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11Between(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11StartsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11EndsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11Contains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11Matches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      bolt11IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      paidAtEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      paidAtGreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      paidAtGreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      paidAtLessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      paidAtLessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      paidAtBetween(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperGreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperGreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperLessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperLessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperBetween(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperStartsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperEndsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      zapperIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageGreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageGreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageLessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageLessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageBetween(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageStartsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageEndsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      preimageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionGreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionGreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionLessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionLessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionBetween(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionStartsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionEndsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientGreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientGreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientLessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientLessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientBetween(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientStartsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientEndsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      recipientIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderGreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderGreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderLessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderLessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderBetween(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderStartsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderEndsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      senderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdGreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdGreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdLessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdLessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdBetween(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdStartsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdEndsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      eventIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentGreaterThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentGreaterThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentLessThan(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentLessThanOrEqualTo(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentBetween(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentStartsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentEndsWith(
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterFilterCondition>
      findEventEqualTo(
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
}

extension ZapRecordsDBISARQueryObject
    on QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QFilterCondition> {}

extension ZapRecordsDBISARQuerySortBy
    on QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QSortBy> {
  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> sortByBolt11(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByBolt11Desc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByPaidAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByPaidAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> sortByZapper(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByZapperDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> sortByPreimage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByPreimageDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByDescriptionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByRecipient({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByRecipientDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> sortBySender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortBySenderDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> sortByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> sortByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByFindEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      sortByFindEventDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }
}

extension ZapRecordsDBISARQuerySortThenBy
    on QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QSortThenBy> {
  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> thenByBolt11(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByBolt11Desc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByPaidAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByPaidAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> thenByZapper(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByZapperDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> thenByPreimage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByPreimageDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByDescriptionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByRecipient({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByRecipientDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> thenBySender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenBySenderDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> thenByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy> thenByContent(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByContentDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByFindEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterSortBy>
      thenByFindEventDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }
}

extension ZapRecordsDBISARQueryWhereDistinct
    on QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QDistinct> {
  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByBolt11({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByPaidAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByZapper({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByPreimage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByRecipient({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctBySender({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QAfterDistinct>
      distinctByFindEvent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }
}

extension ZapRecordsDBISARQueryProperty1
    on QueryBuilder<ZapRecordsDBISAR, ZapRecordsDBISAR, QProperty> {
  QueryBuilder<ZapRecordsDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, String, QAfterProperty> bolt11Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, int, QAfterProperty> paidAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, String, QAfterProperty> zapperProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, String, QAfterProperty> preimageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, String, QAfterProperty> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, String, QAfterProperty> recipientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, String, QAfterProperty> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, String, QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, String, QAfterProperty> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, bool, QAfterProperty> findEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension ZapRecordsDBISARQueryProperty2<R>
    on QueryBuilder<ZapRecordsDBISAR, R, QAfterProperty> {
  QueryBuilder<ZapRecordsDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, String), QAfterProperty> bolt11Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, int), QAfterProperty> paidAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, String), QAfterProperty> zapperProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, String), QAfterProperty>
      preimageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, String), QAfterProperty>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, String), QAfterProperty>
      recipientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, String), QAfterProperty> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, String), QAfterProperty>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, String), QAfterProperty>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R, bool), QAfterProperty>
      findEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}

extension ZapRecordsDBISARQueryProperty3<R1, R2>
    on QueryBuilder<ZapRecordsDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<ZapRecordsDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, String), QOperations>
      bolt11Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, int), QOperations> paidAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, String), QOperations>
      zapperProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, String), QOperations>
      preimageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, String), QOperations>
      descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, String), QOperations>
      recipientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, String), QOperations>
      senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, String), QOperations>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, String), QOperations>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<ZapRecordsDBISAR, (R1, R2, bool), QOperations>
      findEventProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }
}
