import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../auth_providers.dart"; 

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailC = TextEditingController();
  final _usernameC = TextEditingController(); 
  final _passC = TextEditingController();
  final _pass2C = TextEditingController();

  var _isLogin = true;
  var _loading = false;

  @override
  void dispose() {
    _emailC.dispose();
    _usernameC.dispose();
    _passC.dispose();
    _pass2C.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final auth = ref.read(authRepositoryProvider);
    final email = _emailC.text.trim();
    final pass  = _passC.text;

    try {
      if (_isLogin) {
        await auth.login(email: email, password: pass);
      } else {
        await auth.register(email: email, password: pass);
      }
      if (!mounted) return;
      context.go("/home");
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Błąd: $e")),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return "Podaj email";
    if (!v.contains("@")) return "Nieprawidłowy email";
    return null;
  }

  String? _validatePass(String? v) {
    if (v == null || v.length < 6) return "Hasło min. 6 znaków";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final title = _isLogin ? "Logowanie" : "Rejestracja";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    children: [
                      Expanded(
                        child: SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(value: true, label: Text("Logowanie")),
                            ButtonSegment(value: false, label: Text("Rejestracja")),
                          ],
                          selected: {_isLogin},
                          onSelectionChanged: (s) {
                            setState(() => _isLogin = s.first);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailC,
                    decoration: const InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  if (!_isLogin) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _usernameC,
                      decoration: const InputDecoration(labelText: "Nazwa użytkownika (opcjonalnie)"),
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passC,
                    decoration: const InputDecoration(labelText: "Hasło"),
                    obscureText: true,
                    validator: _validatePass,
                  ),
                  if (!_isLogin) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pass2C,
                      decoration: const InputDecoration(labelText: "Powtórz hasło"),
                      obscureText: true,
                      validator: (v) {
                        if (v != _passC.text) return "Hasła muszą się zgadzać";
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 16),
                  if (_loading) const CircularProgressIndicator(),
                  if (!_loading)
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _submit,
                        child: Text(_isLogin ? "Zaloguj" : "Zarejestruj"),
                      ),
                    ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(_isLogin
                        ? "Nie masz konta? Zarejestruj się"
                        : "Masz już konto? Zaloguj się")
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
