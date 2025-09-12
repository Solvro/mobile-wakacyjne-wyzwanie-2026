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
    print("Downloading & uploading photo from URL...");

    await photosRepository.uploadPhotoFromUrl(photoUrl);

    final placeWithPhoto = place.copyWith(
      imageUrl: photoUrl,
    );

    print("Creating place: ${placeWithPhoto.toJson()}");

    final PlaceModel createdPlace = await dreamPlaceRepository.addPlace(placeWithPhoto);

    return createdPlace;
  } catch (e) {
    print("DreamPlaceService error: $e");
    throw Exception("Failed to create place with photo URL: $e");
  }
}

}
