import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app.dart";
import "providers/auth_providers.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  await container.read(authRepositoryProvider).initialize();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
