// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetConfigDBISARCollection on Isar {
  IsarCollection<int, ConfigDBISAR> get configDBISARs => this.collection();
}

const ConfigDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ConfigDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'd',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'eventId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'time',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'configJson',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'proxyJson',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'd',
        properties: [
          "d",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, ConfigDBISAR>(
    serialize: serializeConfigDBISAR,
    deserialize: deserializeConfigDBISAR,
    deserializeProperty: deserializeConfigDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeConfigDBISAR(IsarWriter writer, ConfigDBISAR object) {
  IsarCore.writeString(writer, 1, object.d);
  IsarCore.writeString(writer, 2, object.eventId);
  IsarCore.writeLong(writer, 3, object.time);
  IsarCore.writeString(writer, 4, object.configJson);
  IsarCore.writeString(writer, 5, object.proxyJson);
  return object.id;
}

@isarProtected
ConfigDBISAR deserializeConfigDBISAR(IsarReader reader) {
  final String _d;
  _d = IsarCore.readString(reader, 1) ?? '';
  final String _eventId;
  _eventId = IsarCore.readString(reader, 2) ?? '';
  final int _time;
  {
    final value = IsarCore.readLong(reader, 3);
    if (value == -9223372036854775808) {
      _time = 0;
    } else {
      _time = value;
    }
  }
  final String _configJson;
  _configJson = IsarCore.readString(reader, 4) ?? '';
  final String _proxyJson;
  _proxyJson = IsarCore.readString(reader, 5) ?? '';
  final object = ConfigDBISAR(
    d: _d,
    eventId: _eventId,
    time: _time,
    configJson: _configJson,
    proxyJson: _proxyJson,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeConfigDBISARProp(IsarReader reader, int property) {
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
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      return IsarCore.readString(reader, 5) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ConfigDBISARUpdate {
  bool call({
    required int id,
    String? d,
    String? eventId,
    int? time,
    String? configJson,
    String? proxyJson,
  });
}

class _ConfigDBISARUpdateImpl implements _ConfigDBISARUpdate {
  const _ConfigDBISARUpdateImpl(this.collection);

  final IsarCollection<int, ConfigDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? d = ignore,
    Object? eventId = ignore,
    Object? time = ignore,
    Object? configJson = ignore,
    Object? proxyJson = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (d != ignore) 1: d as String?,
          if (eventId != ignore) 2: eventId as String?,
          if (time != ignore) 3: time as int?,
          if (configJson != ignore) 4: configJson as String?,
          if (proxyJson != ignore) 5: proxyJson as String?,
        }) >
        0;
  }
}

sealed class _ConfigDBISARUpdateAll {
  int call({
    required List<int> id,
    String? d,
    String? eventId,
    int? time,
    String? configJson,
    String? proxyJson,
  });
}

class _ConfigDBISARUpdateAllImpl implements _ConfigDBISARUpdateAll {
  const _ConfigDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, ConfigDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? d = ignore,
    Object? eventId = ignore,
    Object? time = ignore,
    Object? configJson = ignore,
    Object? proxyJson = ignore,
  }) {
    return collection.updateProperties(id, {
      if (d != ignore) 1: d as String?,
      if (eventId != ignore) 2: eventId as String?,
      if (time != ignore) 3: time as int?,
      if (configJson != ignore) 4: configJson as String?,
      if (proxyJson != ignore) 5: proxyJson as String?,
    });
  }
}

extension ConfigDBISARUpdate on IsarCollection<int, ConfigDBISAR> {
  _ConfigDBISARUpdate get update => _ConfigDBISARUpdateImpl(this);

  _ConfigDBISARUpdateAll get updateAll => _ConfigDBISARUpdateAllImpl(this);
}

sealed class _ConfigDBISARQueryUpdate {
  int call({
    String? d,
    String? eventId,
    int? time,
    String? configJson,
    String? proxyJson,
  });
}

class _ConfigDBISARQueryUpdateImpl implements _ConfigDBISARQueryUpdate {
  const _ConfigDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ConfigDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? d = ignore,
    Object? eventId = ignore,
    Object? time = ignore,
    Object? configJson = ignore,
    Object? proxyJson = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (d != ignore) 1: d as String?,
      if (eventId != ignore) 2: eventId as String?,
      if (time != ignore) 3: time as int?,
      if (configJson != ignore) 4: configJson as String?,
      if (proxyJson != ignore) 5: proxyJson as String?,
    });
  }
}

extension ConfigDBISARQueryUpdate on IsarQuery<ConfigDBISAR> {
  _ConfigDBISARQueryUpdate get updateFirst =>
      _ConfigDBISARQueryUpdateImpl(this, limit: 1);

