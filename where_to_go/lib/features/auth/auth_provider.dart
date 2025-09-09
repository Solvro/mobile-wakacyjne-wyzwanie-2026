import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "auth_exception.dart";
import "authentication_repository.dart";

part "auth_provider.g.dart";

@riverpod
AuthenticationRepository authRepository(Ref ref) {
  return AuthenticationRepository();
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthenticationRepository _repo;

  @override
  Future<bool> build() async {
    _repo = ref.watch(authRepositoryProvider);
    final token = await _repo.getAccessToken();
    return token != null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final success = await _repo.login(email: email, password: password);
      state = AsyncValue.data(success);
    } on AuthException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> register(String email, String password, String username) async {
    state = const AsyncValue.loading();
    try {
      final success = await _repo.register(email: email, password: password, username: username);
      state = AsyncValue.data(success);
    } on AuthException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AsyncValue.data(false);
    ref.invalidateSelf();
  }

  Future<void> checkAuthStatus() async {
    state = const AsyncValue.loading();
    try {
      final token = await _repo.getAccessToken();
      state = AsyncValue.data(token != null);
    } on AuthException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
