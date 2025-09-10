import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "hook_solution/my_app_hook.dart"; // ignore: unused_import
import "inherited_solution/my_app_inherited.dart"; // ignore: unused_import
import "my_app.dart";

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
