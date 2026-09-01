import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
class Themem extends _$Themem {
  static const _key = 'is_light_theme';
  @override
  Future<bool?> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key); // stan początkowy
  }

  Future<void> toggle(bool value) async {
    // metoda pozwaląca zmienić stan providera

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, value);
    state = AsyncData(value);
  }
}
