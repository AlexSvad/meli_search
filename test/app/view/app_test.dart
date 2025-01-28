import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/app.dart';
import 'package:meli_search/app/ui/screens/search_screen.dart';

void main() {
  group('App', () {
    testWidgets('renders SearchScreen', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(SearchScreen), findsOneWidget);
    });
  });
}
