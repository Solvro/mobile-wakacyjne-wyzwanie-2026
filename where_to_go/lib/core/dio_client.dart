import "dart:async";
import "package:dio/dio.dart";
import "../core/api_path.dart";
import "../features/auth/authentication_repository.dart";

Dio buildAuthorizedDio(AuthenticationRepository auth) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl, 
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    validateStatus: (s) => s != null && s < 500,
  ));

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    responseHeader: false,
  ));

  Completer<String?>? refreshCompleter;

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await auth.readAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
      handler.next(options);
    },

    onError: (error, handler) async {
      final status = error.response?.statusCode;
      if (status != 401) {
        return handler.next(error);
      }

      if (refreshCompleter != null) {
        try {
          final newToken = await refreshCompleter!.future;
          if (newToken == null || newToken.isEmpty) {
            await auth.logout();
            return handler.next(error);
          }
          final req = error.requestOptions;
          req.headers["Authorization"] = "Bearer $newToken";
          final clone = await dio.fetch<dynamic>(req);
          return handler.resolve(clone);
        } on Exception catch (_) {
          await auth.logout();
          return handler.next(error);
        }
      }

      refreshCompleter = Completer<String?>();
      try {
        final refreshToken = await auth.readRefreshToken();
        if (refreshToken == null || refreshToken.isEmpty) {
          refreshCompleter!.complete(null);
          await auth.logout();
          return handler.next(error);
        }

        final bare = Dio(BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          headers: {"Content-Type": "application/json", "Accept": "application/json"},
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          validateStatus: (s) => s != null && s < 500,
        ));

        final resp = await bare.post<Map<String, dynamic>>(
          ApiPaths.refresh,
          data: {"refreshToken": refreshToken},
        );

        if (resp.statusCode == 200) {
          final newAccess = (resp.data?["accessToken"] as String?) ?? "";
          if (newAccess.isNotEmpty) {
            await auth.saveAccessToken(newAccess);
            refreshCompleter!.complete(newAccess);

            final req = error.requestOptions;
            req.headers["Authorization"] = "Bearer $newAccess";
            final clone = await dio.fetch<dynamic>(req);
            return handler.resolve(clone);
          }
        }

        refreshCompleter!.complete(null);
        await auth.logout();
        return handler.next(error);
      } catch (e) {
        refreshCompleter!.completeError(e);
        await auth.logout();
        return handler.next(error);
      } finally {
        refreshCompleter = null;
      }
    },
  ));

  return dio;
}
