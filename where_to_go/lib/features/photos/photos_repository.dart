import "dart:io";
import "package:dio/dio.dart";

class PhotosRepository {
  final Dio _dio;

  PhotosRepository(this._dio);

  Future<String> uploadPhoto(File file) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      "/photos",
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      if (data != null && data.containsKey("url")) {
        return data["url"] as String;
      } else {
        throw Exception("Brak URL w odpowiedzi serwera");
      }
    } else {
      throw Exception("Nie udało się przesłać zdjęcia: ${response.statusCode}");
    }
  }
}
