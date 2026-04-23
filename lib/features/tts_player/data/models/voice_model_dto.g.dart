// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_model_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVoiceModelDtoCollection on Isar {
  IsarCollection<VoiceModelDto> get voiceModelDtos => this.collection();
}

const VoiceModelDtoSchema = CollectionSchema(
  name: r'VoiceModelDto',
  id: -2460044796104426415,
  properties: {
    r'architectureName': PropertySchema(
      id: 0,
      name: r'architectureName',
      type: IsarType.string,
    ),
    r'configJsonPath': PropertySchema(
      id: 1,
      name: r'configJsonPath',
      type: IsarType.string,
    ),
    r'displayName': PropertySchema(
      id: 2,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'flagEmoji': PropertySchema(
      id: 3,
      name: r'flagEmoji',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 4,
      name: r'id',
      type: IsarType.string,
    ),
    r'isCustomImport': PropertySchema(
      id: 5,
      name: r'isCustomImport',
      type: IsarType.bool,
    ),
    r'isSelected': PropertySchema(
      id: 6,
      name: r'isSelected',
      type: IsarType.bool,
    ),
    r'language': PropertySchema(
      id: 7,
      name: r'language',
      type: IsarType.string,
    ),
    r'onnxModelPath': PropertySchema(
      id: 8,
      name: r'onnxModelPath',
      type: IsarType.string,
    ),
    r'qualityRating': PropertySchema(
      id: 9,
      name: r'qualityRating',
      type: IsarType.long,
    ),
    r'remoteZipUrl': PropertySchema(
      id: 10,
      name: r'remoteZipUrl',
      type: IsarType.string,
    ),
    r'sizeBytes': PropertySchema(
      id: 11,
      name: r'sizeBytes',
      type: IsarType.long,
    ),
    r'speakerId': PropertySchema(
      id: 12,
      name: r'speakerId',
      type: IsarType.long,
    ),
    r'statusName': PropertySchema(
      id: 13,
      name: r'statusName',
      type: IsarType.string,
    )
  },
  estimateSize: _voiceModelDtoEstimateSize,
  serialize: _voiceModelDtoSerialize,
  deserialize: _voiceModelDtoDeserialize,
  deserializeProp: _voiceModelDtoDeserializeProp,
  idName: r'isarId',
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
  getId: _voiceModelDtoGetId,
  getLinks: _voiceModelDtoGetLinks,
  attach: _voiceModelDtoAttach,
  version: '3.1.0+1',
);

int _voiceModelDtoEstimateSize(
  VoiceModelDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.architectureName.length * 3;
  {
    final value = object.configJsonPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.displayName.length * 3;
  bytesCount += 3 + object.flagEmoji.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.language.length * 3;
  {
    final value = object.onnxModelPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.remoteZipUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.statusName.length * 3;
  return bytesCount;
}

void _voiceModelDtoSerialize(
  VoiceModelDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.architectureName);
  writer.writeString(offsets[1], object.configJsonPath);
  writer.writeString(offsets[2], object.displayName);
  writer.writeString(offsets[3], object.flagEmoji);
  writer.writeString(offsets[4], object.id);
  writer.writeBool(offsets[5], object.isCustomImport);
  writer.writeBool(offsets[6], object.isSelected);
  writer.writeString(offsets[7], object.language);
  writer.writeString(offsets[8], object.onnxModelPath);
  writer.writeLong(offsets[9], object.qualityRating);
  writer.writeString(offsets[10], object.remoteZipUrl);
  writer.writeLong(offsets[11], object.sizeBytes);
  writer.writeLong(offsets[12], object.speakerId);
  writer.writeString(offsets[13], object.statusName);
}

VoiceModelDto _voiceModelDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VoiceModelDto();
  object.architectureName = reader.readString(offsets[0]);
  object.configJsonPath = reader.readStringOrNull(offsets[1]);
  object.displayName = reader.readString(offsets[2]);
  object.flagEmoji = reader.readString(offsets[3]);
  object.id = reader.readString(offsets[4]);
  object.isCustomImport = reader.readBool(offsets[5]);
  object.isSelected = reader.readBool(offsets[6]);
  object.isarId = id;
  object.language = reader.readString(offsets[7]);
  object.onnxModelPath = reader.readStringOrNull(offsets[8]);
  object.qualityRating = reader.readLong(offsets[9]);
  object.remoteZipUrl = reader.readStringOrNull(offsets[10]);
  object.sizeBytes = reader.readLong(offsets[11]);
  object.speakerId = reader.readLong(offsets[12]);
  object.statusName = reader.readString(offsets[13]);
  return object;
}

P _voiceModelDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _voiceModelDtoGetId(VoiceModelDto object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _voiceModelDtoGetLinks(VoiceModelDto object) {
  return [];
}

void _voiceModelDtoAttach(
    IsarCollection<dynamic> col, Id id, VoiceModelDto object) {
  object.isarId = id;
}

extension VoiceModelDtoByIndex on IsarCollection<VoiceModelDto> {
  Future<VoiceModelDto?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  VoiceModelDto? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<VoiceModelDto?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<VoiceModelDto?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(VoiceModelDto object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(VoiceModelDto object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<VoiceModelDto> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<VoiceModelDto> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension VoiceModelDtoQueryWhereSort
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QWhere> {
  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VoiceModelDtoQueryWhere
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QWhereClause> {
  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterWhereClause> idEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterWhereClause> idNotEqualTo(
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

extension VoiceModelDtoQueryFilter
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QFilterCondition> {
  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'architectureName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'architectureName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'architectureName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'architectureName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'architectureName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'architectureName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'architectureName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'architectureName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'architectureName',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      architectureNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'architectureName',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'configJsonPath',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'configJsonPath',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'configJsonPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'configJsonPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'configJsonPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'configJsonPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'configJsonPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'configJsonPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'configJsonPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'configJsonPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'configJsonPath',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      configJsonPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'configJsonPath',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flagEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'flagEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'flagEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'flagEmoji',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'flagEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'flagEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'flagEmoji',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'flagEmoji',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'flagEmoji',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      flagEmojiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'flagEmoji',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition> idBetween(
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

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      idStartsWith(
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

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition> idContains(
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

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition> idMatches(
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

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      isCustomImportEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCustomImport',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      isSelectedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSelected',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'language',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'language',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'onnxModelPath',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'onnxModelPath',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onnxModelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'onnxModelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'onnxModelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'onnxModelPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'onnxModelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'onnxModelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'onnxModelPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'onnxModelPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onnxModelPath',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      onnxModelPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'onnxModelPath',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      qualityRatingEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualityRating',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      qualityRatingGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qualityRating',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      qualityRatingLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qualityRating',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      qualityRatingBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qualityRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteZipUrl',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteZipUrl',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteZipUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteZipUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteZipUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteZipUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteZipUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteZipUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteZipUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteZipUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteZipUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      remoteZipUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteZipUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      sizeBytesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sizeBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      sizeBytesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sizeBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      sizeBytesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sizeBytes',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      sizeBytesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sizeBytes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      speakerIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speakerId',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      speakerIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speakerId',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      speakerIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speakerId',
        value: value,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      speakerIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speakerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statusName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statusName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statusName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusName',
        value: '',
      ));
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterFilterCondition>
      statusNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statusName',
        value: '',
      ));
    });
  }
}

extension VoiceModelDtoQueryObject
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QFilterCondition> {}

extension VoiceModelDtoQueryLinks
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QFilterCondition> {}

extension VoiceModelDtoQuerySortBy
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QSortBy> {
  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByArchitectureName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'architectureName', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByArchitectureNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'architectureName', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByConfigJsonPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configJsonPath', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByConfigJsonPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configJsonPath', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortByFlagEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flagEmoji', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByFlagEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flagEmoji', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByIsCustomImport() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustomImport', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByIsCustomImportDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustomImport', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByIsSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByOnnxModelPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onnxModelPath', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByOnnxModelPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onnxModelPath', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByQualityRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityRating', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByQualityRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityRating', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByRemoteZipUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteZipUrl', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByRemoteZipUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteZipUrl', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortBySizeBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeBytes', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortBySizeBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeBytes', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortBySpeakerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speakerId', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortBySpeakerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speakerId', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> sortByStatusName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusName', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      sortByStatusNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusName', Sort.desc);
    });
  }
}

extension VoiceModelDtoQuerySortThenBy
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QSortThenBy> {
  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByArchitectureName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'architectureName', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByArchitectureNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'architectureName', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByConfigJsonPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configJsonPath', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByConfigJsonPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'configJsonPath', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenByFlagEmoji() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flagEmoji', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByFlagEmojiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'flagEmoji', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByIsCustomImport() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustomImport', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByIsCustomImportDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCustomImport', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByIsSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByOnnxModelPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onnxModelPath', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByOnnxModelPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onnxModelPath', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByQualityRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityRating', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByQualityRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityRating', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByRemoteZipUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteZipUrl', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByRemoteZipUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteZipUrl', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenBySizeBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeBytes', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenBySizeBytesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sizeBytes', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenBySpeakerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speakerId', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenBySpeakerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speakerId', Sort.desc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy> thenByStatusName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusName', Sort.asc);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QAfterSortBy>
      thenByStatusNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusName', Sort.desc);
    });
  }
}

