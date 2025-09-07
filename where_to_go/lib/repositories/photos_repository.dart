// lib/repositories/photos_repository.dart
import "dart:io";
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../providers/http_client_provider.dart";

class PhotosRepository {
  final Dio _dio;

  PhotosRepository({Dio? dio}) : _dio = dio ?? Dio();

  // Uploduje zdjęcie i zwraca id, filename, size, path (choć ja skorzystam tylko z path)
  Future<String?> uploadPhoto(File imageFile) async {
    try {
      final String filename = imageFile.path.split("/").last;

      final response = await _dio.post(
        "$_baseUrl/photos/upload", // 👈 tu Twój endpoint
        data: FormData.fromMap({
          "photo": await MultipartFile.fromFile(
            imageFile.path,
            filename: filename,
          ),
        }),
        options: Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return data["path"] as String; // Zwraca ścieżkę do zdjęcia
      }
    } on DioException catch (e) {
      throw Exception("Błąd podczas uploadu zdjęcia: ${e.response?.data}");
    }
    return null;
  }
}
