abstract class AuthenticationRepository {
  Future<bool> isLoggedIn();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  Future<String?> getAccessToken();
  Future<String> getCurrentUser();
}
