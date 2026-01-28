import 'package:go_router/go_router.dart';
import 'package:riki_and_morti/config/navigation/app_routes.dart';

class AppRouter {
  GoRouter get router => GoRouter(
    routes: [
      GoRoute(path: AppRoutes.homeRoute.path, name: AppRoutes.homeRoute.name),
    ],
  );
}
