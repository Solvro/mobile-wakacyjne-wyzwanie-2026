import "dart:async";
import "package:dio/dio.dart";
import "../features/auth/authentication_repository.dart";
import "api_path.dart";

Dio buildAuthorizedDio(AuthenticationRepository auth) {
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
    request: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
  ));

  Completer<bool>? refreshCompleter;

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await auth.readAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
      handler.next(options);
    },
    onError: (err, handler) async {
      final status = err.response?.statusCode ?? 0;

      final path = err.requestOptions.path;
      if (status != 401 || path == ApiPaths.refresh) {
        return handler.next(err);
      }

      refreshCompleter ??= Completer<bool>()..complete(_runRefresh(auth));
      final ok = await refreshCompleter!.future.catchError((_) => false);
      refreshCompleter = null;

      if (!ok) {
        await auth.logout();
        return handler.next(err);
      }

      final newAccess = await auth.readAccessToken();
      final ro = err.requestOptions;
      ro.headers["Authorization"] = "Bearer $newAccess";

      try {
        final cloneResponse = await dio.fetch<Response<dynamic>>(ro);
        return handler.resolve(cloneResponse);
      } on Exception catch (_) {
        return handler.next(err);
      }
    },
  ));

  return dio;
}

Future<bool> _runRefresh(AuthenticationRepository auth) async {
  try {
    return await auth.refreshToken();
  } on Exception catch (_) {
    return false;
  }
}
