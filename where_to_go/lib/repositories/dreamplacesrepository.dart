import 'package:drift/drift.dart';
import '../database/app_database.dart';

class DreamPlacesRepository {
  final AppDatabase _db;

  DreamPlacesRepository(this._db);

  Future<List<DreamPlace>> getAllPlaces() => _db.select(_db.dreamPlaces).get();

  Future<void> toggleFavourite(String id, bool b) async {
    await (_db.update(_db.dreamPlaces)..where((tbl) => tbl.id.equals(id)))
        .write(DreamPlacesCompanion(isFavourite: Value(!b)));
    await printAllPlaces();
  }

  Future<void> seedData() async {
    // print("BBBBBBBBBBB");
    final places = await getAllPlaces();
    // print("BABAB");
    if (places.isEmpty) {
      print("inicjalizacja bazy");
      await _db.batch((batch) {
        batch.insertAll(_db.dreamPlaces, [
          DreamPlacesCompanion.insert(
            id: '1',
            name: 'Kyoto, Japonia',
            description:
                'Serce japońskiej kultury, które mieści tysiące świątyń, pięknych ogrodów i tradycyjnych herbaciarni.',
            imageUrl: 'assets/images/obrazek.webp',
            //  isFavourite: const Value(false),
          ),
          DreamPlacesCompanion.insert(
            id: '2',
            name: 'Zakynthos, Grecja',
            description: 'Jedna z najbardziej malowniczych wysp Grecji.',
            imageUrl: 'assets/images/grecja.webp',
            //  isFavourite: const Value(false),
          ),
          DreamPlacesCompanion.insert(
            id: '3',
            name: 'Malaga, Hiszpania',
            description: 'Słoneczne miasto na wybrzeżu Costa del Sol.',
            imageUrl: 'assets/images/hiszpania.webp',
            // isFavourite: const Value(false),
          ),
          DreamPlacesCompanion.insert(
            id: '4',
            name: 'Chongqing, Chiny',
            description:
                'Megamiasto położone w górach, które posiada wielopoziomową architekturę.',
            imageUrl: 'assets/images/china.jpg',
            //   isFavourite: const Value(false),
          ),
          DreamPlacesCompanion.insert(
            id: '5',
            name: 'Bangkok, Tajlandia',
            description:
                'Najczęściej odwiedzane miasto przez turystów z całego świata.',
            imageUrl: 'assets/images/tajlandia.jpg',
            //  isFavourite: const Value(false),
          ),
        ]);
      });
    }
    await printAllPlaces();
  }

  Future<void> printAllPlaces() async {
    print("---------------Baza danych:-----------------");
    final places = await getAllPlaces();
    for (final place in places) {
      print(
        'ID: ${place.id} | Nazwa: ${place.name} | Ulubione: ${place.isFavourite}',
      );
    }
  }
}
