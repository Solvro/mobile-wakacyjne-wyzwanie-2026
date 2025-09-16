import "dart:async";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../auth/auth_providers.dart" show dioProvider;
import "dreamplace.dart";
import "dreamplacerep.dart";

final dreamPlacesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repo = DreamPlacesRepositoryRemote(dio);

  ref.onDispose(() {
    unawaited(repo.dispose());
  });

  return repo;
});

final dreamPlacesStreamProvider = StreamProvider.autoDispose<List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.watchAll();
});

final dreamPlacesProvider = FutureProvider.autoDispose<List<DreamPlace>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return repo.getAll();
});

final dreamPlacesControllerProvider =
    StateNotifierProvider.autoDispose<DreamPlacesController, AsyncValue<List<DreamPlace>>>((ref) {
  final repo = ref.watch(dreamPlacesRepositoryProvider);
  return DreamPlacesController(repo);
});

class DreamPlacesController extends StateNotifier<AsyncValue<List<DreamPlace>>> {
  DreamPlacesController(this._repo) : super(const AsyncValue.loading()) {
    _sub = _repo.watchAll().listen(
          (items) => state = AsyncValue.data(items),
          onError: (Object e, StackTrace st) => state = AsyncValue.error(e, st),
        );
  }

  final DreamPlacesRepository _repo;
  StreamSubscription<List<DreamPlace>>? _sub;

  @override
  void dispose() {
    unawaited(_sub?.cancel());
    super.dispose();
  }

  Future<void> refresh() async {
    try {
      final items = await _repo.getAll();
      state = AsyncValue.data(items);
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(DreamPlace place) async {
    state = const AsyncValue.loading();
    await _repo.add(place);
  }

  Future<void> update(DreamPlace place) async {
    state = const AsyncValue.loading();
    await _repo.update(place);
  }

  Future<void> delete(String id) async {
    state = const AsyncValue.loading();
    await _repo.delete(id);
  }

  Future<void> toggleFavourite(String id) async {
    await _repo.toggleFavourite(id);
  }
}
