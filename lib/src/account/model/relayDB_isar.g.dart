// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relayDB_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRelayDBISARCollection on Isar {
  IsarCollection<RelayDBISAR> get relayDBISARs => this.collection();
}

const RelayDBISARSchema = CollectionSchema(
  name: r'RelayDBISAR',
  id: 862786408464510114,
  properties: {
    r'channelMessageSinceString': PropertySchema(
      id: 0,
      name: r'channelMessageSinceString',
      type: IsarType.string,
    ),
    r'channelMessageUntilString': PropertySchema(
      id: 1,
      name: r'channelMessageUntilString',
      type: IsarType.string,
    ),
    r'commonMessagesSince': PropertySchema(
      id: 2,
      name: r'commonMessagesSince',
      type: IsarType.long,
    ),
    r'commonMessagesUntil': PropertySchema(
      id: 3,
      name: r'commonMessagesUntil',
      type: IsarType.long,
    ),
    r'contact': PropertySchema(
      id: 4,
      name: r'contact',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 5,
      name: r'description',
      type: IsarType.string,
    ),
    r'fees': PropertySchema(
      id: 6,
      name: r'fees',
      type: IsarType.string,
    ),
    r'friendMessageSinceString': PropertySchema(
      id: 7,
      name: r'friendMessageSinceString',
      type: IsarType.string,
    ),
    r'friendMessageUntilString': PropertySchema(
      id: 8,
      name: r'friendMessageUntilString',
      type: IsarType.string,
    ),
    r'friendRequestSince': PropertySchema(
      id: 9,
      name: r'friendRequestSince',
      type: IsarType.long,
    ),
    r'friendRequestUntil': PropertySchema(
      id: 10,
      name: r'friendRequestUntil',
      type: IsarType.long,
    ),
    r'groupMessageSinceString': PropertySchema(
      id: 11,
      name: r'groupMessageSinceString',
      type: IsarType.string,
    ),
    r'groupMessageUntilString': PropertySchema(
      id: 12,
      name: r'groupMessageUntilString',
      type: IsarType.string,
    ),
    r'icon': PropertySchema(
      id: 13,
      name: r'icon',
      type: IsarType.string,
    ),
    r'limitation': PropertySchema(
      id: 14,
      name: r'limitation',
      type: IsarType.string,
    ),
    r'momentSinceString': PropertySchema(
      id: 15,
      name: r'momentSinceString',
      type: IsarType.string,
    ),
    r'momentUntilString': PropertySchema(
      id: 16,
      name: r'momentUntilString',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 17,
      name: r'name',
      type: IsarType.string,
    ),
    r'paymentsUrl': PropertySchema(
      id: 18,
      name: r'paymentsUrl',
      type: IsarType.string,
    ),
    r'pubkey': PropertySchema(
      id: 19,
      name: r'pubkey',
      type: IsarType.string,
    ),
    r'software': PropertySchema(
      id: 20,
      name: r'software',
      type: IsarType.string,
    ),
    r'supportedNipExtensions': PropertySchema(
      id: 21,
      name: r'supportedNipExtensions',
      type: IsarType.string,
    ),
    r'supportedNips': PropertySchema(
      id: 22,
      name: r'supportedNips',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 23,
      name: r'url',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 24,
      name: r'version',
      type: IsarType.string,
    ),
    r'zapRecordSinceString': PropertySchema(
      id: 25,
      name: r'zapRecordSinceString',
      type: IsarType.string,
    ),
    r'zapRecordUntilString': PropertySchema(
      id: 26,
      name: r'zapRecordUntilString',
      type: IsarType.string,
    )
  },
  estimateSize: _relayDBISAREstimateSize,
  serialize: _relayDBISARSerialize,
  deserialize: _relayDBISARDeserialize,
  deserializeProp: _relayDBISARDeserializeProp,
  idName: r'id',
  indexes: {
    r'url': IndexSchema(
      id: -5756857009679432345,
      name: r'url',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'url',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _relayDBISARGetId,
  getLinks: _relayDBISARGetLinks,
  attach: _relayDBISARAttach,
  version: '3.1.0+1',
);

int _relayDBISAREstimateSize(
  RelayDBISAR object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.channelMessageSinceString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.channelMessageUntilString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contact;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fees;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.friendMessageSinceString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.friendMessageUntilString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.groupMessageSinceString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.groupMessageUntilString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.icon;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.limitation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.momentSinceString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.momentUntilString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.paymentsUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pubkey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.software;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.supportedNipExtensions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.supportedNips;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.url.length * 3;
  {
    final value = object.version;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.zapRecordSinceString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.zapRecordUntilString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _relayDBISARSerialize(
  RelayDBISAR object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.channelMessageSinceString);
  writer.writeString(offsets[1], object.channelMessageUntilString);
  writer.writeLong(offsets[2], object.commonMessagesSince);
  writer.writeLong(offsets[3], object.commonMessagesUntil);
  writer.writeString(offsets[4], object.contact);
  writer.writeString(offsets[5], object.description);
  writer.writeString(offsets[6], object.fees);
  writer.writeString(offsets[7], object.friendMessageSinceString);
  writer.writeString(offsets[8], object.friendMessageUntilString);
  writer.writeLong(offsets[9], object.friendRequestSince);
  writer.writeLong(offsets[10], object.friendRequestUntil);
  writer.writeString(offsets[11], object.groupMessageSinceString);
  writer.writeString(offsets[12], object.groupMessageUntilString);
  writer.writeString(offsets[13], object.icon);
  writer.writeString(offsets[14], object.limitation);
  writer.writeString(offsets[15], object.momentSinceString);
  writer.writeString(offsets[16], object.momentUntilString);
  writer.writeString(offsets[17], object.name);
  writer.writeString(offsets[18], object.paymentsUrl);
  writer.writeString(offsets[19], object.pubkey);
  writer.writeString(offsets[20], object.software);
  writer.writeString(offsets[21], object.supportedNipExtensions);
  writer.writeString(offsets[22], object.supportedNips);
  writer.writeString(offsets[23], object.url);
  writer.writeString(offsets[24], object.version);
  writer.writeString(offsets[25], object.zapRecordSinceString);
  writer.writeString(offsets[26], object.zapRecordUntilString);
}

RelayDBISAR _relayDBISARDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RelayDBISAR(
    channelMessageSinceString: reader.readStringOrNull(offsets[0]),
    channelMessageUntilString: reader.readStringOrNull(offsets[1]),
    commonMessagesSince: reader.readLongOrNull(offsets[2]) ?? 0,
    commonMessagesUntil: reader.readLongOrNull(offsets[3]) ?? 0,
    contact: reader.readStringOrNull(offsets[4]),
    description: reader.readStringOrNull(offsets[5]),
    fees: reader.readStringOrNull(offsets[6]),
    friendMessageSinceString: reader.readStringOrNull(offsets[7]),
    friendMessageUntilString: reader.readStringOrNull(offsets[8]),
    friendRequestSince: reader.readLongOrNull(offsets[9]) ?? 0,
    friendRequestUntil: reader.readLongOrNull(offsets[10]) ?? 0,
    groupMessageSinceString: reader.readStringOrNull(offsets[11]),
    groupMessageUntilString: reader.readStringOrNull(offsets[12]),
    icon: reader.readStringOrNull(offsets[13]),
    limitation: reader.readStringOrNull(offsets[14]),
    momentSinceString: reader.readStringOrNull(offsets[15]),
    momentUntilString: reader.readStringOrNull(offsets[16]),
    paymentsUrl: reader.readStringOrNull(offsets[18]),
    pubkey: reader.readStringOrNull(offsets[19]),
    software: reader.readStringOrNull(offsets[20]),
    supportedNipExtensions: reader.readStringOrNull(offsets[21]),
    supportedNips: reader.readStringOrNull(offsets[22]),
    url: reader.readStringOrNull(offsets[23]) ?? '',
    version: reader.readStringOrNull(offsets[24]),
    zapRecordSinceString: reader.readStringOrNull(offsets[25]),
    zapRecordUntilString: reader.readStringOrNull(offsets[26]),
  );
  object.id = id;
  object.name = reader.readStringOrNull(offsets[17]);
  return object;
}

P _relayDBISARDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _relayDBISARGetId(RelayDBISAR object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _relayDBISARGetLinks(RelayDBISAR object) {
  return [];
}

void _relayDBISARAttach(
    IsarCollection<dynamic> col, Id id, RelayDBISAR object) {
  object.id = id;
}

extension RelayDBISARByIndex on IsarCollection<RelayDBISAR> {
  Future<RelayDBISAR?> getByUrl(String url) {
    return getByIndex(r'url', [url]);
  }

  RelayDBISAR? getByUrlSync(String url) {
    return getByIndexSync(r'url', [url]);
  }

  Future<bool> deleteByUrl(String url) {
    return deleteByIndex(r'url', [url]);
  }

  bool deleteByUrlSync(String url) {
    return deleteByIndexSync(r'url', [url]);
  }

  Future<List<RelayDBISAR?>> getAllByUrl(List<String> urlValues) {
    final values = urlValues.map((e) => [e]).toList();
    return getAllByIndex(r'url', values);
  }

  List<RelayDBISAR?> getAllByUrlSync(List<String> urlValues) {
    final values = urlValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'url', values);
  }

  Future<int> deleteAllByUrl(List<String> urlValues) {
    final values = urlValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'url', values);
  }

  int deleteAllByUrlSync(List<String> urlValues) {
    final values = urlValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'url', values);
  }

  Future<Id> putByUrl(RelayDBISAR object) {
    return putByIndex(r'url', object);
  }

  Id putByUrlSync(RelayDBISAR object, {bool saveLinks = true}) {
    return putByIndexSync(r'url', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUrl(List<RelayDBISAR> objects) {
    return putAllByIndex(r'url', objects);
  }

  List<Id> putAllByUrlSync(List<RelayDBISAR> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'url', objects, saveLinks: saveLinks);
  }
}

extension RelayDBISARQueryWhereSort
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QWhere> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RelayDBISARQueryWhere
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QWhereClause> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterWhereClause> urlEqualTo(
      String url) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'url',
        value: [url],
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterWhereClause> urlNotEqualTo(
      String url) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'url',
              lower: [],
              upper: [url],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'url',
              lower: [url],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'url',
              lower: [url],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'url',
              lower: [],
              upper: [url],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RelayDBISARQueryFilter
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QFilterCondition> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'channelMessageSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'channelMessageSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'channelMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'channelMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'channelMessageSinceString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'channelMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'channelMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelMessageSinceString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelMessageSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageSinceStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelMessageSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'channelMessageUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'channelMessageUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'channelMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'channelMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'channelMessageUntilString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'channelMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'channelMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'channelMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'channelMessageUntilString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'channelMessageUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      channelMessageUntilStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'channelMessageUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonMessagesSince',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commonMessagesSince',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commonMessagesSince',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesSinceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commonMessagesSince',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonMessagesUntil',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commonMessagesUntil',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commonMessagesUntil',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      commonMessagesUntilBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commonMessagesUntil',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contact',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contact',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contact',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contact',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> contactMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contact',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contact',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      contactIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contact',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fees',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      feesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fees',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fees',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fees',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fees',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fees',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fees',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fees',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fees',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fees',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> feesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fees',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      feesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fees',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'friendMessageSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'friendMessageSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendMessageSinceString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'friendMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'friendMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'friendMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'friendMessageSinceString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendMessageSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageSinceStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'friendMessageSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'friendMessageUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'friendMessageUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendMessageUntilString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'friendMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'friendMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'friendMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'friendMessageUntilString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendMessageUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendMessageUntilStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'friendMessageUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendRequestSince',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendRequestSince',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendRequestSince',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestSinceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendRequestSince',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friendRequestUntil',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friendRequestUntil',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friendRequestUntil',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      friendRequestUntilBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friendRequestUntil',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupMessageSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupMessageSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupMessageSinceString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupMessageSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupMessageSinceString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupMessageSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageSinceStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupMessageSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupMessageUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupMessageUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupMessageUntilString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupMessageUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupMessageUntilString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupMessageUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      groupMessageUntilStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupMessageUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'icon',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      iconIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'icon',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'icon',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'icon',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'icon',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> iconIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'icon',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      iconIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'icon',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'limitation',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'limitation',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'limitation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'limitation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'limitation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'limitation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'limitation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'limitation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'limitation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'limitation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'limitation',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      limitationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'limitation',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'momentSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'momentSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'momentSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'momentSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'momentSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'momentSinceString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'momentSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'momentSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'momentSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'momentSinceString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'momentSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentSinceStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'momentSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'momentUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'momentUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'momentUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'momentUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'momentUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'momentUntilString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'momentUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'momentUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'momentUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'momentUntilString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'momentUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      momentUntilStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'momentUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paymentsUrl',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paymentsUrl',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentsUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentsUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentsUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentsUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'paymentsUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'paymentsUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'paymentsUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'paymentsUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentsUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      paymentsUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'paymentsUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pubkey',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pubkey',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pubkey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pubkey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pubkey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pubkey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pubkey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pubkey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pubkey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> pubkeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pubkey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pubkey',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      pubkeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pubkey',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'software',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'software',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> softwareEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'software',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'software',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'software',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> softwareBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'software',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'software',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'software',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'software',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> softwareMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'software',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'software',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      softwareIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'software',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'supportedNipExtensions',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'supportedNipExtensions',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedNipExtensions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supportedNipExtensions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supportedNipExtensions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supportedNipExtensions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supportedNipExtensions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supportedNipExtensions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supportedNipExtensions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supportedNipExtensions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedNipExtensions',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipExtensionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supportedNipExtensions',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'supportedNips',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'supportedNips',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedNips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supportedNips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supportedNips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supportedNips',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supportedNips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supportedNips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supportedNips',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supportedNips',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supportedNips',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      supportedNipsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supportedNips',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'version',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'version',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition> versionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'version',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      versionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'version',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'zapRecordSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'zapRecordSinceString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zapRecordSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'zapRecordSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'zapRecordSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'zapRecordSinceString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'zapRecordSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'zapRecordSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'zapRecordSinceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'zapRecordSinceString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zapRecordSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordSinceStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'zapRecordSinceString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'zapRecordUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'zapRecordUntilString',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zapRecordUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'zapRecordUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'zapRecordUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'zapRecordUntilString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'zapRecordUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'zapRecordUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'zapRecordUntilString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'zapRecordUntilString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zapRecordUntilString',
        value: '',
      ));
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterFilterCondition>
      zapRecordUntilStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'zapRecordUntilString',
        value: '',
      ));
    });
  }
}

