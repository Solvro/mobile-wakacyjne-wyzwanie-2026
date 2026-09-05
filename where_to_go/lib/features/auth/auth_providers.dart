import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "secure_storage.dart";
import "authentication_repository.dart";

part "auth_providers.g.dart";

final secureStorageProvider = Provider((ref) => SecureStorage());

final authRepositoryProvider = Provider((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthenticationRepository(storage);
});

@riverpod
class AuthStatus extends _$AuthStatus {
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
}
