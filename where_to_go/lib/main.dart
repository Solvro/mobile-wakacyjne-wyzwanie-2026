import 'package:flutter/material.dart';
import 'package:flutter_application_1/dreamplacescreen.dart';
import 'package:flutter_application_1/features/theme_provider.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'features/favorite/favorite_provider.dart';
import 'app_router.dart';
import 'package:go_router/go_router.dart';
import 'features/places/places_provider.dart';
import 'features/places/place.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:drift/drift.dart';
//import 'database/app_database.dart';
//import 'repositories/dreamplacesrepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LocalThemeRepository = ref.watch(thememProvider);
    return LocalThemeRepository.when(
      data: (mode) => MaterialApp.router(
        routerConfig: goRouter,
        title: 'Wybierz miejsce',

        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color.fromARGB(255, 36, 119, 105),

          cardTheme: CardThemeData(
            color: Colors.amber,
            shadowColor: const Color.fromARGB(255, 68, 20, 20),
            elevation: 5,
          ),

          colorScheme: ColorScheme.light(
            primary: Colors.amber,
            secondary: Color.fromARGB(255, 25, 100, 96),
            shadow: Color.fromRGBO(38, 72, 165, 0.76),
          ),

          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 76, 147, 156),
            foregroundColor: const Color.fromARGB(255, 219, 255, 238),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color.fromARGB(255, 66, 65, 65),

          cardTheme: CardThemeData(
            color: const Color.fromARGB(255, 41, 64, 99),
            shadowColor: const Color.fromARGB(255, 68, 20, 20),
            elevation: 5,
          ),

          colorScheme: ColorScheme.dark(
            primary: const Color.fromARGB(255, 9, 114, 128),
            secondary: Color.fromARGB(255, 12, 41, 61),
            shadow: Color.fromRGBO(38, 72, 165, 0.76),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 20, 37, 83),
            foregroundColor: const Color.fromARGB(255, 146, 194, 233),
          ),
        ),

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
    // final LocalThemeRepository=ref.watch(thememProvider);
    /* return Scaffold(
      body: ListView(children: [
        maker(context, ref.watch(placesProvider)[0]),
        maker(context, ref.watch(placesProvider)[1]),
        maker(context, ref.watch(placesProvider)[2]),
        maker(context, ref.watch(placesProvider)[3]),
        maker(context, ref.watch(placesProvider)[4])
      ]),*/
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
