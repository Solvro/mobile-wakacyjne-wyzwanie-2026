import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'place.dart';

part 'places_provider.g.dart';

const _initialPlaces = [
  Place(
    id: '1',
    title: 'Jezioro Como',
    imagePath: 'assets/images/como.webp',
    description:
        'Jezioro Como to malownicza lokalizacja we Włoszech, która przyciąga turystów z całego świata swoim pięknem i klimatem.',
    weather: 'Słonecznie',
    temperature: '23°C',
    wind: '10 km/h',
    activities: ['Pływanie', 'Zwiedzanie', 'Wędrówki'],
  ),
  Place(
    id: '2',
    title: 'Santorini, Grecja',
    imagePath: 'assets/images/santorini.webp',
    description:
        'Santorini to grecka wyspa słynąca z białych domków z niebieskimi kopułami, zapierających dech w piersiach zachodów słońca i krystalicznie czystego morza.',
    weather: 'Pochmurno',
    temperature: '27°C',
    wind: '15 km/h',
    activities: ['Snorkeling', 'Degustacja wina', 'Fotografowanie'],
  ),
  Place(
    id: '3',
    title: 'Bali',
    imagePath: 'assets/images/Bali.jpg',
    description:
        'Bali to indonezyjska wyspa pełna bujnej przyrody, ryżowych tarasów, świątyń i żywej kultury, idealna dla poszukiwaczy spokoju i przygód.',
    weather: 'Tropikalnie',
    temperature: '31°C',
    wind: '8 km/h',
    activities: ['Surfing', 'Joga', 'Zwiedzanie świątyń'],
  ),
  Place(
    id: '4',
    title: 'Fiord Geiranger',
    imagePath: 'assets/images/Fiord.jpg',
    description:
        'Fiord Geiranger w Norwegii to jeden z najpiękniejszych fiordów świata z majestatycznymi wodospadami, stromymi klifami i turkusową wodą.',
    weather: 'Wietrznie',
    temperature: '14°C',
    wind: '25 km/h',
    activities: ['Kajaki', 'Trekking', 'Rejs statkiem'],
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p,
    ];
  }
}
