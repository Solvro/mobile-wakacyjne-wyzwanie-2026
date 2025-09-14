import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";

import "../auth/auth_provider.dart";

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final usernameController = TextEditingController();

    final authNotifier = ref.watch(authNotifierProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Zarejestruj się",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 64),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Nazwa użytkownika",
                  hintText: "Nazwa użytkownika",
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  hintText: "E-mail",
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Hasło",
                  hintText: "Hasło",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: "Potwierdź hasło",
                  hintText: "Potwierdź hasło",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  final confirmPassword = confirmPasswordController.text.trim();

                  if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
                    if (password == confirmPassword) {
                      await authNotifier.register(email, password);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Hasła się różnią")),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Wypełnij wszystkie pola")),
                    );
                  }
                },
                child: const Text("Zarejestruj"),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.go("/login");
                },
                child: Text(
                  "Masz już konto?\nZaloguj się",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
