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
    
    if (response.data == null) {
      return <PlaceModel>[];
    }
    
    final placesData = response.data!["places"];
    if (placesData == null) {
      return <PlaceModel>[];
    }
    
    final placesList = placesData as List<dynamic>? ?? <dynamic>[];
    
    return placesList
        .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PlaceModel> getPlace(int id) async {
    final response = await apiClient.dio.get<Map<String, dynamic>>("/places/$id");
    return PlaceModel.fromJson(response.data!);
  }

  Future<PlaceModel> updatePlace(PlaceModel place) async {
    final response = await apiClient.dio.put<Map<String, dynamic>>("/places/${place.id}", data: place.toJson());
    return PlaceModel.fromJson(response.data!);
  }

  Future<PlaceModel> updateIsFavorite(int id, {required bool isFavorite}) async {
    final response = await apiClient.dio.patch<Map<String, dynamic>>("/places/$id", data: {"isFavorite": isFavorite});
    return PlaceModel.fromJson(response.data!);
  }

  Future<void> deletePlace(int id) async {
    await apiClient.dio.delete<Map<String, dynamic>>("/places/$id");
  }
}
