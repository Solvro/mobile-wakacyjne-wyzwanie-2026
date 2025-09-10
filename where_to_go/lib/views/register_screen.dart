import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:reactive_forms/reactive_forms.dart";

import "../features/auth/auth_provider.dart";
import "../utils/error_handler.dart";
import "../widgets/auth/email_form.dart";
import "../widgets/auth/password_form.dart";
import "login_screen.dart";

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  static String route = "/register";

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final form = FormGroup({
    "email": FormControl<String>(validators: [Validators.required, Validators.email]),
    "password": FormControl<String>(validators: [Validators.required]),
    "passwordConfirmation": FormControl<String>(),
  }, validators: [
    Validators.mustMatch("password", "passwordConfirmation")
  ]);

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      if (next.hasError) {
        handleError(context, ref, next.error);
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text("Bucket List"),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ReactiveForm(
                        formGroup: form,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          const Text("Rejestracja", style: TextStyle(fontSize: 25)),
                          const SizedBox(height: 20),
                          const EmailForm(
                              formControlName: "email",
                              labelText: "Email",
                              validationMessage: "Email wymagany",
                              validationMessageEmail: "Podaj prawidłowy email"),
                          const SizedBox(height: 16),
                          const PasswordForm(
                            formControlName: "password",
                            labelText: "Hasło",
                            validationMessage: "Hasło wymagane",
                            mustMatch: "",
                          ),
                          const SizedBox(height: 16),
                          const PasswordForm(
                            formControlName: "passwordConfirmation",
                            labelText: "Powtórz Hasło",
                            validationMessage: "Wpisz ponownie hasło",
                            mustMatch: "Hasła muszą być identyczne",
                          ),
                          const SizedBox(height: 24),
                          ReactiveFormConsumer(builder: (context, formGroup, child) {
                            return ElevatedButton(
                              onPressed: formGroup.valid && !authState.isLoading ? _register : null,
                              child: authState.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("Zarejestruj się"),
                            );
                          }),
                          const SizedBox(height: 12),
                          TextButton(onPressed: () => context.go(LoginScreen.route), child: const Text("Zaloguj się"))
                        ]))))));
  }

  Future<void> _register() async {
    if (form.valid) {
      final email = form.value["email"]! as String;
      final password = form.value["password"]! as String;
      await ref.read(authNotifierProvider.notifier).register(email, password);
    } else {
      form.markAllAsTouched();
    }
  }
}
