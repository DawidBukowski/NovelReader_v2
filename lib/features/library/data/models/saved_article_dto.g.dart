// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_article_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavedArticleDtoCollection on Isar {
  IsarCollection<SavedArticleDto> get savedArticleDtos => this.collection();
}

const SavedArticleDtoSchema = CollectionSchema(
  name: r'SavedArticleDto',
  id: -3949242122056387623,
  properties: {
    r'estimatedReadMinutes': PropertySchema(
      id: 0,
      name: r'estimatedReadMinutes',
      type: IsarType.long,
    ),
    r'lastSegmentIndex': PropertySchema(
      id: 1,
      name: r'lastSegmentIndex',
      type: IsarType.long,
    ),
    r'plainText': PropertySchema(
      id: 2,
      name: r'plainText',
      type: IsarType.string,
    ),
    r'readProgress': PropertySchema(
      id: 3,
      name: r'readProgress',
      type: IsarType.double,
    ),
    r'savedAt': PropertySchema(
      id: 4,
      name: r'savedAt',
      type: IsarType.dateTime,
    ),
    r'sourceUrl': PropertySchema(
      id: 5,
      name: r'sourceUrl',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 6,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _savedArticleDtoEstimateSize,
  serialize: _savedArticleDtoSerialize,
  deserialize: _savedArticleDtoDeserialize,
  deserializeProp: _savedArticleDtoDeserializeProp,
  idName: r'id',
  indexes: {
    r'savedAt': IndexSchema(
      id: -5998206549842823851,
      name: r'savedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'savedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _savedArticleDtoGetId,
  getLinks: _savedArticleDtoGetLinks,
  attach: _savedArticleDtoAttach,
  version: '3.1.0+1',
);

int _savedArticleDtoEstimateSize(
  SavedArticleDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.plainText.length * 3;
  bytesCount += 3 + object.sourceUrl.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _savedArticleDtoSerialize(
  SavedArticleDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.estimatedReadMinutes);
  writer.writeLong(offsets[1], object.lastSegmentIndex);
  writer.writeString(offsets[2], object.plainText);
  writer.writeDouble(offsets[3], object.readProgress);
  writer.writeDateTime(offsets[4], object.savedAt);
  writer.writeString(offsets[5], object.sourceUrl);
  writer.writeString(offsets[6], object.title);
}

SavedArticleDto _savedArticleDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavedArticleDto();
  object.estimatedReadMinutes = reader.readLong(offsets[0]);
  object.id = id;
  object.lastSegmentIndex = reader.readLong(offsets[1]);
  object.plainText = reader.readString(offsets[2]);
  object.readProgress = reader.readDouble(offsets[3]);
  object.savedAt = reader.readDateTime(offsets[4]);
  object.sourceUrl = reader.readString(offsets[5]);
  object.title = reader.readString(offsets[6]);
  return object;
}

P _savedArticleDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _savedArticleDtoGetId(SavedArticleDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _savedArticleDtoGetLinks(SavedArticleDto object) {
  return [];
}

void _savedArticleDtoAttach(
    IsarCollection<dynamic> col, Id id, SavedArticleDto object) {
  object.id = id;
}

extension SavedArticleDtoQueryWhereSort
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QWhere> {
  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhere> anySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'savedAt'),
      );
    });
  }
}

extension SavedArticleDtoQueryWhere
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QWhereClause> {
  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause> idBetween(
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

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause>
      savedAtEqualTo(DateTime savedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'savedAt',
        value: [savedAt],
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause>
      savedAtNotEqualTo(DateTime savedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'savedAt',
              lower: [],
              upper: [savedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'savedAt',
              lower: [savedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'savedAt',
              lower: [savedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'savedAt',
              lower: [],
              upper: [savedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause>
      savedAtGreaterThan(
    DateTime savedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'savedAt',
        lower: [savedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause>
      savedAtLessThan(
    DateTime savedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'savedAt',
        lower: [],
        upper: [savedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterWhereClause>
      savedAtBetween(
    DateTime lowerSavedAt,
    DateTime upperSavedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'savedAt',
        lower: [lowerSavedAt],
        includeLower: includeLower,
        upper: [upperSavedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SavedArticleDtoQueryFilter
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QFilterCondition> {
  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      estimatedReadMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estimatedReadMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      estimatedReadMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estimatedReadMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      estimatedReadMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estimatedReadMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      estimatedReadMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estimatedReadMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      lastSegmentIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSegmentIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      lastSegmentIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSegmentIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      lastSegmentIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSegmentIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      lastSegmentIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSegmentIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plainText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plainText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plainText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plainText',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      plainTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plainText',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      readProgressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'readProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      readProgressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'readProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      readProgressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'readProgress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      readProgressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'readProgress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      savedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'savedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      savedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'savedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      savedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'savedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      savedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'savedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      sourceUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension SavedArticleDtoQueryObject
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QFilterCondition> {}

extension SavedArticleDtoQueryLinks
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QFilterCondition> {}

extension SavedArticleDtoQuerySortBy
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QSortBy> {
  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByEstimatedReadMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedReadMinutes', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByEstimatedReadMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedReadMinutes', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByLastSegmentIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSegmentIndex', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByLastSegmentIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSegmentIndex', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByPlainText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plainText', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByPlainTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plainText', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByReadProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readProgress', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByReadProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readProgress', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy> sortBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortBySavedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortBySourceUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceUrl', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortBySourceUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceUrl', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension SavedArticleDtoQuerySortThenBy
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QSortThenBy> {
  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByEstimatedReadMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedReadMinutes', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByEstimatedReadMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estimatedReadMinutes', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByLastSegmentIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSegmentIndex', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByLastSegmentIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSegmentIndex', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByPlainText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plainText', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByPlainTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plainText', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByReadProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readProgress', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByReadProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readProgress', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy> thenBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenBySavedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedAt', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenBySourceUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceUrl', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenBySourceUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceUrl', Sort.desc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension SavedArticleDtoQueryWhereDistinct
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QDistinct> {
  QueryBuilder<SavedArticleDto, SavedArticleDto, QDistinct>
      distinctByEstimatedReadMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estimatedReadMinutes');
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QDistinct>
      distinctByLastSegmentIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSegmentIndex');
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QDistinct> distinctByPlainText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plainText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QDistinct>
      distinctByReadProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readProgress');
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QDistinct>
      distinctBySavedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'savedAt');
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QDistinct> distinctBySourceUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedArticleDto, SavedArticleDto, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension SavedArticleDtoQueryProperty
    on QueryBuilder<SavedArticleDto, SavedArticleDto, QQueryProperty> {
  QueryBuilder<SavedArticleDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SavedArticleDto, int, QQueryOperations>
      estimatedReadMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estimatedReadMinutes');
    });
  }

  QueryBuilder<SavedArticleDto, int, QQueryOperations>
      lastSegmentIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSegmentIndex');
    });
  }

  QueryBuilder<SavedArticleDto, String, QQueryOperations> plainTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plainText');
    });
  }

  QueryBuilder<SavedArticleDto, double, QQueryOperations>
      readProgressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readProgress');
    });
  }

  QueryBuilder<SavedArticleDto, DateTime, QQueryOperations> savedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'savedAt');
    });
  }

  QueryBuilder<SavedArticleDto, String, QQueryOperations> sourceUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceUrl');
    });
  }

  QueryBuilder<SavedArticleDto, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
