// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetEventDBISARCollection on Isar {
  IsarCollection<int, EventDBISAR> get eventDBISARs => this.collection();
}

const EventDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'EventDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'eventId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'rawData',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'expiration',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'eventSendStatusJson',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'eventReceiveStatusJson',
        type: IsarType.string,
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
  converter: IsarObjectConverter<int, EventDBISAR>(
    serialize: serializeEventDBISAR,
    deserialize: deserializeEventDBISAR,
    deserializeProperty: deserializeEventDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeEventDBISAR(IsarWriter writer, EventDBISAR object) {
  IsarCore.writeString(writer, 1, object.eventId);
  IsarCore.writeString(writer, 2, object.rawData);
  IsarCore.writeLong(writer, 3, object.expiration ?? -9223372036854775808);
  {
    final value = object.eventSendStatusJson;
    if (value == null) {
      IsarCore.writeNull(writer, 4);
    } else {
      IsarCore.writeString(writer, 4, value);
    }
  }
  {
    final value = object.eventReceiveStatusJson;
    if (value == null) {
      IsarCore.writeNull(writer, 5);
    } else {
      IsarCore.writeString(writer, 5, value);
    }
  }
  return object.id;
}

@isarProtected
EventDBISAR deserializeEventDBISAR(IsarReader reader) {
  final String _eventId;
  _eventId = IsarCore.readString(reader, 1) ?? '';
  final String _rawData;
  _rawData = IsarCore.readString(reader, 2) ?? '';
  final int? _expiration;
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _expiration = null;
    } else {
      _expiration = value;
    }
  }
  final object = EventDBISAR(
    eventId: _eventId,
    rawData: _rawData,
    expiration: _expiration,
  );
  object.id = IsarCore.readId(reader);
  object.eventSendStatusJson = IsarCore.readString(reader, 4);
  object.eventReceiveStatusJson = IsarCore.readString(reader, 5);
  return object;
}

@isarProtected
dynamic deserializeEventDBISARProp(IsarReader reader, int property) {
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
          return null;
        } else {
          return value;
        }
      }
    case 4:
      return IsarCore.readString(reader, 4);
    case 5:
      return IsarCore.readString(reader, 5);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _EventDBISARUpdate {
  bool call({
    required int id,
    String? eventId,
    String? rawData,
    int? expiration,
    String? eventSendStatusJson,
    String? eventReceiveStatusJson,
  });
}

class _EventDBISARUpdateImpl implements _EventDBISARUpdate {
  const _EventDBISARUpdateImpl(this.collection);

  final IsarCollection<int, EventDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? eventId = ignore,
    Object? rawData = ignore,
    Object? expiration = ignore,
    Object? eventSendStatusJson = ignore,
    Object? eventReceiveStatusJson = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (eventId != ignore) 1: eventId as String?,
          if (rawData != ignore) 2: rawData as String?,
          if (expiration != ignore) 3: expiration as int?,
          if (eventSendStatusJson != ignore) 4: eventSendStatusJson as String?,
          if (eventReceiveStatusJson != ignore)
            5: eventReceiveStatusJson as String?,
        }) >
        0;
  }
}

sealed class _EventDBISARUpdateAll {
  int call({
    required List<int> id,
    String? eventId,
    String? rawData,
    int? expiration,
    String? eventSendStatusJson,
    String? eventReceiveStatusJson,
  });
}

class _EventDBISARUpdateAllImpl implements _EventDBISARUpdateAll {
  const _EventDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, EventDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? eventId = ignore,
    Object? rawData = ignore,
    Object? expiration = ignore,
    Object? eventSendStatusJson = ignore,
    Object? eventReceiveStatusJson = ignore,
  }) {
    return collection.updateProperties(id, {
      if (eventId != ignore) 1: eventId as String?,
      if (rawData != ignore) 2: rawData as String?,
      if (expiration != ignore) 3: expiration as int?,
      if (eventSendStatusJson != ignore) 4: eventSendStatusJson as String?,
      if (eventReceiveStatusJson != ignore)
        5: eventReceiveStatusJson as String?,
    });
  }
}

extension EventDBISARUpdate on IsarCollection<int, EventDBISAR> {
  _EventDBISARUpdate get update => _EventDBISARUpdateImpl(this);

  _EventDBISARUpdateAll get updateAll => _EventDBISARUpdateAllImpl(this);
}

sealed class _EventDBISARQueryUpdate {
  int call({
    String? eventId,
    String? rawData,
    int? expiration,
    String? eventSendStatusJson,
    String? eventReceiveStatusJson,
  });
}

class _EventDBISARQueryUpdateImpl implements _EventDBISARQueryUpdate {
  const _EventDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<EventDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? eventId = ignore,
    Object? rawData = ignore,
    Object? expiration = ignore,
    Object? eventSendStatusJson = ignore,
    Object? eventReceiveStatusJson = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (eventId != ignore) 1: eventId as String?,
      if (rawData != ignore) 2: rawData as String?,
      if (expiration != ignore) 3: expiration as int?,
      if (eventSendStatusJson != ignore) 4: eventSendStatusJson as String?,
      if (eventReceiveStatusJson != ignore)
        5: eventReceiveStatusJson as String?,
    });
  }
}

extension EventDBISARQueryUpdate on IsarQuery<EventDBISAR> {
  _EventDBISARQueryUpdate get updateFirst =>
      _EventDBISARQueryUpdateImpl(this, limit: 1);

  _EventDBISARQueryUpdate get updateAll => _EventDBISARQueryUpdateImpl(this);
}

