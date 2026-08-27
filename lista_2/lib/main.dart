import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lista_2/features/places/places_provider.dart';
// import 'features/favorite/favorite_provider.dart';
import 'app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override //funkcja build jest jak narysuj co ma być teraz na ekranie
  Widget build(BuildContext context) {
    //MaterialApp to widget który jest jak kontener na całą aplikację
    return MaterialApp.router(
      title: 'Start',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 27, 122, 40)),
      ),
      routerConfig: goRouter,  // wskazanie na to że dream ekran ma być wyświetlany jako pierwszy
    );
  }
}



class DreamPlaceScreen extends ConsumerWidget {
  final String id;

  const DreamPlaceScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placesProvider);
    final place = places.firstWhere((p) => p.id == id);
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 17, 109, 25),
        appBar: AppBar(
          title: Text(place.title),
          backgroundColor: const Color.fromARGB(255, 137, 22, 141),
          foregroundColor: const Color.fromARGB(255, 182, 228, 186),

          actions: [
            IconButton(
              onPressed: () {
                ref.read(placesProvider.notifier).toggleFavorite(id); 
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
              place.imagePath,
              fit: BoxFit.cover
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
      final places = ref.watch(placesProvider);

      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 186, 197, 206),
        appBar: AppBar(title: Text('Wymarzone kierunki'),
          backgroundColor: const Color.fromARGB(255, 119, 109, 202),
          foregroundColor: const Color.fromARGB(255, 207, 205, 216),),
        body: ListView.builder(
          itemCount: places.length, // Tyle razy pętla się wykona, ile masz miejsc w bazie
          itemBuilder: (context, index) {
            // Wyciąganie konkretnego miejsca na podstawie jego numeru w kolejce
            final place = places[index];

            return ListTile(
              leading: Image.asset(
                place.imagePath, 
                width: 50, 
                height: 50, 
                fit: BoxFit.cover
              ),
              title: Text(place.title),
              trailing: Icon(
                place.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: place.isFavorite ? Colors.red : Colors.white70,
              ),
              onTap: () {
                // 5. Dynamiczny adres! Zamiast wpisywać "1" lub "2", bierzemy ID z bazy
                GoRouter.of(context).push('/place/${place.id}');
              },
            );
          },
      ),
      );
    }
  }
