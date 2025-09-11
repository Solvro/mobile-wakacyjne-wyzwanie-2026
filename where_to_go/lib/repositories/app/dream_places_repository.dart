import "../../models/place/place_create_without_owner_input_dto.dart";
import "../../models/place/place_response_dto.dart";
import "../../utils/sort_order.dart";

abstract class DreamPlacesRepository {
  Future<PlaceResponseDto> read(String id);
  Future<List<PlaceResponseDto>> readAll(SortOrder sortOrder);
  Future<void> toggleFavorite(String id);
  Future<PlaceResponseDto> create(PlaceCreateWithoutOwnerInputDto newPlace);
  Future<void> delete(String id);
  Future<PlaceResponseDto> updatePlace(String id, PlaceCreateWithoutOwnerInputDto updatedPlace);
}
