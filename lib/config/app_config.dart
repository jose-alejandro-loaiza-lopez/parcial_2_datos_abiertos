import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const String _defaultApiBaseUrl =
      'https://api-colombia.com/api/v1';

  /// URL base de la API Colombia.
  ///
  /// Si el archivo de configuración no se cargó (por ejemplo, porque el
  /// hosting no sirve el asset) se usa la URL pública como respaldo en lugar
  /// de fallar al acceder a [dotenv.env], que lanza una excepción cuando
  /// `dotenv.load` no se ha completado.
  static String get apiBaseUrl {
    if (!dotenv.isInitialized) {
      return _defaultApiBaseUrl;
    }

    final value = dotenv.env['API_BASE_URL'];
    if (value == null || value.trim().isEmpty) {
      return _defaultApiBaseUrl;
    }

    return value.trim();
  }
}