class _EventDBISARQueryBuilderUpdateImpl implements _EventDBISARQueryUpdate {
  const _EventDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<EventDBISAR, EventDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? eventId = ignore,
    Object? rawData = ignore,
    Object? expiration = ignore,
    Object? eventSendStatusJson = ignore,
    Object? eventReceiveStatusJson = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (eventId != ignore) 1: eventId as String?,
        if (rawData != ignore) 2: rawData as String?,
        if (expiration != ignore) 3: expiration as int?,
        if (eventSendStatusJson != ignore) 4: eventSendStatusJson as String?,
        if (eventReceiveStatusJson != ignore)
          5: eventReceiveStatusJson as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension EventDBISARQueryBuilderUpdate
    on QueryBuilder<EventDBISAR, EventDBISAR, QOperations> {
  _EventDBISARQueryUpdate get updateFirst =>
      _EventDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _EventDBISARQueryUpdate get updateAll =>
      _EventDBISARQueryBuilderUpdateImpl(this);
}

extension EventDBISARQueryFilter
    on QueryBuilder<EventDBISAR, EventDBISAR, QFilterCondition> {
  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> idBetween(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> eventIdEqualTo(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> eventIdLessThan(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> eventIdBetween(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> eventIdEndsWith(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> eventIdContains(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> eventIdMatches(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> rawDataEqualTo(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      rawDataGreaterThan(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      rawDataGreaterThanOrEqualTo(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> rawDataLessThan(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      rawDataLessThanOrEqualTo(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> rawDataBetween(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      rawDataStartsWith(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> rawDataEndsWith(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> rawDataContains(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition> rawDataMatches(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      rawDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      rawDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      expirationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      expirationIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      expirationEqualTo(
    int? value,
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      expirationGreaterThan(
    int? value,
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      expirationGreaterThanOrEqualTo(
    int? value,
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      expirationLessThan(
    int? value,
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      expirationLessThanOrEqualTo(
    int? value,
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      expirationBetween(
    int? lower,
    int? upper,
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonEqualTo(
    String? value, {
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonGreaterThan(
    String? value, {
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonGreaterThanOrEqualTo(
    String? value, {
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonLessThan(
    String? value, {
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonLessThanOrEqualTo(
    String? value, {
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonStartsWith(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonEndsWith(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventSendStatusJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonEqualTo(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonGreaterThan(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonGreaterThanOrEqualTo(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonLessThan(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonLessThanOrEqualTo(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonBetween(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonStartsWith(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonEndsWith(
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonContains(String value,
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonMatches(String pattern,
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

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterFilterCondition>
      eventReceiveStatusJsonIsNotEmpty() {
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

extension EventDBISARQueryObject
    on QueryBuilder<EventDBISAR, EventDBISAR, QFilterCondition> {}

extension EventDBISARQuerySortBy
    on QueryBuilder<EventDBISAR, EventDBISAR, QSortBy> {
  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> sortByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> sortByEventIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> sortByRawData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> sortByRawDataDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> sortByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> sortByExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy>
      sortByEventSendStatusJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy>
      sortByEventSendStatusJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy>
      sortByEventReceiveStatusJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy>
      sortByEventReceiveStatusJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension EventDBISARQuerySortThenBy
    on QueryBuilder<EventDBISAR, EventDBISAR, QSortThenBy> {
  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> thenByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> thenByEventIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> thenByRawData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> thenByRawDataDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> thenByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy> thenByExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy>
      thenByEventSendStatusJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy>
      thenByEventSendStatusJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy>
      thenByEventReceiveStatusJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterSortBy>
      thenByEventReceiveStatusJsonDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension EventDBISARQueryWhereDistinct
    on QueryBuilder<EventDBISAR, EventDBISAR, QDistinct> {
  QueryBuilder<EventDBISAR, EventDBISAR, QAfterDistinct> distinctByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterDistinct> distinctByRawData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterDistinct>
      distinctByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterDistinct>
      distinctByEventSendStatusJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EventDBISAR, EventDBISAR, QAfterDistinct>
      distinctByEventReceiveStatusJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }
}

extension EventDBISARQueryProperty1
    on QueryBuilder<EventDBISAR, EventDBISAR, QProperty> {
  QueryBuilder<EventDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<EventDBISAR, String, QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<EventDBISAR, String, QAfterProperty> rawDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<EventDBISAR, int?, QAfterProperty> expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<EventDBISAR, String?, QAfterProperty>
      eventSendStatusJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<EventDBISAR, String?, QAfterProperty>
      eventReceiveStatusJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension EventDBISARQueryProperty2<R>
    on QueryBuilder<EventDBISAR, R, QAfterProperty> {
  QueryBuilder<EventDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<EventDBISAR, (R, String), QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<EventDBISAR, (R, String), QAfterProperty> rawDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<EventDBISAR, (R, int?), QAfterProperty> expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<EventDBISAR, (R, String?), QAfterProperty>
      eventSendStatusJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<EventDBISAR, (R, String?), QAfterProperty>
      eventReceiveStatusJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension EventDBISARQueryProperty3<R1, R2>
    on QueryBuilder<EventDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<EventDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<EventDBISAR, (R1, R2, String), QOperations> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<EventDBISAR, (R1, R2, String), QOperations> rawDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<EventDBISAR, (R1, R2, int?), QOperations> expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<EventDBISAR, (R1, R2, String?), QOperations>
      eventSendStatusJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<EventDBISAR, (R1, R2, String?), QOperations>
      eventReceiveStatusJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}
