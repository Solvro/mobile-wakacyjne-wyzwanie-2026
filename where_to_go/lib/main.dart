import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_router.dart';
import 'features/places/places_provider.dart';
import 'features/places/dream_place.dart';
import 'features/places/dream_places_repository.dart';
import 'features/theme/theme_provider.dart';
import 'features/theme/local_theme_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicjalizacja SharedPreferences dla motywu
  final prefs = await SharedPreferences.getInstance();

  // Inicjalizacja Hive dla miejsc
  await Hive.initFlutter();
  Hive.registerAdapter(DreamPlaceAdapter());
  final dreamPlacesBox = await Hive.openBox<DreamPlace>('dream_places');

  final repository = DreamPlacesRepository(dreamPlacesBox);
  await repository.seedDatabase();

  runApp(
    ProviderScope(
      overrides: [
        dreamPlacesBoxProvider.overrideWithValue(dreamPlacesBox),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeOption = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      routerConfig: goRouter,
      // Tryb jasny – jasnozielone tło i akcenty
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFE8F5E9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFC8E6C9)),
      ),
      // Tryb ciemny – ciemnozielone tło i akcenty
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D2818),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF05190E)),
      ),
      themeMode: _mapAppThemeToThemeMode(themeOption),
    );
  }

  ThemeMode _mapAppThemeToThemeMode(AppThemeOption option) {
    switch (option) {
      case AppThemeOption.light:
        return ThemeMode.light;
      case AppThemeOption.dark:
        return ThemeMode.dark;
      case AppThemeOption.system:
      default:
        return ThemeMode.system;
    }
  }
}

// Ekran główny
class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final currentTheme = ref.watch(themeNotifierProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Miejsca"),
        actions: [
          IconButton(
            icon: Icon(
              currentTheme == AppThemeOption.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              final nextTheme =
                  currentTheme == AppThemeOption.dark
                      ? AppThemeOption.light
                      : AppThemeOption.dark;
              ref.read(themeNotifierProvider.notifier).setTheme(nextTheme);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return ListTile(
            leading: Image.asset(place.imagePath),
            title: Text(place.name),
            subtitle: Text(place.description),
            trailing: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color:
                  place.isFavorite
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
            ),
            onTap: () {
              GoRouter.of(
                context,
              ).push("${DreamPlaceScreen.route}/${place.id}");
            },
          );
        },
      ),
    );
  }
}

// Szczegóły miejsc
class DreamPlaceScreen extends ConsumerWidget {
  static const route = '/details';

  final String id;

  const DreamPlaceScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == id);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(placesProvider.notifier).toggle(place.id);
            },
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color:
                  place.isFavorite
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              place.imagePath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star, color: colorScheme.primary),
                    const SizedBox(height: 4),
                    const Text("Gwiazdy"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.location_on, color: colorScheme.primary),
                    const SizedBox(height: 4),
                    const Text("Lokacja"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.access_time, color: colorScheme.primary),
                    const SizedBox(height: 4),
                    const Text("Czas"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
