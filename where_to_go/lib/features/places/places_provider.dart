import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final placesProvider = StreamProvider<List<DreamPlace>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllPlaces();
});

class PlacesNotifier {
  final AppDatabase _db;
  PlacesNotifier(this._db);

  Future<void> toggleFavorite(int id, bool currentStatus) async {
    await _db.toggleFavorite(id, currentStatus);
  }
}

final placesNotifierProvider = Provider<PlacesNotifier>((ref) {
  final db = ref.watch(databaseProvider);
  return PlacesNotifier(db);
});
