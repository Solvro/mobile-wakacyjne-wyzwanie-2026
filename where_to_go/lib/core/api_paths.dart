class ApiPaths {
  static const baseUrl = "https://backend-api.w.solvro.pl";
  static const login = "/auth/login";
  static const register = "/auth/register";
  static const refresh = "/auth/refresh";
  static const me = "/auth/me";
  static const places = "/places";
  static String placeById(int? id) => "/places/$id";
  static String photoByFileName(String? fileName) => "photos/$fileName";
}