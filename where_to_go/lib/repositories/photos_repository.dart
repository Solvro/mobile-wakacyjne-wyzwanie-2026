// lib/repositories/photos_repository.dart
import "dart:convert";
import "dart:io";
import "package:http/http.dart" as http;
import "package:http_parser/http_parser.dart";
import "package:mime/mime.dart";

import "../models/photo.dart";

class PhotosRepository {
  final String apiUrl; // https://backend-api.w.solvro.pl

  PhotosRepository({required this.apiUrl});

  /// 🔹 Upload zdjęcia i zwróć Photo (z path i url)
  Future<Photo> uploadPhoto(File file) async {
    final mimeType = lookupMimeType(file.path) ?? "image/jpeg";
    final mediaType = MediaType.parse(mimeType);

    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$apiUrl/photos/upload"),
    );

    request.files.add(await http.MultipartFile.fromPath(
      "file",
      file.path,
      contentType: mediaType,
    ));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      final data = json.decode(responseBody) as Map<String, dynamic>;
      return Photo.fromJson(data);
    } else {
      throw Exception(
        "Upload zdjęcia nie powiódł się (${response.statusCode}): $responseBody",
      );
    }
  }

  /// 🔹 Pobierz listę wszystkich zdjęć jako pełne URL-e
  Future<List<String>> fetchPhotos() async {
    final response = await http.get(Uri.parse("$apiUrl/photos"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      // API zwraca same nazwy plików, np. ["xxx.jpg", "yyy.png"]
      return data.map((f) => "$apiUrl/photos/$f").toList();
    } else {
      throw Exception(
        "Nie udało się pobrać zdjęć (${response.statusCode}): ${response.body}",
      );
    }
  }
}
