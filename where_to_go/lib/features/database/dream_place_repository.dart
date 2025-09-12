import "package:dio/dio.dart";
import "package:logger/logger.dart";
import "../models/dream_place.dart";

final logger = Logger();

class DreamPlacesRepository {
  final Dio _dio;

  DreamPlacesRepository(this._dio);

  Future<List<DreamPlace>> getAllPlaces() async {
    final response = await _dio.get<Map<String, dynamic>>("/places");
    final data = response.data?["items"] as List<dynamic>? ?? [];
    final places = data.map((e) => DreamPlace.fromJson(e as Map<String, dynamic>)).toList();
    return places;
  }

  Future<DreamPlace> getPlace(String id) async {
    final response = await _dio.get<Map<String, dynamic>>("/places/$id");
    final data = response.data;
    if (data == null) {
      throw Exception("Brak danych z API");
    }
    final placeJson = data["item"] ?? data;
    return DreamPlace.fromJson(placeJson as Map<String, dynamic>);
  }

  Future<DreamPlace> addPlace(DreamPlace place) async {
    final response = await _dio.post<Map<String, dynamic>>(
      "/places",
      data: place.toJson(),
    );

    logger.d("Odpowiedź serwera (addPlace): ${response.data}");

    return DreamPlace.fromJson(response.data!);
  }

  Future<DreamPlace> updatePlace(DreamPlace place) async {
    final response = await _dio.put<Map<String, dynamic>>(
      "/places/${place.id}",
      data: place.toJson(),
    );
    return DreamPlace.fromJson(response.data!);
  }

  Future<void> deletePlace(String id) async {
    await _dio.delete<void>("/places/$id");
  }

  Future<void> toggleFavourite(DreamPlace place) async {
    final updatedPlace = place.copyWith(isFavourite: !place.isFavourite);
    await updatePlace(updatedPlace);
  }
}
