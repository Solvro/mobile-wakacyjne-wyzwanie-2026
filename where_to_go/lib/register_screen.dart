import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "authentication/auth_notifier.dart";

class _RegisterScreen extends ConsumerStatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<_RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool _loading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _loading = true);

    try {
      await ref.read(authProvider.notifier).authRepo.register(_email, _password);
      ref.read(authProvider.notifier).state = AuthStatus.authenticated;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registered as $_email")),
        );
        Navigator.of(context).pop();
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $e")),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.isEmpty ? "Enter an email" : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? "Password too short" : null,
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              if (_loading) const CircularProgressIndicator()
              else ElevatedButton(
                onPressed: _register, 
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}