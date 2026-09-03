import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dream_place.dart';
import 'local_places_repository.dart';

part 'places_provider.g.dart';



@riverpod
LocalPlacesRepository placesRepository(PlacesRepositoryRef ref){
  return LocalPlacesRepository();
}

@riverpod
class Places extends _$Places {
  @override 
  FutureOr<List<DreamPlace>> build() async {
    return _loadPlaces();
  }
  
  Future<List<DreamPlace>> _loadPlaces() async{
    final repository = ref.read(placesRepositoryProvider);
    final placesFromDb = await repository.getAllPlaces();
    
    if (placesFromDb.isEmpty) {
      await _seedInitialData(repository);
      return await repository.getAllPlaces();
    }
    
    return placesFromDb;
  }

  Future<void> _seedInitialData(LocalPlacesRepository repository) async {
    final initialPlaces = [
      DreamPlace(
        id: 1,
        name: 'Nowa Zelandia',
        description: 'Pogoda może zmieniać się tutaj błyskawicznie, dlatego ubiór "na cebulkę" i dobra kurtka przeciwdeszczowa to podstawa o każdej porze roku. Pamiętaj też, że obowiązuje tu ruch lewostronny, a na lotnisku spotkasz się z niezwykle surowymi kontrolami bioasekuracyjnymi, które surowo zabraniają wwożenia wielu produktów spożywczych czy chociażby brudnego sprzętu trekkingowego.',
        imageUrl: 'assets/nowa_zelandia.jpg',
        isFavorite: false
      ),
      DreamPlace(
        id: 2,
        name: 'Norwegia',
        description: 'To kraj niemal całkowicie bezgotówkowy, dlatego wszędzie bez problemu zapłacisz kartą lub telefonem, a lokalne banknoty są używane niezwykle rzadko. Ze względu na wysokie koszty życia, jeśli podróżujesz budżetowo, warto zaplanować przygotowywanie posiłków we własnym zakresie oraz rezerwację noclegów ze sporym wyprzedzeniem.',
        imageUrl: 'assets/norwegia.jpg',
        isFavorite: false
      ),
      DreamPlace(
        id: 3,
        name: 'Korea Południowa',
        description: 'Ze względów bezpieczeństwa narodowego Mapy Google działają tu w bardzo ograniczonym zakresie (nie wyznaczają tras pieszych), więc przed wyjazdem koniecznie zainstaluj lokalne aplikacje, takie jak Naver Map lub KakaoMap. Do wygodnego korzystania z transportu publicznego i robienia drobnych zakupów w sklepach spożywczych, najlepiej od razu po przylocie wyrobić i doładować popularną kartę Tmoney.',
        imageUrl: 'assets/korea_poludniowa.jpg',
        isFavorite: false
      ),
    ];

    for (final place in initialPlaces) {
      await repository.savePlace(place);
    }
  }

  Future<void> savePlace(DreamPlace place) async {
    state = const AsyncValue.loading();
    final repository = ref.read(placesRepositoryProvider);
    await repository.savePlace(place);
    state = AsyncValue.data(await repository.getAllPlaces());
  }

  Future<void> toggleFavorite(DreamPlace place) async {
    final updatedPlace = DreamPlace(
      id: place.id,
      name: place.name,
      description: place.description,
      imageUrl: place.imageUrl,
      isFavorite: !place.isFavorite,
    )..id = place.id; 

    await savePlace(updatedPlace);
  }
}