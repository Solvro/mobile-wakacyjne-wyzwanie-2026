import "package:drift/drift.dart";

import "tables/dream_place.dart";

part "database.g.dart";

@DriftDatabase(tables: [DreamPlaces])
class Database extends _$Database {
  Database(super.e);

  @override
  int get schemaVersion => 1;

  Future<List<DreamPlace>> getAllDreamPlaces() => select(dreamPlaces).get();

  Future<int> insertDreamPlace(DreamPlacesCompanion entry) => into(dreamPlaces).insert(entry);

  Future<int> deleteDreamPlace(int id) => (delete(dreamPlaces)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> clearDreamPlaces() => delete(dreamPlaces).go();

  Future<DreamPlace?> getDreamPlaceById(int id) =>
      (select(dreamPlaces)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<bool> updateDreamPlace(DreamPlace place) => update(dreamPlaces).replace(place);

  Future<void> toggleFavourite(int id, {required bool isFavourite}) async {
    await (update(dreamPlaces)..where((t) => t.id.equals(id)))
        .write(DreamPlacesCompanion(isFavorited: Value(isFavourite)));
  }

  Future<void> seedIfEmpty() async {
    final count = await (select(dreamPlaces)..limit(1)).get();
    if (count.isEmpty) {
      final places = <DreamPlacesCompanion>[
        DreamPlacesCompanion.insert(
          name: "Santorini, Grecja",
          description: "Białe domki nad Morzem Egejskim.",
          imageUrl: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        ),
        DreamPlacesCompanion.insert(
          name: "Kioto, Japonia",
          description: "Świątynie, ogrody i tradycja.",
          imageUrl: "https://images.unsplash.com/photo-1542051841857-5f90071e7989",
        ),
        DreamPlacesCompanion.insert(
          name: "Majorka, Hiszpania",
          description: "Plaże, góry i urokliwe miasteczka.",
          imageUrl: "https://images.unsplash.com/photo-1500375592092-40eb2168fd21",
        ),
      ];

      await batch((b) => b.insertAll(dreamPlaces, places));
    }
  }
}
