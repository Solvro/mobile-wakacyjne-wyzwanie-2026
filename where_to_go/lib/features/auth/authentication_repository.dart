import 'dart:async';

import 'secure_storage.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository(this._secureStorage);

  final SecureStorage _secureStorage;

  Future<String?> getKey() => _secureStorage.getAccessKey();
  Future<void> saveKey(String key) => _secureStorage.saveAccessKey(key);
  Future<void> clearKey() => _secureStorage.deleteAccessKey();
}
