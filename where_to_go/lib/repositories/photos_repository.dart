// lib/repositories/photos_repository.dart
import "dart:convert";
import "dart:io";
import "package:http/http.dart" as http;
import "package:http_parser/http_parser.dart";
import "package:mime/mime.dart";

import "../models/photo.dart";

class PhotosRepository {
  final String apiUrl;

  PhotosRepository({required this.apiUrl});

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
}
