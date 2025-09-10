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
      id: "",
      name: name,
      description: description,
      imageUrl: imageUrl,
    );

    return dreamPlacesRepository.addPlace(newPlace);
  }
}
