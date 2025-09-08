import "dart:ui";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../providers/local_theme_provider.dart";
import "../repositories/local_theme_repository.dart";

bool isDarkMode(BuildContext context, WidgetRef ref) {
  final deviceTheme = MediaQuery.platformBrightnessOf(context);
  final theme = ref.watch(localThemeProvider);
  return theme.value == LocalThemeEnum.dark ||
      (deviceTheme == Brightness.dark && theme.value == LocalThemeEnum.defaultTheme);
}
