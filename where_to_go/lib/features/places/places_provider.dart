import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'dream_place.dart';
import 'dream_places_repository.dart';

part 'places_provider.g.dart';

final dreamPlacesBoxProvider = Provider<Box<DreamPlace>>((ref) {
  throw UnimplementedError('Box<DreamPlace> wymaga nadpisania w main.dart');
});

final dreamPlacesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  return DreamPlacesRepository(ref.watch(dreamPlacesBoxProvider));
});

@riverpod
class Places extends _$Places {
  @override
  List<DreamPlace> build() {
    final repository = ref.watch(dreamPlacesRepositoryProvider);
    return repository.getAllPlaces();
  }

  Future<void> toggle(String id) async {
    final repository = ref.read(dreamPlacesRepositoryProvider);
    await repository.toggleFavorite(id);
    state = repository.getAllPlaces();
  }
}
