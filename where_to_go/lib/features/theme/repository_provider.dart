import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../repositories/app/local_theme_repository.dart";
import "../../repositories/implementations/app/local_theme_repository_impl.dart";

part "repository_provider.g.dart";

@Riverpod(keepAlive: true)
Future<LocalThemeRepository> localThemeRepository(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return LocalThemeRepositoryImpl(prefs);
}
