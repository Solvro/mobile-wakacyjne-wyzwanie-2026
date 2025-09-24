import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../auth/auth_provider.dart";
import "../theme/local_theme_repository.dart";
import "../theme/theme_notifier.dart";
import "shared_widgets/app_navigation_bar.dart";

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ustawienia"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(ref.watch(themeNotifierProvider).value == AppThemeMode.light
                ? Icons.dark_mode_rounded
                : Icons.light_mode_rounded),
            title: const Text("Zmień motyw"),
            onTap: themeNotifier.toggleTheme,
          ),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text("Odśwież login"),
            onTap: () async {
              try {
                await authNotifier.refreshToken();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login odświeżony!")),
                  );
                }
              } on Exception catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Nie udało się odświeżyć: $e")),
                  );
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Wyloguj się"),
            onTap: () async {
              await authNotifier.logout();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Zostałeś wylogowany")),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: const AppNavigationBar(currentIndex: 2),
    );
  }
}
