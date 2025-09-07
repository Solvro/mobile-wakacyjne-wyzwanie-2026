import "../../models/place/place_create_without_owner_input_dto.dart";
import "../../models/place/place_response_dto.dart";

abstract class DreamPlacesRepository {
  Future<PlaceResponseDto> read(String id);
  Future<List<PlaceResponseDto>> readAll();
  Future<void> toggleFavorite(String id);
  Future<PlaceResponseDto> create(PlaceCreateWithoutOwnerInputDto newPlace);
  Future<void> delete(String id);
}