extension VoiceModelDtoQueryWhereDistinct
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> {
  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct>
      distinctByArchitectureName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'architectureName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct>
      distinctByConfigJsonPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'configJsonPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctByFlagEmoji(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'flagEmoji', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct>
      distinctByIsCustomImport() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCustomImport');
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSelected');
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctByLanguage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'language', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctByOnnxModelPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onnxModelPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct>
      distinctByQualityRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qualityRating');
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctByRemoteZipUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteZipUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctBySizeBytes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sizeBytes');
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctBySpeakerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speakerId');
    });
  }

  QueryBuilder<VoiceModelDto, VoiceModelDto, QDistinct> distinctByStatusName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusName', caseSensitive: caseSensitive);
    });
  }
}

extension VoiceModelDtoQueryProperty
    on QueryBuilder<VoiceModelDto, VoiceModelDto, QQueryProperty> {
  QueryBuilder<VoiceModelDto, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<VoiceModelDto, String, QQueryOperations>
      architectureNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'architectureName');
    });
  }

  QueryBuilder<VoiceModelDto, String?, QQueryOperations>
      configJsonPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'configJsonPath');
    });
  }

  QueryBuilder<VoiceModelDto, String, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<VoiceModelDto, String, QQueryOperations> flagEmojiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'flagEmoji');
    });
  }

  QueryBuilder<VoiceModelDto, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VoiceModelDto, bool, QQueryOperations> isCustomImportProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCustomImport');
    });
  }

  QueryBuilder<VoiceModelDto, bool, QQueryOperations> isSelectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSelected');
    });
  }

  QueryBuilder<VoiceModelDto, String, QQueryOperations> languageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'language');
    });
  }

  QueryBuilder<VoiceModelDto, String?, QQueryOperations>
      onnxModelPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onnxModelPath');
    });
  }

  QueryBuilder<VoiceModelDto, int, QQueryOperations> qualityRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualityRating');
    });
  }

  QueryBuilder<VoiceModelDto, String?, QQueryOperations>
      remoteZipUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteZipUrl');
    });
  }

  QueryBuilder<VoiceModelDto, int, QQueryOperations> sizeBytesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sizeBytes');
    });
  }

  QueryBuilder<VoiceModelDto, int, QQueryOperations> speakerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speakerId');
    });
  }

  QueryBuilder<VoiceModelDto, String, QQueryOperations> statusNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusName');
    });
  }
}
