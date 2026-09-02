// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DreamPlacesTable extends DreamPlaces
    with TableInfo<$DreamPlacesTable, DreamPlace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DreamPlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationTitleMeta =
      const VerificationMeta('locationTitle');
  @override
  late final GeneratedColumn<String> locationTitle = GeneratedColumn<String>(
      'location_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _icon1Meta = const VerificationMeta('icon1');
  @override
  late final GeneratedColumn<int> icon1 = GeneratedColumn<int>(
      'icon1', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _icon2Meta = const VerificationMeta('icon2');
  @override
  late final GeneratedColumn<int> icon2 = GeneratedColumn<int>(
      'icon2', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _icon3Meta = const VerificationMeta('icon3');
  @override
  late final GeneratedColumn<int> icon3 = GeneratedColumn<int>(
      'icon3', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _iconText1Meta =
      const VerificationMeta('iconText1');
  @override
  late final GeneratedColumn<String> iconText1 = GeneratedColumn<String>(
      'icon_text1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconText2Meta =
      const VerificationMeta('iconText2');
  @override
  late final GeneratedColumn<String> iconText2 = GeneratedColumn<String>(
      'icon_text2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconText3Meta =
      const VerificationMeta('iconText3');
  @override
  late final GeneratedColumn<String> iconText3 = GeneratedColumn<String>(
      'icon_text3', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        locationTitle,
        description,
        imagePath,
        isFavorite,
        icon1,
        icon2,
        icon3,
        iconText1,
        iconText2,
        iconText3
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dream_places';
  @override
  VerificationContext validateIntegrity(Insertable<DreamPlace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('location_title')) {
      context.handle(
          _locationTitleMeta,
          locationTitle.isAcceptableOrUnknown(
              data['location_title']!, _locationTitleMeta));
    } else if (isInserting) {
      context.missing(_locationTitleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('icon1')) {
      context.handle(
          _icon1Meta, icon1.isAcceptableOrUnknown(data['icon1']!, _icon1Meta));
    } else if (isInserting) {
      context.missing(_icon1Meta);
    }
    if (data.containsKey('icon2')) {
      context.handle(
          _icon2Meta, icon2.isAcceptableOrUnknown(data['icon2']!, _icon2Meta));
    } else if (isInserting) {
      context.missing(_icon2Meta);
    }
    if (data.containsKey('icon3')) {
      context.handle(
          _icon3Meta, icon3.isAcceptableOrUnknown(data['icon3']!, _icon3Meta));
    } else if (isInserting) {
      context.missing(_icon3Meta);
    }
    if (data.containsKey('icon_text1')) {
      context.handle(_iconText1Meta,
          iconText1.isAcceptableOrUnknown(data['icon_text1']!, _iconText1Meta));
    } else if (isInserting) {
      context.missing(_iconText1Meta);
    }
    if (data.containsKey('icon_text2')) {
      context.handle(_iconText2Meta,
          iconText2.isAcceptableOrUnknown(data['icon_text2']!, _iconText2Meta));
    } else if (isInserting) {
      context.missing(_iconText2Meta);
    }
    if (data.containsKey('icon_text3')) {
      context.handle(_iconText3Meta,
          iconText3.isAcceptableOrUnknown(data['icon_text3']!, _iconText3Meta));
    } else if (isInserting) {
      context.missing(_iconText3Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DreamPlace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DreamPlace(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      locationTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      icon1: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon1'])!,
      icon2: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon2'])!,
      icon3: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon3'])!,
      iconText1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_text1'])!,
      iconText2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_text2'])!,
      iconText3: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_text3'])!,
    );
  }

  @override
  $DreamPlacesTable createAlias(String alias) {
    return $DreamPlacesTable(attachedDatabase, alias);
  }
}

class DreamPlace extends DataClass implements Insertable<DreamPlace> {
  final int id;
  final String title;
  final String locationTitle;
  final String description;
  final String imagePath;
  final bool isFavorite;
  final int icon1;
  final int icon2;
  final int icon3;
  final String iconText1;
  final String iconText2;
  final String iconText3;
  const DreamPlace(
      {required this.id,
      required this.title,
      required this.locationTitle,
      required this.description,
      required this.imagePath,
      required this.isFavorite,
      required this.icon1,
      required this.icon2,
      required this.icon3,
      required this.iconText1,
      required this.iconText2,
      required this.iconText3});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['location_title'] = Variable<String>(locationTitle);
    map['description'] = Variable<String>(description);
    map['image_path'] = Variable<String>(imagePath);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['icon1'] = Variable<int>(icon1);
    map['icon2'] = Variable<int>(icon2);
    map['icon3'] = Variable<int>(icon3);
    map['icon_text1'] = Variable<String>(iconText1);
    map['icon_text2'] = Variable<String>(iconText2);
    map['icon_text3'] = Variable<String>(iconText3);
    return map;
  }

  DreamPlacesCompanion toCompanion(bool nullToAbsent) {
    return DreamPlacesCompanion(
      id: Value(id),
      title: Value(title),
      locationTitle: Value(locationTitle),
      description: Value(description),
      imagePath: Value(imagePath),
      isFavorite: Value(isFavorite),
      icon1: Value(icon1),
      icon2: Value(icon2),
      icon3: Value(icon3),
      iconText1: Value(iconText1),
      iconText2: Value(iconText2),
      iconText3: Value(iconText3),
    );
  }

  factory DreamPlace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DreamPlace(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      locationTitle: serializer.fromJson<String>(json['locationTitle']),
      description: serializer.fromJson<String>(json['description']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      icon1: serializer.fromJson<int>(json['icon1']),
      icon2: serializer.fromJson<int>(json['icon2']),
      icon3: serializer.fromJson<int>(json['icon3']),
      iconText1: serializer.fromJson<String>(json['iconText1']),
      iconText2: serializer.fromJson<String>(json['iconText2']),
      iconText3: serializer.fromJson<String>(json['iconText3']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'locationTitle': serializer.toJson<String>(locationTitle),
      'description': serializer.toJson<String>(description),
      'imagePath': serializer.toJson<String>(imagePath),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'icon1': serializer.toJson<int>(icon1),
      'icon2': serializer.toJson<int>(icon2),
      'icon3': serializer.toJson<int>(icon3),
      'iconText1': serializer.toJson<String>(iconText1),
      'iconText2': serializer.toJson<String>(iconText2),
      'iconText3': serializer.toJson<String>(iconText3),
    };
  }

  DreamPlace copyWith(
          {int? id,
          String? title,
          String? locationTitle,
          String? description,
          String? imagePath,
          bool? isFavorite,
          int? icon1,
          int? icon2,
          int? icon3,
          String? iconText1,
          String? iconText2,
          String? iconText3}) =>
      DreamPlace(
        id: id ?? this.id,
        title: title ?? this.title,
        locationTitle: locationTitle ?? this.locationTitle,
        description: description ?? this.description,
        imagePath: imagePath ?? this.imagePath,
        isFavorite: isFavorite ?? this.isFavorite,
        icon1: icon1 ?? this.icon1,
        icon2: icon2 ?? this.icon2,
        icon3: icon3 ?? this.icon3,
        iconText1: iconText1 ?? this.iconText1,
        iconText2: iconText2 ?? this.iconText2,
        iconText3: iconText3 ?? this.iconText3,
      );
  DreamPlace copyWithCompanion(DreamPlacesCompanion data) {
    return DreamPlace(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      locationTitle: data.locationTitle.present
          ? data.locationTitle.value
          : this.locationTitle,
      description:
          data.description.present ? data.description.value : this.description,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      icon1: data.icon1.present ? data.icon1.value : this.icon1,
      icon2: data.icon2.present ? data.icon2.value : this.icon2,
      icon3: data.icon3.present ? data.icon3.value : this.icon3,
      iconText1: data.iconText1.present ? data.iconText1.value : this.iconText1,
      iconText2: data.iconText2.present ? data.iconText2.value : this.iconText2,
      iconText3: data.iconText3.present ? data.iconText3.value : this.iconText3,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DreamPlace(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('locationTitle: $locationTitle, ')
          ..write('description: $description, ')
          ..write('imagePath: $imagePath, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('icon1: $icon1, ')
          ..write('icon2: $icon2, ')
          ..write('icon3: $icon3, ')
          ..write('iconText1: $iconText1, ')
          ..write('iconText2: $iconText2, ')
          ..write('iconText3: $iconText3')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      locationTitle,
      description,
      imagePath,
      isFavorite,
      icon1,
      icon2,
      icon3,
      iconText1,
      iconText2,
      iconText3);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DreamPlace &&
          other.id == this.id &&
          other.title == this.title &&
          other.locationTitle == this.locationTitle &&
          other.description == this.description &&
          other.imagePath == this.imagePath &&
          other.isFavorite == this.isFavorite &&
          other.icon1 == this.icon1 &&
          other.icon2 == this.icon2 &&
          other.icon3 == this.icon3 &&
          other.iconText1 == this.iconText1 &&
          other.iconText2 == this.iconText2 &&
          other.iconText3 == this.iconText3);
}

class DreamPlacesCompanion extends UpdateCompanion<DreamPlace> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> locationTitle;
  final Value<String> description;
  final Value<String> imagePath;
  final Value<bool> isFavorite;
  final Value<int> icon1;
  final Value<int> icon2;
  final Value<int> icon3;
  final Value<String> iconText1;
  final Value<String> iconText2;
  final Value<String> iconText3;
  const DreamPlacesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.locationTitle = const Value.absent(),
    this.description = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.icon1 = const Value.absent(),
    this.icon2 = const Value.absent(),
    this.icon3 = const Value.absent(),
    this.iconText1 = const Value.absent(),
    this.iconText2 = const Value.absent(),
    this.iconText3 = const Value.absent(),
  });
  DreamPlacesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String locationTitle,
    required String description,
    required String imagePath,
    this.isFavorite = const Value.absent(),
    required int icon1,
    required int icon2,
    required int icon3,
    required String iconText1,
    required String iconText2,
    required String iconText3,
  })  : title = Value(title),
        locationTitle = Value(locationTitle),
        description = Value(description),
        imagePath = Value(imagePath),
        icon1 = Value(icon1),
        icon2 = Value(icon2),
        icon3 = Value(icon3),
        iconText1 = Value(iconText1),
        iconText2 = Value(iconText2),
        iconText3 = Value(iconText3);
  static Insertable<DreamPlace> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? locationTitle,
    Expression<String>? description,
    Expression<String>? imagePath,
    Expression<bool>? isFavorite,
    Expression<int>? icon1,
    Expression<int>? icon2,
    Expression<int>? icon3,
    Expression<String>? iconText1,
    Expression<String>? iconText2,
    Expression<String>? iconText3,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (locationTitle != null) 'location_title': locationTitle,
      if (description != null) 'description': description,
      if (imagePath != null) 'image_path': imagePath,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (icon1 != null) 'icon1': icon1,
      if (icon2 != null) 'icon2': icon2,
      if (icon3 != null) 'icon3': icon3,
      if (iconText1 != null) 'icon_text1': iconText1,
      if (iconText2 != null) 'icon_text2': iconText2,
      if (iconText3 != null) 'icon_text3': iconText3,
    });
  }

  DreamPlacesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? locationTitle,
      Value<String>? description,
      Value<String>? imagePath,
      Value<bool>? isFavorite,
      Value<int>? icon1,
      Value<int>? icon2,
      Value<int>? icon3,
      Value<String>? iconText1,
      Value<String>? iconText2,
      Value<String>? iconText3}) {
    return DreamPlacesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      locationTitle: locationTitle ?? this.locationTitle,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
      icon1: icon1 ?? this.icon1,
      icon2: icon2 ?? this.icon2,
      icon3: icon3 ?? this.icon3,
      iconText1: iconText1 ?? this.iconText1,
      iconText2: iconText2 ?? this.iconText2,
      iconText3: iconText3 ?? this.iconText3,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (locationTitle.present) {
      map['location_title'] = Variable<String>(locationTitle.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (icon1.present) {
      map['icon1'] = Variable<int>(icon1.value);
    }
    if (icon2.present) {
      map['icon2'] = Variable<int>(icon2.value);
    }
    if (icon3.present) {
      map['icon3'] = Variable<int>(icon3.value);
    }
    if (iconText1.present) {
      map['icon_text1'] = Variable<String>(iconText1.value);
    }
    if (iconText2.present) {
      map['icon_text2'] = Variable<String>(iconText2.value);
    }
    if (iconText3.present) {
      map['icon_text3'] = Variable<String>(iconText3.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DreamPlacesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('locationTitle: $locationTitle, ')
          ..write('description: $description, ')
          ..write('imagePath: $imagePath, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('icon1: $icon1, ')
          ..write('icon2: $icon2, ')
          ..write('icon3: $icon3, ')
          ..write('iconText1: $iconText1, ')
          ..write('iconText2: $iconText2, ')
          ..write('iconText3: $iconText3')
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

typedef $$DreamPlacesTableCreateCompanionBuilder = DreamPlacesCompanion
    Function({
  Value<int> id,
  required String title,
  required String locationTitle,
  required String description,
  required String imagePath,
  Value<bool> isFavorite,
  required int icon1,
  required int icon2,
  required int icon3,
  required String iconText1,
  required String iconText2,
  required String iconText3,
});
typedef $$DreamPlacesTableUpdateCompanionBuilder = DreamPlacesCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> locationTitle,
  Value<String> description,
  Value<String> imagePath,
  Value<bool> isFavorite,
  Value<int> icon1,
  Value<int> icon2,
  Value<int> icon3,
  Value<String> iconText1,
  Value<String> iconText2,
  Value<String> iconText3,
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
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationTitle => $composableBuilder(
      column: $table.locationTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get icon1 => $composableBuilder(
      column: $table.icon1, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get icon2 => $composableBuilder(
      column: $table.icon2, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get icon3 => $composableBuilder(
      column: $table.icon3, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconText1 => $composableBuilder(
      column: $table.iconText1, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconText2 => $composableBuilder(
      column: $table.iconText2, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconText3 => $composableBuilder(
      column: $table.iconText3, builder: (column) => ColumnFilters(column));
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
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationTitle => $composableBuilder(
      column: $table.locationTitle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get icon1 => $composableBuilder(
      column: $table.icon1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get icon2 => $composableBuilder(
      column: $table.icon2, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get icon3 => $composableBuilder(
      column: $table.icon3, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconText1 => $composableBuilder(
      column: $table.iconText1, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconText2 => $composableBuilder(
      column: $table.iconText2, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconText3 => $composableBuilder(
      column: $table.iconText3, builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get locationTitle => $composableBuilder(
      column: $table.locationTitle, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<int> get icon1 =>
      $composableBuilder(column: $table.icon1, builder: (column) => column);

  GeneratedColumn<int> get icon2 =>
      $composableBuilder(column: $table.icon2, builder: (column) => column);

  GeneratedColumn<int> get icon3 =>
      $composableBuilder(column: $table.icon3, builder: (column) => column);

  GeneratedColumn<String> get iconText1 =>
      $composableBuilder(column: $table.iconText1, builder: (column) => column);

  GeneratedColumn<String> get iconText2 =>
      $composableBuilder(column: $table.iconText2, builder: (column) => column);

  GeneratedColumn<String> get iconText3 =>
      $composableBuilder(column: $table.iconText3, builder: (column) => column);
}

class $$DreamPlacesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DreamPlacesTable,
    DreamPlace,
    $$DreamPlacesTableFilterComposer,
    $$DreamPlacesTableOrderingComposer,
    $$DreamPlacesTableAnnotationComposer,
    $$DreamPlacesTableCreateCompanionBuilder,
    $$DreamPlacesTableUpdateCompanionBuilder,
    (DreamPlace, BaseReferences<_$AppDatabase, $DreamPlacesTable, DreamPlace>),
    DreamPlace,
    PrefetchHooks Function()> {
  $$DreamPlacesTableTableManager(_$AppDatabase db, $DreamPlacesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DreamPlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DreamPlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DreamPlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> locationTitle = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<int> icon1 = const Value.absent(),
            Value<int> icon2 = const Value.absent(),
            Value<int> icon3 = const Value.absent(),
            Value<String> iconText1 = const Value.absent(),
            Value<String> iconText2 = const Value.absent(),
            Value<String> iconText3 = const Value.absent(),
          }) =>
              DreamPlacesCompanion(
            id: id,
            title: title,
            locationTitle: locationTitle,
            description: description,
            imagePath: imagePath,
            isFavorite: isFavorite,
            icon1: icon1,
            icon2: icon2,
            icon3: icon3,
            iconText1: iconText1,
            iconText2: iconText2,
            iconText3: iconText3,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String locationTitle,
            required String description,
            required String imagePath,
            Value<bool> isFavorite = const Value.absent(),
            required int icon1,
            required int icon2,
            required int icon3,
            required String iconText1,
            required String iconText2,
            required String iconText3,
          }) =>
              DreamPlacesCompanion.insert(
            id: id,
            title: title,
            locationTitle: locationTitle,
            description: description,
            imagePath: imagePath,
            isFavorite: isFavorite,
            icon1: icon1,
            icon2: icon2,
            icon3: icon3,
            iconText1: iconText1,
            iconText2: iconText2,
            iconText3: iconText3,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DreamPlacesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DreamPlacesTable,
    DreamPlace,
    $$DreamPlacesTableFilterComposer,
    $$DreamPlacesTableOrderingComposer,
    $$DreamPlacesTableAnnotationComposer,
    $$DreamPlacesTableCreateCompanionBuilder,
    $$DreamPlacesTableUpdateCompanionBuilder,
    (DreamPlace, BaseReferences<_$AppDatabase, $DreamPlacesTable, DreamPlace>),
    DreamPlace,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DreamPlacesTableTableManager get dreamPlaces =>
      $$DreamPlacesTableTableManager(_db, _db.dreamPlaces);
}
