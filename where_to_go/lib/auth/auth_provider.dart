import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/places/places_provider.dart';
import '../../repositories/authrepo.dart';

part 'auth_provider.g.dart';

@riverpod
AuthenticationRepository authRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return AuthenticationRepository(db: db);
}

@riverpod
class Auth extends _$Auth {
  @override
  Future<bool> build() async {
    final repo = ref.watch(authRepositoryProvider);
    return repo.isLoggedIn();
  }

  Future<void> login({required String email, required String password}) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.login(email: email, password: password);
    state = const AsyncData(true);
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    final repo = ref.read(authRepositoryProvider);
    await repo.register(email: email, username: username, password: password);
    state = const AsyncData(true);
  }

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
    state = const AsyncData(false);
  }
}
