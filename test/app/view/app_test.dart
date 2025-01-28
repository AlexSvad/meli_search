import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/app.dart';
import 'package:meli_search/app/dependency_register.dart';
import 'package:meli_search/app/ui/screens/search_screen.dart';

void main() {
  setUpAll(() async {
    await Register.init();
  });
  tearDownAll(Register.dispose);
  group('App', () {
    testWidgets('renders SearchScreen', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(SearchScreen), findsOneWidget);
    });
  });
}
