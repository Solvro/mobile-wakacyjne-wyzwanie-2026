import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "place.dart";
import "places_database.dart";

part "places_provider.g.dart";

@riverpod
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();

  ref.onDispose(db.close);
  return db;
}

@riverpod
class Places extends _$Places {
  @override
  Stream<List<Place>> build() {
    final db = ref.watch(appDatabaseProvider);

    return db.watchAllPlaces();
  }

  void toggleFavorite(String id) async {
    final db = ref.read(appDatabaseProvider);

    final places = state.value;
    if (places != null) {
      final place = places.firstWhere((p) => p.id == id);

      await db.updateFavorite(id, !place.isFavorite);
    }
  }
}
