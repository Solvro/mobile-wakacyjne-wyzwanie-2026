// Добавьте эти провайдеры в ваш существующий файл dream_place_providers.dart

import "package:flutter_riverpod/flutter_riverpod.dart";
import "/features/places/place_model.dart";
import "../../authentication/http_client.dart";
import "../../dream_place_service.dart";
import "../../photos_repository.dart";
import "dream_place_repository.dart";

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient.instance; 
});

final dreamPlacesRepositoryProvider = Provider<DreamPlaceRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DreamPlaceRepository(apiClient);
});

final photosRepositoryProvider = Provider<PhotosRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return PhotosRepository(apiClient);
});

final dreamPlaceServiceProvider = Provider<DreamPlaceService>((ref) {
  final dreamPlaceRepository = ref.watch(dreamPlacesRepositoryProvider);
  final photosRepository = ref.watch(photosRepositoryProvider);
  return DreamPlaceService(dreamPlaceRepository, photosRepository);
});

final dreamPlacesProvider = FutureProvider<List<PlaceModel>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.getAllPlaces();
});

final dreamPlaceProvider = FutureProvider.family<PlaceModel, String>((ref, id) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.getPlace(int.parse(id));
});