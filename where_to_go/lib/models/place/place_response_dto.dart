import "package:freezed_annotation/freezed_annotation.dart";

part "place_response_dto.freezed.dart";
part "place_response_dto.g.dart";

@freezed
abstract class PlaceResponseDto with _$PlaceResponseDto {
  factory PlaceResponseDto(
      {required int id,
      required String name,
      required String description,
      required String imageUrl,
      @JsonKey(name: "isFavourite", defaultValue: false) required bool isFavourite,
      required String ownerEmail}) = _PlaceResponseDto;

  factory PlaceResponseDto.fromJson(Map<String, dynamic> json) => _$PlaceResponseDtoFromJson(json);
}
