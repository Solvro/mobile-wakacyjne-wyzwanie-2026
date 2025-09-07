import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "../../auth/local_authentication_repository.dart";

class LocalAuthenticationRepositoryImpl implements LocalAuthenticationRepository {
  static const storage = FlutterSecureStorage();
  static const _accessToken = "access_token";
  static const _refreshToken = "refresh_token";

  @override
  Future<void> deleteTokens() async {
    await storage.delete(key: _accessToken);
    await storage.delete(key: _refreshToken);
  }

  @override
  Future<(String?, String?)> readTokens() async {
    final accessToken = await storage.read(key: _accessToken);
    final refreshToken = await storage.read(key: _refreshToken);

    return (accessToken, refreshToken);
  }

  @override
  Future<void> saveTokens(String accessTokenValue, String refreshTokenValue) async {
    await storage.write(key: _accessToken, value: accessTokenValue);
    await storage.write(key: _refreshToken, value: refreshTokenValue);
  }
}
