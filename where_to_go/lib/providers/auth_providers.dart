// lib/providers/auth_providers.dart
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "../models/authentication_tokens.dart";
import "../repositories/authentication_repository.dart";
import "../repositories/local_authentication_repository.dart";
import "../repositories/remote_authentication_repository.dart";

// 1. Provider dla zewnętrznych zależności
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// Provider tylko dla podstawowego Dio (bez interceptorów)
final baseDioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: "https://backend-api.w.solvro.pl",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  ));
});

// 2. Provider dla lokalnego repozytorium
final localAuthRepoProvider = Provider<LocalAuthenticationRepository>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return LocalAuthenticationRepository(secureStorage: secureStorage);
});

// Provider dla zdalnego repozytorium
final remoteAuthRepoProvider = Provider<RemoteAuthenticationRepository>((ref) {
  final dio = ref.read(baseDioProvider);
  final localAuthRepo = ref.read(localAuthRepoProvider);
  return RemoteAuthenticationRepository(dio: dio, localAuthRepo: localAuthRepo);
});

// 3. Główny provider AuthenticationRepository
final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  final localAuthRepo = ref.read(localAuthRepoProvider);
  final remoteAuthRepo = ref.read(remoteAuthRepoProvider);

  final authRepo = AuthenticationRepository(
    localAuthenticationRepository: localAuthRepo,
    remoteAuthenticationRepository: remoteAuthRepo,
  );

  ref.onDispose(authRepo.dispose);

  return authRepo;
});

// 4. Provider stanu sesji (czy token wygasł)
final sessionExpiredProvider = StateProvider<bool>((ref) => false);

// 5. Provider Dio z interceptorami
final dioProvider = Provider<Dio>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  final baseDio = ref.read(baseDioProvider);
  final sessionExpired = ref.read(sessionExpiredProvider.notifier);

  baseDio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // Pomijamy refresh token endpoint
      if (!options.path.contains("/auth/refresh")) {
        final token = authRepo.tokens?.accessToken;
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
      }
      handler.next(options);
    },
    onError: (error, handler) async {
      // Jeśli 401 i nie endpoint refresh token
      if (error.response?.statusCode == 401 && !error.requestOptions.path.contains("/auth/refresh")) {
        try {
          // Próba odświeżenia tokenu
          await authRepo.refreshToken();

          final newToken = authRepo.tokens?.accessToken;
          if (newToken != null) {
            error.requestOptions.headers["Authorization"] = "Bearer $newToken";
          }

          final response = await baseDio.fetch<dynamic>(error.requestOptions);
          return handler.resolve(response);
        } on DioException catch (_) {
          // Ustawiamy flagę sesji wygasłej
          sessionExpired.state = true;
          await authRepo.logout();
          return handler.next(error);
        }
      }

      handler.next(error);
    },
  ));

  // Dodatkowe pokazywanie requestów po dodaniu nagłówków (mam dosyć szukania w kodzie, czy endpointy są dobre)
  baseDio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: print,
  ));

  return baseDio;
});

// 6. Provider stanu autentykacji
final authStateProvider = FutureProvider<bool>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.isLoggedIn;
});

// 7. Provider dla tokenów (opcjonalnie)
final tokensProvider = Provider<AuthenticationTokens?>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.tokens;
});
