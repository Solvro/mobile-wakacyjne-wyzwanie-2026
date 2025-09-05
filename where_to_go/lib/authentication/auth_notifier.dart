import "package:flutter_riverpod/flutter_riverpod.dart";
import "authentication_repository.dart";
import "local_authentication_repository.dart";
import "remote_authentication_repository.dart";

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthNotifier extends StateNotifier<AuthStatus> {
  final AuthenticationRepository authRepo;

  AuthNotifier(this.authRepo) : super(AuthStatus.unknown) {
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final loggedIn = await authRepo.isLogged();
    state = loggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
  }

  Future<void> login(String email, String password) async {
    await authRepo.login(email, password);
    state = AuthStatus.authenticated;
  }

  Future<void> logout() async {
    await authRepo.logout();
    state = AuthStatus.unauthenticated;
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  final repo = AuthenticationRepository(
    localAuthRepo: LocalAuthenticationRepository(),
    remoteAuthRepo: RemoteAuthenticationRepository(),
  );
  return AuthNotifier(repo);
});
