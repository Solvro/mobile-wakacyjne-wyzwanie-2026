import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../features/places/place_provider.dart";
import "../features/theme/providers/theme_provider.dart";
import "../features/theme/repositories/local_theme_repository.dart";
import "dream_place_screen.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Moje ulubione miejsca:3"),
        ),
        body: Consumer(builder: (context, ref, child) {
          final theme = ref.watch(localThemeStateProvider);

          return Column(
            children: [
              DropdownMenu<LocalTheme>(
                  initialSelection: theme.valueOrNull,
                  onSelected: (value) {
                    if (value != null) {
                      ref.read(localThemeStateProvider.notifier).setTheme(value);
                    }
                  },
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: LocalTheme.light, label: "Light"),
                    DropdownMenuEntry(value: LocalTheme.dark, label: "Dark"),
                    DropdownMenuEntry(value: LocalTheme.defaultTheme, label: "Default"),
                  ]),
              Expanded(
                child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: ref
                        .watch(placesProvider)
                        .map((place) => Card(
                                child: ListTile(
                              title: Text(place.title),
                              onTap: () => {GoRouter.of(context).push("${DreamPlaceScreen.route}/${place.id}")},
                            )))
                        .toList()),
              ),
            ],
          );
        }));
  }
}
