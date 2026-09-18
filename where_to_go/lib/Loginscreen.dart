import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  //static const String route = '/login';
  bool errorMessage = false;
  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      errorMessage = false;
    });
    try {
      await ref
          .read(authProvider.notifier)
          .login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    } catch (e) {
      if (!mounted) return;
      setState(() => errorMessage = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.secondary,
      appBar: AppBar(title: Text("Logowanie")),
      body: SingleChildScrollView(
        child: Padding(
          padding: .all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(label: Text("Username/email:")),
                  keyboardType: .emailAddress,
                  validator: _required,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(label: Text("Hasło:")),
                  obscureText: true,
                  validator: _required,
                ),
                SizedBox(height: 16),
                if (errorMessage)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      "Niepoprawny login albo hasło!",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: submit,
                  child: const Text('Zaloguj się'),
                ),
                TextButton(
                  onPressed: () => context.go('/register'),
                  child: Text("Rejestracja"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? "To pole jest wymagane" : null;
}
