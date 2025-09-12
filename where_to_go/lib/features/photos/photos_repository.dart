import "dart:io";
import "package:dio/dio.dart";
import "package:logger/logger.dart";

class PhotosRepository {
  final Dio _dio;
  final _logger = Logger();

  PhotosRepository(this._dio);

  Future<String> uploadPhoto(File file) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      "/photos/upload",
      data: formData,
      options: Options(
        contentType: "multipart/form-data",
        headers: {
          "Accept": "application/json",
        },
      ),
    );

    _logger.d("Status: ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      _logger.d("Odpowiedź serwera: $data");

      if (data != null && data.containsKey("filename")) {
        final filename = data["filename"] as String;
        return filename;
      } else {
        throw Exception("Brak pola 'filename' w odpowiedzi serwera");
      }
    } else {
      throw Exception("Nie udało się przesłać zdjęcia: ${response.statusCode}");
    }
  }
}
