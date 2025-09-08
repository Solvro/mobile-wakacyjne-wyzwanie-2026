// lib/providers/photos_providers.dart
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../repositories/photos_repository.dart";
import "auth_providers.dart";

/// Provider dla PhotosRepository
final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PhotosRepository(apiUrl: dio.options.baseUrl);
});
