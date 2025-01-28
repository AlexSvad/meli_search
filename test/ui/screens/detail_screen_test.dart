import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/domain/entities/item_entity.dart';
import 'package:meli_search/app/l10n/l10n.dart';
import 'package:meli_search/app/ui/blocs/detail_bloc/detail_bloc.dart';
import 'package:meli_search/app/ui/blocs/detail_bloc/detail_event.dart';
import 'package:meli_search/app/ui/blocs/detail_bloc/detail_state.dart';
import 'package:meli_search/app/ui/screens/detail_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockDetailBloc extends MockBloc<DetailEvent, DetailState>
    implements DetailBloc {}

void main() {
  group('DetailScreen', () {
    late MockDetailBloc mockDetailBloc;

    setUp(() {
      mockDetailBloc = MockDetailBloc();
    });

    Widget buildTestableWidget() {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider<DetailBloc>(
          create: (_) => mockDetailBloc,
          child: const DetailScreen(itemId: 'MLA123'),
        ),
      );
    }

    testWidgets('muestra loading cuando DetailStatus.loading', (tester) async {
      when(() => mockDetailBloc.state).thenReturn(
        const DetailState(status: DetailStatus.loading),
      );

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('muestra mensaje de error cuando DetailStatus.failure',
        (tester) async {
      when(() => mockDetailBloc.state).thenReturn(
        const DetailState(
          status: DetailStatus.failure,
          errorMessage: 'Error de prueba en detalle',
        ),
      );

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.text('Error de prueba en detalle'), findsOneWidget);
    });

    testWidgets('muestra datos del item cuando DetailStatus.success',
        (tester) async {
      const item = ItemEntity(
        id: 'MLA123',
        title: 'Test Item',
        price: 999.99,
        thumbnailUrl: 'http://example.com/image.jpg',
        availableQuantity: 10,
      );

      when(() => mockDetailBloc.state).thenReturn(
        const DetailState(
          status: DetailStatus.success,
          item: item,
        ),
      );

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.text('Test Item'), findsOneWidget);
      expect(find.text('\$999.99'), findsOneWidget);
      expect(find.textContaining('10'), findsOneWidget);
    });

    testWidgets('verifica que se muestre el AppBar y botón back',
        (tester) async {
      when(() => mockDetailBloc.state).thenReturn(
        const DetailState(status: DetailStatus.loading),
      );

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      final backButton = find.byIcon(Icons.arrow_back_ios_rounded);
      expect(backButton, findsOneWidget);
      await tester.tap(backButton);
    });
  });
}
