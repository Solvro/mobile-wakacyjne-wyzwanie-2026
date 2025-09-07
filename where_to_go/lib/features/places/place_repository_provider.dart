import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../repositories/app/dream_places_repository.dart";
import "../../repositories/implementations/app/dream_places_repository_impl.dart";
import "../auth/http_provider.dart";

part "place_repository_provider.g.dart";

@Riverpod(keepAlive: true)
Future<DreamPlacesRepository> dreamPlacesRepository(Ref ref) async {
  final dio = await ref.watch(clientDioProvider.future);

  return DreamPlacesRepositoryImpl(dio);
}
