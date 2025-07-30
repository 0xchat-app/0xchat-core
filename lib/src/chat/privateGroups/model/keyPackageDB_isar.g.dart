// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyPackageDB_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetKeyPackageDBISARCollection on Isar {
  IsarCollection<int, KeyPackageDBISAR> get keyPackageDBISARs =>
      this.collection();
}

const KeyPackageDBISARSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'KeyPackageDBISAR',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'keyPackageId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'ownerPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'type',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'status',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'client',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'encodedKeyPackage',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'eventId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'createTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'mlsProtocolVersion',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'ciphersuite',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'extensions',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'relays',
        type: IsarType.stringList,
      ),
      IsarPropertySchema(
        name: 'usedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'usedByPubkey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'lastUpdatedTime',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'notes',
        type: IsarType.string,
      ),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'keyPackageId',
        properties: [
          "keyPackageId",
        ],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, KeyPackageDBISAR>(
    serialize: serializeKeyPackageDBISAR,
    deserialize: deserializeKeyPackageDBISAR,
    deserializeProperty: deserializeKeyPackageDBISARProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeKeyPackageDBISAR(IsarWriter writer, KeyPackageDBISAR object) {
  IsarCore.writeString(writer, 1, object.keyPackageId);
  IsarCore.writeString(writer, 2, object.ownerPubkey);
  IsarCore.writeString(writer, 3, object.type);
  IsarCore.writeString(writer, 4, object.status);
  IsarCore.writeString(writer, 5, object.client);
  IsarCore.writeString(writer, 6, object.encodedKeyPackage);
  IsarCore.writeString(writer, 7, object.eventId);
  IsarCore.writeLong(writer, 8, object.createTime);
  IsarCore.writeString(writer, 9, object.mlsProtocolVersion);
  IsarCore.writeString(writer, 10, object.ciphersuite);
  {
    final list = object.extensions;
    final listWriter = IsarCore.beginList(writer, 11, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  {
    final list = object.relays;
    final listWriter = IsarCore.beginList(writer, 12, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  IsarCore.writeLong(writer, 13, object.usedTime ?? -9223372036854775808);
  {
    final value = object.usedByPubkey;
    if (value == null) {
      IsarCore.writeNull(writer, 14);
    } else {
      IsarCore.writeString(writer, 14, value);
    }
  }
  IsarCore.writeLong(writer, 15, object.lastUpdatedTime);
  {
    final value = object.notes;
    if (value == null) {
      IsarCore.writeNull(writer, 16);
    } else {
      IsarCore.writeString(writer, 16, value);
    }
  }
  return object.id;
}

@isarProtected
KeyPackageDBISAR deserializeKeyPackageDBISAR(IsarReader reader) {
  final String _keyPackageId;
  _keyPackageId = IsarCore.readString(reader, 1) ?? '';
  final String _ownerPubkey;
  _ownerPubkey = IsarCore.readString(reader, 2) ?? '';
  final String _type;
  _type = IsarCore.readString(reader, 3) ?? '';
  final String _status;
  _status = IsarCore.readString(reader, 4) ?? '';
  final String _client;
  _client = IsarCore.readString(reader, 5) ?? '';
  final String _encodedKeyPackage;
  _encodedKeyPackage = IsarCore.readString(reader, 6) ?? '';
  final String _eventId;
  _eventId = IsarCore.readString(reader, 7) ?? '';
  final int _createTime;
  _createTime = IsarCore.readLong(reader, 8);
  final String _mlsProtocolVersion;
  _mlsProtocolVersion = IsarCore.readString(reader, 9) ?? '';
  final String _ciphersuite;
  _ciphersuite = IsarCore.readString(reader, 10) ?? '';
  final List<String> _extensions;
  {
    final length = IsarCore.readList(reader, 11, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _extensions = const <String>[];
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _extensions = list;
      }
    }
  }
  final List<String> _relays;
  {
    final length = IsarCore.readList(reader, 12, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        _relays = const <String>[];
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        _relays = list;
      }
    }
  }
  final int? _usedTime;
  {
    final value = IsarCore.readLong(reader, 13);
    if (value == -9223372036854775808) {
      _usedTime = null;
    } else {
      _usedTime = value;
    }
  }
  final String? _usedByPubkey;
  _usedByPubkey = IsarCore.readString(reader, 14);
  final int _lastUpdatedTime;
  _lastUpdatedTime = IsarCore.readLong(reader, 15);
  final String? _notes;
  _notes = IsarCore.readString(reader, 16);
  final object = KeyPackageDBISAR(
    keyPackageId: _keyPackageId,
    ownerPubkey: _ownerPubkey,
    type: _type,
    status: _status,
    client: _client,
    encodedKeyPackage: _encodedKeyPackage,
    eventId: _eventId,
    createTime: _createTime,
    mlsProtocolVersion: _mlsProtocolVersion,
    ciphersuite: _ciphersuite,
    extensions: _extensions,
    relays: _relays,
    usedTime: _usedTime,
    usedByPubkey: _usedByPubkey,
    lastUpdatedTime: _lastUpdatedTime,
    notes: _notes,
  );
  object.id = IsarCore.readId(reader);
  return object;
}

@isarProtected
dynamic deserializeKeyPackageDBISARProp(IsarReader reader, int property) {
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
      return IsarCore.readLong(reader, 8);
    case 9:
      return IsarCore.readString(reader, 9) ?? '';
    case 10:
      return IsarCore.readString(reader, 10) ?? '';
    case 11:
      {
        final length = IsarCore.readList(reader, 11, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <String>[];
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 12:
      {
        final length = IsarCore.readList(reader, 12, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <String>[];
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    case 13:
      {
        final value = IsarCore.readLong(reader, 13);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return value;
        }
      }
    case 14:
      return IsarCore.readString(reader, 14);
    case 15:
      return IsarCore.readLong(reader, 15);
    case 16:
      return IsarCore.readString(reader, 16);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _KeyPackageDBISARUpdate {
  bool call({
    required int id,
    String? keyPackageId,
    String? ownerPubkey,
    String? type,
    String? status,
    String? client,
    String? encodedKeyPackage,
    String? eventId,
    int? createTime,
    String? mlsProtocolVersion,
    String? ciphersuite,
    int? usedTime,
    String? usedByPubkey,
    int? lastUpdatedTime,
    String? notes,
  });
}

class _KeyPackageDBISARUpdateImpl implements _KeyPackageDBISARUpdate {
  const _KeyPackageDBISARUpdateImpl(this.collection);

  final IsarCollection<int, KeyPackageDBISAR> collection;

  @override
  bool call({
    required int id,
    Object? keyPackageId = ignore,
    Object? ownerPubkey = ignore,
    Object? type = ignore,
    Object? status = ignore,
    Object? client = ignore,
    Object? encodedKeyPackage = ignore,
    Object? eventId = ignore,
    Object? createTime = ignore,
    Object? mlsProtocolVersion = ignore,
    Object? ciphersuite = ignore,
    Object? usedTime = ignore,
    Object? usedByPubkey = ignore,
    Object? lastUpdatedTime = ignore,
    Object? notes = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (keyPackageId != ignore) 1: keyPackageId as String?,
          if (ownerPubkey != ignore) 2: ownerPubkey as String?,
          if (type != ignore) 3: type as String?,
          if (status != ignore) 4: status as String?,
          if (client != ignore) 5: client as String?,
          if (encodedKeyPackage != ignore) 6: encodedKeyPackage as String?,
          if (eventId != ignore) 7: eventId as String?,
          if (createTime != ignore) 8: createTime as int?,
          if (mlsProtocolVersion != ignore) 9: mlsProtocolVersion as String?,
          if (ciphersuite != ignore) 10: ciphersuite as String?,
          if (usedTime != ignore) 13: usedTime as int?,
          if (usedByPubkey != ignore) 14: usedByPubkey as String?,
          if (lastUpdatedTime != ignore) 15: lastUpdatedTime as int?,
          if (notes != ignore) 16: notes as String?,
        }) >
        0;
  }
}

sealed class _KeyPackageDBISARUpdateAll {
  int call({
    required List<int> id,
    String? keyPackageId,
    String? ownerPubkey,
    String? type,
    String? status,
    String? client,
    String? encodedKeyPackage,
    String? eventId,
    int? createTime,
    String? mlsProtocolVersion,
    String? ciphersuite,
    int? usedTime,
    String? usedByPubkey,
    int? lastUpdatedTime,
    String? notes,
  });
}

class _KeyPackageDBISARUpdateAllImpl implements _KeyPackageDBISARUpdateAll {
  const _KeyPackageDBISARUpdateAllImpl(this.collection);

  final IsarCollection<int, KeyPackageDBISAR> collection;

  @override
  int call({
    required List<int> id,
    Object? keyPackageId = ignore,
    Object? ownerPubkey = ignore,
    Object? type = ignore,
    Object? status = ignore,
    Object? client = ignore,
    Object? encodedKeyPackage = ignore,
    Object? eventId = ignore,
    Object? createTime = ignore,
    Object? mlsProtocolVersion = ignore,
    Object? ciphersuite = ignore,
    Object? usedTime = ignore,
    Object? usedByPubkey = ignore,
    Object? lastUpdatedTime = ignore,
    Object? notes = ignore,
  }) {
    return collection.updateProperties(id, {
      if (keyPackageId != ignore) 1: keyPackageId as String?,
      if (ownerPubkey != ignore) 2: ownerPubkey as String?,
      if (type != ignore) 3: type as String?,
      if (status != ignore) 4: status as String?,
      if (client != ignore) 5: client as String?,
      if (encodedKeyPackage != ignore) 6: encodedKeyPackage as String?,
      if (eventId != ignore) 7: eventId as String?,
      if (createTime != ignore) 8: createTime as int?,
      if (mlsProtocolVersion != ignore) 9: mlsProtocolVersion as String?,
      if (ciphersuite != ignore) 10: ciphersuite as String?,
      if (usedTime != ignore) 13: usedTime as int?,
      if (usedByPubkey != ignore) 14: usedByPubkey as String?,
      if (lastUpdatedTime != ignore) 15: lastUpdatedTime as int?,
      if (notes != ignore) 16: notes as String?,
    });
  }
}

extension KeyPackageDBISARUpdate on IsarCollection<int, KeyPackageDBISAR> {
  _KeyPackageDBISARUpdate get update => _KeyPackageDBISARUpdateImpl(this);

  _KeyPackageDBISARUpdateAll get updateAll =>
      _KeyPackageDBISARUpdateAllImpl(this);
}

sealed class _KeyPackageDBISARQueryUpdate {
  int call({
    String? keyPackageId,
    String? ownerPubkey,
    String? type,
    String? status,
    String? client,
    String? encodedKeyPackage,
    String? eventId,
    int? createTime,
    String? mlsProtocolVersion,
    String? ciphersuite,
    int? usedTime,
    String? usedByPubkey,
    int? lastUpdatedTime,
    String? notes,
  });
}

class _KeyPackageDBISARQueryUpdateImpl implements _KeyPackageDBISARQueryUpdate {
  const _KeyPackageDBISARQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<KeyPackageDBISAR> query;
  final int? limit;

  @override
  int call({
    Object? keyPackageId = ignore,
    Object? ownerPubkey = ignore,
    Object? type = ignore,
    Object? status = ignore,
    Object? client = ignore,
    Object? encodedKeyPackage = ignore,
    Object? eventId = ignore,
    Object? createTime = ignore,
    Object? mlsProtocolVersion = ignore,
    Object? ciphersuite = ignore,
    Object? usedTime = ignore,
    Object? usedByPubkey = ignore,
    Object? lastUpdatedTime = ignore,
    Object? notes = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (keyPackageId != ignore) 1: keyPackageId as String?,
      if (ownerPubkey != ignore) 2: ownerPubkey as String?,
      if (type != ignore) 3: type as String?,
      if (status != ignore) 4: status as String?,
      if (client != ignore) 5: client as String?,
      if (encodedKeyPackage != ignore) 6: encodedKeyPackage as String?,
      if (eventId != ignore) 7: eventId as String?,
      if (createTime != ignore) 8: createTime as int?,
      if (mlsProtocolVersion != ignore) 9: mlsProtocolVersion as String?,
      if (ciphersuite != ignore) 10: ciphersuite as String?,
      if (usedTime != ignore) 13: usedTime as int?,
      if (usedByPubkey != ignore) 14: usedByPubkey as String?,
      if (lastUpdatedTime != ignore) 15: lastUpdatedTime as int?,
      if (notes != ignore) 16: notes as String?,
    });
  }
}

extension KeyPackageDBISARQueryUpdate on IsarQuery<KeyPackageDBISAR> {
  _KeyPackageDBISARQueryUpdate get updateFirst =>
      _KeyPackageDBISARQueryUpdateImpl(this, limit: 1);

  _KeyPackageDBISARQueryUpdate get updateAll =>
      _KeyPackageDBISARQueryUpdateImpl(this);
}

class _KeyPackageDBISARQueryBuilderUpdateImpl
    implements _KeyPackageDBISARQueryUpdate {
  const _KeyPackageDBISARQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? keyPackageId = ignore,
    Object? ownerPubkey = ignore,
    Object? type = ignore,
    Object? status = ignore,
    Object? client = ignore,
    Object? encodedKeyPackage = ignore,
    Object? eventId = ignore,
    Object? createTime = ignore,
    Object? mlsProtocolVersion = ignore,
    Object? ciphersuite = ignore,
    Object? usedTime = ignore,
    Object? usedByPubkey = ignore,
    Object? lastUpdatedTime = ignore,
    Object? notes = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (keyPackageId != ignore) 1: keyPackageId as String?,
        if (ownerPubkey != ignore) 2: ownerPubkey as String?,
        if (type != ignore) 3: type as String?,
        if (status != ignore) 4: status as String?,
        if (client != ignore) 5: client as String?,
        if (encodedKeyPackage != ignore) 6: encodedKeyPackage as String?,
        if (eventId != ignore) 7: eventId as String?,
        if (createTime != ignore) 8: createTime as int?,
        if (mlsProtocolVersion != ignore) 9: mlsProtocolVersion as String?,
        if (ciphersuite != ignore) 10: ciphersuite as String?,
        if (usedTime != ignore) 13: usedTime as int?,
        if (usedByPubkey != ignore) 14: usedByPubkey as String?,
        if (lastUpdatedTime != ignore) 15: lastUpdatedTime as int?,
        if (notes != ignore) 16: notes as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension KeyPackageDBISARQueryBuilderUpdate
    on QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QOperations> {
  _KeyPackageDBISARQueryUpdate get updateFirst =>
      _KeyPackageDBISARQueryBuilderUpdateImpl(this, limit: 1);

  _KeyPackageDBISARQueryUpdate get updateAll =>
      _KeyPackageDBISARQueryBuilderUpdateImpl(this);
}

extension KeyPackageDBISARQueryFilter
    on QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QFilterCondition> {
  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdGreaterThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdGreaterThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdLessThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdLessThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdBetween(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      keyPackageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyGreaterThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyGreaterThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyLessThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyLessThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyBetween(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ownerPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeGreaterThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeGreaterThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeLessThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeLessThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeBetween(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusGreaterThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusGreaterThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusLessThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusLessThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusBetween(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientGreaterThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientGreaterThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientLessThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientLessThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientBetween(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      clientIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageGreaterThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageGreaterThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageLessThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageLessThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageBetween(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      encodedKeyPackageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 6,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdGreaterThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdGreaterThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdLessThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdLessThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdBetween(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      eventIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 7,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionGreaterThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionGreaterThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionLessThan(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionLessThanOrEqualTo(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionBetween(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      mlsProtocolVersionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 9,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 10,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 10,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      ciphersuiteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 10,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementEqualTo(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementGreaterThan(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementLessThan(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 11,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsIsEmpty() {
    return not().extensionsIsNotEmpty();
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      extensionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 11, value: null),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementEqualTo(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementGreaterThan(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementLessThan(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementLessThanOrEqualTo(
    String value, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementBetween(
    String lower,
    String upper, {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementStartsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementEndsWith(
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 12,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysIsEmpty() {
    return not().relaysIsNotEmpty();
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      relaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 12, value: null),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedTimeIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedTimeEqualTo(
    int? value,
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedTimeGreaterThan(
    int? value,
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedTimeGreaterThanOrEqualTo(
    int? value,
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedTimeLessThan(
    int? value,
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedTimeLessThanOrEqualTo(
    int? value,
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedTimeBetween(
    int? lower,
    int? upper,
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

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 14,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 14,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      usedByPubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 14,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      lastUpdatedTimeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      lastUpdatedTimeGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      lastUpdatedTimeGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      lastUpdatedTimeLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      lastUpdatedTimeLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 15,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      lastUpdatedTimeBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 15,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 16,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 16,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 16,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 16,
          value: '',
        ),
      );
    });
  }
}

extension KeyPackageDBISARQueryObject
    on QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QFilterCondition> {}

extension KeyPackageDBISARQuerySortBy
    on QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QSortBy> {
  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByKeyPackageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByKeyPackageIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByOwnerPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByOwnerPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> sortByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> sortByTypeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> sortByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> sortByClient(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByClientDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        5,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByEncodedKeyPackage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByEncodedKeyPackageDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        6,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> sortByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        7,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByMlsProtocolVersion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByMlsProtocolVersionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        9,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByCiphersuite({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByCiphersuiteDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        10,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByUsedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByUsedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByUsedByPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        14,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByUsedByPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        14,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByLastUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> sortByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      sortByNotesDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        16,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension KeyPackageDBISARQuerySortThenBy
    on QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QSortThenBy> {
  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByKeyPackageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByKeyPackageIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByOwnerPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByOwnerPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> thenByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> thenByTypeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> thenByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByStatusDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> thenByClient(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByClientDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByEncodedKeyPackage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByEncodedKeyPackageDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> thenByEventId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByEventIdDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByMlsProtocolVersion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByMlsProtocolVersionDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByCiphersuite({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByCiphersuiteDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByUsedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByUsedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByUsedByPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByUsedByPubkeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByLastUpdatedTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy> thenByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterSortBy>
      thenByNotesDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension KeyPackageDBISARQueryWhereDistinct
    on QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QDistinct> {
  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByKeyPackageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByOwnerPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByClient({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByEncodedKeyPackage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByEventId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByMlsProtocolVersion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByCiphersuite({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByExtensions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByRelays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByUsedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByUsedByPubkey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByLastUpdatedTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QAfterDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16, caseSensitive: caseSensitive);
    });
  }
}

extension KeyPackageDBISARQueryProperty1
    on QueryBuilder<KeyPackageDBISAR, KeyPackageDBISAR, QProperty> {
  QueryBuilder<KeyPackageDBISAR, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty>
      keyPackageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty> ownerPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty> clientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty>
      encodedKeyPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty> eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<KeyPackageDBISAR, int, QAfterProperty> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty>
      mlsProtocolVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String, QAfterProperty> ciphersuiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<KeyPackageDBISAR, List<String>, QAfterProperty>
      extensionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<KeyPackageDBISAR, List<String>, QAfterProperty>
      relaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<KeyPackageDBISAR, int?, QAfterProperty> usedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String?, QAfterProperty>
      usedByPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<KeyPackageDBISAR, int, QAfterProperty>
      lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<KeyPackageDBISAR, String?, QAfterProperty> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}

extension KeyPackageDBISARQueryProperty2<R>
    on QueryBuilder<KeyPackageDBISAR, R, QAfterProperty> {
  QueryBuilder<KeyPackageDBISAR, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty>
      keyPackageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty>
      ownerPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty> clientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty>
      encodedKeyPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, int), QAfterProperty>
      createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty>
      mlsProtocolVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String), QAfterProperty>
      ciphersuiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, List<String>), QAfterProperty>
      extensionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, List<String>), QAfterProperty>
      relaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, int?), QAfterProperty> usedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String?), QAfterProperty>
      usedByPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, int), QAfterProperty>
      lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R, String?), QAfterProperty> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}

extension KeyPackageDBISARQueryProperty3<R1, R2>
    on QueryBuilder<KeyPackageDBISAR, (R1, R2), QAfterProperty> {
  QueryBuilder<KeyPackageDBISAR, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations>
      keyPackageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations>
      ownerPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations>
      clientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations>
      encodedKeyPackageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations>
      eventIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, int), QOperations>
      createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations>
      mlsProtocolVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String), QOperations>
      ciphersuiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, List<String>), QOperations>
      extensionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, List<String>), QOperations>
      relaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, int?), QOperations>
      usedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String?), QOperations>
      usedByPubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, int), QOperations>
      lastUpdatedTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<KeyPackageDBISAR, (R1, R2, String?), QOperations>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}
