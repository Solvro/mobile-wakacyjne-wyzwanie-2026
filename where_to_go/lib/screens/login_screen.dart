import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static const route = "/login";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Text("Logowanie"),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "e-mail",
            )
          ),
          TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "hasło",
              )
          )
        ],
      )
    );
  }
}