import 'package:dio/dio.dart';
import 'package:injector/injector.dart';

import 'data/repositories/items_repository.dart';
import 'data/services/mercado_libre_service.dart';

abstract class Register {
  static final Injector injector = Injector.appInstance;

  static Future<void> init() async {
    await _initDI();
  }

  static void dispose() {
    injector.clearAll();
  }

  static Future<void> _initDI() async {
    injector
      ..registerSingleton<Dio>(() {
        return Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );
      })
      ..registerSingleton<MercadoLibreClient>(() {
        final dio = injector.get<Dio>();
        return MercadoLibreClient(dio);
      })
      ..registerSingleton<ItemsRepository>(() {
        final client = injector.get<MercadoLibreClient>();
        return ItemsRepository(client: client);
      });
  }
}
