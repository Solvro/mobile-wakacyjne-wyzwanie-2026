import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";
import "features/theme/providers/theme_provider.dart";
import "features/theme/repositories/local_theme_repository.dart";

class ThemeProvider extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) {
        final theme = ref.watch(localThemeStateProvider);
        final deviceTheme = MediaQuery.platformBrightnessOf(context);

        final defaultTheme = deviceTheme == Brightness.dark ? LocalTheme.dark : LocalTheme.light;
        return MaterialApp.router(
            routerConfig: goRouter,
            theme: switch (theme) {
              AsyncData(value: (final value)) => value.themeData ?? defaultTheme.themeData,
              _ => defaultTheme.themeData
            });
      },
    );
  }
}

void main() {
  runApp(ProviderScope(
    child: ThemeProvider(),
  ));
}
