import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../features/auth/auth_provider.dart";
import "../../features/theme/theme_provider.dart";
import "../../themes/enums/mode_theme.dart";
import "../../themes/utils.dart";

class UserDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final authAsync = ref.watch(authNotifierProvider);
    final modeTheme = themeAsync.valueOrNull ?? ModeTheme.system;
    final isDark = _isDark(modeTheme, context);

    return Drawer(
        child: Column(children: [
      authAsync.when(
        data: (email) {
          return UserAccountsDrawerHeader(
            accountName: const Text("Witaj,"),
            accountEmail: Text(email!),
            decoration: BoxDecoration(color: context.colorScheme.primary),
          );
        },
        error: (error, stack) => const Center(child: Text("Brak miejsc")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      const SizedBox(height: 8),
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () async {
            await ref.read(themeNotifierProvider.notifier).toggleTheme();
          },
          label: const Text("Zmień motyw"),
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          iconAlignment: IconAlignment.end,
        ),
      ),
      const SizedBox(height: 15),
      TextButton.icon(
          onPressed: () async {
            context.pop();
            await ref.read(authNotifierProvider.notifier).logout();
          },
          icon: const Icon(Icons.logout),
          label: const Text("Wyloguj się")),
    ]));
  }

  bool _isDark(ModeTheme modeTheme, BuildContext context) {
    return switch (modeTheme) {
      ModeTheme.dark => true,
      ModeTheme.light => false,
      ModeTheme.system => context.isDarkMode,
    };
  }
}
