import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../db/database.dart";
import "place_repository.dart";

part "places_provider.g.dart";

@riverpod
Stream<List<DreamPlace>> places(Ref ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.watchAll();
}

@riverpod
Stream<DreamPlace?> placeById(Ref ref, int id) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.watchById(id);
}
