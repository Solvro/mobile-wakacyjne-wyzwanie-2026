import "dart:convert";

import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";
import "package:flutter/material.dart" hide Column, Table;

import "place.dart";

part "places_database.g.dart";

class FeaturesConverter extends TypeConverter<List<Feature>, String> {
  const FeaturesConverter();

  @override
  List<Feature> fromSql(String fromDb) {
    final List<dynamic> names = json.decode(fromDb);
    return names.map((name) {
      return Feature.all.firstWhere(
        (f) => f.name == name,
        orElse: () => Feature(name as String, Icons.help),
      );
    }).toList();
  }

  @override
  String toSql(List<Feature> value) {
    return json.encode(value.map((f) => f.name).toList());
  }
}

class PlacesTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get homeImagePath => text()();
  TextColumn get pageImagePath => text()();
  TextColumn get pageTitle => text()();
  TextColumn get description => text()();
  TextColumn get features => text().map(const FeaturesConverter())();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [PlacesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Place>> watchAllPlaces() {
    return select(placesTable).watch().map((rows) {
      return rows
          .map(
            (row) => Place(
              id: row.id,
              title: row.title,
              homeImagePath: row.homeImagePath,
              pageImagePath: row.pageImagePath,
              pageTitle: row.pageTitle,
              description: row.description,
              features: row.features,
              isFavorite: row.isFavorite,
            ),
          )
          .toList();
    });
  }

  Future<void> updateFavorite(String id, bool isFavorite) {
    return (update(placesTable)..where((t) => t.id.equals(id))).write(
      PlacesTableCompanion(isFavorite: Value(isFavorite)),
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: "my_database");
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        for (final p in _initialPlaces) {
          await into(placesTable).insert(
            PlacesTableCompanion.insert(
              id: p.id,
              title: p.title,
              homeImagePath: p.homeImagePath,
              pageImagePath: p.pageImagePath,
              pageTitle: p.pageTitle,
              description: p.description,
              features: p.features,
              isFavorite: Value(p.isFavorite),
            ),
          );
        }
      },
    );
  }
}

const _initialPlaces = [
  Place(
    id: "1",
    title: "Lagonisi, Grecja",
    homeImagePath: "assets/images/lagonisi.jpg",
    pageImagePath: "assets/images/lagonisi2.jpg",
    pageTitle: "Nadmorskie miasteczko Lagonisi",
    description: "Nadmorska dzielnica mieszkaniowa na Riwierze Ateńskiej i południowej części Kalyvia Thorikou we wschodniej Attyce.",
    features: [
      Feature("Plaża piasczysta", Icons.beach_access),
      Feature("Jedzenie", Icons.fastfood),
      Feature("Słońce", Icons.sunny),
    ],
  ),
  Place(
    id: "2",
    title: "Vodice, Chorwacja",
    homeImagePath: "assets/images/vodice.jpg",
    pageImagePath: "assets/images/vodice2.jpg",
    pageTitle: "Słoneczny kurort Vodice",
    description: "Miasto i port w Chorwacji, w żupanii szybenicko-knińskiej, siedziba miasta Vodice.",
    features: [
      Feature("Plaża kamienista", Icons.beach_access),
      Feature("Życie nocne", Icons.nightlife),
      Feature("Słońce", Icons.sunny),
    ],
  ),
  Place(
    id: "3",
    title: "Rimini, Włochy",
    homeImagePath: "assets/images/rimini2.jpg",
    pageImagePath: "assets/images/rimini.jpg",
    pageTitle: "Turystyczne Rimini",
    description: "Jedno z najpopularniejszych miast turystyczno-wypoczynkowych nad północnym Adriatykiem.",
    features: [
      Feature("Plaża piasczysta", Icons.beach_access),
      Feature("Życie nocne", Icons.nightlife),
      Feature("Słońce", Icons.sunny),
      Feature("Duże miasto", Icons.location_city),
    ],
  ),
  Place(
    id: "4",
    title: "Madryt, Hiszpania",
    homeImagePath: "assets/images/madryt.jpg",
    pageImagePath: "assets/images/madryt2.jpg",
    pageTitle: "Centrum Hiszpanii, Madryt",
    description: "Stolica i największe miasto Hiszpanii, położone w środkowej części kraju, nad rzeką Manzanares.",
    features: [
      Feature("Stolica", Icons.location_city),
      Feature("Życie nocne", Icons.nightlife),
      Feature("Nad rzeką", Icons.water),
    ],
  ),
  Place(
    id: "5",
    title: "Zakopane, Polska",
    homeImagePath: "assets/images/zakopane.jpg",
    pageImagePath: "assets/images/zakopane2.jpg",
    pageTitle: "Zimowa stolica, Zakopane",
    description: "Miasto w południowej Polsce, największa miejscowość w bezpośrednim otoczeniu Tatr, duży ośrodek sportów zimowych",
    features: [
      Feature("Góry", Icons.terrain),
      Feature("Park Narodowy", Icons.hiking),
      Feature("Narty", Icons.downhill_skiing),
    ],
  ),
];
