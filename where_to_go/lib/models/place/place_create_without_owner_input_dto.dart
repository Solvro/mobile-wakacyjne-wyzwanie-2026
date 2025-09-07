import "package:freezed_annotation/freezed_annotation.dart";

part "place_create_without_owner_input_dto.freezed.dart";
part "place_create_without_owner_input_dto.g.dart";

@freezed
abstract class PlaceCreateWithoutOwnerInputDto with _$PlaceCreateWithoutOwnerInputDto {
  factory PlaceCreateWithoutOwnerInputDto(
      {required String name,
      required String description,
      imageUrl,
      required isFavourite}) = _PlaceCreateWithoutOwnerInputDto;

  factory PlaceCreateWithoutOwnerInputDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceCreateWithoutOwnerInputDtoFromJson(json);
}
