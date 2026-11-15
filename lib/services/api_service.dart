import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

/// Generic HTTP helper that handles status codes and exceptions.
class ApiService {
  static const Duration _timeout = Duration(seconds: 15);

  static Future<List<dynamic>> fetchList(String endpoint) async {
    final response = await _get(endpoint);
    _ensureSuccess(response, endpoint);

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw Exception(
        'La API devolvió un formato inesperado para $endpoint. '
        'Intenta de nuevo en unos segundos.',
      );
    }

    return decoded;
  }

  static Future<Map<String, dynamic>> fetchOne(
    String endpoint,
    int id,
  ) async {
    final response = await _get('$endpoint/$id');
    _ensureSuccess(response, '$endpoint/$id');

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception(
        'La API devolvió un formato inesperado para $endpoint/$id. '
        'Intenta de nuevo en unos segundos.',
      );
    }

    return decoded;
  }

  static Future<http.Response> _get(String path) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/$path');

    try {
      return await http.get(url).timeout(_timeout);
    } on TimeoutException {
      throw Exception(
        'La API Colombia tardó demasiado en responder. '
        'Revisa tu conexión e intenta de nuevo.',
      );
    } on http.ClientException {
      throw Exception(
        'No fue posible conectar con la API Colombia. '
        'Revisa tu conexión e intenta de nuevo.',
      );
    }
  }

  static void _ensureSuccess(http.Response response, String path) {
    if (response.statusCode != 200) {
      throw Exception(
        'Error al obtener datos de $path '
        '(código ${response.statusCode}).',
      );
    }
  }
}
