import "package:flutter_riverpod/flutter_riverpod.dart";
import "../database/dream_place_provider.dart";

final sortOrderProvider = StateProvider<SortOrder>((ref) => SortOrder.asc);
final sortByProvider = StateProvider<SortBy>((ref) => SortBy.name);
