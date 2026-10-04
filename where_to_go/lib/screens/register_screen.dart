import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/auth_providers.dart';

final hidePasswordProvider = StateProvider<bool>((ref) => true);

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  static const route = "/login/register";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hidePassword = ref.watch(hidePasswordProvider);

    Future<void> sendAuthData() async {
      final email = emailController.text;
      final password = passwordController.text;
      final confirm = confirmPasswordController.text;

      if(email.isEmpty || password.isEmpty) return;

      if(password != confirm) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Hasła się nie zgadzają"))
        );
      }

      try {
        await ref.read(authStatusControllerProvider.notifier).register(email, password);
        GoRouter.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Logowanie"),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e-mail",
              ),
              onSubmitted: (_) => sendAuthData(),
            ),
            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(hidePassword ? Icons.check_box_outline_blank : Icons.check_box),
                  onPressed: () => ref.read(hidePasswordProvider.notifier).state = !hidePassword,
                ),
                border: OutlineInputBorder(),
                hintText: "hasło",
              ),
              onSubmitted: (_) => sendAuthData(),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(hidePassword ? Icons.check_box_outline_blank : Icons.check_box),
                  onPressed: () => ref.read(hidePasswordProvider.notifier).state = !hidePassword,
                ),
                border: OutlineInputBorder(),
                hintText: "powtórz hasło",
              ),
              onSubmitted: (_) => sendAuthData(),
            ),
          ],
        ),
      ),
    );
  }
}