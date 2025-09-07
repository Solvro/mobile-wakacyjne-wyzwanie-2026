import "package:flutter_riverpod/flutter_riverpod.dart";

import "../models/dream_place.dart";
import "../providers/auth_providers.dart";
import "../repositories/dream_place_repository.dart";

/// Provider repozytorium DreamPlace
final dreamPlaceRepositoryProvider = Provider<DreamPlaceRepository>((ref) {
  final dio = ref.watch(baseDioProvider);
  return DreamPlaceRepository(apiUrl: dio.options.baseUrl);
});

/// Provider do listy miejsc marzeń
final dreamPlacesProvider = FutureProvider<List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlaceRepositoryProvider);
  return repo.fetchDreamPlaces();
});
