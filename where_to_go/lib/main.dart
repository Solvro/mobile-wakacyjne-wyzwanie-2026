import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";

void main() {
  runApp(ProviderScope(child: MaterialApp.router(routerConfig: goRouter)));
}
