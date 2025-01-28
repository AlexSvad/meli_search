import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/dependency_register.dart';
import 'package:meli_search/app/domain/entities/item_entity.dart';
import 'package:meli_search/app/l10n/l10n.dart';
import 'package:meli_search/app/ui/screens/detail_screen.dart';
import 'package:meli_search/app/ui/screens/results_screen.dart';

void main() {
  setUpAll(() async {
    await Register.init();
  });

  tearDownAll(Register.dispose);

  group('ResultsScreen', () {
    testWidgets('muestra mensaje "sin resultados" cuando la lista está vacía',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ResultsScreen(results: []),
          ),
        ),
      );
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('muestra lista de resultados cuando la lista no está vacía',
        (tester) async {
      const items = [
        ItemEntity(
          id: 'MLA123',
          title: 'Item 1',
          price: 123.45,
          thumbnailUrl: 'http://example.com/img1.jpg',
          availableQuantity: 10,
        ),
        ItemEntity(
          id: 'MLA456',
          title: 'Item 2',
          price: 234.56,
          thumbnailUrl: 'http://example.com/img2.jpg',
          availableQuantity: 5,
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ResultsScreen(results: items),
          ),
        ),
      );

      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('\$123.45'), findsOneWidget);
      expect(find.text('\$234.56'), findsOneWidget);
    });

    testWidgets('navega a DetailScreen al hacer tap en un elemento',
        (tester) async {
      const items = [
        ItemEntity(
          id: 'MLA123',
          title: 'Item 1',
          price: 123.45,
          thumbnailUrl: 'http://example.com/img1.jpg',
          availableQuantity: 10,
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ResultsScreen(results: items),
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(find.byType(DetailScreen), findsOneWidget);

      final detailScreenWidget =
          tester.widget<DetailScreen>(find.byType(DetailScreen));
      expect(detailScreenWidget.itemId, 'MLA123');
    });
  });
}
