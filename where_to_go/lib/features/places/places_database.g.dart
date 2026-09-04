// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_database.dart';

// ignore_for_file: type=lint
class $PlacesTableTable extends PlacesTable
    with TableInfo<$PlacesTableTable, PlacesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _homeImagePathMeta = const VerificationMeta(
    'homeImagePath',
  );
  @override
  late final GeneratedColumn<String> homeImagePath = GeneratedColumn<String>(
    'home_image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageImagePathMeta = const VerificationMeta(
    'pageImagePath',
  );
  @override
  late final GeneratedColumn<String> pageImagePath = GeneratedColumn<String>(
    'page_image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pageTitleMeta = const VerificationMeta(
    'pageTitle',
  );
  @override
  late final GeneratedColumn<String> pageTitle = GeneratedColumn<String>(
    'page_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<Feature>, String> features =
      GeneratedColumn<String>(
        'features',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<Feature>>($PlacesTableTable.$converterfeatures);
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    homeImagePath,
    pageImagePath,
    pageTitle,
    description,
    features,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlacesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('home_image_path')) {
      context.handle(
        _homeImagePathMeta,
        homeImagePath.isAcceptableOrUnknown(
          data['home_image_path']!,
          _homeImagePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeImagePathMeta);
    }
    if (data.containsKey('page_image_path')) {
      context.handle(
        _pageImagePathMeta,
        pageImagePath.isAcceptableOrUnknown(
          data['page_image_path']!,
          _pageImagePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pageImagePathMeta);
    }
    if (data.containsKey('page_title')) {
      context.handle(
        _pageTitleMeta,
        pageTitle.isAcceptableOrUnknown(data['page_title']!, _pageTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_pageTitleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlacesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlacesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      homeImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_image_path'],
      )!,
      pageImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}page_image_path'],
      )!,
      pageTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}page_title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      features: $PlacesTableTable.$converterfeatures.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}features'],
        )!,
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
    );
  }

  @override
  $PlacesTableTable createAlias(String alias) {
    return $PlacesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Feature>, String> $converterfeatures =
      const FeaturesConverter();
}

