import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'place.dart';

part 'places_provider.g.dart';

const _initialPlaces = [
  Place(
    id: '1', title:"Kyoto, Japonia",
    backcolor:Color.fromARGB(255, 110, 110, 233),
    shortdesc:"Kyoto, dawna stolica Japonii",
    description:"Serce japońskiej kultury, które mieści tysiące świątyń, pięknych ogrodów i tradycyjnych herbaciarni.",
    path:'assets/images/obrazek.webp',
    listastr:["Jedzenie","Herbata","Świątynie i zamki","Ogrody"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.emoji_food_beverage_outlined),Icon(Icons.castle),Icon(Icons.place)],
   
   ),

  Place(
    id: '2',  title:"Zakynthos, Grecja",
    backcolor:Color.fromARGB(255, 91, 207, 223),
    shortdesc:"Białe klify Zakynthos",
    description:"Jedna z najbardziej malowniczych wysp Grecji.",
    path:'assets/images/grecja.webp',
    listastr:["Jedzenie","Nurkowanie","Plaże","Zwiedzanie"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.scuba_diving),Icon(Icons.beach_access),Icon(Icons.place)],
   
  ),

  Place(
  id: '3',  title:"Malaga, Hiszpania",
  backcolor:Color.fromARGB(255, 238, 223, 90),
  shortdesc:"Malaga, hiszpańskie miasto portowe",
  description:"Słoneczne miasto na wybrzeżu Costa del Sol.",
  path:'assets/images/hiszpania.webp',
  listastr:["Jedzenie","Teatr","Surfing","Muzeum Picassa"],
  listaicon:[Icon(Icons.restaurant),Icon(Icons.theater_comedy),Icon(Icons.surfing),Icon(Icons.art_track)],
  
  ),

  Place(
    id:'4',  title:"Chongqing, Chiny",
    backcolor:Color.fromARGB(255, 238, 80, 80),
    shortdesc:"Chongqing - miasto labirynt",
    description:"Megamiasto położone w górach, które posiada wielopoziomową architekturę.",
    path:'assets/images/china.jpg',
    listastr:["Jedzenie","Miasto mgieł","Podniebny most","Ogrody"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.foggy),Icon(Icons.cloud),Icon(Icons.place)],
  
  ),

  Place(
    id: '5',  title:"Bangkok, Tajlandia",
    backcolor:Color.fromARGB(255, 177, 230, 92),
    shortdesc:"Bangkok, stolica Tajlandii",
    description:"Najczęściej odwiedzane miasto przez turystów z całego świata.",
    path:'assets/images/tajlandia.jpg',
    listastr:["Street food","Nurkowanie","Świątynie i zamki","Dżungla i wyspy"],
    listaicon:[Icon(Icons.restaurant),Icon(Icons.scuba_diving_outlined),Icon(Icons.castle),Icon(Icons.place)],
    
  )
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}