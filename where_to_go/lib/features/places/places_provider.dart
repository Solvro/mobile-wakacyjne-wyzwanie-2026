import "package:drift/drift.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../database/app_database.dart";
import "place.dart";

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final placesStreamProvider = StreamProvider<List<Place>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.dreamPlaces).watch().map(
        (rows) => rows
            .map(
              (r) => Place(
                id: r.id.toString(),
                title: r.name,
                description: r.description,
                imageUrl: r.imageUrl,
                isFavorite: r.isFavourite,
              ),
            )
            .toList(),
      );
});

final placesNotifierProvider = Provider<PlacesController>((ref) {
  final db = ref.watch(databaseProvider);
  return PlacesController(db);
});

class PlacesController {
  final AppDatabase _db;
  PlacesController(this._db);

  Future<void> toggleFavorite(String id) async {
    final intId = int.tryParse(id);
    if (intId == null) return;

    final place = await (_db.select(_db.dreamPlaces)..where((tbl) => tbl.id.equals(intId))).getSingleOrNull();
    if (place == null) return;

    await (_db.update(_db.dreamPlaces)..where((tbl) => tbl.id.equals(intId))).write(
      DreamPlacesCompanion(isFavourite: Value(!place.isFavourite)),
    );
  }

  Future<void> seedInitialData() async {
    final existing = await _db.select(_db.dreamPlaces).get();
    if (existing.isNotEmpty) return;

    final initialList = [
      DreamPlacesCompanion.insert(
        name: "Amalfi, Włochy",
        description: "Kolorowe klify i Morze Tyrreńskie",
        imageUrl: "https://images.unsplash.com/photo-1533105079780-92b9be482077?w=500&q=80",
        isFavourite: const Value(false),
      ),
      DreamPlacesCompanion.insert(
        name: "Banff, Kanada",
        description: "Góry Skaliste i turkusowe jeziora",
        imageUrl: "https://images.unsplash.com/photo-1503614472-8c93d56e92ce?w=500&q=80",
        isFavourite: const Value(false),
      ),
      DreamPlacesCompanion.insert(
        name: "Paryż, Francja",
        description: "Miasto miłości i architektury",
        imageUrl: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=500&q=80",
        isFavourite: const Value(true),
      ),
      DreamPlacesCompanion.insert(
        name: "Kioto, Japonia",
        description: "Tradycyjne świątynie i ogrody",
        imageUrl: "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=500&q=80",
        isFavourite: const Value(false),
      ),
    ];

    await _db.batch((b) => b.insertAll(_db.dreamPlaces, initialList));
  }
}
