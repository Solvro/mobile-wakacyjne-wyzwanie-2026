import "features/places/place_model.dart";
import "features/table/dream_place_repository.dart";
import "photo_model.dart";
import "photos_repository.dart";

class DreamPlaceService {
  final DreamPlaceRepository dreamPlaceRepository;
  final PhotosRepository photosRepository;

  DreamPlaceService(this.dreamPlaceRepository, this.photosRepository);

  Future<PlaceModel> createDreamPlaceWithPhotoUrl({
    required PlaceModel place,
    required String photoUrl,
  }) async {
    try {
      final PhotoModel uploadedPhoto = await photosRepository.uploadPhotoFromUrl(photoUrl);

      final placeWithPhoto = place.copyWith(imageUrl: uploadedPhoto.fileName);

      final PlaceModel createdPlace = await dreamPlaceRepository.addPlace(placeWithPhoto);

      final fullImageUrl = dreamPlaceRepository.buildImageUrl(createdPlace.imageUrl);

      return createdPlace.copyWith(imageUrl: fullImageUrl);
    } catch (e) {
      throw Exception("Failed to create place with photo URL: $e");
    }
  }
}
