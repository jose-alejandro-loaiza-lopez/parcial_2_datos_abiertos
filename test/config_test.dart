import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parcial_2_datos_abiertos/config/app_config.dart';

void main() {
  test('usa la API pública cuando la configuración no se ha cargado', () {
    expect(dotenv.isInitialized, isFalse);
    expect(AppConfig.apiBaseUrl, 'https://api-colombia.com/api/v1');
  });

  test('lee la URL base desde la configuración cargada', () {
    dotenv.testLoad(fileInput: 'API_BASE_URL=https://example.test/api/v1');

    expect(AppConfig.apiBaseUrl, 'https://example.test/api/v1');
  });

  test('vuelve al valor por defecto cuando la URL está vacía', () {
    dotenv.testLoad(fileInput: 'API_BASE_URL=');

    expect(AppConfig.apiBaseUrl, 'https://api-colombia.com/api/v1');
  });
}
