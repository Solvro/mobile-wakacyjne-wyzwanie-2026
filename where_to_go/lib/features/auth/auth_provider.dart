import "package:riverpod_annotation/riverpod_annotation.dart";

import "auth_repository.dart";

part "auth_provider.g.dart";

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<bool> build() {
    return ref.watch(authRepositoryProvider).isLoggedIn();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).login(email, password);
      state = const AsyncData(true);
    } on Object catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> register(String email, String password) async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).register(email, password);
      state = const AsyncData(true);
    } on Object catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(false);
  }
}
