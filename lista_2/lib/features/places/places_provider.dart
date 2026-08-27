import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'place.dart';

part 'places_provider.g.dart';

const _initialPlaces = [
  Place(id: '1', title: 'Nowa Zelandia',
  description: 'Pogoda może zmieniać się tutaj błyskawicznie, dlatego ubiór "na cebulkę" i dobra kurtka przeciwdeszczowa to podstawa o każdej porze roku. Pamiętaj też, że obowiązuje tu ruch lewostronny, a na lotnisku spotkasz się z niezwykle surowymi kontrolami bioasekuracyjnymi, które surowo zabraniają wwożenia wielu produktów spożywczych czy chociażby brudnego sprzętu trekkingowego.', 
  imagePath:'assets/nowa_zelandia.jpg'),
  Place(id: '2', title: 'Norwegia',
  description: 'To kraj niemal całkowicie bezgotówkowy, dlatego wszędzie bez problemu zapłacisz kartą lub telefonem, a lokalne banknoty są używane niezwykle rzadko. Ze względu na wysokie koszty życia, jeśli podróżujesz budżetowo, warto zaplanować przygotowywanie posiłków we własnym zakresie oraz rezerwację noclegów ze sporym wyprzedzeniem.',
  imagePath:'assets/norwegia.jpg'),
  Place(id: '3', title: 'Korea Południowa',
  description: 'Ze względów bezpieczeństwa narodowego Mapy Google działają tu w bardzo ograniczonym zakresie (nie wyznaczają tras pieszych), więc przed wyjazdem koniecznie zainstaluj lokalne aplikacje, takie jak Naver Map lub KakaoMap. Do wygodnego korzystania z transportu publicznego i robienia drobnych zakupów w sklepach spożywczych, najlepiej od razu po przylocie wyrobić i doładować popularną kartę Tmoney.',
  imagePath:'assets/korea_poludniowa.jpg'),
  Place(id: '4', title: 'Holandia',
  description: 'Rowerzyści mają w tym kraju bezwzględne pierwszeństwo na ścieżkach rowerowych, dlatego jako pieszy musisz zachować szczególną ostrożność, by przypadkiem nie wejść im pod koła. Pogoda bywa tu bardzo wietrzna i deszczowa, więc zamiast tradycyjnego parasola (który łatwo połamać na wietrze) znacznie lepiej sprawdzi się solidny płaszcz przeciwdeszczowy.',
  imagePath:'assets/holandia.jpg'),
  Place(id: '5', title: 'Andora',
  description: 'Ten mały górski kraj nie należy do Unii Europejskiej ani strefy Schengen (choć obowiązującą walutą jest euro), co oznacza, że standardowe pakiety internetowe nie działają, a opłaty za roaming komórkowy mogą być gigantyczne. Ponieważ Andora leży głęboko w Pirenejach i nie posiada własnego lotniska ani stacji kolejowej, dotarcie na miejsce wymaga wynajęcia auta lub transferu autobusowego z sąsiedniej Hiszpanii lub Francji.',
  imagePath:'assets/andora.jpg'),
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