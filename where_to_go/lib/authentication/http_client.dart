import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

class ApiClient {
  final Dio _dio;

  ApiClient._internal()
      : _dio = Dio(
          BaseOptions(
            baseUrl: "https://backend-api.w.solvro.pl",
          ),
        ) {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint("📡 $obj"),
      ),
    );
  }

  static final _instance = ApiClient._internal();

  static ApiClient get instance => _instance;

  Dio get dio => _dio;

  void setAccessToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  void clearAccessToken() {
    _dio.options.headers.remove("Authorization");
  }
}
