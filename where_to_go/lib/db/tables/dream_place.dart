import "package:drift/drift.dart";

class DreamPlaces extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  BoolColumn get isFavorited => boolean().withDefault(const Constant(false))();
}
