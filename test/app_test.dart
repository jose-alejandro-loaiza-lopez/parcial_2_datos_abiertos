import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:parcial_2_datos_abiertos/main.dart';
import 'package:parcial_2_datos_abiertos/routes/app_router.dart';

void main() {
  testWidgets('renderiza el dashboard con las cuatro categorías',
      (tester) async {
    tester.view.physicalSize = const Size(1000, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Explora los datos'), findsOneWidget);
    expect(find.text('Departamentos'), findsOneWidget);
    expect(find.text('Presidentes'), findsOneWidget);
    expect(find.text('Atracciones'), findsOneWidget);
    expect(find.text('Regiones'), findsOneWidget);
  });

  test('expone las rutas del catálogo y sus detalles', () {
    final home = appRouter.configuration.routes.single as GoRoute;
    final children = home.routes.whereType<GoRoute>().toList();

    expect(home.name, 'dashboard');
    expect(home.path, '/');
    expect(
      children.map((route) => route.name),
      ['departments', 'presidents', 'attractions', 'regions'],
    );

    for (final section in children) {
      final detail = section.routes.single as GoRoute;
      expect(detail.path, ':id');
      expect(detail.name, endsWith('-detail'));
    }
  });
}
