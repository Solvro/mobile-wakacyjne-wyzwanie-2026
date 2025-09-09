import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "features/routing/app_router.dart";
import "features/themes/app_theme.dart";
import "features/themes/local_theme_repository.dart";
import "features/themes/theme_notifier.dart";

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final appTheme = AppThemeImplementation();
    final router = ref.watch(goRouterProvider);

    return themeAsync.when(
      data: (theme) {
        final themeMode = switch (theme) {
          AppTheme.light => ThemeMode.light,
          AppTheme.dark => ThemeMode.dark,
          AppTheme.system => platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
        };

        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: appTheme.light,
          darkTheme: appTheme.dark,
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (error, stack) => MaterialApp(
        home: Scaffold(body: Center(child: Text("Błąd: $error"))),
      ),
    );
  }
}
