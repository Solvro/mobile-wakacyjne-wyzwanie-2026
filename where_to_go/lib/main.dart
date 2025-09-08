import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";
import "features/places/place.dart";
import "features/places/repositories/places_repository.dart";
import "features/theme/providers/local_theme_provider.dart";
import "features/theme/repositories/local_theme_repository.dart";
import "gen/assets.gen.dart";
import "services/database.dart";

class ThemeProvider extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) {
        final theme = ref.watch(localThemeProvider);
        final deviceTheme = MediaQuery.platformBrightnessOf(context);

        final defaultTheme = deviceTheme == Brightness.dark ? LocalThemeEnum.dark : LocalThemeEnum.light;
        return MaterialApp.router(routerConfig: goRouter, theme: (theme.value ?? defaultTheme).themeData);
      },
    );
  }
}

// ignore: unreachable_from_main
Future<void> seedData() async {
  final places = [
    Place(
        id: 1,
        title: "Kętrzyn",
        photo: Assets.images.image.path,
        description:
            "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
    Place(
        id: 2,
        title: "Kętrzyn",
        photo: Assets.images.image.path,
        description:
            "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
    Place(
        id: 3,
        title: "Kętrzyn",
        photo: Assets.images.image.path,
        description:
            "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
    Place(
        id: 4,
        title: "Kętrzyn",
        photo: Assets.images.image.path,
        description:
            "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
    Place(
        id: 5,
        title: "Kętrzyn",
        photo: Assets.images.image.path,
        description:
            "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
    Place(
        id: 6,
        title: "Kętrzyn",
        photo: Assets.images.image.path,
        description:
            "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
    Place(
        id: 7,
        title: "Kętrzyn",
        photo: Assets.images.image.path,
        description:
            "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
    Place(
        id: 8,
        title: "Kętrzyn",
        photo: Assets.images.image.path,
        description:
            "Kętrzyn to najlepsze miasto w Warminsko mazurksim wojewodztwie. Bardzo je lubie, ma jezioro basen i lodowisko w zime, także to jest super."),
  ];

  final database = AppDatabase();
  final placesRepository = PlacesRepository(database: database);

  for (final place in places) {
    await placesRepository.create(place);
  }
}

void main() {
  //seedData();

  runApp(ProviderScope(
    child: ThemeProvider(),
  ));
}
