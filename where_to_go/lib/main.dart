import 'package:flutter/material.dart';
import 'package:flutter_application_1/dreamplacescreen.dart';
import 'package:flutter_application_1/features/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.dart';
import 'package:go_router/go_router.dart';
import 'features/places/places_provider.dart';
import 'features/places/place.dart';
import 'theme.dart';
import 'auth/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localThemeRepository = ref.watch(thememProvider);
    return localThemeRepository.when(
      data: (mode) => MaterialApp.router(
        routerConfig: ref.watch(goRouterProvider),
        title: 'Wybierz miejsce',
        theme: lighttheme,
        darkTheme: darktheme,
        themeMode: switch (mode) {
          true => ThemeMode.light,
          false => ThemeMode.dark,
          null => ThemeMode.system,
        },
      ),
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (err, stack) => const MaterialApp(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  Card maker(BuildContext context, Place dps) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(dps.title, style: TextStyle(fontSize: 20)),
        leading: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(dps.path, fit: BoxFit.cover),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            Icon(dps.isFavorite ? Icons.favorite : Icons.favorite_border),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () {
          GoRouter.of(context).push("${DreamPlaceScreen.route}/${dps.id}");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);
    return placesAsync.when(
      data: (places) => Scaffold(
        body: ListView(children: [for (final p in places) maker(context, p)]),
        appBar: AppBar(
          title: Text("Wybierz miejsce"),
          actions: [
            Row(
              children: [
                Text("Tryb jasny"),
                Switch(
                  value: ref.watch(thememProvider).value ?? false,
                  onChanged: ((value) {
                    ref.read(thememProvider.notifier).toggle(value);
                  }),
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Wyloguj',
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Błąd: $e'))),
    );
  }
}
