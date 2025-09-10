import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../database/dream_place_provider.dart";
import "dream_place_service.dart";
import "photos_repository_provider.dart";

part "dream_place_service_provider.g.dart";

@riverpod
DreamPlaceService dreamPlaceService(Ref ref) {
  final photosRepository = ref.watch(photosRepositoryProvider);
  final dreamPlacesRepository = ref.watch(dreamPlacesRepositoryProvider);
  return DreamPlaceService(
    photosRepository: photosRepository,
    dreamPlacesRepository: dreamPlacesRepository,
  );
}
