import "package:dio/dio.dart";
import "package:flutter/material.dart";

abstract class RemoteAuthenticationRepository {
  Future<(String, String)> logIn(String email, String password);
  Future<(String, String)> signIn(String email, String password);
  Future<String?> refreshToken(String refreshToken);
}

class RemoteAuthenticationRepositoryImpl implements RemoteAuthenticationRepository {
  final dio = Dio(BaseOptions(baseUrl: "https://backend-api.w.solvro.pl/"));

  @override
  Future<(String, String)> logIn(String email, String password) async {
    try {
      final response = await dio.post<Map<String, dynamic>>("/auth/login", data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          final accessToken = data["accessToken"] as String;
          final refreshToken = data["refreshToken"] as String;
          return (accessToken, refreshToken);
        }
      }
    } on DioException catch (e) {
      debugPrint("[RemoteAuthRepo] Response: ${e.response?.data}");
    } on Object catch (e) {
      debugPrint("[RemoteAuthRepo] Error during login: $e");
    }
    throw Exception("Login failed");
  }

  @override
  Future<(String, String)> signIn(String email, String password) async {
    try {
      final response = await dio.post<Map<String, dynamic>>("/auth/register", data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          // backend may return different key names depending on endpoint/version
          final accessToken = (data["accessToken"] ?? data["access_token"]) as String?;
          final refreshToken = (data["refreshToken"] ?? data["refresh_token"]) as String?;
          if (accessToken != null && refreshToken != null) {
            return (accessToken, refreshToken);
          }
        }
      }
    } on DioException catch (e) {
      debugPrint("[RemoteAuthRepo] DioError during sign up: ${e.message}");
      debugPrint("[RemoteAuthRepo] Response: ${e.response?.data}");
    } on Object catch (e) {
      debugPrint("[RemoteAuthRepo] Error during sign up: $e");
    }

    throw Exception("Sign up failed");
  }

  @override
  Future<String?> refreshToken(String refreshToken) async {
    try {
      final resp = await dio.post<Map<String, dynamic>>("/auth/refresh",
          data: {"refreshToken": refreshToken},
          options: Options(
            validateStatus: (status) => status != null && status < 500,
          ));

      if (resp.statusCode == 200 && resp.data != null) {
        final data = resp.data!;
        final access = (data["accessToken"] ?? data["access_token"]) as String?;
        if (access != null && access.isNotEmpty) {
          debugPrint("[RemoteAuthRepo] Successfully refreshed token");
          return access;
        } else {
          debugPrint("[RemoteAuthRepo] Refresh response missing access token");
        }
      } else {
        debugPrint("[RemoteAuthRepo] Non-200 status or empty response");
      }
      return null;
    } on DioException catch (e) {
      debugPrint("[RemoteAuthRepo] DioError during token refresh: ${e.message}");
      debugPrint("[RemoteAuthRepo] Response data: ${e.response?.data}");
      debugPrint("[RemoteAuthRepo] Response status: ${e.response?.statusCode}");
      return null;
    } on Object catch (e) {
      debugPrint("[RemoteAuthRepo] Error during token refresh: $e");
      return null;
    }
  }
}
