import "dart:io";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:path_provider/path_provider.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../features/photos/repository/photo_repository.dart";
import "../authed_client.dart";
import "../retrofit_client.dart";

part "photo_repository_impl.g.dart";

class PhotoRepositoryImpl implements PhotoRepository {
  final RestClient _client;

  PhotoRepositoryImpl(this._client);

  @override
  Future<String> uploadImage(File image) async {
    final uploadedImage = await _client.postImage(image);
    return uploadedImage.filename;
  }

  @override
  Future<File> downloadImage(String name) async {
    final bytes = await _client.downloadPhoto(name);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File("${tempDir.path}/$name");
    await tempFile.writeAsBytes(bytes);
    return tempFile;
  }
}

@riverpod
Future<PhotoRepository> photoRepository(Ref ref) async {
  return PhotoRepositoryImpl(await ref.watch(authedClientProvider.future));
}
