import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

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
      print("[RemoteAuthRepo] Attempting to log in: $email, $password");
      final response = await dio.post<Map<String, dynamic>>("/auth/login", data: {
        "email": email,
        "password": password,
      });
      print("[RemoteAuthRepo] Login response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          final accessToken = data["accessToken"] as String;
          final refreshToken = data["refreshToken"] as String;
          print("[RemoteAuthRepo] Login successful, tokens received");
          return (accessToken, refreshToken);
        }
      }
    } on DioException catch (e) {
      print("[RemoteAuthRepo] DioError during login: ${e.message}");
      print("[RemoteAuthRepo] Response: ${e.response?.data}");
    } on Object catch (e) {
      print("[RemoteAuthRepo] Error during login: $e");
    }
    throw Exception("Login failed");
  }

  @override
  Future<(String, String)> signIn(String email, String password) async {
    try {
      print("[RemoteAuthRepo] Attempting to sign up: $email");
      final response = await dio.post<Map<String, dynamic>>("/auth/register", data: {
        "email": email,
        "password": password,
      });
      print("[RemoteAuthRepo] Sign up response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null) {
          // backend may return different key names depending on endpoint/version
          final accessToken = (data["accessToken"] ?? data["access_token"]) as String?;
          final refreshToken = (data["refreshToken"] ?? data["refresh_token"]) as String?;
          if (accessToken != null && refreshToken != null) {
            print("[RemoteAuthRepo] Sign up successful, tokens received");
            return (accessToken, refreshToken);
          }
        }
      }
    } on DioException catch (e) {
      print("[RemoteAuthRepo] DioError during sign up: ${e.message}");
      print("[RemoteAuthRepo] Response: ${e.response?.data}");
    } on Object catch (e) {
      print("[RemoteAuthRepo] Error during sign up: $e");
    }

    throw Exception("Sign up failed");
  }

  @override
  Future<String?> refreshToken(String refreshToken) async {
    try {
      print("[RemoteAuthRepo] Attempting to refresh token with refreshToken=${refreshToken.substring(0, 10)}...");

      final resp = await dio.post<Map<String, dynamic>>("/auth/refresh",
          data: {"refreshToken": refreshToken},
          options: Options(
            validateStatus: (status) => status != null && status < 500,
          ));

      print("[RemoteAuthRepo] Refresh token response status: ${resp.statusCode}");
      print("[RemoteAuthRepo] Refresh token response: ${resp.data}");

      if (resp.statusCode == 200 && resp.data != null) {
        final data = resp.data!;
        final access = (data["accessToken"] ?? data["access_token"]) as String?;
        if (access != null && access.isNotEmpty) {
          print("[RemoteAuthRepo] Successfully refreshed token");
          return access;
        } else {
          print("[RemoteAuthRepo] Refresh response missing access token");
        }
      } else {
        print("[RemoteAuthRepo] Non-200 status or empty response");
      }
      return null;
    } on DioException catch (e) {
      print("[RemoteAuthRepo] DioError during token refresh: ${e.message}");
      print("[RemoteAuthRepo] Response data: ${e.response?.data}");
      print("[RemoteAuthRepo] Response status: ${e.response?.statusCode}");
      return null;
    } on Object catch (e) {
      print("[RemoteAuthRepo] Error during token refresh: $e");
      return null;
    }
  }
}
