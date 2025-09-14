import "package:freezed_annotation/freezed_annotation.dart";

part "auth_tokens.freezed.dart";
part "auth_tokens.g.dart";

@freezed
abstract class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) => _$AuthTokensFromJson(json);
}
