import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../network/dio_provider.dart";
import "token_storage.dart";

part "auth_repository.g.dart";

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(dioProvider), TokenStorage());
}

class AuthRepository {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  AuthRepository(this._dio, this._tokenStorage);

  Future<bool> isLoggedIn() async {
    final token = await _tokenStorage.getToken();
    return token != null;
  }

  String _parseDioError(DioException e) {
    final responseData = e.response?.data;
    if (responseData is Map) {
      final msg = responseData["message"];
      if (msg is List && msg.isNotEmpty) {
        final firstMsg = msg.first;
        if (firstMsg is Map && firstMsg["message"] != null) {
          final strMsg = firstMsg["message"].toString();
          if (strMsg.contains("Invalid email")) {
            return "Niepoprawny format adresu e-mail (np. user@domain.com).";
          }
          return strMsg;
        }
        return firstMsg.toString();
      } else if (msg is String) {
        if (e.response?.statusCode == 409 || msg.contains("exists")) {
          return "Użytkownik o tym e-mailu już istnieje.";
        }
        if (e.response?.statusCode == 401 || msg.contains("credentials")) {
          return "Nieprawidłowy e-mail lub hasło.";
        }
        return msg;
      }
    }
    if (e.response?.statusCode == 401) {
      return "Nieprawidłowy e-mail lub hasło.";
    }
    if (e.response?.statusCode == 409) {
      return "Użytkownik o tym e-mailu już istnieje.";
    }
    return "Wystąpił błąd sieci lub autoryzacji.";
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _dio.post<dynamic>("/auth/login", data: {"email": email, "password": password});

      final data = response.data;
      String? token;
      if (data is Map) {
        token = (data["accessToken"] ?? data["access_token"])?.toString();
      }

      if (token != null) {
        await _tokenStorage.saveToken(token);
      } else {
        throw Exception("Nie udało się pobrać tokenu autoryzacji.");
      }
    } on DioException catch (e) {
      throw Exception(_parseDioError(e));
    }
  }

  Future<void> register(String email, String password) async {
    try {
      final response = await _dio.post<dynamic>("/auth/register", data: {"email": email, "password": password});

      final data = response.data;
      String? token;
      if (data is Map) {
        token = (data["accessToken"] ?? data["access_token"])?.toString();
      }

      if (token != null) {
        await _tokenStorage.saveToken(token);
      } else {
        await login(email, password);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        await login(email, password);
      } else {
        throw Exception(_parseDioError(e));
      }
    }
  }

  Future<void> logout() async {
    await _tokenStorage.deleteToken();
  }
}
