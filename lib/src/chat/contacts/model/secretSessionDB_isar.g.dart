// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secretSessionDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetSecretSessionDBISARCollection on Isar {
  IsarCollection<int, SecretSessionDBISAR> get secretSessionDBISARs =>
      this.collection();
}

const SecretSessionDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'SecretSessionDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'sessionId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'myPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'myAliasPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'myAliasPrivkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'toPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'toAliasPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'shareSecretKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'sharePubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'interval',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'expiration',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'relay',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'otherFields',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'lastUpdateTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'status',
        type: IsarType.long,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'sessionId',
        properties: [
          "sessionId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, SecretSessionDBISAR>(
    serialize: serializeSecretSessionDBISAR,
    deserialize: deserializeSecretSessionDBISAR,
    deserializeProperty: deserializeSecretSessionDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeSecretSessionDBISAR(
    IsarWriter writer, SecretSessionDBISAR object) {
  IsarCore.writeString(writer, 1, object.sessionId);
  {
    final value = object.myPubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  {
    final value = object.myAliasPubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 3);
    } else {
      IsarCore.writeString(writer, 3, value);
    }
  }
  {
    final value = object.myAliasPrivkey;
    if (value == null) {
      IsarCore.writeNull(writer, 4);
    } else {
      IsarCore.writeString(writer, 4, value);
    }
  }
  {
    final value = object.toPubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 5);
    } else {
      IsarCore.writeString(writer, 5, value);
    }
  }
  {
    final value = object.toAliasPubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 6);
    } else {
      IsarCore.writeString(writer, 6, value);
    }
  }
  {
    final value = object.shareSecretKey;
    if (value == null) {
      IsarCore.writeNull(writer, 7);
    } else {
      IsarCore.writeString(writer, 7, value);
    }
  }
  {
    final value = object.sharePubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 8);
    } else {
      IsarCore.writeString(writer, 8, value);
    }
  }
  IsarCore.writeLong(writer, 9, object.interval ?? -9223372036854775808);
  IsarCore.writeLong(writer, 10, object.expiration ?? -9223372036854775808);
  {
    final value = object.relay;
    if (value == null) {
      IsarCore.writeNull(writer, 11);
    } else {
      IsarCore.writeString(writer, 11, value);
    }
  }
  {
    final value = object.otherFields;
    if (value == null) {
      IsarCore.writeNull(writer, 12);
    } else {
      IsarCore.writeString(writer, 12, value);
    }
  }
  IsarCore.writeLong(writer, 13, object.lastUpdateTime);
  IsarCore.writeLong(writer, 14, object.status ?? -9223372036854775808);
  return object.id;
}

