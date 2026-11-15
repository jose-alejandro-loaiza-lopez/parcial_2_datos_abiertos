import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/app_router.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // La configuración es opcional: si el hosting no sirve el archivo,
  // AppConfig usa la URL pública de la API Colombia como respaldo.
  // Se usa `config.env` (sin punto inicial) porque GitHub Pages no publica
  // archivos ocultos como `.env`.
  await dotenv.load(fileName: 'config.env', isOptional: true);

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
