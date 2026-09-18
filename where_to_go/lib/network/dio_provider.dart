import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
FlutterSecureStorage secureStorage(ref) {
  return const FlutterSecureStorage();
}

@riverpod
Dio dio(ref) {
  final storage = ref.watch(secureStorageProvider);
  final options = BaseOptions(
    baseUrl: 'http://10.0.2.2:3000',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );
  final dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) {
        return handler.next(error);
      },
    ),
  );

  return dio;
}
