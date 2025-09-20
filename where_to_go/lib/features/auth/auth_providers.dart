import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "../../core/api_path.dart";
import "../../core/dio_client.dart";
import "../../features/auth/authentication_repository.dart";
import "../../features/auth/local_auth_repository.dart";
import "../../features/auth/remote_auth_repository.dart";

final _secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final localAuthRepoProvider = Provider<LocalAuthenticationRepository>((ref) {
  return LocalAuthenticationRepository(ref.read(_secureStorageProvider));
});

final _baseDioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiPaths.baseUrl,
    headers: const {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    validateStatus: (s) => s != null && s < 500,
  ));

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    responseHeader: false,
  ));

  return dio;
});

final remoteAuthRepoProvider = Provider<RemoteAuthenticationRepository>((ref) {
  return RemoteAuthenticationRepository(ref.read(_baseDioProvider));
});

final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(
    local: ref.read(localAuthRepoProvider),
    remote: ref.read(remoteAuthRepoProvider),
  );
});

final dioProvider = Provider<Dio>((ref) {
  final auth = ref.read(authRepositoryProvider);
  return buildAuthorizedDio(auth);
});

final isLoggedInProvider = FutureProvider<bool>((ref) {
  return ref.read(authRepositoryProvider).isLoggedIn();
});
