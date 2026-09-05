import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../core/api_paths.dart";
import "auth_interceptor.dart";
import "secure_storage.dart";
import "authentication_repository.dart";

part "auth_providers.g.dart";

final secureStorageProvider = Provider((ref) => SecureStorage());

final dioProvider = Provider((ref) {
  final dio = Dio(BaseOptions(baseUrl: ApiPaths.baseUrl));

  dio.interceptors.add(AuthInterceptor(ref));

  return dio;
});

final authRepositoryProvider = Provider((ref) {
  final storage = ref.watch(secureStorageProvider);
  final dio = ref.watch(dioProvider);
  return AuthenticationRepository(storage, dio);
});

@riverpod
class AuthStatusController extends _$AuthStatusController {
  @override
  AuthenticationStatus build() {
    _init();
    return AuthenticationStatus.unknown;
  }

  Future<void> _init() async {
    final key = await ref.read(authRepositoryProvider).getKey();
    state = (key != null)
        ? AuthenticationStatus.authenticated
        : AuthenticationStatus.unauthenticated;
  }

  Future<void> login(String email, String password) async {
    try {
      await ref.read(authRepositoryProvider).loginUser(email, password);
      state = AuthenticationStatus.authenticated;
    } catch(e) {
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await ref.read(authRepositoryProvider).registerUser(email, password);
    } catch(e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await ref.read(authRepositoryProvider).logoutUser();
      state = AuthenticationStatus.unauthenticated;
    } catch(e) {
      rethrow;
    }
  }
}
