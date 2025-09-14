import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../database/dream_place_provider.dart";
import "../models/dream_place.dart";
import "search_query_provider.dart";
import "show_favorites_only_provider.dart";

part "filtered_dream_places_provider.g.dart";

@riverpod
List<DreamPlace> filteredDreamPlaces(Ref ref) {
  final placesAsync = ref.watch(dreamPlacesProvider);
  final showFavoritesOnly = ref.watch(showFavoritesOnlyProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  return placesAsync.when(
    data: (places) {
      var filteredPlaces = places;

      if (showFavoritesOnly) {
        filteredPlaces = places.where((place) => place.isFavourite).toList();
      }

      if (searchQuery.isNotEmpty) {
        filteredPlaces = filteredPlaces
            .where((place) =>
                place.name.toLowerCase().contains(searchQuery) || place.description.toLowerCase().contains(searchQuery))
            .toList();
      }
      return filteredPlaces;
    },
    loading: () => [],
    error: (_, __) => [],
  );
}
