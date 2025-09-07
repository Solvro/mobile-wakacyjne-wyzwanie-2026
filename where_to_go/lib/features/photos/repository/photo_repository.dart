import "dart:io";

abstract class PhotoRepository {
  Future<String> uploadImage(File image);
  Future<File> downloadImage(String name);
}
