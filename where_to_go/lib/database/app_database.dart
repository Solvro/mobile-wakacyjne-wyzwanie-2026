import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";

part "app_database.g.dart";

class DreamPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  BoolColumn get isFavourite => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [DreamPlaces])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: "where_to_go_db");
  }
}
