import "../../auth/authentication_repository.dart";
import "../../auth/local_authentication_repository.dart";
import "../../auth/remote_authentication_repository.dart";

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final LocalAuthenticationRepository _localAuthenticationRepository;
  final RemoteAuthenticationRepository _remoteAuthenticationRepository;

  AuthenticationRepositoryImpl(this._localAuthenticationRepository, this._remoteAuthenticationRepository);

  @override
  Future<bool> isLoggedIn() async {
    final (accessToken, refreshToken) = await _localAuthenticationRepository.readTokens();
    return accessToken != null && refreshToken != null;
  }

  @override
  Future<void> login(String email, String password) async {
    final authResponse = await _remoteAuthenticationRepository.login(email, password);
    await _localAuthenticationRepository.saveTokens(authResponse.accessToken, authResponse.refreshToken);
  }

  @override
  Future<void> logout() async {
    await _localAuthenticationRepository.deleteTokens();
  }

  @override
  Future<void> register(String email, String password) async {
    final authResponse = await _remoteAuthenticationRepository.register(email, password);
    await _localAuthenticationRepository.saveTokens(authResponse.accessToken, authResponse.refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    final (accessToken, _) = await _localAuthenticationRepository.readTokens();

    return accessToken;
  }

  @override
  Future<String> getCurrentUser() async {
    final me = await _remoteAuthenticationRepository.getMe();

    return me.email;
  }
}
