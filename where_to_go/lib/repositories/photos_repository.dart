// lib/repositories/photos_repository.dart
import "dart:io";
import "package:dio/dio.dart";

class PhotoUploadResponse {
  final String id;
  final String filename;
  final String originalName;
  final String mimeType;
  final int size;
  final String path;
  final DateTime createdAt;

  PhotoUploadResponse({
    required this.id,
    required this.filename,
    required this.originalName,
    required this.mimeType,
    required this.size,
    required this.path,
    required this.createdAt,
  });

  factory PhotoUploadResponse.fromJson(Map<String, dynamic> json) {
    return PhotoUploadResponse(
      id: json["id"] as String,
      filename: json["filename"] as String,
      originalName: json["originalName"] as String,
      mimeType: json["mimeType"] as String,
      size: json["size"] as int,
      path: json["path"] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
    );
  }

  @override
  String toString() {
    return "PhotoUploadResponse(id: $id, path: $path, size: $size bytes)";
  }
}

abstract class IPhotosRepository {
  Future<PhotoUploadResponse> uploadPhoto(File imageFile);
}

class PhotosRepository implements IPhotosRepository {
  final Dio _dio;
  final String _baseUrl;

  PhotosRepository({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  @override
  Future<PhotoUploadResponse> uploadPhoto(File imageFile) async {
    try {
      if (!imageFile.existsSync()) {
        throw Exception("Plik nie istnieje: ${imageFile.path}");
      }
      final fileLength = imageFile.lengthSync();

      // Limit 15MB
      if (fileLength > 15 * 1024 * 1024) {
        throw Exception("Plik jest zbyt duży: ${fileLength ~/ 1024 ~/ 1024}MB");
      }

      final String originalName = imageFile.path.split("/").last;

      final multipartFile = await MultipartFile.fromFile(
        imageFile.path,
        filename: originalName,
      );

      final formData = FormData.fromMap({
        "file": multipartFile,
      });

      final response = await _dio.post<Map<String, dynamic>>(
        "$_baseUrl/photos/upload",
        data: formData,
      );

      if (response.statusCode == 201) {
        final data = response.data!;
        return PhotoUploadResponse.fromJson(data);
      } else {
        throw Exception("Nieoczekiwany status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        throw Exception("Błąd uploadu (${e.response!.statusCode}): $errorData");
      } else {
        throw Exception("Błąd sieci: ${e.message}");
      }
    } catch (e) {
      throw Exception("Nieoczekiwany błąd: $e");
    }
  }
}
