import "dart:io";
import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";

part "dream_place_table.g.dart";

class DreamPlaceTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().withLength(min: 1, max: 500)();
  TextColumn get imageUrl => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [DreamPlaceTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "dream_places.sqlite"));
    return NativeDatabase(file);
  });
}
