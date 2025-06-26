// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zapsDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetZapsDBISARCollection on Isar {
  IsarCollection<int, ZapsDBISAR> get zapsDBISARs => this.collection();
}

const ZapsDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ZapsDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'lnAddr',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'lnURL',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'allowsNostr',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'callback',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'minSendable',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'maxSendable',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'nostrPubkey',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'lnAddr',
        properties: [
          "lnAddr",
        ],
        unique: true,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'lnURL',
        properties: [
          "lnURL",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, ZapsDBISAR>(
    serialize: serializeZapsDBISAR,
    deserialize: deserializeZapsDBISAR,
    deserializeProperty: deserializeZapsDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeZapsDBISAR(IsarWriter writer, ZapsDBISAR object) {
  IsarCore.writeString(writer, 1, object.lnAddr);
  IsarCore.writeString(writer, 2, object.lnURL);
  IsarCore.writeBool(writer, 3, object.allowsNostr);
  IsarCore.writeString(writer, 4, object.callback);
  IsarCore.writeLong(writer, 5, object.minSendable);
  IsarCore.writeLong(writer, 6, object.maxSendable);
  IsarCore.writeString(writer, 7, object.nostrPubkey);
  return object.id;
}

@isarProtected
ZapsDBISAR deserializeZapsDBISAR(IsarReader reader) {
  final String _lnAddr;
  _lnAddr = IsarCore.readString(reader, 1) ?? '';
  final String _lnURL;
  _lnURL = IsarCore.readString(reader, 2) ?? '';
  final bool _allowsNostr;
  _allowsNostr = IsarCore.readBool(reader, 3);
  final String _callback;
  _callback = IsarCore.readString(reader, 4) ?? '';
  final int _minSendable;
  {
    final value = IsarCore.readLong(reader, 5);
    if (value == -9223372036854775808) {
      _minSendable = 0;
    } else {
      _minSendable = value;
    }
  }
  final int _maxSendable;
  {
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      _maxSendable = 0;
    } else {
      _maxSendable = value;
    }
  }
  final String _nostrPubkey;
  _nostrPubkey = IsarCore.readString(reader, 7) ?? '';
  final object = ZapsDBISAR(
    lnAddr: _lnAddr,
    lnURL: _lnURL,
    allowsNostr: _allowsNostr,
    callback: _callback,
    minSendable: _minSendable,
    maxSendable: _maxSendable,
    nostrPubkey: _nostrPubkey,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeZapsDBISARProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readBool(reader, 3);
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      {
        final value = IsarCore.readLong(reader, 5);
        if (value == -9223372036854775808) {
          return 0;
        } else {
          return value;
        }
      }
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

sealed class _ZapsDBISARUpdate {
  bool call({
    required int id,
    String? lnAddr,
    String? lnURL,
    bool? allowsNostr,
    String? callback,
    int? minSendable,
    int? maxSendable,
    String? nostrPubkey,
  });
}

class _ZapsDBISARUpdateImpl implements _ZapsDBISARUpdate {
  const _ZapsDBISARUpdateImpl(this.collection);

  final IsarCollection<int, ZapsDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? lnAddr = ignore,
    Object? lnURL = ignore,
    Object? allowsNostr = ignore,
    Object? callback = ignore,
    Object? minSendable = ignore,
    Object? maxSendable = ignore,
    Object? nostrPubkey = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (lnAddr != ignore) 1: lnAddr as String?,
          if (lnURL != ignore) 2: lnURL as String?,
          if (allowsNostr != ignore) 3: allowsNostr as bool?,
          if (callback != ignore) 4: callback as String?,
          if (minSendable != ignore) 5: minSendable as int?,
          if (maxSendable != ignore) 6: maxSendable as int?,
          if (nostrPubkey != ignore) 7: nostrPubkey as String?,
        }) >
        0;
  }
}

sealed class _ZapsDBISARUpdateAll {
  int call({
    required List<int> id,
    String? lnAddr,
    String? lnURL,
    bool? allowsNostr,
    String? callback,
    int? minSendable,
    int? maxSendable,
    String? nostrPubkey,
  });
}

