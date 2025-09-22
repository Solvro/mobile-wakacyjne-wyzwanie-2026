import "package:drift/drift.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../db/database.dart";
import "../../db/database_provider.dart";

part "place_repository.g.dart";

abstract interface class DreamPlacesRepository {
  Stream<List<DreamPlace>> watchAll();
  Stream<DreamPlace?> watchById(int id);

  Future<List<DreamPlace>> getAll();
  Future<DreamPlace?> getById(int id);
  Future<int> create({
    required String name,
    required String description,
    required String imageUrl,
    bool isFavorited,
  });
  Future<bool> update(DreamPlace place);
  Future<int> delete(int id);
  Future<void> toggleFavorite(int id, {required bool isFavorite});
}

class DriftDreamPlacesRepository implements DreamPlacesRepository {
  DriftDreamPlacesRepository(this._db);
  final Database _db;

  @override
  Stream<List<DreamPlace>> watchAll() => _db.select(_db.dreamPlaces).watch();

  @override
  Stream<DreamPlace?> watchById(int id) =>
      (_db.select(_db.dreamPlaces)..where((t) => t.id.equals(id))).watchSingleOrNull();

  @override
  Future<List<DreamPlace>> getAll() => _db.getAllDreamPlaces();

  @override
  Future<DreamPlace?> getById(int id) => _db.getDreamPlaceById(id);

  @override
  Future<int> create({
    required String name,
    required String description,
    required String imageUrl,
    bool isFavorited = false,
  }) async {
    final companion = DreamPlacesCompanion.insert(
      name: name,
      description: description,
      imageUrl: imageUrl,
      isFavorited: Value(isFavorited),
    );
    return _db.insertDreamPlace(companion);
  }

  @override
  Future<bool> update(DreamPlace place) => _db.updateDreamPlace(place);

  @override
  Future<int> delete(int id) => _db.deleteDreamPlace(id);

  @override
  Future<void> toggleFavorite(int id, {required bool isFavorite}) => _db.toggleFavourite(id, isFavourite: isFavorite);
}

@riverpod
DreamPlacesRepository dreamPlacesRepository(Ref ref) {
  final db = ref.watch(databaseProvider).value!;
  return DriftDreamPlacesRepository(db);
}
