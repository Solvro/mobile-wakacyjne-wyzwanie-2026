import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "features/auth/auth_exception.dart";
import "features/auth/auth_provider.dart";

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  var _isLogin = true;
  var _loading = false;
  String? _error;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      if (_isLogin) {
        await ref.read(authNotifierProvider.notifier).login(
              _emailCtrl.text.trim(),
              _passwordCtrl.text,
            );
      } else {
        await ref.read(authNotifierProvider.notifier).register(
              _emailCtrl.text.trim(),
              _passwordCtrl.text,
              _usernameCtrl.text.trim(),
            );
      }
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 👇 przeniesione z initState
    ref.listen<AsyncValue<bool>>(authNotifierProvider, (_, state) {
      state.whenData((loggedIn) {
        if (loggedIn && mounted) {
          context.go("/");
        }
      });
    });

    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? "Logowanie" : "Rejestracja")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (v) => v == null || v.isEmpty ? "Podaj email" : null,
                ),
                if (!_isLogin)
                  TextFormField(
                    controller: _usernameCtrl,
                    decoration: const InputDecoration(labelText: "Nazwa użytkownika"),
                    validator: (v) => v == null || v.isEmpty ? "Podaj nazwę użytkownika" : null,
                  ),
                TextFormField(
                  controller: _passwordCtrl,
                  decoration: const InputDecoration(labelText: "Hasło"),
                  obscureText: true,
                  validator: (v) => v == null || v.isEmpty ? "Podaj hasło" : null,
                ),
                if (!_isLogin)
                  TextFormField(
                    controller: _confirmCtrl,
                    decoration: const InputDecoration(labelText: "Potwierdź hasło"),
                    obscureText: true,
                    validator: (v) => v != _passwordCtrl.text ? "Hasła się różnią" : null,
                  ),
                const SizedBox(height: 20),
                if (_loading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_isLogin ? "Zaloguj się" : "Zarejestruj się"),
                  ),
                TextButton(
                  onPressed: () {
                    setState(() => _isLogin = !_isLogin);
                  },
                  child: Text(
                    _isLogin ? "Nie masz konta? Zarejestruj się" : "Masz już konto? Zaloguj się",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
