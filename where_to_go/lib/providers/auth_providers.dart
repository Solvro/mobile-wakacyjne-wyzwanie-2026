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

// 2. Provider dla repozytoriów
final localAuthRepoProvider = Provider<LocalAuthenticationRepository>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return LocalAuthenticationRepository(secureStorage: secureStorage);
});

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

// Provider Dio z interceptorami (PO authRepositoryProvider)
final dioProvider = Provider<Dio>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  final baseDio = ref.read(baseDioProvider);

  baseDio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // Nie dodawaj Authorization przy refreshToken
      if (!options.path.contains("/auth/refresh")) {
        final token = authRepo.tokens?.accessToken;
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
      }
      return handler.next(options);
    },
    onError: (error, handler) async {
      if (error.response?.statusCode == 401 && !error.requestOptions.path.contains("/auth/refresh")) {
        try {
          await authRepo.refreshToken();

          // Poprawne ponowienie requestu
          final newToken = authRepo.tokens?.accessToken;
          if (newToken != null) {
            error.requestOptions.headers["Authorization"] = "Bearer $newToken";
          }

          final response = await baseDio.fetch<dynamic>(error.requestOptions);
          return handler.resolve(response);
        } on DioException catch (e) {
          await authRepo.logout();
          return handler.reject(e);
        } on Exception {
          return handler.next(error);
        }
      }
      return handler.next(error);
    },
  ));

  // Dodatkowe pokazywanie requestów po dodaniu nagłówków (mam dosyć szukania w kodzie, czy endpointy są dobre)
  baseDio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    responseHeader: false,
  ));

  return baseDio;
});

// 4. Provider stanu autentykacji
final authStateProvider = FutureProvider<bool>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.isLoggedIn;
});

// 5. Provider dla tokenów (opcjonalnie)
final tokensProvider = Provider<AuthenticationTokens?>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  return authRepo.tokens;
});
