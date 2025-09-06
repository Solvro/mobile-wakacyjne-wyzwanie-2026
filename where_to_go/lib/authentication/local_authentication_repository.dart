import "package:flutter_secure_storage/flutter_secure_storage.dart";

class LocalAuthenticationRepository {
  final _storage = const FlutterSecureStorage();

  Future<void> writeAccessToken(String token) async {
    await _storage.write(key: "access_token", value: token);
  }

  Future<String?> readAccessToken() {
    return _storage.read(key: "access_token");
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: "access_token");
  }

  Future<void> writeRefreshToken(String token) async {
  await _storage.write(key: "refresh_token", value: token);
  }

  Future<String?> readRefreshToken() {
    return _storage.read(key: "refresh_token");
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: "refresh_token");
  }
}
