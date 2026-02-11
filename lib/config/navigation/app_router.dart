import 'package:go_router/go_router.dart';
import 'package:riki_and_morti/config/navigation/app_routes.dart';
import 'package:riki_and_morti/presentation/screens/favourite/favourite_screen.dart';
import 'package:riki_and_morti/presentation/screens/home/home_screen.dart';

class AppRouter {
  GoRouter get router => GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.homeRoute.path,
        name: AppRoutes.homeRoute.name,
        builder: (context, state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: AppRoutes.favourites.path,
            name: AppRoutes.favourites.name,
            builder: (context, state) {
              return const FavouriteScreen();
            },
          ),
        ],
      ),
    ],
  );
}