class _ZapsDBISARUpdateAllImpl implements _ZapsDBISARUpdateAll {
  const _ZapsDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, ZapsDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? lnAddr = ignore,
    Object? lnURL = ignore,
    Object? allowsNostr = ignore,
    Object? callback = ignore,
    Object? minSendable = ignore,
    Object? maxSendable = ignore,
    Object? nostrPubkey = ignore,
  }) {
    return collection.updateProperties(id, {
      if (lnAddr != ignore) 1: lnAddr as String?,
      if (lnURL != ignore) 2: lnURL as String?,
      if (allowsNostr != ignore) 3: allowsNostr as bool?,
      if (callback != ignore) 4: callback as String?,
      if (minSendable != ignore) 5: minSendable as int?,
      if (maxSendable != ignore) 6: maxSendable as int?,
      if (nostrPubkey != ignore) 7: nostrPubkey as String?,
    });
  }
}

extension ZapsDBISARUpdate on IsarCollection<int, ZapsDBISAR> {
  _ZapsDBISARUpdate get update => _ZapsDBISARUpdateImpl(this);

  _ZapsDBISARUpdateAll get updateAll => _ZapsDBISARUpdateAllImpl(this);
}

sealed class _ZapsDBISARQueryUpdate {
  int call({
    String? lnAddr,
    String? lnURL,
    bool? allowsNostr,
    String? callback,
    int? minSendable,
    int? maxSendable,
    String? nostrPubkey,
  });
}

class _ZapsDBISARQueryUpdateImpl implements _ZapsDBISARQueryUpdate {
  const _ZapsDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ZapsDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? lnAddr = ignore,
    Object? lnURL = ignore,
    Object? allowsNostr = ignore,
    Object? callback = ignore,
    Object? minSendable = ignore,
    Object? maxSendable = ignore,
    Object? nostrPubkey = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (lnAddr != ignore) 1: lnAddr as String?,
      if (lnURL != ignore) 2: lnURL as String?,
      if (allowsNostr != ignore) 3: allowsNostr as bool?,
      if (callback != ignore) 4: callback as String?,
      if (minSendable != ignore) 5: minSendable as int?,
      if (maxSendable != ignore) 6: maxSendable as int?,
      if (nostrPubkey != ignore) 7: nostrPubkey as String?,
    });
  }
}

extension ZapsDBISARQueryUpdate on IsarQuery<ZapsDBISAR> {
  _ZapsDBISARQueryUpdate get updateFirst =>
      _ZapsDBISARQueryUpdateImpl(this, limit: 1);

  _ZapsDBISARQueryUpdate get updateAll => _ZapsDBISARQueryUpdateImpl(this);
}

