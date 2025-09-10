import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../auth/dio_provider.dart";
import "../models/dream_place.dart";
import "dream_place_repository.dart";

part "dream_place_provider.g.dart";

@riverpod
DreamPlacesRepository dreamPlacesRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return DreamPlacesRepository(dio);
}

@riverpod
class DreamPlaces extends _$DreamPlaces {
  @override
  Future<List<DreamPlace>> build() {
    final repo = ref.watch(dreamPlacesRepositoryProvider);
    return repo.getAllPlaces();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      final repo = ref.watch(dreamPlacesRepositoryProvider);
      return repo.getAllPlaces();
    });
  }

  Future<void> addPlace(DreamPlace place) async {
    final repo = ref.watch(dreamPlacesRepositoryProvider);
    final newPlace = await repo.addPlace(place);
    state.whenData((places) => state = AsyncData([...places, newPlace]));
  }

  Future<void> updatePlace(DreamPlace place) async {
    final repo = ref.watch(dreamPlacesRepositoryProvider);
    final updated = await repo.updatePlace(place);
    state.whenData((places) {
      final updatedList = [for (final p in places) p.id == updated.id ? updated : p];
      state = AsyncData(updatedList);
    });
  }

  Future<void> deletePlace(String id) async {
    final repo = ref.watch(dreamPlacesRepositoryProvider);
    await repo.deletePlace(id);
    state.whenData((places) {
      final updatedList = places.where((p) => p.id != id).toList();
      state = AsyncData(updatedList);
    });
  }

  Future<void> toggleFavourite(String id) async {
    final places = state.value;
    if (places == null) return;

    final index = places.indexWhere((p) => p.id == id);
    if (index == -1) return;

    final place = places[index];
    final updatedPlace = place.copyWith(isFavourite: !place.isFavourite);

    await updatePlace(updatedPlace);
  }
}
