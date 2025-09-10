import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../auth/dio_provider.dart";
import "photos_repository.dart";

part "photos_repository_provider.g.dart";

@riverpod
PhotosRepository photosRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return PhotosRepository(dio);
}
