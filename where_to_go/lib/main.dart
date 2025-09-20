import "package:dio/dio.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

import "app_router.dart";
import "core/api_path.dart";
import "core/dio_client.dart";

import "features/auth/auth_providers.dart";
import "features/auth/local_auth_repository.dart";
import "features/auth/remote_auth_repository.dart";
import "features/auth/authentication_repository.dart";

import "theme/app.theme.dart";
import "theme/local_theme.dart";
import "theme/providers.dart";

const bool ENABLE_API_SMOKE_TEST = true;

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
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ));

  final remoteRepo = RemoteAuthenticationRepository(rawDio);
  final authRepo = AuthenticationRepository(local: localRepo, remote: remoteRepo);

  if (kDebugMode && ENABLE_API_SMOKE_TEST) {
    await _probeLoginPaths();
  }

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

Future<void> _probeLoginPaths() async {
  final candidates = <({String baseUrl, String path})>[
    (baseUrl: "https://backend-api.w.solvro.pl", path: "/auth/login"),
    (baseUrl: "https://backend-api.w.solvro.pl/api", path: "/auth/login"),
    (baseUrl: "https://backend-api.w.solvro.pl", path: "/api/auth/login"),
    (baseUrl: "https://backend-api.w.solvro.pl/api", path: "/api/auth/login"),
  ];

  const body = {"email": "test@test.pl", "password": "Secret123!"};

  debugPrint("=== 🔎 PROBE AUTH/LOGIN START ===");
  for (final c in candidates) {
    final dio = Dio(BaseOptions(
      baseUrl: c.baseUrl,
      headers: const {"Content-Type": "application/json", "Accept": "application/json"},
      validateStatus: (s) => s != null && s < 500,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    ));

    try {
      debugPrint("→ TRY: baseUrl=${c.baseUrl}  path=${c.path}");
      final res = await dio.post<Map<String, dynamic>>(c.path, data: body);
      debugPrint("← STATUS: ${res.statusCode}  URL: ${c.baseUrl}${c.path}");
      debugPrint("← BODY: ${res.data}");
    } on Exception catch (e) {
      debugPrint("← EXC for ${c.baseUrl}${c.path}: $e");
    }
  }
  debugPrint("=== 🔎 PROBE AUTH/LOGIN END ===");

  debugPrint("""
Jeśli wszystkie 4 dają 404:
- endpoint ma inną nazwę (np. /login, /auth/signin),
- albo logowanie NIE istnieje w tym API.
Wtedy wejdź w Swagger i podaj dokładną ścieżkę/metodę, zrobimy pod to ApiPaths.
""");
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
