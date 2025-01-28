import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/main_development.dart' as app;

void main() {
  test('main() se ejecuta sin errores', () {
    expect(() => app.main(), returnsNormally);
  });
}
