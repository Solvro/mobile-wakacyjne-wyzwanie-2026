import "package:drift/drift.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../services/database.dart";
import "../../../services/database_provider.dart";
import "../place.dart";

part "places_repository.g.dart";

@riverpod
PlacesRepository placesRepository(Ref ref) {
  final database = ref.watch(databaseProvider);
  return PlacesRepository(database: database);
}

class PlacesRepository {
  AppDatabase database;

  PlacesRepository({required this.database});

  Place _convertToPlace(DreamPlace row) {
    return Place(
      id: row.id,
      title: row.name,
      description: row.description,
      photo: row.photoUrl,
      isFavorite: row.isFavorite,
    );
  }

  Future<Iterable<Place>> getAll() async {
    final rows = await database.select(database.dreamPlaces).get();

    return rows.map(_convertToPlace);
  }

  Future<Place> getById(int id) async {
    final row = await (database.select(database.dreamPlaces)
          ..where((tbl) => tbl.id.equals(id))
          ..limit(1))
        .getSingle();

    return _convertToPlace(row);
  }

  Future<void> update(Place place) async {
    await (database.update(database.dreamPlaces)..where((tbl) => tbl.id.equals(place.id))).write(
      DreamPlacesCompanion(
        name: Value(place.title),
        description: Value(place.description),
        photoUrl: Value(place.photo),
        isFavorite: Value(place.isFavorite),
      ),
    );
  }

  Future<Place> create(Place place) async {
    final id = await database.into(database.dreamPlaces).insert(
          DreamPlacesCompanion(
            name: Value(place.title),
            description: Value(place.description),
            photoUrl: Value(place.photo),
            isFavorite: Value(place.isFavorite),
          ),
        );

    return getById(id);
  }

  Future<void> delete(int id) async {
    await (database.delete(database.dreamPlaces)..where((tbl) => tbl.id.equals(id))).go();
  }
}
