import "package:dio/dio.dart";

import "auth_tokens.dart";

class RemoteAuthenticationRepository {
  final Dio _dio;

  RemoteAuthenticationRepository({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: "https://backend-api.w.solvro.pl/",
              connectTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5),
            ));

  Future<AuthTokens> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>("auth/login", data: {
        "email": email,
        "password": password,
      });

      if (response.data != null) {
        final authTokens = AuthTokens.fromJson(response.data!);
        return authTokens;
      } else {
        throw Exception("Login failed with status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Failed to login: ${e.message}");
    }
  }

  Future<AuthTokens> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>("auth/register", data: {
        "email": email,
        "password": password,
      });

      if (response.data != null) {
        final authTokens = AuthTokens.fromJson(response.data!);
        return authTokens;
      } else {
        throw Exception("Registration failed with status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Failed to register: ${e.message}");
    }
  }

  Future<AuthTokens> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "auth/refresh",
        data: {
          "refreshToken": refreshToken,
        },
      );

      if (response.data != null) {
        final authTokens = AuthTokens.fromJson(response.data!);
        return authTokens;
      } else {
        throw Exception("Token refresh failed with status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Failed to refresh token: ${e.message}");
    }
  }
}
