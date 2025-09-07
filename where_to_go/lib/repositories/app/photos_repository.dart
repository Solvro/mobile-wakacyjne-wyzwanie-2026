import "dart:io";

abstract class PhotosRepository {
  Future<String> uploadPhoto(File imageUrl);
}
