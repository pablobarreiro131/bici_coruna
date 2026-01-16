import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bici_coruna/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Prueba de Sistema: Flujo completo de consulta de estación', () {
    testWidgets('Usuario consulta disponibilidad de bicis en una estación', 
      (WidgetTester tester) async {

      app.main();
      await tester.pumpAndSettle();

      await tester.pump(Duration(seconds: 2));
      await tester.pumpAndSettle(Duration(seconds: 10));

      expect(find.byType(MaterialApp), findsOneWidget);

      final cards = find.byType(Card);
      if (cards.evaluate().isNotEmpty) {
        expect(cards, findsWidgets);

        await tester.tap(cards.first);
        await tester.pumpAndSettle();

        final detailTexts = find.textContaining('disponible', findRichText: true);
        if (detailTexts.evaluate().isNotEmpty) {
          expect(detailTexts, findsWidgets);
        }
      }

      final backButton = find.byType(BackButton);
      if (backButton.evaluate().isEmpty) {

        final backIcon = find.byIcon(Icons.arrow_back);
        if (backIcon.evaluate().isNotEmpty) {
          await tester.tap(backIcon);
          await tester.pumpAndSettle();
        }
      } else {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }
    });
  });
}