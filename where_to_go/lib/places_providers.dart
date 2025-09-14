import "dart:typed_data";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "dio_provider.dart";
import "models/dream_place.dart";
import "places_repository.dart";

part "places_providers.g.dart";

// DreamPlaces
@riverpod
PlacesRepository repository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return PlacesRepository(dio);
}

@riverpod
class AllPlaces extends _$AllPlaces {
  @override
  FutureOr<List<DreamPlace>> build() async {
    final repo = ref.watch(repositoryProvider);
    return repo.getAllPlaces();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(repositoryProvider);
      return repo.getAllPlaces();
    });
  }
}

@riverpod
class FavoritePlaces extends _$FavoritePlaces {
  @override
  FutureOr<List<DreamPlace>> build() async {
    final repo = ref.read(repositoryProvider);
    final all = await repo.getAllPlaces();
    return all.where((p) => p.isFavourite).toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(repositoryProvider);
      final all = await repo.getAllPlaces();
      return all.where((p) => p.isFavourite).toList();
    });
  }
}

@riverpod
class PlaceDetails extends _$PlaceDetails {
  @override
  FutureOr<DreamPlace> build(int id) async {
    final repo = ref.read(repositoryProvider);
    final place = await repo.getPlaceById(id);

    if (place == null) {
      throw Exception("Place with id=$id not found");
    }

    return place;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(repositoryProvider);
      final place = await repo.getPlaceById(id);
      if (place == null) {
        throw Exception("Place with id=$id not found");
      }
      return place;
    });
  }
}

@riverpod
Future<Uint8List> photo(Ref ref, String filename) async {
  final repo = ref.read(repositoryProvider);
  return repo.getPhoto(filename);
}

void invalidateProviders(WidgetRef ref, int id) {
  ref.invalidate(placeDetailsProvider(id));
  ref.invalidate(allPlacesProvider);
  ref.invalidate(favoritePlacesProvider);
}

/*// InfoColumns
@riverpod
Stream<List<InfoColumn>> infoColumnsStream(Ref ref, int dreamPlaceId) {
  final repo = ref.watch(repositoryProvider);
  return repo.watchInfoColumnsByPlaceId(dreamPlaceId);
}

@riverpod
Future<List<InfoColumn>> infoColumns(Ref ref, int dreamPlaceId) async {
  final repo = ref.watch(repositoryProvider);
  return repo.getInfoColumnsByPlaceId(dreamPlaceId);
}*/
