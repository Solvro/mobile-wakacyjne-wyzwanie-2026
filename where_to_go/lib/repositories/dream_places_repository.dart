import "package:drift/drift.dart";
import "../database/app_database.dart";

abstract class DreamPlacesRepository {
  Future<List<DreamPlace>> getAllPlaces();
  Stream<List<DreamPlace>> watchAllPlaces();
  Future<void> updateFavourite({required int id, required bool isFavourite});
  Future<void> seedInitialData();
}

class DriftDreamPlacesRepository implements DreamPlacesRepository {
  final AppDatabase _db;

  DriftDreamPlacesRepository(this._db);

  @override
  Future<List<DreamPlace>> getAllPlaces() {
    return _db.select(_db.dreamPlaces).get();
  }

  @override
  Stream<List<DreamPlace>> watchAllPlaces() {
    return _db.select(_db.dreamPlaces).watch();
  }

  @override
  Future<void> updateFavourite({
    required int id,
    required bool isFavourite,
  }) async {
    await (_db.update(_db.dreamPlaces)..where((tbl) => tbl.id.equals(id))).write(
      DreamPlacesCompanion(
        isFavourite: Value(isFavourite),
      ),
    );
  }

  @override
  Future<void> seedInitialData() async {
    final existingPlaces = await _db.select(_db.dreamPlaces).get();
    if (existingPlaces.isNotEmpty) {
      return;
    }

    final samplePlaces = [
      DreamPlacesCompanion.insert(
        name: "Paryż",
        description: "Miasto miłości i wieży Eiffla.",
        imageUrl:
            "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
        isFavourite: const Value(true),
      ),
      DreamPlacesCompanion.insert(
        name: "Tokio",
        description: "Stolica technologii i kwitnącej wiśni.",
        imageUrl:
            "https://images.unsplash.com/photo-1503899036084-c55cdd92da26",
        isFavourite: const Value(false),
      ),
      DreamPlacesCompanion.insert(
        name: "Nowy Jork",
        description: "Miasto drapaczy chmur i Times Square.",
        imageUrl:
            "https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9",
        isFavourite: const Value(true),
      ),
      DreamPlacesCompanion.insert(
        name: "Rzym",
        description: "Wieczne miasto z Koloseum i pizzą.",
        imageUrl:
            "https://images.unsplash.com/photo-1552832230-c0197dd311b5",
        isFavourite: const Value(false),
      ),
    ];

    await _db.batch((batch) {
      batch.insertAll(_db.dreamPlaces, samplePlaces);
    });
  }
}