extension RelayDBISARQueryObject
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QFilterCondition> {}

extension RelayDBISARQueryLinks
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QFilterCondition> {}

extension RelayDBISARQuerySortBy
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QSortBy> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByChannelMessageSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelMessageSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByChannelMessageSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelMessageSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByChannelMessageUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelMessageUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByChannelMessageUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelMessageUntilString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByCommonMessagesSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonMessagesSince', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByCommonMessagesSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonMessagesSince', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByCommonMessagesUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonMessagesUntil', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByCommonMessagesUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonMessagesUntil', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contact', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByContactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contact', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByFees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fees', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByFeesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fees', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendMessageSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendMessageSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendMessageSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendMessageSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendMessageUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendMessageUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendMessageUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendMessageUntilString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendRequestSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestSince', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendRequestSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestSince', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendRequestUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestUntil', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByFriendRequestUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestUntil', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByGroupMessageSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupMessageSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByGroupMessageSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupMessageSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByGroupMessageUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupMessageUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByGroupMessageUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupMessageUntilString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByLimitation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitation', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByLimitationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitation', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByMomentSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'momentSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByMomentSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'momentSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByMomentUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'momentUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByMomentUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'momentUntilString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByPaymentsUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentsUrl', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByPaymentsUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentsUrl', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByPubkey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pubkey', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByPubkeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pubkey', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortBySoftware() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'software', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortBySoftwareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'software', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortBySupportedNipExtensions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportedNipExtensions', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortBySupportedNipExtensionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportedNipExtensions', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortBySupportedNips() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportedNips', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortBySupportedNipsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportedNips', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByZapRecordSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zapRecordSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByZapRecordSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zapRecordSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByZapRecordUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zapRecordUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      sortByZapRecordUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zapRecordUntilString', Sort.desc);
    });
  }
}

