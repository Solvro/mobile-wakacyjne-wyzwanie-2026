import "package:dio/dio.dart";

import "../../../models/auth/auth_response.dart";
import "../../../models/auth/me_dto.dart";
import "../../../models/auth/user.dart";
import "../../auth/remote_authentication_repository.dart";

class RemoteAuthenticationRepositoryImpl implements RemoteAuthenticationRepository {
  final Dio _dio;

  RemoteAuthenticationRepositoryImpl(this._dio);

  @override
  Future<AuthResponse> login(String email, String password) async {
    final user = User(email: email, password: password);
    final response = await _dio.post<Map<String, dynamic>>("/auth/login", data: user.toJson());

    return AuthResponse.fromJson(response.data!);
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await _dio.post<Map<String, dynamic>>("/auth/refresh", data: {"refreshToken": refreshToken});

    return AuthResponse.fromJson(response.data!);
  }

  @override
  Future<AuthResponse> register(String email, String password) async {
    final user = User(email: email, password: password);
    final response = await _dio.post<Map<String, dynamic>>("/auth/register", data: user.toJson());

    return AuthResponse.fromJson(response.data!);
  }

  @override
  Future<MeDto> getMe() async {
    final response = await _dio.get<Map<String, dynamic>>("/auth/me");

    return MeDto.fromJson(response.data!);
  }
}
