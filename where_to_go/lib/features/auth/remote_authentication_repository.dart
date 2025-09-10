import "package:dio/dio.dart";
import "auth_exception.dart";

class RemoteAuthenticationRepository {
  final Dio _dio;

  RemoteAuthenticationRepository({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: "https://backend-api.w.solvro.pl",
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
              ),
            );

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "/auth/login",
        data: {"email": email, "password": password},
      );
      return response.data!;
    } on DioException catch (e) {
      throw AuthException("Login failed: ${e.response?.data ?? e.message}");
    }
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "/auth/register",
        data: {
          "email": email,
          "password": password,
          "username": username,
        },
      );
      return response.data!;
    } on DioException catch (e) {
      throw AuthException("Register failed: ${e.response?.data ?? e.message}");
    }
  }

  Future<Map<String, dynamic>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "/auth/refresh",
        data: {"refreshToken": refreshToken},
      );
      return response.data!;
    } on DioException catch (e) {
      throw AuthException("Token refresh failed: ${e.response?.data ?? e.message}");
    }
  }
}
