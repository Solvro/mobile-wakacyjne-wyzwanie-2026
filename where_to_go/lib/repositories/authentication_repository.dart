// lib/repositories/authentication_repository.dart
import "dart:async";
import "dart:developer" as developer;

import "package:flutter/material.dart";

import "../models/authentication_tokens.dart";
import "local_authentication_repository.dart";
import "remote_authentication_repository.dart";

class AuthenticationRepository {
  final LocalAuthenticationRepository _localAuthenticationRepository;
  final RemoteAuthenticationRepository _remoteAuthenticationRepository;
  AuthenticationTokens? _tokens;

  final _authController = StreamController<AuthenticationTokens?>.broadcast();

  AuthenticationRepository({
    required LocalAuthenticationRepository localAuthenticationRepository,
    required RemoteAuthenticationRepository remoteAuthenticationRepository,
  })  : _localAuthenticationRepository = localAuthenticationRepository,
        _remoteAuthenticationRepository = remoteAuthenticationRepository;

  Future<void> initialize() async {
    try {
      debugPrint("AuthRepo initialize started");
      _tokens = await _localAuthenticationRepository.getTokens();
      debugPrint("AuthRepo tokens: $_tokens");
      _authController.add(_tokens);
      debugPrint("AuthRepo initialize completed");
    } catch (e, stackTrace) {
      debugPrint("AuthRepo initialize error: $e,  stackTrace: $stackTrace");
      rethrow;
    }
  }

  Future<bool> get isLoggedIn async {
    final tokens = await _localAuthenticationRepository.getTokens();
    return tokens != null && tokens.isValid;
  }

  AuthenticationTokens? get tokens => _tokens;

  Stream<AuthenticationTokens?> get authStateChanges => _authController.stream;

  Future<AuthenticationTokens?> login(String email, String password) async {
    try {
      final response = await _remoteAuthenticationRepository.login(email: email, password: password);

      if (response != null) {
        _tokens = response;
        _authController.add(_tokens);
        developer.log("Login successful for: $email", name: "Auth");
        return response;
      }
      return null;
    } catch (e) {
      developer.log("Login failed: $e", name: "Auth");
      rethrow;
    }
  }

  Future<AuthenticationTokens?> register(String email, String password) async {
    try {
      final response = await _remoteAuthenticationRepository.register(email: email, password: password);

      if (response != null) {
        _tokens = response;
        _authController.add(_tokens);
        developer.log("Register successful for: $email", name: "Auth");
        return response;
      }
      return null;
    } catch (e) {
      developer.log("Register failed: $e", name: "Auth");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _localAuthenticationRepository.deleteTokens();
      _tokens = null;
      _authController.add(null);
      developer.log("User logged out", name: "Auth");
    } catch (e) {
      developer.log("Logout error: $e", name: "Auth");
      rethrow;
    }
  }

  Future<AuthenticationTokens?> refreshToken() async {
    try {
      final refreshed = await _remoteAuthenticationRepository.refreshToken();
      if (refreshed != null) {
        _tokens = refreshed;
        _authController.add(_tokens);
      }
      return refreshed;
    } catch (e) {
      developer.log("Token refresh error: $e", name: "Auth");
      rethrow;
    }
  }

  Future<void> dispose() async {
    await _authController.close();
  }
}
