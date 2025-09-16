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
  Future<void> toggleFavourite(String id);

  Future<void> seedIfEmpty();
}

class DreamPlacesRepositoryRemote implements DreamPlacesRepository {
  DreamPlacesRepositoryRemote(this._dio);

  final Dio _dio;

  final _controller = StreamController<List<DreamPlace>>.broadcast();
  var _cache = <DreamPlace>[];
  var _initialized = false;

  Future<void> _refresh() async {
    final res = await _dio.get<List<dynamic>>(ApiPaths.dreamPlaces);
    final data = res.data ?? const <dynamic>[];
    _cache = data
        .map((e) => _fromJson(e as Map<String, dynamic>))
        .toList(growable: false);

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
    final body = Map<String, dynamic>.from(_toJson(place))..remove("id");
    await _dio.post<void>(ApiPaths.dreamPlaces, data: body);
    await _refresh();
  }

  @override
  Future<void> update(DreamPlace place) async {
    try {
      await _dio.patch<void>(ApiPaths.dreamPlaceById(place.id), data: _toJson(place));
    } on DioException catch (e) {
      final sc = e.response?.statusCode ?? 0;
      if (sc == 404 || sc == 405) {
        await _dio.put<void>(ApiPaths.dreamPlaceById(place.id), data: _toJson(place));
      } else {
        rethrow;
      }
    }
    await _refresh();
  }

  @override
  Future<void> delete(String id) async {
    await _dio.delete<void>(ApiPaths.dreamPlaceById(id));
    await _refresh();
  }

  @override
  Future<void> toggleFavourite(String id) async {
    final idx = _cache.indexWhere((p) => p.id == id);
    if (idx == -1) {
      await _refresh();
      return;
    }
    final newValue = !_cache[idx].isFavourite;
    await _dio.patch<void>(
      ApiPaths.dreamPlaceById(id),
      data: {"isFavorite": newValue},
    );
    await _refresh();
  }

  @override
  Future<void> seedIfEmpty() async {

  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

DreamPlace _fromJson(Map<String, dynamic> j) {
  return DreamPlace(
    id: (j["id"] ?? j["_id"] ?? "").toString(),
    name: (j["name"] ?? j["title"] ?? "") as String,
    description: (j["description"] ?? "") as String,
    assetPath: (j["assetPath"] ?? j["imageUrl"] ?? j["photoUrl"] ?? "") as String,
    isFavourite: (j["isFavorite"] ?? j["isFavourite"] ?? j["favorite"] ?? false) as bool,
  );
}

Map<String, dynamic> _toJson(DreamPlace p) => <String, dynamic>{
      "id": p.id,                
      "name": p.name,
      "description": p.description,
      "imageUrl": p.assetPath,    
      "isFavorite": p.isFavourite 
    };
