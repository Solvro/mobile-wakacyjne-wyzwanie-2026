import "dart:io";

import "package:dio/dio.dart";
import "package:path_provider/path_provider.dart";

import "authentication/http_client.dart";
import "photo_model.dart";

class PhotosRepository {
  final ApiClient _apiClient;

  PhotosRepository(this._apiClient);

  Future<PhotoModel> uploadPhoto(File photo) async {
    try {
      final fileName = photo.path.split("/").last;

      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          photo.path,
          filename: fileName,
        ),
      });

      final response = await _apiClient.dio.post(
        "/photos/upload",
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          sendTimeout: const Duration(minutes: 2),
          receiveTimeout: const Duration(minutes: 2),
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PhotoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception("Failed to upload photo: ${response.statusCode}");
      }
    } catch (e) {
      print("PhotosRepository uploadPhoto error: $e");
      rethrow;
    }
  }

  Future<PhotoModel> uploadPhotoFromUrl(String imageUrl) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

      final response = await Dio().download(imageUrl, filePath);

      if (response.statusCode == 200) {
        final file = File(filePath);
        return await uploadPhoto(file);
      } else {
        throw Exception("Failed to download image: ${response.statusCode}");
      }
    } catch (e) {
      print("uploadPhotoFromUrl error: $e");
      rethrow;
    }
  }
}
