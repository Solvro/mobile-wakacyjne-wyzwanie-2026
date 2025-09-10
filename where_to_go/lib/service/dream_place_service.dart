// lib/service/dream_place_service.dart
import "dart:io";

import "../models/dream_place.dart";
import "../repositories/dream_place_repository.dart";
import "../repositories/photos_repository.dart";

class DreamPlaceService {
  final DreamPlaceRepository placesRepo;
  final PhotosRepository photosRepo;

  DreamPlaceService({
    required this.placesRepo,
    required this.photosRepo,
  });

  Future<DreamPlace> createDreamPlaceWithPhoto({
    required File file,
    required String name,
    required String description,
    required bool isFavorite,
  }) async {
    // 1. Upload zdjęcia → dostajemy Photo (z path i url)
    final photo = await photosRepo.uploadPhoto(file);

    await photosRepo.ensurePhotoExists(photo.filename);

    // 2. Utwórz miejsce, podając pełny URL
    return placesRepo.createDreamPlace(
      name: name,
      description: description,
      imageUrl: photo.filename,
      isFavuorite: isFavorite,
    );
  }
}