@isarProtected
SecretSessionDBISAR deserializeSecretSessionDBISAR(IsarReader reader) {
  final String _sessionId;
  _sessionId = IsarCore.readString(reader, 1) ?? '';
  final String? _myPubkey;
  _myPubkey = IsarCore.readString(reader, 2) ?? '';
  final String? _myAliasPubkey;
  _myAliasPubkey = IsarCore.readString(reader, 3) ?? '';
  final String? _myAliasPrivkey;
  _myAliasPrivkey = IsarCore.readString(reader, 4) ?? '';
  final String? _toPubkey;
  _toPubkey = IsarCore.readString(reader, 5) ?? '';
  final String? _toAliasPubkey;
  _toAliasPubkey = IsarCore.readString(reader, 6) ?? '';
  final String? _shareSecretKey;
  _shareSecretKey = IsarCore.readString(reader, 7) ?? '';
  final String? _sharePubkey;
  _sharePubkey = IsarCore.readString(reader, 8) ?? '';
  final int? _interval;
  {
    final value = IsarCore.readLong(reader, 9);
    if (value == -9223372036854775808) {
      _interval = 0;
    } else {
      _interval = value;
    }
  }
  final int? _expiration;
  {
    final value = IsarCore.readLong(reader, 10);
    if (value == -9223372036854775808) {
      _expiration = 0;
    } else {
      _expiration = value;
    }
  }
  final String? _relay;
  _relay = IsarCore.readString(reader, 11) ?? '';
  final String? _otherFields;
  _otherFields = IsarCore.readString(reader, 12) ?? '';
  final int _lastUpdateTime;
  {
    final value = IsarCore.readLong(reader, 13);
    if (value == -9223372036854775808) {
      _lastUpdateTime = 0;
    } else {
      _lastUpdateTime = value;
    }
  }
  final int? _status;
  {
    final value = IsarCore.readLong(reader, 14);
    if (value == -9223372036854775808) {
      _status = 0;
    } else {
      _status = value;
    }
  }
  final object = SecretSessionDBISAR(
    sessionId: _sessionId,
    myPubkey: _myPubkey,
    myAliasPubkey: _myAliasPubkey,
    myAliasPrivkey: _myAliasPrivkey,
    toPubkey: _toPubkey,
    toAliasPubkey: _toAliasPubkey,
    shareSecretKey: _shareSecretKey,
    sharePubkey: _sharePubkey,
    interval: _interval,
    expiration: _expiration,
    relay: _relay,
    otherFields: _otherFields,
    lastUpdateTime: _lastUpdateTime,
    status: _status,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeSecretSessionDBISARProp(IsarReader reader, int property) {
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
      return IsarCore.readString(reader, 8) ?? '';
    case 9:
      {
        final value = IsarCore.readLong(reader, 9);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 10:
      {
        final value = IsarCore.readLong(reader, 10);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 11:
      return IsarCore.readString(reader, 11) ?? '';
    case 12:
      return IsarCore.readString(reader, 12) ?? '';
    case 13:
      {
        final value = IsarCore.readLong(reader, 13);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
    case 14:
      {
        final value = IsarCore.readLong(reader, 14);
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

sealed class _SecretSessionDBISARUpdate {
  bool call({
    required int id,
    String? sessionId,
    String? myPubkey,
    String? myAliasPubkey,
    String? myAliasPrivkey,
    String? toPubkey,
    String? toAliasPubkey,
    String? shareSecretKey,
    String? sharePubkey,
    int? interval,
    int? expiration,
    String? relay,
    String? otherFields,
    int? lastUpdateTime,
    int? status,
  });
}

class _SecretSessionDBISARUpdateImpl implements _SecretSessionDBISARUpdate {
  const _SecretSessionDBISARUpdateImpl(this.collection);

  final IsarCollection<int, SecretSessionDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? sessionId = ignore,
    Object? myPubkey = ignore,
    Object? myAliasPubkey = ignore,
    Object? myAliasPrivkey = ignore,
    Object? toPubkey = ignore,
    Object? toAliasPubkey = ignore,
    Object? shareSecretKey = ignore,
    Object? sharePubkey = ignore,
    Object? interval = ignore,
    Object? expiration = ignore,
    Object? relay = ignore,
    Object? otherFields = ignore,
    Object? lastUpdateTime = ignore,
    Object? status = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (sessionId != ignore) 1: sessionId as String?,
          if (myPubkey != ignore) 2: myPubkey as String?,
          if (myAliasPubkey != ignore) 3: myAliasPubkey as String?,
          if (myAliasPrivkey != ignore) 4: myAliasPrivkey as String?,
          if (toPubkey != ignore) 5: toPubkey as String?,
          if (toAliasPubkey != ignore) 6: toAliasPubkey as String?,
          if (shareSecretKey != ignore) 7: shareSecretKey as String?,
          if (sharePubkey != ignore) 8: sharePubkey as String?,
          if (interval != ignore) 9: interval as int?,
          if (expiration != ignore) 10: expiration as int?,
          if (relay != ignore) 11: relay as String?,
          if (otherFields != ignore) 12: otherFields as String?,
          if (lastUpdateTime != ignore) 13: lastUpdateTime as int?,
          if (status != ignore) 14: status as int?,
        }) >
        0;
  }
}

sealed class _SecretSessionDBISARUpdateAll {
  int call({
    required List<int> id,
    String? sessionId,
    String? myPubkey,
    String? myAliasPubkey,
    String? myAliasPrivkey,
    String? toPubkey,
    String? toAliasPubkey,
    String? shareSecretKey,
    String? sharePubkey,
    int? interval,
    int? expiration,
    String? relay,
    String? otherFields,
    int? lastUpdateTime,
    int? status,
  });
}

class _SecretSessionDBISARUpdateAllImpl
    implements _SecretSessionDBISARUpdateAll {
  const _SecretSessionDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, SecretSessionDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? sessionId = ignore,
    Object? myPubkey = ignore,
    Object? myAliasPubkey = ignore,
    Object? myAliasPrivkey = ignore,
    Object? toPubkey = ignore,
    Object? toAliasPubkey = ignore,
    Object? shareSecretKey = ignore,
    Object? sharePubkey = ignore,
    Object? interval = ignore,
    Object? expiration = ignore,
    Object? relay = ignore,
    Object? otherFields = ignore,
    Object? lastUpdateTime = ignore,
    Object? status = ignore,
  }) {
    return collection.updateProperties(id, {
      if (sessionId != ignore) 1: sessionId as String?,
      if (myPubkey != ignore) 2: myPubkey as String?,
      if (myAliasPubkey != ignore) 3: myAliasPubkey as String?,
      if (myAliasPrivkey != ignore) 4: myAliasPrivkey as String?,
      if (toPubkey != ignore) 5: toPubkey as String?,
      if (toAliasPubkey != ignore) 6: toAliasPubkey as String?,
      if (shareSecretKey != ignore) 7: shareSecretKey as String?,
      if (sharePubkey != ignore) 8: sharePubkey as String?,
      if (interval != ignore) 9: interval as int?,
      if (expiration != ignore) 10: expiration as int?,
      if (relay != ignore) 11: relay as String?,
      if (otherFields != ignore) 12: otherFields as String?,
      if (lastUpdateTime != ignore) 13: lastUpdateTime as int?,
      if (status != ignore) 14: status as int?,
    });
  }
}

extension SecretSessionDBISARUpdate
    on IsarCollection<int, SecretSessionDBISAR> {
  _SecretSessionDBISARUpdate get update => _SecretSessionDBISARUpdateImpl(this);

  _SecretSessionDBISARUpdateAll get updateAll =>
      _SecretSessionDBISARUpdateAllImpl(this);
}

sealed class _SecretSessionDBISARQueryUpdate {
  int call({
    String? sessionId,
    String? myPubkey,
    String? myAliasPubkey,
    String? myAliasPrivkey,
    String? toPubkey,
    String? toAliasPubkey,
    String? shareSecretKey,
    String? sharePubkey,
    int? interval,
    int? expiration,
    String? relay,
    String? otherFields,
    int? lastUpdateTime,
    int? status,
  });
}

class _SecretSessionDBISARQueryUpdateImpl
    implements _SecretSessionDBISARQueryUpdate {
  const _SecretSessionDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<SecretSessionDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? sessionId = ignore,
    Object? myPubkey = ignore,
    Object? myAliasPubkey = ignore,
    Object? myAliasPrivkey = ignore,
    Object? toPubkey = ignore,
    Object? toAliasPubkey = ignore,
    Object? shareSecretKey = ignore,
    Object? sharePubkey = ignore,
    Object? interval = ignore,
    Object? expiration = ignore,
    Object? relay = ignore,
    Object? otherFields = ignore,
    Object? lastUpdateTime = ignore,
    Object? status = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (sessionId != ignore) 1: sessionId as String?,
      if (myPubkey != ignore) 2: myPubkey as String?,
      if (myAliasPubkey != ignore) 3: myAliasPubkey as String?,
      if (myAliasPrivkey != ignore) 4: myAliasPrivkey as String?,
      if (toPubkey != ignore) 5: toPubkey as String?,
      if (toAliasPubkey != ignore) 6: toAliasPubkey as String?,
      if (shareSecretKey != ignore) 7: shareSecretKey as String?,
      if (sharePubkey != ignore) 8: sharePubkey as String?,
      if (interval != ignore) 9: interval as int?,
      if (expiration != ignore) 10: expiration as int?,
      if (relay != ignore) 11: relay as String?,
      if (otherFields != ignore) 12: otherFields as String?,
      if (lastUpdateTime != ignore) 13: lastUpdateTime as int?,
      if (status != ignore) 14: status as int?,
    });
  }
}

