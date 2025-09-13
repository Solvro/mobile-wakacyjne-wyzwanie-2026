import "/features/places/place_model.dart";
import "../../authentication/http_client.dart";

class DreamPlaceRepository {
  final ApiClient apiClient;

  DreamPlaceRepository(this.apiClient);

  Future<PlaceModel> addPlace(PlaceModel place) async {
    final response = await apiClient.dio.post<Map<String, dynamic>>(
      "/places",
      data: place.toJson(),
    );
    return PlaceModel.fromJson(response.data!);
  }

  Future<List<PlaceModel>> getAllPlaces() async {
    final response = await apiClient.dio.get<Map<String, dynamic>>("/places");

    final data = response.data;
    if (data == null) return <PlaceModel>[];

    final results = data["results"] as List<dynamic>? ?? <dynamic>[];

    return results.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<PlaceModel> getPlace(int id) async {
    final response = await apiClient.dio.get<Map<String, dynamic>>("/places/$id");
    return PlaceModel.fromJson(response.data!);
  }

  Future<PlaceModel> updateIsFavorite(int id, {required bool isFavorite}) async {
    final response = await apiClient.dio.put<Map<String, dynamic>>(
      "/places/$id",
      data: {"isFavourite": isFavorite},
    );
    return PlaceModel.fromJson(response.data!);
  }

  String buildImageUrl(String filename) {
    if (filename.isEmpty) return "";
    return "${apiClient.dio.options.baseUrl}/photos/$filename";
  }

  Future<void> deletePlace(int id) async {
    await apiClient.dio.delete<Map<String, dynamic>>("/places/$id");
  }
}
