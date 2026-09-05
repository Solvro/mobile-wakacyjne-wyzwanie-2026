import 'dart:async';

import 'secure_storage.dart';

enum AuthenticationStatus {unknown, authenticated, unauthenticated}

class AuthenticationRepository {
  AuthenticationRepository(this._secureStorage);

  final SecureStorage _secureStorage;

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final key = await _secureStorage.getAccessKey();

    if(key != null && key.isNotEmpty) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }

    yield* _controller.stream;
  }



  void dispose() => _controller.close();
}