import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../repositories/auth/authentication_repository.dart";
import "../../repositories/auth/local_authentication_repository.dart";
import "../../repositories/auth/remote_authentication_repository.dart";
import "../../repositories/implementations/auth/authentication_repository_impl.dart";
import "../../repositories/implementations/auth/local_authentication_repository_impl.dart";
import "../../repositories/implementations/auth/remote_authentication_repository_impl.dart";
import "http_provider.dart";

part "repository_providers.g.dart";

@Riverpod(keepAlive: true)
LocalAuthenticationRepository localAuthenticationRepository(Ref ref) {
  return LocalAuthenticationRepositoryImpl();
}

@Riverpod(keepAlive: true)
Future<RemoteAuthenticationRepository> remoteAuthenticationRepository(Ref ref) async {
  final dio = ref.watch(clientDioProvider.future);

  return RemoteAuthenticationRepositoryImpl(await dio);
}

@Riverpod(keepAlive: true)
Future<AuthenticationRepository> authenticationRepository(Ref ref) async {
  final local = ref.watch(localAuthenticationRepositoryProvider);
  final remote = await ref.watch(remoteAuthenticationRepositoryProvider.future);

  return AuthenticationRepositoryImpl(local, remote);
}

@Riverpod(keepAlive: true)
Future<String?> accessToken(Ref ref) async {
  final authRepository = await ref.watch(authenticationRepositoryProvider.future);

  return authRepository.getAccessToken();
}
