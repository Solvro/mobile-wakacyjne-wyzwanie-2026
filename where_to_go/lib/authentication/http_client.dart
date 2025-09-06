import "package:dio/dio.dart";

class ApiClient {
  final Dio _dio;

  factory ApiClient(String? accessToken) {
    if (_instance == null || accessToken != null) {
      _instance = ApiClient._internal(accessToken);
    }
    return _instance!;
  }

  ApiClient._internal(String? accessToken)
      : _dio = Dio(BaseOptions(
          baseUrl: "https://backend-api.w.solvro.pl",
          headers: accessToken != null
              ? {"Authorization": accessToken}
              : {},
        ));

  static ApiClient? _instance;

  Dio get dio => _dio;
}
