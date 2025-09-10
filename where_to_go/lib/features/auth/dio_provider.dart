import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "auth_exception.dart";
import "auth_provider.dart";

part "dio_provider.g.dart";

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: "https://backend-api.w.solvro.pl/api",
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));

  final authRepo = ref.read(authRepositoryProvider);
  final authNotifier = ref.read(authNotifierProvider.notifier);
  Future<String>? refreshTokenFuture;

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await authRepo.getAccessToken();
      if (token != null) options.headers["Authorization"] = "Bearer $token";
      return handler.next(options);
    },
    onError: (DioException e, handler) async {
      if (e.response?.statusCode == 401) {
        final refreshToken = await authRepo.getRefreshToken();
        if (refreshToken != null) {
          refreshTokenFuture ??= authRepo
              .refreshToken()
              .then((data) => data["accessToken"] as String)
              .whenComplete(() => refreshTokenFuture = null);

          try {
            final newAccessToken = await refreshTokenFuture;
            e.requestOptions.headers["Authorization"] = "Bearer $newAccessToken";
            final response = await dio.fetch<Response<dynamic>>(e.requestOptions);
            return handler.resolve(response);
          } on AuthException catch (_) {
            await authNotifier.logout();
          }
        } else {
          await authNotifier.logout();
        }
      }
      return handler.next(e);
    },
  ));

  return dio;
}
