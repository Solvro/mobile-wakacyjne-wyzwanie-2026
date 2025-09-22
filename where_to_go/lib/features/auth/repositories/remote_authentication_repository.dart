import "package:dio/dio.dart";
import "package:json_annotation/json_annotation.dart";

part "remote_authentication_repository.g.dart";

@JsonSerializable()
class TokenResponse {
  @JsonKey(required: true)
  final String accessToken;
  @JsonKey(required: true)
  final String refreshToken;

  TokenResponse({required this.accessToken, required this.refreshToken});

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

@JsonSerializable()
class AccessTokenResponse {
  @JsonKey(required: true)
  final String accessToken;

  AccessTokenResponse({required this.accessToken});

  factory AccessTokenResponse.fromJson(Map<String, dynamic> json) => _$AccessTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenResponseToJson(this);
}

class RemoteAuthenticationRepository {
  final Dio _dio;

  RemoteAuthenticationRepository(this._dio);

  Future<TokenResponse> login({required String login, required String password}) async {
    final response = await _dio.post<Map<String, dynamic>>("/auth/login", data: {
      "username": login,
      "password": password,
    });
    final data = response.data;
    if (data == null) {
      throw Exception("No data in response");
    }

    return TokenResponse.fromJson(data);
  }

  Future<TokenResponse> register({required String email, required String password}) async {
    final response = await _dio.post<Map<String, dynamic>>("/auth/register", data: {
      "email": email,
      "password": password,
    });
    final data = response.data;
    if (data == null) {
      throw Exception("No data in response");
    }

    return TokenResponse.fromJson(data);
  }

  Future<AccessTokenResponse> refreshToken({required String refreshToken}) async {
    final response = await _dio.post<Map<String, dynamic>>("/auth/refresh", data: {
      "refreshToken": refreshToken,
    });
    final data = response.data;
    if (data == null) {
      throw Exception("No data in response");
    }

    return AccessTokenResponse.fromJson(data);
  }
}
