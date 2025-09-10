import "package:dio/dio.dart";
import "../models/dream_place.dart";

class DreamPlacesRepository {
  final Dio _dio;

  DreamPlacesRepository(this._dio);

  Future<List<DreamPlace>> getAllPlaces() async {
    final response = await _dio.get<List<dynamic>>("/places");
    return response.data!.map((json) => DreamPlace.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<DreamPlace> getPlace(String id) async {
    final response = await _dio.get<Map<String, dynamic>>("/places/$id");
    return DreamPlace.fromJson(response.data!);
  }

  Future<DreamPlace> addPlace(DreamPlace place) async {
    final response = await _dio.post<Map<String, dynamic>>(
      "/places",
      data: place.toJson(),
    );
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
