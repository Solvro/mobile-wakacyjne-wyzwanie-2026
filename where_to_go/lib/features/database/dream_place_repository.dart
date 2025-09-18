import "dart:typed_data";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart" show debugPrint;
import "package:flutter_riverpod/flutter_riverpod.dart" show Ref;

import "../auth/tokens_provider.dart";
import "dream_place.dart";

class DreamPlaceRepository {
  // Use a file-backed DB instead of in-memory so data persists across restarts

  final dio = Dio(BaseOptions(baseUrl: "https://backend-api.w.solvro.pl/"));

  final Map<String, Uint8List> _photoCache = {};

  Future<void> addDreamPlace(DreamPlace place) async {
    await dio.post<Map<String, dynamic>>("/places", data: {
      "name": place.name,
      "description": place.description,
      "imageUrl": place.imageUrl,
      "isFavourite": place.isFavourite,
    });
  }

  Future<List<dynamic>> getAllDreamPlaces(Ref ref) async {
    debugPrint("entering getAllDreamPlaces");

    final tokens = await ref.read(tokensProvider.future);
    final accessToken = tokens.$1;
    if (accessToken == null) {
      debugPrint("getAllDreamPlaces: no access token -> returning empty list");
      return <dynamic>[];
    }

    dio.options.headers = {
      "Authorization": "Bearer $accessToken",
    };

    Response<dynamic>? response;
    try {
      // request dynamic response and inspect contents
      response = await dio.get<dynamic>(
        "/places",
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
    } on DioException catch (dioErr) {
      debugPrint("getAllDreamPlaces: network error: ${dioErr.message}");
      return <dynamic>[];
    } on Object catch (e) {
      debugPrint("getAllDreamPlaces: unexpected error: $e");
      return <dynamic>[];
    }

    if (response.statusCode == 200) {
      final data = response.data;
      return [data];
    }

    return <dynamic>[];
  }

  Future<List<dynamic>> getAllDreamPlacesWithSorting(Ref ref, String sort) async {
    debugPrint("entering getAllDreamPlacesWithSorting");

    final tokens = await ref.read(tokensProvider.future);
    final accessToken = tokens.$1;
    if (accessToken == null) {
      debugPrint("getAllDreamPlacesWithSorting: no access token -> returning empty list");
      return <dynamic>[];
    }

    dio.options.headers = {
      "Authorization": "Bearer $accessToken",
    };

    Response<dynamic>? response;
    try {
      // request dynamic response and inspect contents
      response = await dio.get<dynamic>(
        "/places?sort=$sort&sortBy=string",
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
    } on DioException catch (dioErr) {
      debugPrint("getAllDreamPlacesWithSorting: network error: ${dioErr.message}");
      return <dynamic>[];
    } on Object catch (e) {
      debugPrint("getAllDreamPlacesWithSorting: unexpected error: $e");
      return <dynamic>[];
    }

    if (response.statusCode == 200) {
      final data = response.data;
      return [data];
    }

    return <dynamic>[];
  }

  Future<void> updateDreamplace(DreamPlace place) async {
    await dio.put<Map<String, dynamic>>("/places/${place.id}", data: {
      "name": place.name,
      "description": place.description,
      "imageUrl": place.imageUrl,
      "isFavourite": place.isFavourite,
    });
  }

  Future<void> toggleFavourite(int id) async {
    final placeResp = await dio.get<Map<String, dynamic>>("/places/$id");
    if (placeResp.statusCode == 200 && placeResp.data != null) {
      final data = placeResp.data!;
      final bool isFavourite = !(data["isFavourite"] as bool? ?? false);
      await dio.put<Map<String, dynamic>>("/places/$id", data: {
        "name": data["name"],
        "description": data["description"],
        "imageUrl": data["imageUrl"],
        "isFavourite": isFavourite,
      });
    }
  }

  Future<dynamic> deleteDreamPlace(int id) async {
    await dio.delete<void>("/places/$id");
  }

  Future<Uint8List?> getPhotoBytes(String? filename, String? accessToken) async {
    if (filename == null || filename.isEmpty) return null;

    // return cached bytes if available
    if (_photoCache.containsKey(filename)) {
      return _photoCache[filename];
    }

    final path = "/photos/${Uri.encodeComponent(filename)}";
    debugPrint("getPhotoBytes: requesting $path");

    try {
      final resp = await dio.get<List<int>>(
        path,
        options: Options(
          responseType: ResponseType.bytes,
          headers: accessToken != null ? {"Authorization": "Bearer $accessToken"} : null,
        ),
      );

      final body = resp.data;
      if (body == null) {
        debugPrint("getPhotoBytes: empty body");
        return null;
      }

      final bytes = Uint8List.fromList(body);
      // cache result
      _photoCache[filename] = bytes;
      return bytes;
    } on DioException catch (e) {
      debugPrint("getPhotoBytes: DioException type=${e.type} status=${e.response?.statusCode} message=${e.message}");
    } on Object catch (e, st) {
      debugPrint("getPhotoBytes: unexpected $e\n$st");
    }
    return null;
  }

  void clearPhotoCache() => _photoCache.clear();
}
