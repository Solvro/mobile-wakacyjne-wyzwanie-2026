import "dart:convert";
import "package:http/http.dart" as http; 

class RemoteAuthenticationRepository {
  final baseUrl = "https://backend-api.w.solvro.pl";

  Future<AuthResponse> login(String email, String password) async {
    final uri = Uri.parse("$baseUrl/auth/login");

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return AuthResponse.fromJson(data);
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  Future<RegisterResponse> register(String email, String password) async {
    final uri = Uri.parse("$baseUrl/auth/register");

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return RegisterResponse.fromJson(data);
    } else {
      throw Exception("Register failed: ${response.body}");
    }
  }

  Future<RefreshResponse> refresh(String refreshToken) async {
    final uri = Uri.parse("$baseUrl/auth/refresh");

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "refreshToken": refreshToken,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return RefreshResponse.fromJson(data);
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }
}

class AuthResponse {
  final String accessToken;

  AuthResponse({
    required this.accessToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json){
    return AuthResponse(
      accessToken: json["accessToken"] as String, 
    );
  }
}

class RegisterResponse {
  final String accessToken;
  final String refreshToken;

  RegisterResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      accessToken: json["accessToken"] as String,
      refreshToken: json["refreshToken"] as String
    );
  }
}

class RefreshResponse {
  final String refreshToken;

  RefreshResponse({
    required this.refreshToken,
  });

  factory RefreshResponse.fromJson(Map<String, dynamic> json){
    return RefreshResponse(
      refreshToken: json["refreshToken"] as String
    );
  }
}
