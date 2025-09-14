// lib/providers/dream_places_provider.dart
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../models/dream_place.dart";
import "../repositories/dream_place_repository.dart";
import "../service/dream_place_service.dart";
import "auth_providers.dart";
import "photos_providers.dart";

// Provider repozytorium DreamPlace (CRUD miejsc)
final dreamPlaceRepositoryProvider = Provider<DreamPlaceRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return DreamPlaceRepository(dio: dio);
});

// Provider serwisu DreamPlace (upload + tworzenie miejsca)
final dreamPlaceServiceProvider = Provider<DreamPlaceService>((ref) {
  final placesRepo = ref.watch(dreamPlaceRepositoryProvider);
  final photosRepo = ref.watch(photosRepositoryProvider);
  return DreamPlaceService(placesRepo: placesRepo, photosRepo: photosRepo);
});

// Provider do listy miejsc
final dreamPlacesProvider = FutureProvider.autoDispose<List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlaceRepositoryProvider);
  final sortEnabled = ref.watch(sortEnabledProvider);
  final ascending = ref.watch(ascendingOnlyProvider);

  if (sortEnabled) {
    return repo.fetchDreamPlaceWithSorting(
      ascending: ascending,
      sortBy: "id",
    );
  } else {
    return repo.fetchDreamPlaces();
  }
});

// Provider do pojedynczego miejsca
final dreamPlaceProvider = FutureProvider.family<DreamPlace, int>((ref, id) {
  final repo = ref.watch(dreamPlaceRepositoryProvider);
  return repo.fetchDreamPlace(id);
});

// Toggle dla ulubionych
final showFavoritesOnlyProvider = StateProvider<bool>((ref) => false);

// Toggle dla kierunku sortowania
final ascendingOnlyProvider = StateProvider<bool>((ref) => false);

// Toggle włączania sortowania
final sortEnabledProvider = StateProvider<bool>((ref) => false);
