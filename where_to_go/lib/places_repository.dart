import "dart:async";
import "dart:typed_data";

import "package:dio/dio.dart";
import "package:reactive_image_picker/reactive_image_picker.dart";

import "models/dream_place.dart";

enum SortOrder {
  asc,
  desc;

  String get value => name;
}

class PlacesRepository {
  final Dio _dio;

  PlacesRepository(this._dio) {
    unawaited(getAllPlaces());
  }

  Future<List<DreamPlace>> getAllPlaces({SortOrder? sort}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      "/places",
      queryParameters: {
        "sort": sort?.value ?? SortOrder.asc.value,
        "sortBy": "name",
      },
    );
    final data = response.data?["results"] as List<dynamic>;
    return data.map((e) => DreamPlace.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<DreamPlace?> getPlaceById(int id) async {
    final response = await _dio.get<Map<String, dynamic>>("/places/$id");
    return response.data != null ? DreamPlace.fromJson(response.data!) : null;
  }

  Future<void> addPlace(DreamPlace place) async {
    await _dio.post<Map<String, dynamic>>("/places", data: place.toJson());
  }

  Future<void> updatePlace(DreamPlace place) async {
    await _dio.put<Map<String, dynamic>>("/places/${place.id}", data: place.toJson());
  }

  Future<void> updateFavorite(int id, {required bool isFavorite}) async {
    await _dio.put<Map<String, dynamic>>("/places/$id", data: {"isFavourite": isFavorite});
  }

  Future<void> deletePlace(int id) async {
    await _dio.delete<Map<String, dynamic>>("/places/$id");
  }

  Future<Uint8List> getPhoto(String filename) async {
    final response = await _dio.get<List<int>>(
      "/photos/$filename",
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    return Uint8List.fromList(response.data!);
  }

  Future<void> addPlaceFromForm(
      {required String city, required String country, required String description, required XFile imageFile}) async {
    final filename = await addPhoto(imageFile);
    final name = "$city, $country";
    await addPlace(DreamPlace(id: 0, name: name, description: description, imageUrl: filename));
  }

  Future<String> addPhoto(XFile imageFile) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.name,
      ),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      "/photos/upload",
      data: formData,
    );

    return (response.data?["filename"] ?? "") as String;
  }

  Future<void> updatePlaceFromForm(
      {required int id,
      required String city,
      required String country,
      required String description,
      XFile? imageFile}) async {
    String filename = "";
    if (imageFile != null) {
      filename = await addPhoto(imageFile);
    } else {
      final existingPlace = await getPlaceById(id);
      if (existingPlace != null) {
        filename = existingPlace.imageUrl;
      }
    }
    final name = "$city, $country";
    await updatePlace(DreamPlace(id: id, name: name, description: description, imageUrl: filename));
  }

  /* // InfoColumns
  Future<List<InfoColumn>> getInfoColumnsByPlaceId(int dreamPlaceId) {
    return _db.getInfoColumnsByPlaceId(dreamPlaceId);
  }

  Stream<List<InfoColumn>> watchInfoColumnsByPlaceId(int dreamPlaceId) {
    return (_db.select(_db.infoColumns)..where((tbl) => tbl.dreamPlaceId.equals(dreamPlaceId))).watch();
  }

  Future<void> addInfoColumn(InfoColumnsCompanion column) async {
    await _db.insertInfoColumn(column);
  }

  Future<void> updateInfoColumn(int id, InfoColumnsCompanion column) async {
    await _db.updateInfoColumn(id, iconName: column.iconName.value, infoText: column.infoText.value);
  }

  Future<void> deleteInfoColumn(int id) async {
    await _db.deleteInfoColumn(id);
  }

  Future<void> deleteInfoColumnsByPlaceId(int dreamPlaceId) async {
    await _db.deleteInfoColumnsByPlaceId(dreamPlaceId);
  }
  */
}
