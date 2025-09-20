import "package:dio/dio.dart";
import "../../core/api_path.dart";

class ApiAuthException implements Exception {
  final int? status;
  final String message;
  ApiAuthException(this.message, {this.status});
  @override
  String toString() => "[$status] $message";
}

class RemoteAuthenticationRepository {
  RemoteAuthenticationRepository(this._dio);
  final Dio _dio;

  Future<({String access, String refresh})> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        ApiPaths.login,
        data: {"email": email, "password": password},
      );

      if (res.statusCode == null || res.statusCode! >= 400) {
        final msg =
            (res.data != null && res.data!["message"] is String) ? res.data!["message"] as String : "Błąd logowania";
        throw ApiAuthException(msg, status: res.statusCode);
      }

      final data = res.data;
      if (data == null || data["accessToken"] == null || data["refreshToken"] == null) {
        throw ApiAuthException("Brak tokenów w odpowiedzi", status: res.statusCode);
      }

      return (
        access: data["accessToken"].toString(),
        refresh: data["refreshToken"].toString(),
      );
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      String msg;

      final data = e.response?.data;
      if (data is Map<String, dynamic> && data["message"] is String) {
        msg = data["message"] as String;
      } else {
        msg = e.message ?? "Błąd sieci";
      }

      throw ApiAuthException(msg, status: status);
    }
  }

  Future<({String access, String refresh})> register({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        ApiPaths.register,
        data: {"email": email, "password": password},
      );

      if (res.statusCode == null || res.statusCode! >= 400) {
        final msg =
            (res.data != null && res.data!["message"] is String) ? res.data!["message"] as String : "Błąd rejestracji";
        throw ApiAuthException(msg, status: res.statusCode);
      }

      final data = res.data;
      if (data == null || data["accessToken"] == null || data["refreshToken"] == null) {
        throw ApiAuthException("Brak tokenów w odpowiedzi", status: res.statusCode);
      }

      return (
        access: data["accessToken"].toString(),
        refresh: data["refreshToken"].toString(),
      );
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      String msg;

      final data = e.response?.data;
      if (data is Map<String, dynamic> && data["message"] is String) {
        msg = data["message"] as String;
      } else {
        msg = e.message ?? "Błąd sieci";
      }

      throw ApiAuthException(msg, status: status);
    }
  }

  Future<({String access, String refresh})?> refresh({
    required String refreshToken,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        ApiPaths.refresh,
        data: {"refreshToken": refreshToken},
      );
      if (res.statusCode == null || res.statusCode! >= 400 || res.data == null) {
        return null;
      }
      final data = res.data!;
      return (
        access: data["accessToken"]?.toString() ?? "",
        refresh: data["refreshToken"]?.toString() ?? refreshToken,
      );
    } on DioException {
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post<void>("/api/auth/logout");
    } on DioException {
      //
    }
  }
}
