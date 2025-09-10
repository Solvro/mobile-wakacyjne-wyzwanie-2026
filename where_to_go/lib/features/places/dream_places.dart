import "package:flutter/material.dart";
import "../../gen/assets.gen.dart";
import "../models/attraction.dart";
import "../models/dream_place_old.dart";

final places = [
  DreamPlace(
    title: "Tokio, Japonia",
    imagePath: Assets.images.tokio.path,
    placeName: "Wieża Tokio Tower",
    description:
        "Wysoka wieża widokowa, futurystyczne wieżowce z cyfrowymi bilbordami reklamowymi, czyste niebo i zadbana zieleń.",
    attractions: const [
      Attraction(icon: Icons.wb_sunny, label: "Słońce"),
      Attraction(icon: Icons.cell_tower, label: "Tokio Tower"),
      Attraction(icon: Icons.computer, label: "Technologia"),
      Attraction(icon: Icons.train, label: "Shinkansen"),
    ],
  ),
  DreamPlace(
    title: "Paryż, Francja",
    imagePath: Assets.images.paryz.path,
    placeName: "Wieża Eiffla",
    description:
        "Romantyczna atmosfera, pyszne croissanty i bagietki, zachwycające dzieła sztuki i zjawiskowa architektura.",
    attractions: const [
      Attraction(icon: Icons.location_city, label: "Miasto"),
      Attraction(icon: Icons.local_cafe, label: "Kawiarnie"),
      Attraction(icon: Icons.museum, label: "Muzea"),
      Attraction(icon: Icons.brush, label: "Sztuka"),
    ],
  ),
  DreamPlace(
    title: "Rzym, Włochy",
    imagePath: Assets.images.rzym.path,
    placeName: "Koloseum",
    description:
        "Historyczne ruiny osiągnięć przodków, starożytna architektura, wyjątkowa kuchnia oraz klimat śródziemnomorski",
    attractions: const [
      Attraction(icon: Icons.history, label: "Historia"),
      Attraction(icon: Icons.local_pizza, label: "Pizza"),
      Attraction(icon: Icons.church, label: "Bazyliki"),
      Attraction(icon: Icons.local_cafe, label: "Kawiarnie"),
    ],
  ),
  DreamPlace(
    title: "Nowy Jork, USA",
    imagePath: Assets.images.nowyJork.path,
    placeName: "Statua Wolności",
    description:
        "Ikoniczne miasto, które nigdy nie śpi, z niekończącą się energią, kulturą i rozrywką oraz kolosalnymi wieżowcami.",
    attractions: const [
      Attraction(icon: Icons.location_city, label: "Miasto"),
      Attraction(icon: Icons.shopping_bag, label: "Zakupy"),
      Attraction(icon: Icons.music_note, label: "Muzyka"),
      Attraction(icon: Icons.park, label: "Central Park"),
    ],
  ),
  DreamPlace(
    title: "Kair, Egipt",
    imagePath: Assets.images.kair.path,
    placeName: "Wielkie Piramidy w Gizie",
    description:
        "Starożytne cuda świata, pustynny krajobraz z wielbłądami oraz bogata historia starożytnej cywilizacji.",
    attractions: const [
      Attraction(icon: Icons.beach_access, label: "Pustynia"),
      Attraction(icon: Icons.sailing, label: "Nil"),
      Attraction(icon: Icons.museum, label: "Muzea"),
      Attraction(icon: Icons.landscape, label: "Piramidy"),
    ],
  ),
];