class _ZapsDBISARQueryBuilderUpdateImpl implements _ZapsDBISARQueryUpdate {
  const _ZapsDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ZapsDBISAR, ZapsDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? lnAddr = ignore,
    Object? lnURL = ignore,
    Object? allowsNostr = ignore,
    Object? callback = ignore,
    Object? minSendable = ignore,
    Object? maxSendable = ignore,
    Object? nostrPubkey = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (lnAddr != ignore) 1: lnAddr as String?,
        if (lnURL != ignore) 2: lnURL as String?,
        if (allowsNostr != ignore) 3: allowsNostr as bool?,
        if (callback != ignore) 4: callback as String?,
        if (minSendable != ignore) 5: minSendable as int?,
        if (maxSendable != ignore) 6: maxSendable as int?,
        if (nostrPubkey != ignore) 7: nostrPubkey as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension ZapsDBISARQueryBuilderUpdate
    on QueryBuilder<ZapsDBISAR, ZapsDBISAR, QOperations> {
  _ZapsDBISARQueryUpdate get updateFirst =>
      _ZapsDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _ZapsDBISARQueryUpdate get updateAll =>
      _ZapsDBISARQueryBuilderUpdateImpl(this);
}

extension ZapsDBISARQueryFilter
    on QueryBuilder<ZapsDBISAR, ZapsDBISAR, QFilterCondition> {
  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrGreaterThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      lnAddrGreaterThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrLessThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      lnAddrLessThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrBetween(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrStartsWith(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrEndsWith(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrContains(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrMatches(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnAddrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      lnAddrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLGreaterThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      lnURLGreaterThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLLessThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      lnURLLessThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLBetween(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLStartsWith(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLEndsWith(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLContains(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLMatches(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> lnURLIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      lnURLIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      allowsNostrEqualTo(
    bool value,
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> callbackEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      callbackGreaterThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      callbackGreaterThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> callbackLessThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      callbackLessThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> callbackBetween(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      callbackStartsWith(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> callbackEndsWith(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> callbackContains(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition> callbackMatches(
      String pattern,
      {bool caseSensitive = true}) {
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      callbackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      callbackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      minSendableEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      minSendableGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      minSendableGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      minSendableLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      minSendableLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      minSendableBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      maxSendableEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      maxSendableGreaterThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      maxSendableGreaterThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      maxSendableLessThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      maxSendableLessThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      maxSendableBetween(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyGreaterThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyLessThan(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyLessThanOrEqualTo(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyBetween(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyStartsWith(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyEndsWith(
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterFilterCondition>
      nostrPubkeyIsNotEmpty() {
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

extension ZapsDBISARQueryObject
    on QueryBuilder<ZapsDBISAR, ZapsDBISAR, QFilterCondition> {}

extension ZapsDBISARQuerySortBy
    on QueryBuilder<ZapsDBISAR, ZapsDBISAR, QSortBy> {
  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByLnAddr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByLnAddrDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByLnURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByLnURLDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByAllowsNostr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByAllowsNostrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByCallback(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByCallbackDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByMinSendable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByMinSendableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByMaxSendable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByMaxSendableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByNostrPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> sortByNostrPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension ZapsDBISARQuerySortThenBy
    on QueryBuilder<ZapsDBISAR, ZapsDBISAR, QSortThenBy> {
  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByLnAddr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByLnAddrDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByLnURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByLnURLDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByAllowsNostr() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByAllowsNostrDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByCallback(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByCallbackDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByMinSendable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByMinSendableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByMaxSendable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByMaxSendableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByNostrPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterSortBy> thenByNostrPubkeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension ZapsDBISARQueryWhereDistinct
    on QueryBuilder<ZapsDBISAR, ZapsDBISAR, QDistinct> {
  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterDistinct> distinctByLnAddr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterDistinct> distinctByLnURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterDistinct> distinctByAllowsNostr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterDistinct> distinctByCallback(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterDistinct> distinctByMinSendable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterDistinct> distinctByMaxSendable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<ZapsDBISAR, ZapsDBISAR, QAfterDistinct> distinctByNostrPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }
}

extension ZapsDBISARQueryProperty1
    on QueryBuilder<ZapsDBISAR, ZapsDBISAR, QProperty> {
  QueryBuilder<ZapsDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ZapsDBISAR, String, QAfterProperty> lnAddrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ZapsDBISAR, String, QAfterProperty> lnURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ZapsDBISAR, bool, QAfterProperty> allowsNostrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ZapsDBISAR, String, QAfterProperty> callbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ZapsDBISAR, int, QAfterProperty> minSendableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ZapsDBISAR, int, QAfterProperty> maxSendableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ZapsDBISAR, String, QAfterProperty> nostrPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension ZapsDBISARQueryProperty2<R>
    on QueryBuilder<ZapsDBISAR, R, QAfterProperty> {
  QueryBuilder<ZapsDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ZapsDBISAR, (R, String), QAfterProperty> lnAddrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ZapsDBISAR, (R, String), QAfterProperty> lnURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ZapsDBISAR, (R, bool), QAfterProperty> allowsNostrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ZapsDBISAR, (R, String), QAfterProperty> callbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ZapsDBISAR, (R, int), QAfterProperty> minSendableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ZapsDBISAR, (R, int), QAfterProperty> maxSendableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ZapsDBISAR, (R, String), QAfterProperty> nostrPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}

extension ZapsDBISARQueryProperty3<R1, R2>
    on QueryBuilder<ZapsDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<ZapsDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ZapsDBISAR, (R1, R2, String), QOperations> lnAddrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ZapsDBISAR, (R1, R2, String), QOperations> lnURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ZapsDBISAR, (R1, R2, bool), QOperations> allowsNostrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ZapsDBISAR, (R1, R2, String), QOperations> callbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ZapsDBISAR, (R1, R2, int), QOperations> minSendableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ZapsDBISAR, (R1, R2, int), QOperations> maxSendableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<ZapsDBISAR, (R1, R2, String), QOperations>
      nostrPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }
}
