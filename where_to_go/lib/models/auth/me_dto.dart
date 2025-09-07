import "package:freezed_annotation/freezed_annotation.dart";

part "me_dto.freezed.dart";
part "me_dto.g.dart";

@freezed
abstract class MeDto with _$MeDto {
  factory MeDto({required String email, required int iat, required int exp}) = _MeDto;

  factory MeDto.fromJson(Map<String, dynamic> json) => _$MeDtoFromJson(json);
}
