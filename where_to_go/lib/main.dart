import "package:dio/dio.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "app_router.dart";
import "core/api_path.dart";
import "core/dio_client.dart";

import "features/auth/auth_providers.dart";
import "features/auth/authentication_repository.dart";
import "features/auth/local_auth_repository.dart";
import "features/auth/remote_auth_repository.dart";

import "theme/app.theme.dart";
import "theme/local_theme.dart";
import "theme/providers.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const storage = FlutterSecureStorage();
  final localRepo = LocalAuthenticationRepository(storage);

  final rawDio = Dio(BaseOptions(
    baseUrl: ApiPaths.baseUrl,
    headers: const {"Content-Type": "application/json", "Accept": "application/json"},
    validateStatus: (s) => s != null && s < 500,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
  ))
    ..interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ));

  final remoteRepo = RemoteAuthenticationRepository(rawDio);
  final authRepo = AuthenticationRepository(local: localRepo, remote: remoteRepo);

  final appDio = buildAuthorizedDio(authRepo);

  runApp(ProviderScope(
    overrides: [
      localAuthRepoProvider.overrideWithValue(localRepo),
      remoteAuthRepoProvider.overrideWithValue(remoteRepo),
      authRepositoryProvider.overrideWithValue(authRepo),
      dioProvider.overrideWithValue(appDio),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChoice = ref.watch(themeChoiceProvider);
    if (themeChoice.isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    final choice = themeChoice.value ?? AppThemeChoice.system;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: mapChoiceToThemeMode(
        choice,
        MediaQuery.platformBrightnessOf(context),
      ),
    );
  }
}
