import 'package:hive/hive.dart';
import 'dream_place.dart';
//ogólnie to od czasu do czasu chce mi się robić komentarze dla mnie ma póżniej <33333

class LocalPlacesRepository {
  // Nazwa pudełka (boxa) Hive.
  static const String _boxName = 'places_box';

  // struktura pomocnicza do otwierania boxa.
  Future<Box<DreamPlace>> _getBox() async {
    // Hive.openBox po prostu otwiera pudełko na dysku.
    // Jeśli nie jest otwarte, otworzy je. Jeśli jest, zwróci otwarte.
    return await Hive.openBox<DreamPlace>(_boxName);
  }

  //pobieranie wszystkich miejsc
  Future<List<DreamPlace>> getAllPlaces() async {
    final box = await _getBox();
    // box.values zwraca wszystkie obiekty w środku, zamienia je na Listę
    return box.values.toList();
  }

  Future<DreamPlace?> getPlaceById(int id) async {
    final box = await _getBox();
    // W Hive można użyć ID jako klucza w boxie
    return box.get(id);
  }

  // Zapisywanie lub aktualizowanie miejsca.
  Future<void> savePlace(DreamPlace place) async {
    final box = await _getBox();
    // Używanie ID miejsca jako klucza w boxie, aby łatwo je aktualizować
    await box.put(place.id, place);
  }

  // Usuwanie miejsca po ID
  Future<void> deletePlace(int id) async {
    final box = await _getBox();
    await box.delete(id);
  }

  // Czyszczenie całej bazy danych
  Future<void> clearAllData() async {
    final box = await _getBox();
    await box.clear();
  }
}