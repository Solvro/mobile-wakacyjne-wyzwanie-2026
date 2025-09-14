import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "auth/auth_provider.dart";

part "dio_provider.g.dart";

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://backend-api.w.solvro.pl/",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  dio.interceptors.add(AuthInterceptor(ref));

  return dio;
}

class AuthInterceptor extends Interceptor {
  final Ref _ref;

  AuthInterceptor(this._ref);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final authRepo = _ref.read(authenticationRepositoryProvider);
    final accessToken = await authRepo.getAccessToken();

    if (accessToken != null) {
      options.headers["Authorization"] = "Bearer $accessToken";
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final authRepo = _ref.read(authenticationRepositoryProvider);

    if (err.response?.statusCode == 401 && !err.requestOptions.extra.containsKey("retry")) {
      final refreshToken = await authRepo.getRefreshToken();

      if (refreshToken == null) {
        await authRepo.logout();
        return handler.next(err);
      }

      try {
        final newTokens = await authRepo.refreshToken(refreshToken);

        final requestOptions = err.requestOptions..extra["retry"] = true;

        final accessToken = newTokens.accessToken;
        requestOptions.headers["Authorization"] = "Bearer $accessToken";

        final retryResponse = await _ref.read(dioProvider).fetch<Response<dynamic>>(requestOptions);

        return handler.resolve(retryResponse);
      } on DioException catch (refreshErr) {
        await authRepo.logout();
        return handler.next(refreshErr);
      }
    }
    return handler.next(err);
  }
}
