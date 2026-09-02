import '../../database/database.dart';
import 'package:drift/drift.dart';

class DreamPlacesRepository {
  final AppDatabase db;

  DreamPlacesRepository(this.db);

  // READ: pobieranie wszystkich miejsc
  Future<List<DreamPlace>> getAllPlaces() async {
    return await db.select(db.dreamPlaces).get();
  }

  // UPDATE: zmiana stanu ulubionego
  Future<void> toggleFavourite(int id) async {
    final place = await (db.select(db.dreamPlaces)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (place != null) {
      await (db.update(db.dreamPlaces)..where((tbl) => tbl.id.equals(id)))
          .write(
        DreamPlacesCompanion(
          isFavorite: Value(!place.isFavorite),
        ),
      );
    }
  }
}