extension RelayDBISARQuerySortThenBy
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QSortThenBy> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByChannelMessageSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelMessageSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByChannelMessageSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelMessageSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByChannelMessageUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelMessageUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByChannelMessageUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'channelMessageUntilString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByCommonMessagesSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonMessagesSince', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByCommonMessagesSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonMessagesSince', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByCommonMessagesUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonMessagesUntil', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByCommonMessagesUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commonMessagesUntil', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByContact() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contact', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByContactDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contact', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByFees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fees', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByFeesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fees', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendMessageSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendMessageSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendMessageSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendMessageSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendMessageUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendMessageUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendMessageUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendMessageUntilString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendRequestSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestSince', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendRequestSinceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestSince', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendRequestUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestUntil', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByFriendRequestUntilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'friendRequestUntil', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByGroupMessageSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupMessageSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByGroupMessageSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupMessageSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByGroupMessageUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupMessageUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByGroupMessageUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupMessageUntilString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByIcon() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByIconDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'icon', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByLimitation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitation', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByLimitationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'limitation', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByMomentSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'momentSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByMomentSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'momentSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByMomentUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'momentUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByMomentUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'momentUntilString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByPaymentsUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentsUrl', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByPaymentsUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentsUrl', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByPubkey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pubkey', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByPubkeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pubkey', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenBySoftware() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'software', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenBySoftwareDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'software', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenBySupportedNipExtensions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportedNipExtensions', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenBySupportedNipExtensionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportedNipExtensions', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenBySupportedNips() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportedNips', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenBySupportedNipsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supportedNips', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByZapRecordSinceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zapRecordSinceString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByZapRecordSinceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zapRecordSinceString', Sort.desc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByZapRecordUntilString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zapRecordUntilString', Sort.asc);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QAfterSortBy>
      thenByZapRecordUntilStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zapRecordUntilString', Sort.desc);
    });
  }
}

