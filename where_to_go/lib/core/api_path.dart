class ApiConfig {
  static const baseUrl = "https://backend-api.w.solvro.pl/api";
}

class ApiPaths {
  static const login = "auth/login";
  static const register = "auth/register";
  static const refresh = "auth/refresh";

  static const dreamPlaces = "dream-places";
  static String dreamPlaceById(String id) => "dream-places/$id";
}
