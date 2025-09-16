import "local_auth_repository.dart";
import "remote_auth_repository.dart";

class AuthenticationRepository {
  AuthenticationRepository({
    required LocalAuthenticationRepository local,
    required RemoteAuthenticationRepository remote,
  })  : _local = local,
        _remote = remote;

  final LocalAuthenticationRepository _local;
  final RemoteAuthenticationRepository _remote;

  Future<bool> isLoggedIn() async {
    final access = await _local.readAccessToken();
    return access != null && access.isNotEmpty;
  }

  Future<void> login({required String email, required String password}) async {
    final tokens = await _remote.login(email: email, password: password);
    await _local.saveTokens(accessToken: tokens.access, refreshToken: tokens.refresh);
  }

  Future<void> register({required String email, required String password}) async {
    final tokens = await _remote.register(email: email, password: password);
    await _local.saveTokens(accessToken: tokens.access, refreshToken: tokens.refresh);
  }

  Future<void> logout() => _local.clear();

  Future<String?> readAccessToken() => _local.readAccessToken();
  Future<String?> readRefreshToken() => _local.readRefreshToken();

  Future<void> saveAccessToken(String token) async {
    final refresh = await _local.readRefreshToken() ?? "";
    await _local.saveTokens(accessToken: token, refreshToken: refresh);
  }
}
