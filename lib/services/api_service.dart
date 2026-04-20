import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

/// Generic HTTP helper that handles status codes and exceptions.
class ApiService {
  static Future<List<dynamic>> fetchList(String endpoint) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/$endpoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception(
        'Error al obtener datos de $endpoint (código ${response.statusCode})',
      );
    }
  }

  static Future<Map<String, dynamic>> fetchOne(
      String endpoint, int id) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/$endpoint/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Error al obtener $endpoint/$id (código ${response.statusCode})',
      );
    }
  }
}