class PlacesTableData extends DataClass implements Insertable<PlacesTableData> {
  final String id;
  final String title;
  final String homeImagePath;
  final String pageImagePath;
  final String pageTitle;
  final String description;
  final List<Feature> features;
  final bool isFavorite;
  const PlacesTableData({
    required this.id,
    required this.title,
    required this.homeImagePath,
    required this.pageImagePath,
    required this.pageTitle,
    required this.description,
    required this.features,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['home_image_path'] = Variable<String>(homeImagePath);
    map['page_image_path'] = Variable<String>(pageImagePath);
    map['page_title'] = Variable<String>(pageTitle);
    map['description'] = Variable<String>(description);
    {
      map['features'] = Variable<String>(
        $PlacesTableTable.$converterfeatures.toSql(features),
      );
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  PlacesTableCompanion toCompanion(bool nullToAbsent) {
    return PlacesTableCompanion(
      id: Value(id),
      title: Value(title),
      homeImagePath: Value(homeImagePath),
      pageImagePath: Value(pageImagePath),
      pageTitle: Value(pageTitle),
      description: Value(description),
      features: Value(features),
      isFavorite: Value(isFavorite),
    );
  }

  factory PlacesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlacesTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      homeImagePath: serializer.fromJson<String>(json['homeImagePath']),
      pageImagePath: serializer.fromJson<String>(json['pageImagePath']),
      pageTitle: serializer.fromJson<String>(json['pageTitle']),
      description: serializer.fromJson<String>(json['description']),
      features: serializer.fromJson<List<Feature>>(json['features']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'homeImagePath': serializer.toJson<String>(homeImagePath),
      'pageImagePath': serializer.toJson<String>(pageImagePath),
      'pageTitle': serializer.toJson<String>(pageTitle),
      'description': serializer.toJson<String>(description),
      'features': serializer.toJson<List<Feature>>(features),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  PlacesTableData copyWith({
    String? id,
    String? title,
    String? homeImagePath,
    String? pageImagePath,
    String? pageTitle,
    String? description,
    List<Feature>? features,
    bool? isFavorite,
  }) => PlacesTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    homeImagePath: homeImagePath ?? this.homeImagePath,
    pageImagePath: pageImagePath ?? this.pageImagePath,
    pageTitle: pageTitle ?? this.pageTitle,
    description: description ?? this.description,
    features: features ?? this.features,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  PlacesTableData copyWithCompanion(PlacesTableCompanion data) {
    return PlacesTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      homeImagePath: data.homeImagePath.present
          ? data.homeImagePath.value
          : this.homeImagePath,
      pageImagePath: data.pageImagePath.present
          ? data.pageImagePath.value
          : this.pageImagePath,
      pageTitle: data.pageTitle.present ? data.pageTitle.value : this.pageTitle,
      description: data.description.present
          ? data.description.value
          : this.description,
      features: data.features.present ? data.features.value : this.features,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlacesTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('homeImagePath: $homeImagePath, ')
          ..write('pageImagePath: $pageImagePath, ')
          ..write('pageTitle: $pageTitle, ')
          ..write('description: $description, ')
          ..write('features: $features, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    homeImagePath,
    pageImagePath,
    pageTitle,
    description,
    features,
    isFavorite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlacesTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.homeImagePath == this.homeImagePath &&
          other.pageImagePath == this.pageImagePath &&
          other.pageTitle == this.pageTitle &&
          other.description == this.description &&
          other.features == this.features &&
          other.isFavorite == this.isFavorite);
}

class PlacesTableCompanion extends UpdateCompanion<PlacesTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> homeImagePath;
  final Value<String> pageImagePath;
  final Value<String> pageTitle;
  final Value<String> description;
  final Value<List<Feature>> features;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const PlacesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.homeImagePath = const Value.absent(),
    this.pageImagePath = const Value.absent(),
    this.pageTitle = const Value.absent(),
    this.description = const Value.absent(),
    this.features = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlacesTableCompanion.insert({
    required String id,
    required String title,
    required String homeImagePath,
    required String pageImagePath,
    required String pageTitle,
    required String description,
    required List<Feature> features,
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       homeImagePath = Value(homeImagePath),
       pageImagePath = Value(pageImagePath),
       pageTitle = Value(pageTitle),
       description = Value(description),
       features = Value(features);
  static Insertable<PlacesTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? homeImagePath,
    Expression<String>? pageImagePath,
    Expression<String>? pageTitle,
    Expression<String>? description,
    Expression<String>? features,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (homeImagePath != null) 'home_image_path': homeImagePath,
      if (pageImagePath != null) 'page_image_path': pageImagePath,
      if (pageTitle != null) 'page_title': pageTitle,
      if (description != null) 'description': description,
      if (features != null) 'features': features,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlacesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? homeImagePath,
    Value<String>? pageImagePath,
    Value<String>? pageTitle,
    Value<String>? description,
    Value<List<Feature>>? features,
    Value<bool>? isFavorite,
    Value<int>? rowid,
  }) {
    return PlacesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      homeImagePath: homeImagePath ?? this.homeImagePath,
      pageImagePath: pageImagePath ?? this.pageImagePath,
      pageTitle: pageTitle ?? this.pageTitle,
      description: description ?? this.description,
      features: features ?? this.features,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (homeImagePath.present) {
      map['home_image_path'] = Variable<String>(homeImagePath.value);
    }
    if (pageImagePath.present) {
      map['page_image_path'] = Variable<String>(pageImagePath.value);
    }
    if (pageTitle.present) {
      map['page_title'] = Variable<String>(pageTitle.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (features.present) {
      map['features'] = Variable<String>(
        $PlacesTableTable.$converterfeatures.toSql(features.value),
      );
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('homeImagePath: $homeImagePath, ')
          ..write('pageImagePath: $pageImagePath, ')
          ..write('pageTitle: $pageTitle, ')
          ..write('description: $description, ')
          ..write('features: $features, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlacesTableTable placesTable = $PlacesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [placesTable];
}

typedef $$PlacesTableTableCreateCompanionBuilder =
    PlacesTableCompanion Function({
      required String id,
      required String title,
      required String homeImagePath,
      required String pageImagePath,
      required String pageTitle,
      required String description,
      required List<Feature> features,
      Value<bool> isFavorite,
      Value<int> rowid,
    });
typedef $$PlacesTableTableUpdateCompanionBuilder =
    PlacesTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> homeImagePath,
      Value<String> pageImagePath,
      Value<String> pageTitle,
      Value<String> description,
      Value<List<Feature>> features,
      Value<bool> isFavorite,
      Value<int> rowid,
    });

class $$PlacesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeImagePath => $composableBuilder(
    column: $table.homeImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pageImagePath => $composableBuilder(
    column: $table.pageImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pageTitle => $composableBuilder(
    column: $table.pageTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<Feature>, List<Feature>, String>
  get features => $composableBuilder(
    column: $table.features,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlacesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeImagePath => $composableBuilder(
    column: $table.homeImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pageImagePath => $composableBuilder(
    column: $table.pageImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pageTitle => $composableBuilder(
    column: $table.pageTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get features => $composableBuilder(
    column: $table.features,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlacesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get homeImagePath => $composableBuilder(
    column: $table.homeImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pageImagePath => $composableBuilder(
    column: $table.pageImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pageTitle =>
      $composableBuilder(column: $table.pageTitle, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<Feature>, String> get features =>
      $composableBuilder(column: $table.features, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );
}

class $$PlacesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlacesTableTable,
          PlacesTableData,
          $$PlacesTableTableFilterComposer,
          $$PlacesTableTableOrderingComposer,
          $$PlacesTableTableAnnotationComposer,
          $$PlacesTableTableCreateCompanionBuilder,
          $$PlacesTableTableUpdateCompanionBuilder,
          (
            PlacesTableData,
            BaseReferences<_$AppDatabase, $PlacesTableTable, PlacesTableData>,
          ),
          PlacesTableData,
          PrefetchHooks Function()
        > {
  $$PlacesTableTableTableManager(_$AppDatabase db, $PlacesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> homeImagePath = const Value.absent(),
                Value<String> pageImagePath = const Value.absent(),
                Value<String> pageTitle = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<List<Feature>> features = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlacesTableCompanion(
                id: id,
                title: title,
                homeImagePath: homeImagePath,
                pageImagePath: pageImagePath,
                pageTitle: pageTitle,
                description: description,
                features: features,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String homeImagePath,
                required String pageImagePath,
                required String pageTitle,
                required String description,
                required List<Feature> features,
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlacesTableCompanion.insert(
                id: id,
                title: title,
                homeImagePath: homeImagePath,
                pageImagePath: pageImagePath,
                pageTitle: pageTitle,
                description: description,
                features: features,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlacesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlacesTableTable,
      PlacesTableData,
      $$PlacesTableTableFilterComposer,
      $$PlacesTableTableOrderingComposer,
      $$PlacesTableTableAnnotationComposer,
      $$PlacesTableTableCreateCompanionBuilder,
      $$PlacesTableTableUpdateCompanionBuilder,
      (
        PlacesTableData,
        BaseReferences<_$AppDatabase, $PlacesTableTable, PlacesTableData>,
      ),
      PlacesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlacesTableTableTableManager get placesTable =>
      $$PlacesTableTableTableManager(_db, _db.placesTable);
}
