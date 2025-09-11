import "package:logger/logger.dart";
import "auth_exception.dart";
import "local_authentication_repository.dart";
import "remote_authentication_repository.dart";

class AuthenticationRepository {
  final LocalAuthenticationRepository _localRepo;
  final RemoteAuthenticationRepository _remoteRepo;
  final _logger = Logger();

  AuthenticationRepository({
    LocalAuthenticationRepository? localRepo,
    RemoteAuthenticationRepository? remoteRepo,
  })  : _localRepo = localRepo ?? LocalAuthenticationRepository(),
        _remoteRepo = remoteRepo ?? RemoteAuthenticationRepository();

  Future<bool> login({required String email, required String password}) async {
    try {
      final data = await _remoteRepo.login(email: email, password: password);

      _logger.d("Login response: $data");

      final accessToken = data["accessToken"]?.toString();
      final refreshToken = data["refreshToken"]?.toString();

      if (accessToken == null || refreshToken == null) {
        throw AuthException("Brak tokenów w odpowiedzi serwera");
      }

      await _localRepo.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      return true;
    } on AuthException catch (e) {
      _logger.e("Login failed: $e");
      return false;
    }
  }

  Future<bool> register({required String email, required String password, required String username}) async {
    try {
      final data = await _remoteRepo.register(
        email: email,
        password: password,
        username: username,
      );

      _logger.d("Register response: $data");

      final accessToken = data["accessToken"]?.toString();
      final refreshToken = data["refreshToken"]?.toString();

      if (accessToken == null || refreshToken == null) {
        throw AuthException("Brak tokenów w odpowiedzi serwera");
      }

      await _localRepo.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      return true;
    } on AuthException catch (e) {
      _logger.e("Register failed: $e");
      return false;
    }
  }

  Future<void> logout() => _localRepo.deleteTokens();

  Future<String?> getAccessToken() => _localRepo.readAccessToken();

  Future<String?> getRefreshToken() => _localRepo.readRefreshToken();

  Future<Map<String, dynamic>> refreshToken() async {
    final refresh = await _localRepo.readRefreshToken();
    if (refresh == null) throw AuthException("Brak refresh tokena");

    final data = await _remoteRepo.refreshToken(refreshToken: refresh);

    _logger.d("Refresh token response: $data");

    final accessToken = data["accessToken"]?.toString();
    final refreshToken = data["refreshToken"]?.toString();

    if (accessToken == null || refreshToken == null) {
      throw AuthException("Brak tokenów w odpowiedzi serwera");
    }

    await _localRepo.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    return data;
  }
}
