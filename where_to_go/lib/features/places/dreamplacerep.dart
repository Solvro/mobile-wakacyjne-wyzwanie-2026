import "dart:async";
import "package:dio/dio.dart";
import "../../core/api_path.dart";
import "dreamplace.dart";

abstract class DreamPlacesRepository {
  Stream<List<DreamPlace>> watchAll();
  Future<List<DreamPlace>> getAll();

  Future<void> add(DreamPlace place);
  Future<void> update(DreamPlace place);
  Future<void> delete(String id);
  Future<void> toggleFavorite(String id);

  Future<void> seedIfEmpty();
}

class DreamPlacesRepositoryRemote implements DreamPlacesRepository {
  DreamPlacesRepositoryRemote(this._dio);

  final Dio _dio;

  final _controller = StreamController<List<DreamPlace>>.broadcast();
  var _cache = <DreamPlace>[];
  var _initialized = false;

  Map<String, dynamic> _toApiJson(DreamPlace p) {
    final j = Map<String, dynamic>.from(p.toJson());
    j["isFavourite"] = j.remove("isFavorite");
    return j;
  }

  List<DreamPlace> _parsePlaces(dynamic raw) {
    dynamic list;
    if (raw is List) {
      list = raw;
    } else if (raw is Map<String, dynamic>) {
      if (raw["data"] is List) list = raw["data"];
      if (raw["items"] is List) list = raw["items"];
    }
    final iterable = (list is List) ? list : const <dynamic>[];
    return iterable.whereType<Map<String, dynamic>>().map(DreamPlace.fromJson).toList(growable: false);
  }

  Future<void> _refresh() async {
    final Response<dynamic> res = await _dio.get<dynamic>(ApiPaths.places);
    _cache = _parsePlaces(res.data);
    if (!_controller.isClosed) {
      _controller.add(List.unmodifiable(_cache));
    }
  }

  Future<void> _ensureInit() async {
    if (_initialized) return;
    _initialized = true;
    await _refresh();
  }

  @override
  Stream<List<DreamPlace>> watchAll() async* {
    await _ensureInit();
    yield List.unmodifiable(_cache);
    yield* _controller.stream;
  }

  @override
  Future<List<DreamPlace>> getAll() async {
    await _ensureInit();
    return List.unmodifiable(_cache);
  }

  @override
  Future<void> add(DreamPlace place) async {
    final body = _toApiJson(place)..remove("id");
    await _dio.post<void>(ApiPaths.places, data: body);
    await _refresh();
  }

  @override
  Future<void> update(DreamPlace place) async {
    final payload = _toApiJson(place);
    await _dio.put<void>(ApiPaths.placeById(place.id), data: payload);
    await _refresh();
  }

  @override
  Future<void> delete(String id) async {
    await _dio.delete<void>(ApiPaths.placeById(id));
    await _refresh();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final idx = _cache.indexWhere((p) => p.id == id);
    if (idx == -1) {
      await _refresh();
      return;
    }
    final newValue = !_cache[idx].isFavorite;

    await _dio.put<void>(
      ApiPaths.placeById(id),
      data: {"isFavourite": newValue},
    );
    await _refresh();
  }

  @override
  Future<void> seedIfEmpty() async {}

  Future<void> dispose() async {
    await _controller.close();
  }
}
