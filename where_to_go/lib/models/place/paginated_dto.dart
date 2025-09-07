import "package:freezed_annotation/freezed_annotation.dart";

import "place_response_dto.dart";

part "paginated_dto.freezed.dart";
part "paginated_dto.g.dart";

@freezed
abstract class PaginatedDto with _$PaginatedDto {
  factory PaginatedDto(
      {required int total,
      required int page,
      required int perPage,
      required List<PlaceResponseDto> results}) = _PaginatedDto;

  factory PaginatedDto.fromJson(Map<String, dynamic> json) => _$PaginatedDtoFromJson(json);
}
