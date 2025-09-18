import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "features/auth/authentication_repository_provider.dart";
import "features/auth/tokens_provider.dart";
import "features/theme/local_theme_provider.dart";
import "features/theme/theme.dart";

class AuthView extends HookConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(localThemeNotifierProvider);
    return themeAsync.when(
      data: (currentTheme) {
        final palette = ThemePalette();
        final primaryColor = palette.getPrimaryColor(currentTheme, context);
        final secondaryColor = palette.getSecondaryColor(currentTheme, context);

        final ValueNotifier<bool> isSignup = useState(false);
        var email = "";
        var password = "";
        final authRepo = ref.read(authenticationRepositoryProvider);

        InputDecoration themedDecoration(String label) => InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: secondaryColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            );

        final textStyle = TextStyle(color: secondaryColor);

        return Scaffold(
          backgroundColor: primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Please log in to continue", style: textStyle),
                const SizedBox(height: 12),
                TextField(
                  decoration: themedDecoration("Email"),
                  autocorrect: false,
                  cursorColor: secondaryColor,
                  style: textStyle,
                  onChanged: (value) => email = value.trim(),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: themedDecoration("Password"),
                  obscureText: true,
                  autocorrect: false,
                  cursorColor: secondaryColor,
                  style: textStyle,
                  onChanged: (value) => password = value,
                ),
                if (isSignup.value) ...[
                  const SizedBox(height: 12),
                  TextField(
                    decoration: themedDecoration("Confirm Password"),
                    obscureText: true,
                    autocorrect: false,
                    cursorColor: secondaryColor,
                    style: textStyle,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: secondaryColor),
                    onPressed: () async {
                      try {
                        final response = await authRepo.signIn(email, password);

                        if (response.$1.trim().isNotEmpty && response.$2.trim().isNotEmpty) {
                          final accessToken = response.$1;
                          final refreshToken = response.$2;
                          await authRepo.saveTokens(accessToken, refreshToken);
                          ref.invalidate(tokensProvider);
                        }
                      } on Object catch (e) {
                        debugPrint("Error signing in: $e");
                      }
                    },
                    child: const Text("Sign Up"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: secondaryColor),
                    onPressed: () {
                      isSignup.value = !isSignup.value;
                    },
                    child: const Text("Log In instead"),
                  ),
                ] else ...[
                  const SizedBox(height: 12),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: secondaryColor),
                    onPressed: () async {
                      try {
                        final response = await authRepo.logIn(email, password);
                        if (response.$1.trim().isNotEmpty && response.$2.trim().isNotEmpty) {
                          final accessToken = response.$1;
                          final refreshToken = response.$2;
                          await authRepo.saveTokens(accessToken, refreshToken);
                          ref.invalidate(tokensProvider);
                        }
                      } on Object catch (e) {
                        debugPrint("Error logging in: $e");
                      }
                    },
                    child: const Text("Log In"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: secondaryColor),
                    onPressed: () {
                      isSignup.value = !isSignup.value;
                    },
                    child: const Text("Sign In instead"),
                  ),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => const Center(child: Text("Error loading theme")),
    );
  }
}
