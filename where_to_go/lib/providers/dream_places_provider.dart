// lib/providers/dream_places_provider.dart
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../models/dream_place.dart";
import "../repositories/dream_place_repository.dart";
import "auth_providers.dart";
import "photos_providers.dart";

/// Provider repozytorium DreamPlace
final dreamPlaceRepositoryProvider = Provider<DreamPlaceRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final photosRepo = ref.watch(photosRepositoryProvider);
  return DreamPlaceRepository(dio: dio, photosRepo: photosRepo);
});

/// Provider do listy miejsc
final dreamPlacesProvider = FutureProvider<List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlaceRepositoryProvider);
  return repo.fetchDreamPlaces();
});

/// Provider do pojedynczego miejsca
final dreamPlaceProvider = FutureProvider.family<DreamPlace, int>((ref, id) {
  final repo = ref.watch(dreamPlaceRepositoryProvider);
  return repo.fetchDreamPlace(id);
});
