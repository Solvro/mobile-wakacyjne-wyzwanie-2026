import "package:dio/dio.dart";
import "../../core/api_path.dart";

class RemoteAuthenticationRepository {
  RemoteAuthenticationRepository(this._dio);
  final Dio _dio;

  Future<({String access, String refresh})> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      ApiPaths.login,
      data: {
        "email": email,
        "password": password,
      },
    );
    final data = res.data!;
    return (
      access: data["accessToken"] as String,
      refresh: data["refreshToken"] as String,
    );
  }

  Future<({String access, String refresh})> register({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      ApiPaths.register,
      data: {
        "email": email,
        "password": password,
      },
    );
    final data = res.data!;
    return (
      access: data["accessToken"] as String,
      refresh: data["refreshToken"] as String,
    );
  }

  Future<String> refreshToken({required String refreshToken}) async {
    final res = await _dio.post<Map<String, dynamic>>(
      ApiPaths.refresh,
      data: {"refreshToken": refreshToken},
    );
    final data = res.data!;
    return data["accessToken"] as String;
  }
}
