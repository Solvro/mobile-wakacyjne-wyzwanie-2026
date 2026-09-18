//import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../database/app_database.dart';

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
  @override
  String toString() => message;
}

class AuthenticationRepository {
  AuthenticationRepository({
    FlutterSecureStorage? storage,
    required AppDatabase db,
  })  : //_dio = dio,
        _db = db,
        _storage = storage ?? const FlutterSecureStorage();

  // final Dio _dio;
  final AppDatabase _db;
  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';
  static const _userIdKey = 'user_id';

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: _accessTokenKey);
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _userIdKey);
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);

  Future<void> _saveSession(String userId) async {
    await _storage.write(key: _accessTokenKey, value: 'local_$userId');
    await _storage.write(key: _userIdKey, value: userId);
  }

  Future<User?> _findByEmailOrUsername(String value) async {
    final byEmail = await (_db.select(
      _db.users,
    )..where((u) => u.email.equals(value)))
        .getSingleOrNull();
    if (byEmail != null) return byEmail;

    return (_db.select(
      _db.users,
    )..where((u) => u.username.equals(value)))
        .getSingleOrNull();
  }

  Future<void> login({required String email, required String password}) async {
    final user = await _findByEmailOrUsername(email);

    if (user == null || user.password != password) {
      throw AuthenticationException('Nieprawidłowy login albo hasło');
    }
    await _saveSession(user.id);
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    final existingByEmail = await (_db.select(
      _db.users,
    )..where((u) => u.email.equals(email)))
        .getSingleOrNull();
    final existingByUsername = await (_db.select(
      _db.users,
    )..where((u) => u.username.equals(username)))
        .getSingleOrNull();

    if (existingByEmail != null || existingByUsername != null) {
      throw AuthenticationException('Username lub email już istnieje');
    }

    final id = DateTime.now().microsecondsSinceEpoch.toString();
    await _db.into(_db.users).insert(
          UsersCompanion.insert(
            id: id,
            username: username,
            email: email,
            password: password,
          ),
        );
    await _saveSession(id);
  }
}
