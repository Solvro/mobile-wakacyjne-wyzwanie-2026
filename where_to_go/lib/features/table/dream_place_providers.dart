import "package:flutter_riverpod/flutter_riverpod.dart";
import "/features/places/place_model.dart";
import "../../authentication/http_client.dart";
import "dream_place_repository.dart";

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(null); 
});

final dreamPlacesRepositoryProvider = Provider<DreamPlaceRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DreamPlaceRepository(apiClient);
});

final dreamPlacesProvider = FutureProvider<List<PlaceModel>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.getAllPlaces();
});

final dreamPlaceProvider = FutureProvider.family<PlaceModel, String>((ref, id) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.getPlace(int.parse(id));
});
