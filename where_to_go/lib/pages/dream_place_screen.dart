import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../widgets/dream_place.dart';

class DreamPlaceScreen extends HookWidget {
  const DreamPlaceScreen({super.key});

  static final List<Map<String, dynamic>> _places = [
    {
      "title": "Jezioro Como",
      "imagePath": "assets/images/como.webp",
      "description":
          "Jezioro Como to malownicza lokalizacja we Włoszech, która przyciąga turystów z całego świata swoim pięknem i klimatem.",
      "weather": "Słonecznie",
      "temperature": "23°C",
      "wind": "10 km/h",
      "activities": ["Pływanie", "Zwiedzanie", "Wędrówki"],
    },
    {
      "title": "Santorini",
      "imagePath": "assets/images/santorini.webp",
      "description":
          "Santorini to grecka wyspa słynąca z białych domków z niebieskimi kopułami, zapierających dech w piersiach zachodów słońca i krystalicznie czystego morza.",
      "weather": "Pochmurno",
      "temperature": "27°C",
      "wind": "15 km/h",
      "activities": ["Snorkeling", "Degustacja wina", "Fotografowanie"],
    },
    {
      "title": "Bali",
      "imagePath": "assets/images/Bali.jpg",
      "description":
          "Bali to indonezyjska wyspa pełna bujnej przyrody, ryżowych tarasów, świątyń i żywej kultury, idealna dla poszukiwaczy spokoju i przygód.",
      "weather": "Tropikalnie",
      "temperature": "31°C",
      "wind": "8 km/h",
      "activities": ["Surfing", "Joga", "Zwiedzanie świątyń"],
    },
    {
      "title": "Fiord Geiranger",
      "imagePath": "assets/images/Fiord.jpg",
      "description":
          "Fiord Geiranger w Norwegii to jeden z najpiękniejszych fiordów świata z majestatycznymi wodospadami, stromymi klifami i turkusową wodą.",
      "weather": "Wietrznie",
      "temperature": "14°C",
      "wind": "25 km/h",
      "activities": ["Kajaki", "Trekking", "Rejs statkiem"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Stan zarządzany przez HookWidget (useState)
    final isFavorited = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wymarzone miejsca"),
        actions: [
          IconButton(
            onPressed: () {
              isFavorited.value = !isFavorited.value;
            },
            icon: Icon(
              isFavorited.value ? Icons.favorite : Icons.favorite_border,
              color: isFavorited.value ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _places.length,
        itemBuilder: (context, index) {
          final p = _places[index];
          return DreamPlace(
            title: p["title"] as String,
            imagePath: p["imagePath"] as String,
            description: p["description"] as String,
            weather: p["weather"] as String,
            temperature: p["temperature"] as String,
            wind: p["wind"] as String,
            activities: List<String>.from(p["activities"] as List),
          );
        },
      ),
    );
  }
}
