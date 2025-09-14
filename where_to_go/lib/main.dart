import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";
import "theme/app_theme.dart";
import "theme/local_theme_repository.dart";
import "theme/theme_notifier.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final appThemeEnum = themeAsync.valueOrNull ?? AppThemeMode.system;

    final appTheme = switch (appThemeEnum) {
      AppThemeMode.light => AppTheme().light,
      AppThemeMode.dark => AppTheme().dark,
      AppThemeMode.system => AppTheme().light,
    };

    final router = createRouter(ref);

    return MaterialApp.router(
      title: "Dream Place App",
      theme: appTheme,
      routerConfig: router,
    );
  }
}

/* Future<void> seedDatabase(AppDatabase db) async {
  final repo = PlacesRepository(db);

  final existingPlaces = await repo.getAllPlaces();
  if (existingPlaces.isNotEmpty) {
    return;
  }

  final seedPlaces = <DreamPlacesCompanion>[
    DreamPlacesCompanion.insert(
      title: "Rejkiawik, Islandia",
      placeName: "Rejkiawik",
      description: "Stolica Islandii, znana z pięknych widoków i kultury.",
      imagePath:
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiTeHJAQ3LYDvGrXWLqy3amKWCGMO4jgWbDRTfgKXyJp53yH3VrS9lmWKr4C_pPVJAj1YsL_2QZb-uEk0CmdivaCefF5j6T2WR_3dhmp-Mgtaw1uxGTCfD5PPHaHa6SdYuFOKqHqhPVMWHE/s1600/reykjavik-1.jpg",
    ),
    DreamPlacesCompanion.insert(
      title: "Zermatt, Szwajcaria",
      placeName: "Zermatt",
      description: "Malownicza miejscowość u stóp Matterhorn, raj dla narciarzy i turystów górskich.",
      imagePath:
          "https://d1brno4kbxrfxy.cloudfront.net/wp-content/blogs.dir/35/files/2022/12/RS4772_shutterstock_254090041-scr.jpg",
    ),
    DreamPlacesCompanion.insert(
      title: "Kioto, Japonia",
      placeName: "Kioto",
      description: "Dawna stolica Japonii, znana z świątyń, ogrodów i kwitnącej wiśni.",
      imagePath:
          "https://www.travelcaffeine.com/wp-content/uploads/2020/03/hirano-shrine-cherry-blossom-hanami-sakura-season-kyoto-japan-torii-gate-sunburst.jpg",
    ),
    DreamPlacesCompanion.insert(
      title: "Sydney, Australia",
      placeName: "Sydney",
      description: "Tętniące życiem miasto znane z Opery, plaż i pięknych widoków nad zatoką.",
      imagePath: "https://eybktovvaye.exactdn.com/wp-content/uploads/2024/02/New-Zealand-vs-Australia-1536x863.jpeg",
    ),
    DreamPlacesCompanion.insert(
      title: "Kapsztad, RPA",
      placeName: "Kapsztad",
      description: "Malownicze miasto między górami a oceanem, pełne przyrody i kultury.",
      imagePath: "https://mytraveldairy.com/wp-content/uploads/2025/05/featured-1024x682.jpg",
    ),
    DreamPlacesCompanion.insert(
      title: "Paryż, Francja",
      placeName: "Paryż",
      description: "Romantyczna stolica Francji, pełna sztuki, mody i kulinarnych przysmaków.",
      imagePath:
          "https://www.chooseparisregion.org/sites/default/files/news/6---Tour-Eiffel_AdobeStock_644956457_1920_72dpi.jpg",
    ),
    DreamPlacesCompanion.insert(
      title: "Rio de Janeiro, Brazylia",
      placeName: "Rio de Janeiro",
      description: "Miasto samby, karnawału i spektakularnych plaż w otoczeniu gór.",
      imagePath: "https://cdn.bookaway.com/media/files/5f3bdc55fb2e364a546de117.jpeg",
    ),
  ];

  await db.batch((batch) {
    batch.insertAll(db.dreamPlaces, seedPlaces);
  });

  final infoColumnsSeed = <InfoColumnsCompanion>[
    // Rejkiawik
    InfoColumnsCompanion.insert(
      dreamPlaceId: 1,
      iconName: "restaurant",
      infoText: "Restauracje",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 1,
      iconName: "terrain",
      infoText: "Góry i wulkany",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 1,
      iconName: "auto_awesome",
      infoText: "Zorze polarne",
    ),

    // Zermatt
    InfoColumnsCompanion.insert(
      dreamPlaceId: 2,
      iconName: "downhill_skiing",
      infoText: "Narciarstwo",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 2,
      iconName: "landscape",
      infoText: "Alpy i trekking",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 2,
      iconName: "train",
      infoText: "Panoramiczne pociągi",
    ),

    // Kioto
    InfoColumnsCompanion.insert(
      dreamPlaceId: 3,
      iconName: "park",
      infoText: "Świątynie i ogrody",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 3,
      iconName: "local_florist",
      infoText: "Kwitnąca wiśnia",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 3,
      iconName: "ramen_dining",
      infoText: "Kuchnia japońska",
    ),

    // Sydney
    InfoColumnsCompanion.insert(
      dreamPlaceId: 4,
      iconName: "theaters",
      infoText: "Opera w Sydney",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 4,
      iconName: "beach_access",
      infoText: "Plaże",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 4,
      iconName: "sailing",
      infoText: "Rejsy w zatoce",
    ),

    // Kapsztad
    InfoColumnsCompanion.insert(
      dreamPlaceId: 5,
      iconName: "terrain",
      infoText: "Góra Stołowa",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 5,
      iconName: "water",
      infoText: "Ocean Atlantycki",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 5,
      iconName: "wine_bar",
      infoText: "Winnice",
    ),

    // Paryż
    InfoColumnsCompanion.insert(
      dreamPlaceId: 6,
      iconName: "location_city",
      infoText: "Wieża Eiffla",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 6,
      iconName: "museum",
      infoText: "Luwr",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 6,
      iconName: "coffee",
      infoText: "Kawiarnie",
    ),

    // Rio de Janeiro
    InfoColumnsCompanion.insert(
      dreamPlaceId: 7,
      iconName: "landscape",
      infoText: "Góra Corcovado",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 7,
      iconName: "beach_access",
      infoText: "Plaża Copacabana",
    ),
    InfoColumnsCompanion.insert(
      dreamPlaceId: 7,
      iconName: "celebration",
      infoText: "Karnawał",
    ),
  ];

  await db.batch((batch) => batch.insertAll(db.infoColumns, infoColumnsSeed));
} */
