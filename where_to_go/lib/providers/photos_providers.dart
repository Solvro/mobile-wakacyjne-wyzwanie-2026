// lib/providers/photos_providers.dart
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../repositories/photos_repository.dart";
import "./auth_providers.dart";

final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  final dioBase = ref.read(dioProvider);
  final authRepo = ref.read(authRepositoryProvider);

  // 🔹 Tworzymy kopię Dio, żeby nie dodawać interceptorów wielokrotnie
  final dio = Dio(BaseOptions(
    baseUrl: dioBase.options.baseUrl,
    connectTimeout: dioBase.options.connectTimeout,
    receiveTimeout: dioBase.options.receiveTimeout,
    sendTimeout: dioBase.options.sendTimeout,
    validateStatus: (status) => status != null && status < 500,
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      try {
        final tokens = authRepo.tokens;
        if (tokens != null) {
          options.headers["Authorization"] = "Bearer ${tokens.accessToken}";
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (_) {
        // Ignoruj brak tokenów
      }
      return handler.next(options);
    },
  ));

  return PhotosRepository(apiUrl: dioBase.options.baseUrl);
});
