import "dart:io";

import "package:dio/dio.dart";

import "../../../models/place/photo_response_dto.dart";
import "../../app/photos_repository.dart";

class PhotosRepositoryImpl implements PhotosRepository {
  final Dio _dio;

  PhotosRepositoryImpl(this._dio);

  @override
  Future<String> uploadPhoto(File image) async {
    final fileName = image.path.split("/").last;
    final formData = FormData.fromMap({"file": await MultipartFile.fromFile(image.path, filename: fileName)});
    final response = await _dio.post<Map<String, dynamic>>("/photos/upload", data: formData);
    final photoResponseDto = PhotoResponseDto.fromJson(response.data!);

    return photoResponseDto.filename;
  }
}
