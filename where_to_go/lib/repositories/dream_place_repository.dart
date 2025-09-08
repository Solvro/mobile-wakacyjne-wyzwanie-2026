//lib/repositories/dream_place_repository.dart
import "package:dio/dio.dart";

import "../models/dream_place.dart";

class DreamPlaceRepository {
  final Dio _dio;

  DreamPlaceRepository({
    required Dio dio,
  }) : _dio = dio;

  /// 🔹 Dodaj nowe miejsce (ze zdjęciem, jeśli masz już url)
  Future<DreamPlace> createDreamPlace({
    required String name,
    required String description,
    required String imageUrl,
    required bool isFavorite,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      "/places",
      data: {
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "isFavorite": isFavorite,
      },
    );

    if ((response.statusCode == 201 || response.statusCode == 200) && response.data != null) {
      return DreamPlace.fromJson(response.data!);
    } else {
      throw Exception("Nie udało się stworzyć miejsca (${response.statusCode})");
    }
  }

  /// 🔹 Pobierz wszystkie miejsca (z paginacją)
  Future<List<DreamPlace>> fetchDreamPlaces() async {
    final response = await _dio.get<Map<String, dynamic>>("/places");

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data!;
      final items = data["items"] as List<dynamic>? ?? [];
      return items.map((e) => DreamPlace.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception("Błąd podczas pobierania miejsc (${response.statusCode})");
    }
  }

  /// 🔹 Pobierz pojedyncze miejsce
  Future<DreamPlace> fetchDreamPlace(int id) async {
    final response = await _dio.get<Map<String, dynamic>>("/places/$id");

    if (response.statusCode == 200 && response.data != null) {
      return DreamPlace.fromJson(response.data!);
    } else {
      throw Exception("Nie udało się pobrać miejsca ($id)");
    }
  }

  /// 🔹 Aktualizuj istniejące miejsce
  Future<DreamPlace> updateDreamPlace(DreamPlace place) async {
    if (place.id == null) {
      throw Exception("Nie można zaktualizować miejsca bez ID");
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

    if (response.statusCode == 200 && response.data != null) {
      return DreamPlace.fromJson(response.data!);
    } else {
      throw Exception("Nie udało się zaktualizować miejsca (${place.id})");
    }
  }

  /// 🔹 Usuń miejsce
  Future<void> deleteDreamPlace(int id) async {
    final response = await _dio.delete<void>("/places/$id");

    if (response.statusCode != 204) {
      throw Exception("Nie udało się usunąć miejsca ($id)");
    }
  }
}
