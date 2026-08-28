import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/dream_place_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      name: 'details',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);