extension RelayDBISARQueryWhereDistinct
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> {
  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByChannelMessageSinceString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelMessageSinceString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByChannelMessageUntilString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'channelMessageUntilString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByCommonMessagesSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commonMessagesSince');
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByCommonMessagesUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commonMessagesUntil');
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByContact(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contact', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByFees(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fees', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByFriendMessageSinceString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendMessageSinceString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByFriendMessageUntilString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendMessageUntilString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByFriendRequestSince() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendRequestSince');
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByFriendRequestUntil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friendRequestUntil');
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByGroupMessageSinceString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupMessageSinceString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByGroupMessageUntilString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupMessageUntilString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByIcon(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'icon', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByLimitation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'limitation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByMomentSinceString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'momentSinceString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByMomentUntilString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'momentUntilString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByPaymentsUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentsUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByPubkey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pubkey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctBySoftware(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'software', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctBySupportedNipExtensions({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportedNipExtensions',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctBySupportedNips(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supportedNips',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct> distinctByVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByZapRecordSinceString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zapRecordSinceString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RelayDBISAR, RelayDBISAR, QDistinct>
      distinctByZapRecordUntilString({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zapRecordUntilString',
          caseSensitive: caseSensitive);
    });
  }
}

