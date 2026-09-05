import "package:flutter_riverpod/flutter_riverpod.dart";
import "secure_storage.dart";
import "authentication_repository.dart";

final secureStorageProvider = Provider((ref) => SecureStorage());

final authRepositoryProvider = Provider((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthenticationRepository(storage);
});

final authStatusProvider = StreamProvider<AuthenticationStatus>((ref) {
  return ref.watch(authRepositoryProvider).status;
});