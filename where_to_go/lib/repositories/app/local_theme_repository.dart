import "../../themes/enums/mode_theme.dart";

abstract class LocalThemeRepository {
  Future<ModeTheme> getTheme();

  Future<void> setTheme(ModeTheme theme);
}
