import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lista_2/features/places/places_provider.dart';
import 'app_router.dart';
import 'package:lista_2/features/theme/theme_provider.dart';
import 'package:lista_2/features/places/dream_place.dart';
import 'package:hive_flutter/hive_flutter.dart';
// lub jeśli masz go w jakimś folderze, np.: import 'models/dream_place.dart';

void main() async {
  // te 2 linijki są wymagane przez hive przed startem apki
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // to, żeby Hive rozpoznał Twój model danych
  Hive.registerAdapter(DreamPlaceAdapter());
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  
  @override //funkcja build jest jak narysuj co ma być teraz na ekranie
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeControllerProvider);
    //MaterialApp to widget który jest jak kontener na całą aplikację
    return MaterialApp.router(
      title: 'Start',
      routerConfig: goRouter, // wskazanie na to że dream ekran ma być wyświetlany jako pierwszy
      themeMode: currentThemeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 27, 122, 40)),
      ), 

      darkTheme: ThemeData(
        brightness: Brightness.dark, // To automatycznie przyciemni tła i zmieni tekst na biały
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 27, 122, 40), 
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}



class DreamPlaceScreen extends ConsumerWidget {
  final int id;

  const DreamPlaceScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);
    final currentTheme = ref.watch(themeControllerProvider);
    final isDark = currentTheme == ThemeMode.dark;

    final places = placesAsync.valueOrNull ?? [];

    final place = places.firstWhere(
      (p) => p.id == id,
      orElse: () => DreamPlace(id: -1,name: 'Błąd', description: 'Nie znaleziono miejsca', imageUrl: 'brak', isFavorite: false),
    );

      return Scaffold(
        backgroundColor: isDark ? const Color.fromARGB(255, 17, 92, 30) : const Color.fromARGB(255, 19, 170, 49), //oglny background
        appBar: AppBar(
          title: Text(place.name),
          backgroundColor: const Color.fromARGB(255, 40, 117, 56),
          foregroundColor: const Color.fromARGB(255, 200, 234, 210),

          actions: [
            IconButton(
              onPressed: () {
                ref.read(placesProvider.notifier).toggleFavorite(place);
              },
              icon: Icon(
                place.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: place.isFavorite ? Colors.red : null,
              ),
            )
          ]
        ),
        body: Column(
          children: [
            Image.asset(
              place.imageUrl,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Kilka info przed wyjazdem',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 199, 149, 192),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    place.description,
                    style: TextStyle(
                      color: Color.fromARGB(255, 233, 218, 231),
                      ),                
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Column(
                  children: [
                    Icon(Icons.landscape, color: Color.fromARGB(226, 56, 238, 32), size: 30),
                    SizedBox(height: 4),
                    Text('Góry',
                      style: TextStyle(
                        color: Color.fromARGB(226, 56, 238, 32),
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Icon(Icons.hiking, color: Color.fromARGB(255, 255, 104, 4), size: 30),
                    SizedBox(height: 4),
                    Text('Szlaki',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 104, 4),
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Icon(Icons.beach_access, color: Color.fromARGB(255, 240, 226, 29), size: 30),
                    SizedBox(height: 4),
                    Text('Plaże',
                      style: TextStyle(
                        color: Color.fromARGB(255, 240, 226, 29),
                      ),
                    ),
                  ],
                ),
              ],
            ),         //wyświetlen
          ],
        )
      );
    
  }
}

  class ListScreen extends ConsumerWidget {
    const ListScreen({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final placesAsync = ref.watch(placesProvider);
      final currentTheme = ref.watch(themeControllerProvider);
      final isDark = currentTheme == ThemeMode.dark;

      return Scaffold(
        backgroundColor: isDark ? const Color.fromARGB(255, 74, 15, 104) : const Color.fromARGB(255, 186, 197, 206),
        appBar: AppBar(title: Text('Wymarzone kierunki'),
          backgroundColor: const Color.fromARGB(255, 119, 109, 202),
          foregroundColor: const Color.fromARGB(255, 207, 205, 216),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                final newTheme = isDark ? ThemeMode.light : ThemeMode.dark;
                ref.read(themeControllerProvider.notifier).changeTheme(newTheme);
              },
            )
          ],
        ),

        body: placesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Wystąpił błąd: $err')),
          data: (places) {
            
            if (places.isEmpty) {
              return const Center(child: Text('Nie dodano jeszcze żadnych miejsc.'));
            }

            return ListView.builder(
              itemCount: places.length, 
              itemBuilder: (context, index) {
                final place = places[index];

                return ListTile(
                  leading: Image.asset(
                    place.imageUrl, 
                    width: 50, 
                    height: 50, 
                    fit: BoxFit.cover
                  ),
                  title: Text(place.name),
                  trailing: Icon(
                    place.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: place.isFavorite ? Colors.red : Colors.white70,
                  ),
                  onTap: () {
                    GoRouter.of(context).push('/place/${place.id}');
                  },
                );
              },
            );
          }
        ),
      );
    }
  }
