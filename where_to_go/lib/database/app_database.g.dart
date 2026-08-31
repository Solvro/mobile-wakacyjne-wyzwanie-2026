// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DreamPlacesTable extends DreamPlaces
    with TableInfo<$DreamPlacesTable, DreamPlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DreamPlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
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
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavouriteMeta = const VerificationMeta(
    'isFavourite',
  );
  @override
  late final GeneratedColumn<bool> isFavourite = GeneratedColumn<bool>(
    'is_favourite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favourite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    imageUrl,
    isFavourite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dream_places';
  @override
  VerificationContext validateIntegrity(
    Insertable<DreamPlace> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('is_favourite')) {
      context.handle(
        _isFavouriteMeta,
        isFavourite.isAcceptableOrUnknown(
          data['is_favourite']!,
          _isFavouriteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DreamPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DreamPlace(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      isFavourite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favourite'],
      )!,
    );
  }

  @override
  $DreamPlacesTable createAlias(String alias) {
    return $DreamPlacesTable(attachedDatabase, alias);
  }
}

class DreamPlace extends DataClass implements Insertable<DreamPlace> {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isFavourite;
  const DreamPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isFavourite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    map['is_favourite'] = Variable<bool>(isFavourite);
    return map;
  }

  DreamPlacesCompanion toCompanion(bool nullToAbsent) {
    return DreamPlacesCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      imageUrl: Value(imageUrl),
      isFavourite: Value(isFavourite),
    );
  }

  factory DreamPlace.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DreamPlace(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      isFavourite: serializer.fromJson<bool>(json['isFavourite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'isFavourite': serializer.toJson<bool>(isFavourite),
    };
  }

  DreamPlace copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isFavourite,
  }) => DreamPlace(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    isFavourite: isFavourite ?? this.isFavourite,
  );
  DreamPlace copyWithCompanion(DreamPlacesCompanion data) {
    return DreamPlace(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isFavourite: data.isFavourite.present
          ? data.isFavourite.value
          : this.isFavourite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DreamPlace(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, imageUrl, isFavourite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DreamPlace &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.isFavourite == this.isFavourite);
}

class DreamPlacesCompanion extends UpdateCompanion<DreamPlace> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<bool> isFavourite;
  final Value<int> rowid;
  const DreamPlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DreamPlacesCompanion.insert({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    this.isFavourite = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description),
       imageUrl = Value(imageUrl);
  static Insertable<DreamPlace> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<bool>? isFavourite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isFavourite != null) 'is_favourite': isFavourite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DreamPlacesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? imageUrl,
    Value<bool>? isFavourite,
    Value<int>? rowid,
  }) {
    return DreamPlacesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavourite: isFavourite ?? this.isFavourite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DreamPlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DreamPlacesTable dreamPlaces = $DreamPlacesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dreamPlaces];
}

typedef $$DreamPlacesTableCreateCompanionBuilder =
    DreamPlacesCompanion Function({
      required String id,
      required String name,
      required String description,
      required String imageUrl,
      Value<bool> isFavourite,
      Value<int> rowid,
    });
typedef $$DreamPlacesTableUpdateCompanionBuilder =
    DreamPlacesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<String> imageUrl,
      Value<bool> isFavourite,
      Value<int> rowid,
    });

class $$DreamPlacesTableFilterComposer
    extends Composer<_$AppDatabase, $DreamPlacesTable> {
  $$DreamPlacesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DreamPlacesTableOrderingComposer
    extends Composer<_$AppDatabase, $DreamPlacesTable> {
  $$DreamPlacesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DreamPlacesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DreamPlacesTable> {
  $$DreamPlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => column,
  );
}

class $$DreamPlacesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DreamPlacesTable,
          DreamPlace,
          $$DreamPlacesTableFilterComposer,
          $$DreamPlacesTableOrderingComposer,
          $$DreamPlacesTableAnnotationComposer,
          $$DreamPlacesTableCreateCompanionBuilder,
          $$DreamPlacesTableUpdateCompanionBuilder,
          (
            DreamPlace,
            BaseReferences<_$AppDatabase, $DreamPlacesTable, DreamPlace>,
          ),
          DreamPlace,
          PrefetchHooks Function()
        > {
  $$DreamPlacesTableTableManager(_$AppDatabase db, $DreamPlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DreamPlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DreamPlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DreamPlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<bool> isFavourite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DreamPlacesCompanion(
                id: id,
                name: name,
                description: description,
                imageUrl: imageUrl,
                isFavourite: isFavourite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                required String imageUrl,
                Value<bool> isFavourite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DreamPlacesCompanion.insert(
                id: id,
                name: name,
                description: description,
                imageUrl: imageUrl,
                isFavourite: isFavourite,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DreamPlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DreamPlacesTable,
      DreamPlace,
      $$DreamPlacesTableFilterComposer,
      $$DreamPlacesTableOrderingComposer,
      $$DreamPlacesTableAnnotationComposer,
      $$DreamPlacesTableCreateCompanionBuilder,
      $$DreamPlacesTableUpdateCompanionBuilder,
      (
        DreamPlace,
        BaseReferences<_$AppDatabase, $DreamPlacesTable, DreamPlace>,
      ),
      DreamPlace,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DreamPlacesTableTableManager get dreamPlaces =>
      $$DreamPlacesTableTableManager(_db, _db.dreamPlaces);
}
