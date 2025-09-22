import "dart:io";

import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:path_provider/path_provider.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "database.dart";

part "database_provider.g.dart";

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/where_to_go.sqlite");
    return NativeDatabase(file);
  });
}

@riverpod
Future<Database> database(Ref ref) async {
  final db = Database(_openConnection());
  await Future.microtask(db.seedIfEmpty);
  ref.onDispose(db.close);
  return db;
}
