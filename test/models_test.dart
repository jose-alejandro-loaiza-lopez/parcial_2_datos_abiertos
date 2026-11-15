import 'package:flutter_test/flutter_test.dart';
import 'package:parcial_2_datos_abiertos/models/department.dart';
import 'package:parcial_2_datos_abiertos/models/president.dart';
import 'package:parcial_2_datos_abiertos/models/region.dart';
import 'package:parcial_2_datos_abiertos/models/touristic_attraction.dart';

void main() {
  group('Department', () {
    final json = <String, dynamic>{
      'id': 1,
      'name': 'Valle del Cauca',
      'description': 'Departamento del suroccidente colombiano.',
      'municipalities': 42,
      'surface': 22140,
      'population': 4532150,
      'phonePrefix': '2',
      'regionId': 5,
      'cityCapital': {
        'id': 100,
        'name': 'Santiago de Cali',
        'description': 'Capital del departamento.',
        'surface': 564,
        'population': 2227642,
        'postalCode': '760001',
      },
    };

    test('convierte el JSON en un departamento con capital', () {
      final department = Department.fromJson(json);

      expect(department.id, 1);
      expect(department.name, 'Valle del Cauca');
      expect(department.population, 4532150);
      expect(department.cityCapital?.name, 'Santiago de Cali');
      expect(department.cityCapital?.postalCode, '760001');
    });

    test('usa valores por defecto cuando faltan campos opcionales', () {
      final department = Department.fromJson({'id': 2});

      expect(department.name, 'Sin nombre');
      expect(department.cityCapital, isNull);
      expect(department.population, isNull);
    });

    test('serializa el departamento conservando su capital', () {
      final result = Department.fromJson(json).toJson();

      expect(result['name'], 'Valle del Cauca');
      expect(result['regionId'], 5);
      expect((result['cityCapital'] as Map<String, dynamic>)['name'],
          'Santiago de Cali');
    });
  });

  group('President', () {
    test('compone el nombre completo y el periodo presidencial', () {
      final president = President.fromJson({
        'id': 1,
        'name': 'Gustavo',
        'lastName': 'Petro Urrego',
        'startPeriodDate': '2022-08-07',
        'endPeriodDate': '2026-08-07',
        'politicalParty': 'Colombia Humana',
      });

      expect(president.fullName, 'Gustavo Petro Urrego');
      expect(president.periodLabel, '2022-08-07 — 2026-08-07');
    });

    test('indica un periodo abierto cuando no hay fecha de fin', () {
      final president =
          President.fromJson({'id': 2, 'name': 'Actual', 'lastName': ''});

      expect(president.periodLabel, '? — Presente');
      expect(president.politicalParty, isNull);
    });

    test('serializa los datos del presidente', () {
      final result = President.fromJson({
        'id': 3,
        'name': 'Nombre',
        'lastName': 'Apellido',
        'image': 'https://example.com/p.png',
      }).toJson();

      expect(result['id'], 3);
      expect(result['image'], 'https://example.com/p.png');
    });
  });

  group('TouristicAttraction', () {
    test('selecciona la primera imagen válida y la ciudad anidada', () {
      final attraction = TouristicAttraction.fromJson({
        'id': 10,
        'name': 'Caño Cristales',
        'description': 'Río de los cinco colores.',
        'images': ['no-es-url', 'https://example.com/cano.jpg'],
        'latitude': '2.26',
        'longitude': '-73.79',
        'cityId': 50,
        'city': {'id': 50, 'name': 'La Macarena'},
      });

      expect(attraction.primaryImage, 'https://example.com/cano.jpg');
      expect(attraction.cityName, 'La Macarena');
      expect(attraction.images, hasLength(2));
    });

    test('devuelve null cuando no hay imágenes con URL', () {
      final attraction = TouristicAttraction.fromJson({
        'id': 11,
        'name': 'Atracción sin imagen',
      });

      expect(attraction.primaryImage, isNull);
      expect(attraction.images, isEmpty);
      expect(attraction.cityName, isNull);
    });

    test('serializa las atracciones turísticas', () {
      final result = TouristicAttraction.fromJson({
        'id': 12,
        'name': 'Lugar',
        'images': ['https://example.com/lugar.jpg'],
        'latitude': '1.0',
      }).toJson();

      expect(result['id'], 12);
      expect(result['images'], ['https://example.com/lugar.jpg']);
      expect(result['latitude'], '1.0');
    });
  });

  group('Region', () {
    test('convierte el JSON y aplica valores por defecto', () {
      final region = Region.fromJson({
        'id': 1,
        'name': 'Caribe',
        'description': 'Región costera.',
      });
      final empty = Region.fromJson({'id': 2});

      expect(region.name, 'Caribe');
      expect(region.description, 'Región costera.');
      expect(empty.name, 'Sin nombre');
    });

    test('serializa la región', () {
      final result = Region.fromJson({'id': 1, 'name': 'Andina'}).toJson();

      expect(result, {'id': 1, 'name': 'Andina', 'description': null});
    });
  });
}
