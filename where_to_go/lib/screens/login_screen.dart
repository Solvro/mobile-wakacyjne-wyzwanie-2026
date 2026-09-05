import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:where_to_go/features/auth/auth_providers.dart';

import 'register_screen.dart';

final hidePasswordProvider = StateProvider<bool>((ref) => true);

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static const route = "/login";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var hidePassword = ref.watch(hidePasswordProvider);

    Future<void> sendAuthData() async {
      final email = emailController.text;
      final password = passwordController.text;

      try {
        await ref.read(authStatusControllerProvider.notifier).login(email, password);
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
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: "Nie masz konta? ", style: Theme.of(context).textTheme.displaySmall),
                  TextSpan(
                    text: "Zarejestruj się.",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () => GoRouter.of(context).push(RegisterScreen.route)
                  )
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
