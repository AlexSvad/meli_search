import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/l10n/l10n.dart';
import 'package:meli_search/app/ui/blocs/search_bloc/search_bloc.dart';
import 'package:meli_search/app/ui/blocs/search_bloc/search_event.dart';
import 'package:meli_search/app/ui/blocs/search_bloc/search_state.dart';
import 'package:meli_search/app/ui/screens/search_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  group('SearchScreen', () {
    late MockSearchBloc mockSearchBloc;

    setUp(() {
      mockSearchBloc = MockSearchBloc();
    });

    Future<void> _buildWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: BlocProvider<SearchBloc>(
              create: (_) => mockSearchBloc,
              child: const SearchScreen(),
            ),
          ),
        ),
      );
    }

    testWidgets('muestra CircularProgressIndicator cuando status=loading',
        (tester) async {
      when(() => mockSearchBloc.state).thenReturn(
        const SearchState(status: SearchStatus.loading),
      );

      await _buildWidget(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('muestra mensaje de error cuando status=failure',
        (tester) async {
      when(() => mockSearchBloc.state).thenReturn(
        const SearchState(
          status: SearchStatus.failure,
          errorMessage: 'Error de prueba',
        ),
      );

      await _buildWidget(tester);
      expect(find.text('Error de prueba'), findsOneWidget);
    });

    testWidgets('ingresa texto y dispara SearchQueryChanged', (tester) async {
      when(() => mockSearchBloc.state).thenReturn(const SearchState());
      whenListen(
        mockSearchBloc,
        Stream<SearchState>.fromIterable([]),
        initialState: const SearchState(),
      );

      await _buildWidget(tester);

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'Test query');
      await tester.pumpAndSettle();

      verify(() => mockSearchBloc.add(const SearchQueryChanged('Test query')))
          .called(greaterThanOrEqualTo(1));
    });
  });
}
