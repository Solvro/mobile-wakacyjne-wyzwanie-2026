import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../features/themes/theme_provider.dart";

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  static const route = "/settings";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Ustawienia"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          color: Colors.white,
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Motyw", style: Theme.of(context).textTheme.bodyMedium),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (ThemeMode? newMode) {
                if (newMode != null) {
                  ref
                      .watch(themeControllerProvider.notifier)
                      .setThemeMode(newMode);
                }
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(
                    "Systemowy",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(
                    "Jasny",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(
                    "Ciemny",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
