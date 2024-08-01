// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badgeDB_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBadgeDBISARCollection on Isar {
  IsarCollection<BadgeDBISAR> get badgeDBISARs => this.collection();
}

const BadgeDBISARSchema = CollectionSchema(
  name: r'BadgeDBISAR',
  id: -7171445093192353757,
  properties: {
    r'createTime': PropertySchema(
      id: 0,
      name: r'createTime',
      type: IsarType.long,
    ),
    r'creator': PropertySchema(
      id: 1,
      name: r'creator',
      type: IsarType.string,
    ),
    r'd': PropertySchema(
      id: 2,
      name: r'd',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'image': PropertySchema(
      id: 5,
      name: r'image',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'thumb': PropertySchema(
      id: 7,
      name: r'thumb',
      type: IsarType.string,
    )
  },
  estimateSize: _badgeDBISAREstimateSize,
  serialize: _badgeDBISARSerialize,
  deserialize: _badgeDBISARDeserialize,
  deserializeProp: _badgeDBISARDeserializeProp,
  idName: r'idISAR',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _badgeDBISARGetId,
  getLinks: _badgeDBISARGetLinks,
  attach: _badgeDBISARAttach,
  version: '3.1.0+1',
);

int _badgeDBISAREstimateSize(
  BadgeDBISAR object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.creator.length * 3;
  bytesCount += 3 + object.d.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.image.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.thumb.length * 3;
  return bytesCount;
}

void _badgeDBISARSerialize(
  BadgeDBISAR object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.createTime);
  writer.writeString(offsets[1], object.creator);
  writer.writeString(offsets[2], object.d);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.id);
  writer.writeString(offsets[5], object.image);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.thumb);
}

BadgeDBISAR _badgeDBISARDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BadgeDBISAR(
    createTime: reader.readLongOrNull(offsets[0]) ?? 0,
    creator: reader.readStringOrNull(offsets[1]) ?? '',
    d: reader.readStringOrNull(offsets[2]) ?? '',
    description: reader.readStringOrNull(offsets[3]) ?? '',
    id: reader.readStringOrNull(offsets[4]) ?? '',
    image: reader.readStringOrNull(offsets[5]) ?? '',
    name: reader.readStringOrNull(offsets[6]) ?? '',
    thumb: reader.readStringOrNull(offsets[7]) ?? '',
  );
  object.idISAR = id;
  return object;
}

P _badgeDBISARDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _badgeDBISARGetId(BadgeDBISAR object) {
  return object.idISAR;
}

List<IsarLinkBase<dynamic>> _badgeDBISARGetLinks(BadgeDBISAR object) {
  return [];
}

void _badgeDBISARAttach(
    IsarCollection<dynamic> col, Id id, BadgeDBISAR object) {
  object.idISAR = id;
}

extension BadgeDBISARByIndex on IsarCollection<BadgeDBISAR> {
  Future<BadgeDBISAR?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  BadgeDBISAR? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<BadgeDBISAR?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<BadgeDBISAR?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(BadgeDBISAR object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(BadgeDBISAR object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<BadgeDBISAR> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<BadgeDBISAR> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension BadgeDBISARQueryWhereSort
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QWhere> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterWhere> anyIdISAR() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BadgeDBISARQueryWhere
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QWhereClause> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterWhereClause> idISAREqualTo(
      Id idISAR) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: idISAR,
        upper: idISAR,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterWhereClause> idISARNotEqualTo(
      Id idISAR) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: idISAR, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idISAR, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: idISAR, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: idISAR, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterWhereClause> idISARGreaterThan(
      Id idISAR,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: idISAR, includeLower: include),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterWhereClause> idISARLessThan(
      Id idISAR,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: idISAR, includeUpper: include),
      );
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterWhereClause> idISARBetween(
    Id lowerIdISAR,
    Id upperIdISAR, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIdISAR,
        includeLower: includeLower,
        upper: upperIdISAR,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterWhereClause> idEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterWhereClause> idNotEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }
}

extension BadgeDBISARQueryFilter
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QFilterCondition> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createTime',
        value: value,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createTime',
        value: value,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createTime',
        value: value,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      createTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'creator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'creator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> creatorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'creator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'creator',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      creatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'creator',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'd',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'd',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> dIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'd',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idISAREqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idISAR',
        value: value,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      idISARGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idISAR',
        value: value,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idISARLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idISAR',
        value: value,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> idISARBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idISAR',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      imageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameEqualTo(
    String value, {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameGreaterThan(
    String value, {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameLessThan(
    String value, {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameContains(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      thumbGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumb',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition> thumbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumb',
        value: '',
      ));
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterFilterCondition>
      thumbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumb',
        value: '',
      ));
    });
  }
}

extension BadgeDBISARQueryObject
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QFilterCondition> {}

extension BadgeDBISARQueryLinks
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QFilterCondition> {}

extension BadgeDBISARQuerySortBy
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QSortBy> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createTime', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createTime', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByD() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'd', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'd', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByThumb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumb', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> sortByThumbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumb', Sort.desc);
    });
  }
}

extension BadgeDBISARQuerySortThenBy
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QSortThenBy> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createTime', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByCreateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createTime', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByCreator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByCreatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'creator', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByD() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'd', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'd', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByIdISAR() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idISAR', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByIdISARDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'idISAR', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByThumb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumb', Sort.asc);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QAfterSortBy> thenByThumbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumb', Sort.desc);
    });
  }
}

extension BadgeDBISARQueryWhereDistinct
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> {
  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> distinctByCreateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createTime');
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> distinctByCreator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'creator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> distinctByD(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'd', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> distinctByImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BadgeDBISAR, BadgeDBISAR, QDistinct> distinctByThumb(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumb', caseSensitive: caseSensitive);
    });
  }
}

extension BadgeDBISARQueryProperty
    on QueryBuilder<BadgeDBISAR, BadgeDBISAR, QQueryProperty> {
  QueryBuilder<BadgeDBISAR, int, QQueryOperations> idISARProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'idISAR');
    });
  }

  QueryBuilder<BadgeDBISAR, int, QQueryOperations> createTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createTime');
    });
  }

  QueryBuilder<BadgeDBISAR, String, QQueryOperations> creatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'creator');
    });
  }

  QueryBuilder<BadgeDBISAR, String, QQueryOperations> dProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'd');
    });
  }

  QueryBuilder<BadgeDBISAR, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<BadgeDBISAR, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BadgeDBISAR, String, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<BadgeDBISAR, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<BadgeDBISAR, String, QQueryOperations> thumbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumb');
    });
  }
}
