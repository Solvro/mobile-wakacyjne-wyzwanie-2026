import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../database/dream_place_provider.dart";
import "../models/dream_place.dart";
import "show_favorites_only_provider.dart";

part "filtered_dream_places_provider.g.dart";

@riverpod
List<DreamPlace> filteredDreamPlaces(Ref ref) {
  final placesAsync = ref.watch(dreamPlacesProvider);
  final showFavoritesOnly = ref.watch(showFavoritesOnlyProvider);

  return placesAsync.when(
    data: (places) {
      if (showFavoritesOnly) {
        return places.where((place) => place.isFavourite).toList();
      }
      return places;
    },
    loading: () => [],
    error: (_, __) => [],
  );
}
