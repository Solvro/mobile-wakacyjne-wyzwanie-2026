//lib/repositories/remote_authentication_repository.dart
import "package:dio/dio.dart";
import "../models/authentication_tokens.dart";
import "../repositories/local_authentication_repository.dart";

class RemoteAuthenticationRepository {
  final Dio _dio;
  final LocalAuthenticationRepository _localAuthRepo;

  RemoteAuthenticationRepository({
    required Dio dio,
    required LocalAuthenticationRepository localAuthRepo,
  })  : _dio = dio,
        _localAuthRepo = localAuthRepo;

  Future<AuthenticationTokens?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data!;
        final tokens = AuthenticationTokens(
          accessToken: data["accessToken"] as String,
          refreshToken: data["refreshToken"] as String,
        );
        await _localAuthRepo.saveTokens(tokens);
        return tokens;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        throw Exception("Błąd logowania (${e.response!.statusCode}): $errorData");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("Błąd połączenia: Sprawdź internet");
      } else {
        throw Exception("Błąd logowania: ${e.message}");
      }
    } catch (e) {
      throw Exception("Nieoczekiwany błąd: $e");
    }
    return null;
  }

  Future<AuthenticationTokens?> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "/auth/register",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data!;
        final tokens = AuthenticationTokens(
          accessToken: data["accessToken"] as String,
          refreshToken: data["refreshToken"] as String,
        );
        await _localAuthRepo.saveTokens(tokens);
        return tokens;
      }
    } catch (e) {
      throw Exception("Błąd rejestracji: $e");
    }
    return null;
  }

  Future<AuthenticationTokens?> refreshToken() async {
    final currentTokens = await _localAuthRepo.getTokens();
    if (currentTokens == null) {
      throw Exception("Brak zapisanych tokenów do odświeżenia.");
    }
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "/auth/refresh",
        data: {
          "refreshToken": currentTokens.refreshToken,
        },
      );

      if (response.statusCode == 201) {
        final data = response.data!;
        final tokens = AuthenticationTokens(
          accessToken: data["accessToken"] as String,
          refreshToken: currentTokens.refreshToken,
        );
        await _localAuthRepo.saveTokens(tokens);
        return tokens;
      }
    } catch (e) {
      throw Exception("Błąd odświeżania tokenów: $e");
    }
    return null;
  }
}
