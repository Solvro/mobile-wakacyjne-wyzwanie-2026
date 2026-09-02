import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class DreamPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get locationTitle => text()();
  TextColumn get description => text()();
  TextColumn get imagePath => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  IntColumn get icon1 => integer()();
  IntColumn get icon2 => integer()();
  IntColumn get icon3 => integer()();

  TextColumn get iconText1 => text()();
  TextColumn get iconText2 => text()();
  TextColumn get iconText3 => text()();
}

@DriftDatabase(tables: [DreamPlaces])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Seedowanie wykonuje się WYŁĄCZNIE raz przy fizycznym tworzeniu pliku bazy
          await seedDatabase();
        },
      );

  Future<List<DreamPlace>> getAllPlaces() => select(dreamPlaces).get();
  Stream<List<DreamPlace>> watchAllPlaces() => select(dreamPlaces).watch();

  Future<void> toggleFavorite(int id, bool currentStatus) async {
    await (update(dreamPlaces)..where((tbl) => tbl.id.equals(id))).write(
      DreamPlacesCompanion(
        isFavorite: Value(!currentStatus),
      ),
    );
  }

  Future<void> seedDatabase() async {
    final existingPlaces = await select(dreamPlaces).get();
    if (existingPlaces.isNotEmpty) return;

    final initialPlaces = [
      DreamPlacesCompanion.insert(
        title: 'Koszalin, Polska',
        locationTitle: 'Katedra',
        description:
            'Katedra Niepokalanego Poczęcia Najświętszej Maryi Panny w Koszalinie.',
        imagePath: 'assets/images/koszalin.jpg',
        icon1: Icons.location_on.codePoint,
        icon2: Icons.account_balance.codePoint,
        icon3: Icons.local_grocery_store.codePoint,
        iconText1: 'Centrum',
        iconText2: 'Zabytek',
        iconText3: 'Darmowe',
      ),
      DreamPlacesCompanion.insert(
        title: 'Mielno, Polska',
        locationTitle: 'Plaża',
        description:
            'Mielno słynie z piaszcystych plaż, drogich gofrów i zimnego Bałtyku',
        imagePath: 'assets/images/mielno.jpg',
        icon1: Icons.beach_access.codePoint,
        icon2: Icons.local_dining.codePoint,
        icon3: Icons.wb_sunny.codePoint,
        iconText1: 'Plaża',
        iconText2: 'Restauracje',
        iconText3: 'Słonecznie',
      ),
      DreamPlacesCompanion.insert(
        title: 'Kłodzko, Polska',
        locationTitle: 'Most w Kłodzku',
        description: 'Most w Kłodzku to zabytkowy most przekraczający rzekę.',
        imagePath: 'assets/images/klodzko.jpg',
        icon1: Icons.location_city.codePoint,
        icon2: Icons.history.codePoint,
        icon3: Icons.visibility.codePoint,
        iconText1: 'Miasto',
        iconText2: 'Historia',
        iconText3: 'Widok',
      ),
      DreamPlacesCompanion.insert(
        title: 'Gąski, Polska',
        locationTitle: 'Latarnia Morska',
        description:
            'Latarnia Morska w Gąskach to zabytkowa latarnia morska położona nad Morzem Bałtyckim.',
        imagePath: 'assets/images/gaski.jpg',
        icon1: Icons.landscape.codePoint,
        icon2: Icons.lightbulb.codePoint,
        icon3: Icons.photo_camera.codePoint,
        iconText1: 'Widok',
        iconText2: 'Latarnia',
        iconText3: 'Fotogeniczne',
      ),
      DreamPlacesCompanion.insert(
        title: 'Białogard, Polska',
        locationTitle: 'Rynek',
        description:
            'Rynek w Białogardzie to centralny plac miasta, otoczony zabytkowymi kamienicami.',
        imagePath: 'assets/images/bialogard.jpg',
        icon1: Icons.store.codePoint,
        icon2: Icons.local_cafe.codePoint,
        icon3: Icons.directions_walk.codePoint,
        iconText1: 'Sklepy',
        iconText2: 'Kawiarnie',
        iconText3: 'Spacer',
      ),
    ];

    await batch((batch) {
      batch.insertAll(dreamPlaces, initialPlaces);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    // Zmiana z db.sqlite na db_v2.sqlite wymusi stworzenie czystej bazy
    final file = File(p.join(dbFolder.path, 'db_v3.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
