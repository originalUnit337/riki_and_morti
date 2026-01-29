import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riki_and_morti/config/dependencies/init.dart';
import 'package:riki_and_morti/config/navigation/app_router.dart';
import 'package:riki_and_morti/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  final config = AppRouter().router;
  runApp(MainApp(config: config));
}

class MainApp extends StatelessWidget {
  final GoRouter config;
  const MainApp({required this.config, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightAppTheme,
      darkTheme: AppTheme.darkAppTheme,
      routerConfig: config,
    );
  }
}
