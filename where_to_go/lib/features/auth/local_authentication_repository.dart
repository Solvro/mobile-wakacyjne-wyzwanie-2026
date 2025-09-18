import "package:flutter_secure_storage/flutter_secure_storage.dart";

abstract class LocalAuthenticationRepository {
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<void> readTokens();
  Future<void> deleteTokens();
}

class LocalAuthenticationRepositoryImpl extends LocalAuthenticationRepository {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: "access_token", value: accessToken);
    await _storage.write(key: "refresh_token", value: refreshToken);
  }

  @override
  Future<(String?, String?)> readTokens() async {
    final accessToken = await _storage.read(key: "access_token");
    final refreshToken = await _storage.read(key: "refresh_token");
    if (accessToken == null || refreshToken == null) {
      return (null, null);
    }
    return (accessToken, refreshToken);
  }

  @override
  Future<void> deleteTokens() async {
    await _storage.delete(key: "access_token");
    await _storage.delete(key: "refresh_token");
  }
}
