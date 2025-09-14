import "dart:async";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "auth_state.dart";
import "authentication_repository.dart";
import "local_authentication_repository.dart";
import "remote_authentication_repository.dart";

part "auth_provider.g.dart";

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final AuthenticationRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.read(authenticationRepositoryProvider);
    unawaited(checkLoginStatus());
    return const AuthState.initial();
  }

  Future<void> checkLoginStatus() async {
    state = const AuthState.loading();
    final accessToken = await _authRepository.getAccessToken();
    if (accessToken != null) {
      state = const AuthState.authenticated();
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final success = await _authRepository.login(email: email, password: password);
      if (success) {
        state = const AuthState.authenticated();
      } else {
        state = const AuthState.error("Failed to log in.");
      }
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    state = const AuthState.loading();
    try {
      final success = await _authRepository.register(email: email, password: password);
      if (success) {
        state = const AuthState.authenticated();
      } else {
        state = const AuthState.error("Failed to register.");
      }
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState.unauthenticated();
  }

  Future<void> refreshToken() async {
    try {
      final refreshToken = await _authRepository.getRefreshToken();
      final result = await _authRepository.refreshToken(refreshToken!);
      await _authRepository.saveTokens(result);
      state = const AuthState.authenticated();
    } on Exception catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

@riverpod
AuthenticationRepository authenticationRepository(Ref ref) {
  return AuthenticationRepository(
    localRepo: LocalAuthenticationRepository(),
    remoteRepo: RemoteAuthenticationRepository(),
  );
}

class AuthNotifierListener extends ChangeNotifier {
  AuthNotifierListener(this.ref) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      notifyListeners();
    });
  }

  final WidgetRef ref;
}
