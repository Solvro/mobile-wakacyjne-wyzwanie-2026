// lib/repositories/local_authentication_repository.dart
import "dart:convert";

import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "../models/authentication_tokens.dart";

class LocalAuthenticationRepository {
  static const _tokensKey = "authentication_tokens";

  final FlutterSecureStorage _secureStorage;

  LocalAuthenticationRepository({required FlutterSecureStorage secureStorage}) : _secureStorage = secureStorage;

  Future<void> saveTokens(AuthenticationTokens tokens) async {
    try {
      final jsonString = json.encode(tokens.toJson());
      await _secureStorage.write(key: _tokensKey, value: jsonString);
    } catch (e) {
      throw Exception("Błąd podczas zapisywania tokenów: $e");
    }
  }

  Future<AuthenticationTokens?> getTokens() async {
    try {
      final jsonString = await _secureStorage.read(key: _tokensKey);
      if (jsonString == null) {
        return null;
      }

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return AuthenticationTokens.fromJson(jsonMap);
    } catch (e) {
      throw Exception("Błąd podczas odczytywania tokenów: $e");
    }
  }

  Future<void> deleteTokens() async {
    try {
      await _secureStorage.delete(key: _tokensKey);
    } catch (e) {
      throw Exception("Błąd podczas usuwania tokenów: $e");
    }
  }

  Future<bool> isUserLoggedIn() async {
    final tokens = await getTokens();
    return tokens != null && tokens.isValid;
  }
}
