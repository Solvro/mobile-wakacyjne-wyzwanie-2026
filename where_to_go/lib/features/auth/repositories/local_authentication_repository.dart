import "package:flutter_secure_storage/flutter_secure_storage.dart";

class LocalAuthenticationRepository {
  static const storage = FlutterSecureStorage();

  static const _accessTokenPath = "access_key";
  Future<String?> getAccessToken() {
    return storage.read(key: _accessTokenPath);
  }

  Future<void> setAccessToken(String token) async {
    await storage.write(key: _accessTokenPath, value: token);
  }

  static const _refreshTokenPath = "refresh_token";
  Future<String?> getRefreshToken() {
    return storage.read(key: _refreshTokenPath);
  }

  Future<void> setRefreshToken(String token) async {
    await storage.write(key: _refreshTokenPath, value: token);
  }
}
