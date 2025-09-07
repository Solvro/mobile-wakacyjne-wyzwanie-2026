import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../data/models/create_place_dto.dart";
import "../../../data/models/dream_place.dart";
import "../../../features/places/repository/dream_place_repository.dart";
import "../authed_client.dart";
import "../retrofit_client.dart";

part "dream_place_repository_impl.g.dart";

class DreamPlaceRepositoryImpl implements DreamPlaceRepository {
  final RestClient _client;

  DreamPlaceRepositoryImpl(this._client);

  @override
  Future<List<DreamPlace>> getAll({SortOrder ordering = SortOrder.asc}) async {
    final places = await _client.getPlaces(ordering.name, "name");
    return places.results;
  }

  @override
  Future<DreamPlace> get(int id) async {
    return _client.getPlace(id);
  }

  @override
  Future<void> delete(int id) async {
    await _client.deletePlace(id);
  }

  @override
  Future<DreamPlace> save({
    required String name,
    required String description,
    required String imageUrl,
    bool isFavourite = false,
  }) async {
    final createPlace = CreatePlaceDTO(
      name: name,
      description: description,
      imageUrl: imageUrl,
      isFavourite: isFavourite,
    );
    return _client.postPlace(createPlace);
  }

  @override
  Future<DreamPlace> updatePlace(
    int id, {
    String? name,
    String? description,
    String? imageUrl,
    bool? isFavourite,
  }) async {
    final createPlace = CreatePlaceDTO(
      name: name,
      description: description,
      imageUrl: imageUrl,
      isFavourite: isFavourite,
    );
    return _client.updatePlace(id, createPlace);
  }

  @override
  Future<DreamPlace> toggleFavorite(int id, {required bool newValue}) async {
    final updatedPlace = CreatePlaceDTO(isFavourite: newValue);
    return _client.updatePlace(id, updatedPlace);
  }
}

@riverpod
Future<DreamPlaceRepository> dreamPlaceRepository(Ref ref) async {
  final client = await ref.watch(authedClientProvider.future);
  return DreamPlaceRepositoryImpl(client);
}
