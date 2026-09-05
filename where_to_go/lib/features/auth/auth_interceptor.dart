import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_providers.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.ref);
  final Ref ref;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final key = await ref.read(authRepositoryProvider).getKey();

    if (key != null) {
      options.headers["Authorization"] = "Bearer $key";
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401) {
      ref.read(authRepositoryProvider).logoutUser();
    }
    return handler.next(err);
  }
}