extension RelayDBISARQueryProperty
    on QueryBuilder<RelayDBISAR, RelayDBISAR, QQueryProperty> {
  QueryBuilder<RelayDBISAR, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      channelMessageSinceStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelMessageSinceString');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      channelMessageUntilStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'channelMessageUntilString');
    });
  }

  QueryBuilder<RelayDBISAR, int, QQueryOperations>
      commonMessagesSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commonMessagesSince');
    });
  }

  QueryBuilder<RelayDBISAR, int, QQueryOperations>
      commonMessagesUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commonMessagesUntil');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> contactProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contact');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> feesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fees');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      friendMessageSinceStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendMessageSinceString');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      friendMessageUntilStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendMessageUntilString');
    });
  }

  QueryBuilder<RelayDBISAR, int, QQueryOperations>
      friendRequestSinceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendRequestSince');
    });
  }

  QueryBuilder<RelayDBISAR, int, QQueryOperations>
      friendRequestUntilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friendRequestUntil');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      groupMessageSinceStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupMessageSinceString');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      groupMessageUntilStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupMessageUntilString');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> iconProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'icon');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> limitationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'limitation');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      momentSinceStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'momentSinceString');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      momentUntilStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'momentUntilString');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> paymentsUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentsUrl');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> pubkeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pubkey');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> softwareProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'software');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      supportedNipExtensionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportedNipExtensions');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> supportedNipsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supportedNips');
    });
  }

  QueryBuilder<RelayDBISAR, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      zapRecordSinceStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zapRecordSinceString');
    });
  }

  QueryBuilder<RelayDBISAR, String?, QQueryOperations>
      zapRecordUntilStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zapRecordUntilString');
    });
  }
}
