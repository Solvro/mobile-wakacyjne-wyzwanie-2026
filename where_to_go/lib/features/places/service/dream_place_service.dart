import "dart:io";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../app/remote/repository/dream_place_repository_impl.dart";
import "../../../app/remote/repository/photo_repository_impl.dart";
import "../../../data/models/create_place_dto.dart";
import "../../../data/models/dream_place.dart";
import "../providers/filter_providers.dart";

part "dream_place_service.g.dart";

@riverpod
class DreamPlaceService extends _$DreamPlaceService {
  bool _showOnlyFavourites = false;

  bool get isShowingOnlyFavourites => _showOnlyFavourites;

  @override
  Future<List<DreamPlace>> build() async {
    final repo = await ref.watch(dreamPlaceRepositoryProvider.future);
    final allPlaces = await repo.getAll();
    if (_showOnlyFavourites) {
      return allPlaces.where((p) => p.isFavourite).toList();
    } else {
      return allPlaces;
    }
  }

  Future<void> toggleFilter() async {
    _showOnlyFavourites = !_showOnlyFavourites;
    final repo = await ref.read(dreamPlaceRepositoryProvider.future);
    final allPlaces = await repo.getAll();
    final filtered = _showOnlyFavourites ? allPlaces.where((p) => p.isFavourite).toList() : allPlaces;
    state = AsyncValue.data(filtered);
  }

  Future<void> toggleFavorite(int id) async {
    final currentState = await future;
    final place = currentState.firstWhere((p) => p.id == id);
    final repo = await ref.read(dreamPlaceRepositoryProvider.future);
    final updated = await repo.toggleFavorite(id, newValue: !place.isFavourite);
    final newList = currentState.map((place) => (place.id == updated.id) ? updated : place).toList();
    final filtered = _showOnlyFavourites ? newList.where((p) => p.isFavourite).toList() : newList;
    state = AsyncValue.data(filtered);
  }

  Future<DreamPlace> createDreamPlaceWithPhoto(CreatePlaceDTO place, File file) async {
    final placeRepo = await ref.read(dreamPlaceRepositoryProvider.future);
    final photoRepo = await ref.read(photoRepositoryProvider.future);
    final path = await photoRepo.uploadImage(file);
    final newPlace = await placeRepo.save(
      name: place.name!,
      description: place.description!,
      imageUrl: path,
      isFavourite: place.isFavourite!,
    );

    final updatedList = await placeRepo.getAll();
    final filtered = _showOnlyFavourites ? updatedList.where((p) => p.isFavourite).toList() : updatedList;
    state = AsyncData(filtered);
    return newPlace;
  }

  Future<void> deleteDreamPlace(int id) async {
    final placeRepo = await ref.read(dreamPlaceRepositoryProvider.future);
    await placeRepo.delete(id);
    final updatedList = await placeRepo.getAll();
    final filtered = _showOnlyFavourites ? updatedList.where((p) => p.isFavourite).toList() : updatedList;
    state = AsyncData(filtered);
  }
}

@riverpod
DreamPlace? placeById(Ref ref, int id) {
  final placesAsync = ref.watch(dreamPlaceServiceProvider);
  return placesAsync.whenData((places) => places.firstWhere((p) => p.id == id)).value;
}

@riverpod
Future<List<DreamPlace>> filteredPlaces(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  final allPlacesAsync = await ref.watch(dreamPlaceServiceProvider.future);

  if (query.trim().isEmpty) return allPlacesAsync;

  final lowerQuery = query.toLowerCase();

  return allPlacesAsync.where((place) => place.name.toLowerCase().contains(lowerQuery)).toList();
}
