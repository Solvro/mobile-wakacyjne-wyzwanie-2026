import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:where_to_go/features/places/place.dart';
import 'package:where_to_go/features/places/places_repository.dart';

import '../auth/auth_providers.dart';

part "places_provider.g.dart";

final placesRepositoryProvider = Provider((ref) => PlacesRepository(ref.read(dioProvider)));

@riverpod
class Places extends _$Places {
  @override
  Future<List<Place>> build() async {
    final places = initPlaces();
    return places;
  }

  Future<List<Place>> initPlaces() async {
    try {
      final initialPlaces = await ref
          .read(placesRepositoryProvider)
          .initializePlaces();
      return initialPlaces;
    } catch(e) {
      rethrow;
    }
  }

  Future<void> toggleFavourite(Place place) async {
    final currentPlaces = state.value;
    if(currentPlaces == null) return;
    try{
      await ref.read(placesRepositoryProvider).updateFavourite(place);
      state = AsyncData([
        for(final statePlace in currentPlaces)
          if(statePlace.id == place.id) statePlace.copyWith(isFavourite: !statePlace.isFavourite)
          else statePlace
      ]);

    } catch(e) {
      rethrow;
    }
  }
}