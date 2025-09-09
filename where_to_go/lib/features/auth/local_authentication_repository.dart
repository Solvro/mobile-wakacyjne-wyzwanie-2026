import "package:flutter_secure_storage/flutter_secure_storage.dart";

class LocalAuthenticationRepository {
  static const _accessTokenKey = "access_token";
  static const _refreshTokenKey = "refresh_token";

  final FlutterSecureStorage _secureStorage;

  LocalAuthenticationRepository({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> readAccessToken() async {
    return _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> readRefreshToken() async {
    return _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> deleteTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
