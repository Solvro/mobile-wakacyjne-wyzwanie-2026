import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";
import "features/theme/app_theme.dart";
import "features/theme/local_theme_repository.dart";
import "features/theme/theme_notifier.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final appTheme = AppTheme();
    ThemeMode themeMode = ThemeMode.system;
    themeAsync.whenData((mode) {
      themeMode = switch (mode) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      };
    });

    return MaterialApp.router(
      title: "Where2Go",
      themeMode: themeMode,
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      routerConfig: goRouter,
    );
  }
}