  _ConfigDBISARQueryUpdate get updateAll => _ConfigDBISARQueryUpdateImpl(this);
}

class _ConfigDBISARQueryBuilderUpdateImpl implements _ConfigDBISARQueryUpdate {
  const _ConfigDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ConfigDBISAR, ConfigDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? d = ignore,
    Object? eventId = ignore,
    Object? time = ignore,
    Object? configJson = ignore,
    Object? proxyJson = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (d != ignore) 1: d as String?,
        if (eventId != ignore) 2: eventId as String?,
        if (time != ignore) 3: time as int?,
        if (configJson != ignore) 4: configJson as String?,
        if (proxyJson != ignore) 5: proxyJson as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension ConfigDBISARQueryBuilderUpdate
    on QueryBuilder<ConfigDBISAR, ConfigDBISAR, QOperations> {
  _ConfigDBISARQueryUpdate get updateFirst =>
      _ConfigDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _ConfigDBISARQueryUpdate get updateAll =>
      _ConfigDBISARQueryBuilderUpdateImpl(this);
}

extension ConfigDBISARQueryFilter
    on QueryBuilder<ConfigDBISAR, ConfigDBISAR, QFilterCondition> {
  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dGreaterThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      dGreaterThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dLessThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      dLessThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dBetween(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dStartsWith(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dEndsWith(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dContains(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dMatches(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> dIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      dIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdGreaterThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdGreaterThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdLessThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdLessThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdBetween(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdStartsWith(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdEndsWith(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      eventIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> timeEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      timeGreaterThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      timeGreaterThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> timeLessThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      timeLessThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition> timeBetween(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonGreaterThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonGreaterThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonLessThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonLessThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonBetween(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonStartsWith(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonEndsWith(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      configJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonGreaterThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonGreaterThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonLessThan(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonLessThanOrEqualTo(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonBetween(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonStartsWith(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonEndsWith(
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterFilterCondition>
      proxyJsonIsNotEmpty() {
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

extension ConfigDBISARQueryObject
    on QueryBuilder<ConfigDBISAR, ConfigDBISAR, QFilterCondition> {}

extension ConfigDBISARQuerySortBy
    on QueryBuilder<ConfigDBISAR, ConfigDBISAR, QSortBy> {
  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByD(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByDDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByEventIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByConfigJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByConfigJsonDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByProxyJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> sortByProxyJsonDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension ConfigDBISARQuerySortThenBy
    on QueryBuilder<ConfigDBISAR, ConfigDBISAR, QSortThenBy> {
  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByD(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByDDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByEventIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByConfigJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByConfigJsonDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByProxyJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterSortBy> thenByProxyJsonDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension ConfigDBISARQueryWhereDistinct
    on QueryBuilder<ConfigDBISAR, ConfigDBISAR, QDistinct> {
  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterDistinct> distinctByD(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterDistinct> distinctByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterDistinct> distinctByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterDistinct> distinctByConfigJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ConfigDBISAR, ConfigDBISAR, QAfterDistinct> distinctByProxyJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }
}

extension ConfigDBISARQueryProperty1
    on QueryBuilder<ConfigDBISAR, ConfigDBISAR, QProperty> {
  QueryBuilder<ConfigDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ConfigDBISAR, String, QAfterProperty> dProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ConfigDBISAR, String, QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ConfigDBISAR, int, QAfterProperty> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ConfigDBISAR, String, QAfterProperty> configJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ConfigDBISAR, String, QAfterProperty> proxyJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension ConfigDBISARQueryProperty2<R>
    on QueryBuilder<ConfigDBISAR, R, QAfterProperty> {
  QueryBuilder<ConfigDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ConfigDBISAR, (R, String), QAfterProperty> dProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ConfigDBISAR, (R, String), QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ConfigDBISAR, (R, int), QAfterProperty> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ConfigDBISAR, (R, String), QAfterProperty> configJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ConfigDBISAR, (R, String), QAfterProperty> proxyJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension ConfigDBISARQueryProperty3<R1, R2>
    on QueryBuilder<ConfigDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<ConfigDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ConfigDBISAR, (R1, R2, String), QOperations> dProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ConfigDBISAR, (R1, R2, String), QOperations> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ConfigDBISAR, (R1, R2, int), QOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ConfigDBISAR, (R1, R2, String), QOperations>
      configJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ConfigDBISAR, (R1, R2, String), QOperations>
      proxyJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}
