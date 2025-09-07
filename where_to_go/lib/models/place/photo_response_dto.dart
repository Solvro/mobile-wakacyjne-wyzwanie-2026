import "package:freezed_annotation/freezed_annotation.dart";

part "photo_response_dto.freezed.dart";
part "photo_response_dto.g.dart";

@freezed
abstract class PhotoResponseDto with _$PhotoResponseDto {
  factory PhotoResponseDto(
      {required String id,
      required String filename,
      required String originalName,
      required String mimeType,
      required int size,
      required String path,
      required String createdAt}) = _PhotoResponseDto;

  factory PhotoResponseDto.fromJson(Map<String, dynamic> json) => _$PhotoResponseDtoFromJson(json);
}
