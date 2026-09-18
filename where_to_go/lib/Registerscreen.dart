import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  //  static const String route = '/register';
  String errorMessage = "";
  final formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      errorMessage = "";
    });
    try {
      await ref
          .read(authProvider.notifier)
          .register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            username: _usernameController.text.trim(),
          );
    } catch (e) {
      if (!mounted) return;
      setState(() => errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.secondary,
      appBar: AppBar(title: Text("Rejestracja")),
      body: SingleChildScrollView(
        child: Padding(
          padding: .all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(label: Text("Username:")),
                  validator: _required,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(label: Text("Email:")),
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(label: Text("Powtórz hasło:")),
                  obscureText: true,
                  validator: _required,
                ),
                SizedBox(height: 16),
                if (errorMessage != "")
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: submit,
                  child: const Text('Zarejestruj się'),
                ),

                TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text("Logowanie"),
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
