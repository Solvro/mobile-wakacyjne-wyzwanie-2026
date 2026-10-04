import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveAccessKey(String accessKey) async {
    await _storage.write(key: 'access-key', value: accessKey);
  }

  Future<String?> getAccessKey() async {
    final accessKey = await _storage.read(key: 'access-key');
    return accessKey;
  }

  Future<void> deleteAccessKey() async {
    await _storage.delete(key: 'access-key');
  }
}