extension SecretSessionDBISARQueryUpdate on IsarQuery<SecretSessionDBISAR> {
  _SecretSessionDBISARQueryUpdate get updateFirst =>
      _SecretSessionDBISARQueryUpdateImpl(this, limit: 1);

  _SecretSessionDBISARQueryUpdate get updateAll =>
      _SecretSessionDBISARQueryUpdateImpl(this);
}

class _SecretSessionDBISARQueryBuilderUpdateImpl
    implements _SecretSessionDBISARQueryUpdate {
  const _SecretSessionDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QOperations>
      query;
  final int? limit;

  @override
  int call({
    Object? sessionId = ignore,
    Object? myPubkey = ignore,
    Object? myAliasPubkey = ignore,
    Object? myAliasPrivkey = ignore,
    Object? toPubkey = ignore,
    Object? toAliasPubkey = ignore,
    Object? shareSecretKey = ignore,
    Object? sharePubkey = ignore,
    Object? interval = ignore,
    Object? expiration = ignore,
    Object? relay = ignore,
    Object? otherFields = ignore,
    Object? lastUpdateTime = ignore,
    Object? status = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (sessionId != ignore) 1: sessionId as String?,
        if (myPubkey != ignore) 2: myPubkey as String?,
        if (myAliasPubkey != ignore) 3: myAliasPubkey as String?,
        if (myAliasPrivkey != ignore) 4: myAliasPrivkey as String?,
        if (toPubkey != ignore) 5: toPubkey as String?,
        if (toAliasPubkey != ignore) 6: toAliasPubkey as String?,
        if (shareSecretKey != ignore) 7: shareSecretKey as String?,
        if (sharePubkey != ignore) 8: sharePubkey as String?,
        if (interval != ignore) 9: interval as int?,
        if (expiration != ignore) 10: expiration as int?,
        if (relay != ignore) 11: relay as String?,
        if (otherFields != ignore) 12: otherFields as String?,
        if (lastUpdateTime != ignore) 13: lastUpdateTime as int?,
        if (status != ignore) 14: status as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension SecretSessionDBISARQueryBuilderUpdate
    on QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QOperations> {
  _SecretSessionDBISARQueryUpdate get updateFirst =>
      _SecretSessionDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _SecretSessionDBISARQueryUpdate get updateAll =>
      _SecretSessionDBISARQueryBuilderUpdateImpl(this);
}

extension SecretSessionDBISARQueryFilter on QueryBuilder<SecretSessionDBISAR,
    SecretSessionDBISAR, QFilterCondition> {
  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdGreaterThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdGreaterThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdLessThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdLessThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdBetween(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdStartsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdEndsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sessionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyEqualTo(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyGreaterThan(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyGreaterThanOrEqualTo(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyLessThan(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyLessThanOrEqualTo(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyStartsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyEndsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyEqualTo(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyGreaterThan(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyGreaterThanOrEqualTo(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyLessThan(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyLessThanOrEqualTo(
    String? value, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyStartsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyEndsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyGreaterThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyGreaterThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyLessThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyLessThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyBetween(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyStartsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyEndsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      myAliasPrivkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyGreaterThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyLessThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyLessThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyBetween(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyStartsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyEndsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyGreaterThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyLessThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyLessThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyBetween(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyStartsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyEndsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      toAliasPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyGreaterThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyGreaterThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyLessThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyLessThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyBetween(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyStartsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyEndsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      shareSecretKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyGreaterThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyLessThan(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyLessThanOrEqualTo(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyBetween(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyStartsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyEndsWith(
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      sharePubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 8,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      intervalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      intervalIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      intervalEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      intervalGreaterThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      intervalGreaterThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      intervalLessThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      intervalLessThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      intervalBetween(
    int? lower,
    int? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      expirationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      expirationIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      expirationEqualTo(
    int? value,
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

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      expirationGreaterThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      expirationGreaterThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      expirationLessThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      expirationLessThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      expirationBetween(
    int? lower,
    int? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 11,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 11,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 11,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      relayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 12,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 12,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 12,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      otherFieldsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      lastUpdateTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      lastUpdateTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      lastUpdateTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      lastUpdateTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      lastUpdateTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 13,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      lastUpdateTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 13,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      statusEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      statusGreaterThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      statusGreaterThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      statusLessThan(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      statusLessThanOrEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 14,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterFilterCondition>
      statusBetween(
    int? lower,
    int? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension SecretSessionDBISARQueryObject on QueryBuilder<SecretSessionDBISAR,
    SecretSessionDBISAR, QFilterCondition> {}

extension SecretSessionDBISARQuerySortBy
    on QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QSortBy> {
  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortBySessionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortBySessionIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByMyPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByMyPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByMyAliasPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByMyAliasPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByMyAliasPrivkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByMyAliasPrivkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByToPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByToPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByToAliasPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByToAliasPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByShareSecretKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByShareSecretKeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortBySharePubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortBySharePubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        8,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByRelay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByRelayDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        11,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByOtherFields({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByOtherFieldsDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        12,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByLastUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByLastUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }
}

extension SecretSessionDBISARQuerySortThenBy
    on QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QSortThenBy> {
  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenBySessionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenBySessionIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByMyPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByMyPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByMyAliasPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByMyAliasPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByMyAliasPrivkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByMyAliasPrivkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByToPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByToPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByToAliasPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByToAliasPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByShareSecretKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByShareSecretKeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenBySharePubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenBySharePubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByExpirationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByRelay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByRelayDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByOtherFields({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByOtherFieldsDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByLastUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByLastUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }
}

extension SecretSessionDBISARQueryWhereDistinct
    on QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QDistinct> {
  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctBySessionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByMyPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByMyAliasPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByMyAliasPrivkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByToPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByToAliasPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByShareSecretKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctBySharePubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByExpiration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByRelay({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByOtherFields({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByLastUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QAfterDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14);
    });
  }
}

extension SecretSessionDBISARQueryProperty1
    on QueryBuilder<SecretSessionDBISAR, SecretSessionDBISAR, QProperty> {
  QueryBuilder<SecretSessionDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String, QAfterProperty>
      sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty>
      myPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty>
      myAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty>
      myAliasPrivkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty>
      toPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty>
      toAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty>
      shareSecretKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty>
      sharePubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<SecretSessionDBISAR, int?, QAfterProperty> intervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<SecretSessionDBISAR, int?, QAfterProperty> expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty> relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<SecretSessionDBISAR, String?, QAfterProperty>
      otherFieldsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<SecretSessionDBISAR, int, QAfterProperty>
      lastUpdateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<SecretSessionDBISAR, int?, QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }
}

extension SecretSessionDBISARQueryProperty2<R>
    on QueryBuilder<SecretSessionDBISAR, R, QAfterProperty> {
  QueryBuilder<SecretSessionDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String), QAfterProperty>
      sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      myPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      myAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      myAliasPrivkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      toPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      toAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      shareSecretKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      sharePubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, int?), QAfterProperty>
      intervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, int?), QAfterProperty>
      expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, String?), QAfterProperty>
      otherFieldsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, int), QAfterProperty>
      lastUpdateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R, int?), QAfterProperty>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }
}

extension SecretSessionDBISARQueryProperty3<R1, R2>
    on QueryBuilder<SecretSessionDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<SecretSessionDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String), QOperations>
      sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      myPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      myAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      myAliasPrivkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      toPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      toAliasPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      shareSecretKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      sharePubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, int?), QOperations>
      intervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, int?), QOperations>
      expirationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      relayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, String?), QOperations>
      otherFieldsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, int), QOperations>
      lastUpdateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<SecretSessionDBISAR, (R1, R2, int?), QOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }
}
