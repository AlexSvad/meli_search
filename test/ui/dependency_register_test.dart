import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/repositories/items_repository.dart';
import 'package:meli_search/app/data/services/mercado_libre_service.dart';
import 'package:meli_search/app/dependency_register.dart';

void main() {
  test('init y dispose funcionan correctamente', () async {
    await Register.init();

    final dio = Register.injector.get<Dio>();
    expect(dio, isA<Dio>());

    final client = Register.injector.get<MercadoLibreClient>();
    expect(client, isA<MercadoLibreClient>());

    final repository = Register.injector.get<ItemsRepository>();
    expect(repository, isA<ItemsRepository>());

    Register.dispose();

    expect(() => Register.injector.get<Dio>(), throwsA(isA<Exception>()));
  });
}
