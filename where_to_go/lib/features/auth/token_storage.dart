import "package:flutter_secure_storage/flutter_secure_storage.dart";

class TokenStorage {
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = "jwt_access_token";

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() {
    return _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
