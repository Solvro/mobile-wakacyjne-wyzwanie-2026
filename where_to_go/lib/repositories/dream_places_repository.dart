import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../models/place.dart";
import "../network/dio_provider.dart";

part "dream_places_repository.g.dart";

@riverpod
DreamPlacesRepository dreamPlacesRepository(Ref ref) {
  return DreamPlacesRepository(ref.watch(dioProvider));
}

class DreamPlacesRepository {
  final Dio _dio;

  DreamPlacesRepository(this._dio);

  Future<List<Place>> getAllPlaces() async {
    final response = await _dio.get<Map<String, dynamic>>(
      "/places",
      queryParameters: {
        "sort": "ASC",
        "sortBy": ["id"],
      },
    );

    final data = response.data?["results"] ?? response.data?["items"] ?? response.data?["data"] ?? response.data;
    if (data is List) {
      return data.map((dynamic json) => Place.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<Place> createPlace({
    required String name,
    required String description,
    required String imageUrl,
    bool isFavourite = false,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      "/places",
      data: {"name": name, "description": description, "imageUrl": imageUrl, "isFavourite": isFavourite},
    );
    return Place.fromJson(response.data!);
  }

  Future<void> toggleFavorite(
    int id, {
    required bool currentStatus,
    String? name,
    String? description,
    String? imageUrl,
  }) async {
    final data = <String, dynamic>{"isFavourite": !currentStatus};
    if (name != null) data["name"] = name;
    if (description != null) data["description"] = description;
    if (imageUrl != null) data["imageUrl"] = imageUrl;
    await _dio.put<Map<String, dynamic>>("/places/$id", data: data);
  }
}
