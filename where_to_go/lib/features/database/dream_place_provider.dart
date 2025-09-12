import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../auth/auth_provider.dart";
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
  Future<List<DreamPlace>> build() async {
    // Poczekaj aż auth będzie gotowy
    await ref.watch(authNotifierProvider.future);

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
    state = await AsyncValue.guard(() async {
      final currentPlaces = state.value ?? [];
      return [...currentPlaces, newPlace];
    });
  }

  Future<void> updatePlace(DreamPlace place) async {
    final repo = ref.watch(dreamPlacesRepositoryProvider);
    final updated = await repo.updatePlace(place);
    state = await AsyncValue.guard(() async {
      final currentPlaces = state.value ?? [];
      return currentPlaces.map((p) => p.id == updated.id ? updated : p).toList();
    });
  }

  Future<void> deletePlace(String id) async {
    final repo = ref.watch(dreamPlacesRepositoryProvider);
    await repo.deletePlace(id);
    state = await AsyncValue.guard(() async {
      final currentPlaces = state.value ?? [];
      return currentPlaces.where((p) => p.id != int.parse(id)).toList();
    });
  }

  Future<void> toggleFavourite(String id) async {
    final places = state.value;
    if (places == null) return;

    final intId = int.tryParse(id);
    if (intId == null) return;

    final index = places.indexWhere((p) => p.id == intId);
    if (index == -1) return;

    final place = places[index];
    final updatedPlace = place.copyWith(isFavourite: !place.isFavourite);

    await updatePlace(updatedPlace);
  }
}
