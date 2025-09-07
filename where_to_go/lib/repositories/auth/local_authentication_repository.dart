abstract class LocalAuthenticationRepository {
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<(String?, String?)> readTokens();
  Future<void> deleteTokens();
}
