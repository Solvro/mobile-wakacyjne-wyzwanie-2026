import "../../../data/models/dream_place.dart";

enum SortOrder { asc, desc }

abstract class DreamPlaceRepository {
  const DreamPlaceRepository();

  Future<List<DreamPlace>> getAll({SortOrder ordering});

  Future<DreamPlace> get(int id);

  Future<void> delete(int id);

  Future<DreamPlace> save({
    required String name,
    required String description,
    required String imageUrl,
    bool isFavourite = false,
  });

  Future<DreamPlace> updatePlace(
    int id, {
    String? name,
    String? description,
    String? imageUrl,
    bool? isFavourite,
  });

  Future<DreamPlace> toggleFavorite(int id, {required bool newValue});
}
