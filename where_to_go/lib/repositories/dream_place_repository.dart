// lib/repositories/dream_place_repository.dart
import "dart:io";
import "package:dio/dio.dart";

import "../models/dream_place.dart";
import "../models/photo.dart";
import "photos_repository.dart";

class DreamPlaceRepository {
  final Dio _dio;
  final PhotosRepository _photosRepo;

  DreamPlaceRepository({
    required Dio dio,
    required PhotosRepository photosRepo,
  })  : _dio = dio,
        _photosRepo = photosRepo;

  /// 🔹 Dodawanie miejsca ze zdjęciem
  Future<DreamPlace> createDreamPlaceWithPhoto({
    required File file,
    required String name,
    required String description,
    required bool isFavorite,
  }) async {
    final photo = (await _photosRepo.uploadPhoto(file)) as Photo;

    final response = await _dio.post<Map<String, dynamic>>(
      "/places",
      data: {
        "name": name,
        "description": description,
        "imageUrl": photo.path, // serwer zwraca `path` jako URL
        "isFavorite": isFavorite,
      },
    );

    if ((response.statusCode == 201 || response.statusCode == 200) && response.data != null) {
      return DreamPlace.fromJson(response.data!);
    } else {
      throw Exception("Nie udało się stworzyć miejsca (${response.statusCode})");
    }
  }

  // Pobierz wszystkie miejsca
  Future<List<DreamPlace>> fetchDreamPlaces() async {
    final response = await _dio.get<List<dynamic>>("/places");

    if (response.statusCode == 200 && response.data != null) {
      return response.data!.map((e) => DreamPlace.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Błąd podczas pobierania miejsc (${response.statusCode})");
    }
  }

  // Pobierz jedno miejsce po ID
  Future<DreamPlace> fetchDreamPlace(int id) async {
    final response = await _dio.get<Map<String, dynamic>>("/places/$id");

    if (response.statusCode == 200 && response.data != null) {
      return DreamPlace.fromJson(response.data!);
    } else {
      throw Exception("Nie udało się pobrać miejsca o id=$id (${response.statusCode})");
    }
  }

  // Aktualizacja miejsca
  Future<void> updateDreamPlace(DreamPlace place) async {
    if (place.id == null) {
      throw Exception("Cannot update place without id");
    }

    final response = await _dio.put<Map<String, dynamic>>(
      "/places/${place.id}",
      data: {
        "name": place.name,
        "description": place.description,
        "imageUrl": place.imageUrl,
        "isFavorite": place.isFavorite,
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update dream place");
    }
  }

  // Usunięcie miejsca
  Future<void> deleteDreamPlace(int id) async {
    final response = await _dio.delete<Map<String, dynamic>>("/places/$id");

    if (response.statusCode != 200) {
      throw Exception("Failed to delete dream place");
    }
  }
}
