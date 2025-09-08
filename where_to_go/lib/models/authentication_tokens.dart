//lib/models/authentication_tokens.dart
class AuthenticationTokens {
  final String accessToken;
  final String refreshToken;

  AuthenticationTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
    };
  }

  factory AuthenticationTokens.fromJson(Map<String, dynamic> json) {
    return AuthenticationTokens(
      accessToken: json["accessToken"] as String,
      refreshToken: json["refreshToken"] as String,
    );
  }

  bool get isValid => accessToken.isNotEmpty && refreshToken.isNotEmpty;
}
