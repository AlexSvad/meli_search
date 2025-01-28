import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/bootstrap.dart';

void main() {
  testWidgets('bootstrap inicializa sin errores', (tester) async {
    final originalOnError = FlutterError.onError;
    try {
      await bootstrap(() async {
        return const MaterialApp(
          home: Scaffold(
            body: Text('Meli Testing'),
          ),
        );
      });
    } finally {
      FlutterError.onError = originalOnError;
    }
  });
}
