import 'package:go_router/go_router.dart';
import 'main.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const PlacesScreen()),
    GoRoute(
      path: '${DreamPlaceScreen.route}/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DreamPlaceScreen(id: id);
      },
    ),
  ],
);
