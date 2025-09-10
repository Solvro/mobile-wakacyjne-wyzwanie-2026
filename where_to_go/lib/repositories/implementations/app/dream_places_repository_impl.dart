import "package:dio/dio.dart";

import "../../../models/place/paginated_dto.dart";
import "../../../models/place/place_create_without_owner_input_dto.dart";
import "../../../models/place/place_response_dto.dart";
import "../../../utils/sort_order.dart";
import "../../app/dream_places_repository.dart";

class DreamPlacesRepositoryImpl implements DreamPlacesRepository {
  final Dio _dio;

  DreamPlacesRepositoryImpl(this._dio);

  @override
  Future<void> toggleFavorite(String id) async {
    final placeResponseDto = await read(id);
    final updatedPlace = placeResponseDto.copyWith(isFavourite: !placeResponseDto.isFavourite);

    await _dio.put<Map<String, dynamic>>("/places/$id", data: updatedPlace.toJson());
  }

  @override
  Future<PlaceResponseDto> read(String id) async {
    final response = await _dio.get<Map<String, dynamic>>("/places/$id");

    return PlaceResponseDto.fromJson(response.data!);
  }

  @override
  Future<PlaceResponseDto> create(PlaceCreateWithoutOwnerInputDto newPlace) async {
    final response = await _dio.post<Map<String, dynamic>>("/places", data: newPlace.toJson());

    return PlaceResponseDto.fromJson(response.data!);
  }

  @override
  Future<void> delete(String id) async {
    await _dio.delete<Map<String, dynamic>>("/places/$id");
  }

  @override
  Future<List<PlaceResponseDto>> readAll(SortOrder sortOrder) async {
    final queryParams = {"sort": sortOrder == SortOrder.ascending ? "asc" : "desc", "sortBy": "name"};
    final response = await _dio.get<Map<String, dynamic>>("/places", queryParameters: queryParams);
    final paginatedDto = PaginatedDto.fromJson(response.data!);

    return paginatedDto.results;
  }
}
