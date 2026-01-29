enum AppRoutes {
  homeRoute(name: 'home', path: '/'),
  favourites(name: 'favourites', path: '/favourites');

  final String name;
  final String path;
  const AppRoutes({required this.name, required this.path});
}