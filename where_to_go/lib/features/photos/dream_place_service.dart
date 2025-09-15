import "dart:io";
import "../database/dream_place_repository.dart";
import "../models/dream_place.dart";
import "photos_repository.dart";

class DreamPlaceService {
  final PhotosRepository photosRepository;
  final DreamPlacesRepository dreamPlacesRepository;

  DreamPlaceService({
    required this.photosRepository,
    required this.dreamPlacesRepository,
  });

  Future<DreamPlace> createDreamPlaceWithPhoto({
    required String name,
    required String description,
    required File photo,
  }) async {
    final imageUrl = await photosRepository.uploadPhoto(photo);

    final newPlace = DreamPlace(
      name: name,
      description: description,
      imageUrl: imageUrl,
    );

    return dreamPlacesRepository.addPlace(newPlace);
  }

  Future<DreamPlace> updateDreamPlaceWithPhoto({
    required int id,
    required String name,
    required String description,
    File? photo,
    required String currentImageUrl,
    required bool isFavourite,
  }) async {
    var imageUrl = currentImageUrl;
    if (photo != null) {
      imageUrl = await photosRepository.uploadPhoto(photo);
    }

    final updatedPlace = DreamPlace(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      isFavourite: isFavourite,
    );

    return dreamPlacesRepository.updatePlace(updatedPlace);
  }
}
