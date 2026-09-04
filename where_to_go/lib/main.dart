import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

import "app_router.dart";
import "features/themes/theme_provider.dart";
import "features/themes/app_themes.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    return OrientationBuilder(
      builder: (context, orientation) {
        return MaterialApp.router(
          themeMode: themeMode,
          theme: AppThemes.lightTheme(orientation),
          darkTheme: AppThemes.darkTheme(orientation),
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        );
      },
    );
  }
}
