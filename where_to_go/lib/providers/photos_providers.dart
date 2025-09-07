// lib/providers/photos_providers.dart
import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../repositories/photos_repository.dart";
import "./auth_providers.dart";

final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  final dio = ref.read(dioProvider);
  final authRepo = ref.read(authRepositoryProvider);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      try {
        final tokens = authRepo.tokens;
        if (tokens != null) {
          options.headers["Authorization"] = "Bearer ${tokens.accessToken}";
        }
      } on Exception {
        // Ignoruj błędy przy pobieraniu tokenów
      }
      return handler.next(options);
    },
  ));

  return PhotosRepository(
    dio: dio,
    baseUrl: dio.options.baseUrl,
  );
});
