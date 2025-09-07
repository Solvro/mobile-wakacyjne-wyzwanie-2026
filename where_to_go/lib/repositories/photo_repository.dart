// lib/repositories/photos_repository.dart
import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;

import "../models/photo.dart";

class PhotosRepository {
  final String apiUrl;

  PhotosRepository({required this.apiUrl});

  Future<Photo> uploadPhoto(File file) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$apiUrl/photos/upload"),
    );

    request.files.add(await http.MultipartFile.fromPath("file", file.path));

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody) as Map<String, dynamic>;
      return Photo.fromJson(data);
    } else {
      throw Exception("Upload zdjęcia nie powiódł się (${response.statusCode})");
    }
  }
}
