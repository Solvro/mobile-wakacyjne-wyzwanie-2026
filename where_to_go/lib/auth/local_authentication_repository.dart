import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "auth_tokens.dart";

class LocalAuthenticationRepository {
  static const _accessTokenKey = "ACCESS_TOKEN";
  static const _refreshTokenKey = "REFRESH_TOKEN";

  final FlutterSecureStorage _secureStorage;

  LocalAuthenticationRepository({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<void> saveTokens({
    required AuthTokens authTokens,
  }) async {
    await _secureStorage.write(key: _accessTokenKey, value: authTokens.accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: authTokens.refreshToken);
  }

  Future<String?> getAccessToken() async {
    return _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
