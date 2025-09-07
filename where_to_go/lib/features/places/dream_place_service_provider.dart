import "dart:io";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../models/place/place_create_without_owner_input_dto.dart";
import "../../models/place/place_response_dto.dart";
import "../auth/auth_provider.dart";
import "../photos/photos_repository_provider.dart";
import "place_repository_provider.dart";

part "dream_place_service_provider.g.dart";

@riverpod
class DreamPlaceService extends _$DreamPlaceService {
  @override
  Future<List<PlaceResponseDto>> build() async {
    final isLoggedIn = await ref.watch(authNotifierProvider.future);
    if (isLoggedIn == null) return [];

    final repository = await ref.watch(dreamPlacesRepositoryProvider.future);

    return repository.readAll();
  }

  Future<void> toggleFavorite(String id) async {
    final repository = await ref.read(dreamPlacesRepositoryProvider.future);
    await repository.toggleFavorite(id);

    ref.invalidateSelf();
    ref.invalidate(placeProvider(id));
  }

  Future<void> createPlace(
      {required String name, required String description, required String imageUrl, required bool isFavorite}) async {
    final repository = await ref.read(dreamPlacesRepositoryProvider.future);
    await repository.create(PlaceCreateWithoutOwnerInputDto(
        name: name, description: description, imageUrl: imageUrl, isFavourite: isFavorite));

    ref.invalidateSelf();
  }

  Future<void> deletePlace(String id) async {
    final repository = await ref.read(dreamPlacesRepositoryProvider.future);
    await repository.delete(id);

    ref.invalidateSelf();
  }

  Future<void> createDreamPlaceWithPhoto(PlaceCreateWithoutOwnerInputDto newPlace, File image) async {
    try {
      final placeRepository = await ref.read(dreamPlacesRepositoryProvider.future);
      final photoRepository = await ref.read(photosRepositoryProvider.future);
      final imageUrl = await photoRepository.uploadPhoto(image);
      await placeRepository.create(newPlace.copyWith(imageUrl: imageUrl));

      state = AsyncData(await placeRepository.readAll());

      ref.invalidateSelf();
    } on Exception catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
Future<PlaceResponseDto> place(Ref ref, String id) async {
  final repository = await ref.watch(dreamPlacesRepositoryProvider.future);

  return repository.read(id);
}
