import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/app_router.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // El archivo .env es opcional en producción: si el hosting no lo sirve,
  // AppConfig usa la URL pública de la API Colombia como respaldo.
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // Se conserva la configuración por defecto de AppConfig.
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Colombia Open Data',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: appRouter,
    );
  }
}
