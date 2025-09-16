import "package:flutter_secure_storage/flutter_secure_storage.dart";

class LocalAuthenticationRepository {
  LocalAuthenticationRepository(this._storage);
  final FlutterSecureStorage _storage;

  static const _kAccess = "access_token";
  static const _kRefresh = "refresh_token";

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: _kAccess, value: accessToken);
    await _storage.write(key: _kRefresh, value: refreshToken);
  }

  Future<String?> readAccessToken() => _storage.read(key: _kAccess);
  Future<String?> readRefreshToken() => _storage.read(key: _kRefresh);

  Future<void> clear() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
  }
}
