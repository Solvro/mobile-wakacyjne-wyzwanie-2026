import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../database/app_database.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repositories/dreamplacesrepository.dart';
import 'package:flutter/material.dart';
import 'place.dart';

part 'places_provider.g.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final dreamPlacesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  return DreamPlacesRepository(ref.watch(appDatabaseProvider));
});

const _initialPlaces = [
  Place(
    id: '1',
    title: "Kyoto, Japonia",
    shortdesc: "Kyoto, dawna stolica Japonii",
    description:
        "Serce japońskiej kultury, które mieści tysiące świątyń, pięknych ogrodów i tradycyjnych herbaciarni.",
    path: 'assets/images/obrazek.webp',
    listastr: ["Jedzenie", "Herbata", "Świątynie i zamki", "Ogrody"],
    listaicon: [
      Icon(Icons.restaurant),
      Icon(Icons.emoji_food_beverage_outlined),
      Icon(Icons.castle),
      Icon(Icons.place),
    ],
  ),
  Place(
    id: '2',
    title: "Zakynthos, Grecja",
    shortdesc: "Białe klify Zakynthos",
    description: "Jedna z najbardziej malowniczych wysp Grecji.",
    path: 'assets/images/grecja.webp',
    listastr: ["Jedzenie", "Nurkowanie", "Plaże", "Zwiedzanie"],
    listaicon: [
      Icon(Icons.restaurant),
      Icon(Icons.scuba_diving),
      Icon(Icons.beach_access),
      Icon(Icons.place),
    ],
  ),
  Place(
    id: '3',
    title: "Malaga, Hiszpania",
    shortdesc: "Malaga, hiszpańskie miasto portowe",
    description: "Słoneczne miasto na wybrzeżu Costa del Sol.",
    path: 'assets/images/hiszpania.webp',
    listastr: ["Jedzenie", "Teatr", "Surfing", "Muzeum Picassa"],
    listaicon: [
      Icon(Icons.restaurant),
      Icon(Icons.theater_comedy),
      Icon(Icons.surfing),
      Icon(Icons.art_track),
    ],
  ),
  Place(
    id: '4',
    title: "Chongqing, Chiny",
    shortdesc: "Chongqing - miasto labirynt",
    description:
        "Megamiasto położone w górach, które posiada wielopoziomową architekturę.",
    path: 'assets/images/china.jpg',
    listastr: ["Jedzenie", "Miasto mgieł", "Podniebny most", "Ogrody"],
    listaicon: [
      Icon(Icons.restaurant),
      Icon(Icons.foggy),
      Icon(Icons.cloud),
      Icon(Icons.place),
    ],
  ),
  Place(
    id: '5',
    title: "Bangkok, Tajlandia",
    shortdesc: "Bangkok, stolica Tajlandii",
    description:
        "Najczęściej odwiedzane miasto przez turystów z całego świata.",
    path: 'assets/images/tajlandia.jpg',
    listastr: [
      "Street food",
      "Nurkowanie",
      "Świątynie i zamki",
      "Dżungla i wyspy",
    ],
    listaicon: [
      Icon(Icons.restaurant),
      Icon(Icons.scuba_diving_outlined),
      Icon(Icons.castle),
      Icon(Icons.place),
    ],
  ),
];

@riverpod
class Places extends _$Places {
  @override
  Future<List<Place>> build() async {
    final repo = ref.read(dreamPlacesRepositoryProvider);
    await repo.seedData();
    final dbPlaces = await repo.getAllPlaces();
    final favMap = {for (final p in dbPlaces) p.id: p.isFavourite};
    return [
      for (final p in _initialPlaces)
        p.copyWith(isFavorite: favMap[p.id] ?? false),
    ];

    //return _initialPlaces;
  }

  Future<void> toggleFavorite(String id) async {
    final aktualny = await future;
    final place = aktualny.firstWhere((p) => p.id == id);
    final repo = ref.read(dreamPlacesRepositoryProvider);
    await repo.toggleFavourite(id, place.isFavorite);
    state = AsyncData([
      for (final p in aktualny)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p,
    ]);
  }
}
