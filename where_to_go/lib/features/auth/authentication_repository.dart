import 'dart:async';

import 'package:dio/dio.dart';

import '../../core/api_paths.dart';
import 'secure_storage.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository(this._secureStorage, this._dio);

  final SecureStorage _secureStorage;
  final Dio _dio;

  Future<String?> getKey() => _secureStorage.getAccessKey();
  Future<void> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(ApiPaths.login, data: {"email": email, "password": password});
      final String? token = response.data["accessToken"];

      if(token != null) {
        await _secureStorage.saveAccessKey(token);
      } else {
        throw Exception("Serwer nie zwrócił klucza dostępu");
      }

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Niepoprawny e-mail lub hasło");
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Brak połączenia z internetem");
      } else {
        throw Exception("Wystąpił nieoczekiwany błąd ${e.response?.statusCode}");
      }
    }
  }

  Future<void> registerUser(String email, String password) async {
    try {
      await _dio.post(ApiPaths.register, data: {"email": email, "password": password});
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception("Ten e-mail został już zarejestrowany");
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Brak połączenia z internetem");
      } else {
        throw Exception("Wystąpił nieoczekiwany błąd ${e.response?.statusCode}");
      }
    }
  }

  Future<void> logoutUser() async {
    try {
      await _secureStorage.deleteAccessKey();
    } on DioException catch (e) {
      throw Exception(e.response);
    }
  }
}
