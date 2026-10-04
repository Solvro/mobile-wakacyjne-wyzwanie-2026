import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../features/auth/token_storage.dart";

part "dio_provider.g.dart";

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://backend-api.w.solvro.pl",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  final tokenStorage = TokenStorage();

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await tokenStorage.getToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
}
