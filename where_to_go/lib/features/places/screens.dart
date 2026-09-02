// ignore_for_file: non_const_argument_for_const_parameter, type=lint
import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../../database/database.dart";
import "../../theme_provider.dart";
import "places_provider.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);

    // Bezpieczny odczyt wartości z AsyncValue (domyślnie true dla jasnego)
    final themeState = ref.watch(themeNotifierProvider);
    final systemBrightness = MediaQuery.of(context).platformBrightness;
    final isSystemDark = systemBrightness == Brightness.dark;
    final isLightMode = themeState.value ?? !isSystemDark;
    final textColor = Theme.of(context).textTheme.bodySmall?.color;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Wymarzone Miejsca",
          style: TextStyle(
            color: colors.primary,
            fontFamily: "Roboto",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(
                isLightMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () {
                // Wywołanie metody AsyncNotifier z przełączeniem wartości
                ref.read(themeNotifierProvider.notifier).setTheme(!isLightMode);
              },
            ),
          ),
        ],
      ),
      body: placesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Błąd: $err")),
        data: (places) => ListView.builder(
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  place.imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              ),
              title: Text(place.locationTitle),
              subtitle: Text(place.title),
              trailing: IconButton(
                icon: Icon(
                  place.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: place.isFavorite ? Colors.red : textColor,
                ),
                onPressed: () {
                  ref
                      .read(placesNotifierProvider)
                      .toggleFavorite(place.id, place.isFavorite);
                },
              ),
              onTap: () {
                unawaited(
                  GoRouter.of(
                    context,
                  ).push("${DreamPlaceScreen.route}/${place.id}"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class DreamPlaceScreen extends ConsumerWidget {
  static const route = "/details";
  final int id; // Typ zmieniony ze String na int

  const DreamPlaceScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);
    final ThemeData theme = Theme.of(context);
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: placesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Błąd: $err")),
        data: (places) {
          final place = places.cast<DreamPlace?>().firstWhere(
                (element) => element?.id == id,
                orElse: () => null,
              );

          if (place == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text("Nie znaleziono miejsca")),
            );
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                place.title,
                style: const TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: theme.appBarTheme.backgroundColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    icon: Icon(
                      place.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: place.isFavorite ? Colors.red : textColor,
                    ),
                    onPressed: () {
                      ref
                          .read(placesNotifierProvider)
                          .toggleFavorite(place.id, place.isFavorite);
                    },
                  ),
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 300,
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              place.imagePath,
                              width: 300,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.broken_image, size: 100),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.locationTitle,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    place.description,
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _PlaceInfo(
                                  iconCode: place.icon1,
                                  text: place.iconText1,
                                ),
                                _PlaceInfo(
                                  iconCode: place.icon2,
                                  text: place.iconText2,
                                ),
                                _PlaceInfo(
                                  iconCode: place.icon3,
                                  text: place.iconText3,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PlaceInfo extends StatelessWidget {
  final int iconCode;
  final String text;

  const _PlaceInfo({required this.iconCode, required this.text});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    return Column(
      children: [
        Icon(
          IconData(
            iconCode,
            fontFamily: "MaterialIcons",
          ),
          color: textColor,
        ),
        const SizedBox(height: 4),
        Text(text, style: TextStyle(color: textColor, fontSize: 10)),
      ],
    );
  }
}
