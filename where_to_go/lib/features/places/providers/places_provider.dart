import "package:riverpod_annotation/riverpod_annotation.dart";

import "../place.dart";
import "../repositories/places_repository.dart";

part "places_provider.g.dart";

@riverpod
class Places extends _$Places {
  @override
  Future<Iterable<Place>> build() async {
    return ref.read(placesRepositoryProvider).getAll();
  }

  Future<void> toggleFavorite(int id) async {
    final placesRepository = ref.read(placesRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final place = await placesRepository.getById(id);

      final updatedPlace = place.copyWith(isFavorite: !place.isFavorite);

      await placesRepository.update(updatedPlace);

      return placesRepository.getAll();
    });
  }
}
