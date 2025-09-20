import "package:flutter_secure_storage/flutter_secure_storage.dart";

class LocalAuthenticationRepository {
  LocalAuthenticationRepository(this._storage);
  final FlutterSecureStorage _storage;

  static const kAccess = "access_token";
  static const kRefresh = "refresh_token";

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: kAccess, value: accessToken);
    await _storage.write(key: kRefresh, value: refreshToken);
  }

  Future<String?> readAccessToken() => _storage.read(key: kAccess);

  Future<String?> readRefreshToken() => _storage.read(key: kRefresh);

  Future<void> clear() async {
    await _storage.delete(key: kAccess);
    await _storage.delete(key: kRefresh);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
