import "package:freezed_annotation/freezed_annotation.dart";

part "auth_response.freezed.dart";
part "auth_response.g.dart";

@freezed
abstract class AuthResponse with _$AuthResponse {
  factory AuthResponse({required String accessToken, required String refreshToken}) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
