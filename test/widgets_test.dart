import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parcial_2_datos_abiertos/widgets/dashboard_card.dart';
import 'package:parcial_2_datos_abiertos/widgets/error_widget.dart';
import 'package:parcial_2_datos_abiertos/widgets/loading_widget.dart';

void main() {
  group('DashboardCard', () {
    testWidgets('muestra el título, subtítulo e icono', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DashboardCard(
              icon: Icons.map_rounded,
              title: 'Departamentos',
              subtitle: 'Conoce los 32 departamentos',
              gradientStart: Colors.blue,
              gradientEnd: Colors.indigo,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Departamentos'), findsOneWidget);
      expect(find.text('Conoce los 32 departamentos'), findsOneWidget);
      expect(find.byIcon(Icons.map_rounded), findsOneWidget);
    });

    testWidgets('ejecuta el callback al tocar la tarjeta', (tester) async {
      var taps = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DashboardCard(
              icon: Icons.person_rounded,
              title: 'Presidentes',
              subtitle: 'Historia presidencial',
              gradientStart: Colors.green,
              gradientEnd: Colors.teal,
              onTap: () => taps++,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Presidentes'));
      await tester.pumpAndSettle();

      expect(taps, 1);
    });
  });

  group('LoadingWidget', () {
    testWidgets('usa el mensaje por defecto', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: LoadingWidget())),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Cargando datos...'), findsOneWidget);
    });

    testWidgets('permite personalizar el mensaje', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LoadingWidget(message: 'Cargando regiones...')),
        ),
      );

      expect(find.text('Cargando regiones...'), findsOneWidget);
    });
  });

  group('ErrorDisplay', () {
    testWidgets('muestra el mensaje de error y el botón de reintento',
        (tester) async {
      var retries = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorDisplay(
              message: 'No hay conexión',
              onRetry: () => retries++,
            ),
          ),
        ),
      );

      expect(find.text('Ocurrió un error'), findsOneWidget);
      expect(find.text('No hay conexión'), findsOneWidget);

      await tester.tap(find.text('Reintentar'));
      expect(retries, 1);
    });

    testWidgets('oculta el botón cuando no hay reintento', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ErrorDisplay(message: 'Error fatal')),
        ),
      );

      expect(find.text('Error fatal'), findsOneWidget);
      expect(find.text('Reintentar'), findsNothing);
    });
  });
}
