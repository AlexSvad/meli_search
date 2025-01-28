import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/models/api_item_model.dart';
import 'package:meli_search/app/data/models/search_result_model.dart';
import 'package:meli_search/app/data/repositories/items_repository.dart';
import 'package:meli_search/app/data/services/mercado_libre_service.dart';
import 'package:meli_search/app/domain/entities/item_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockMercadoLibreClient extends Mock implements MercadoLibreClient {}

void main() {
  late ItemsRepository repository;
  late MockMercadoLibreClient mockClient;

  setUp(() {
    mockClient = MockMercadoLibreClient();
    repository = ItemsRepository(client: mockClient);
  });

  group('ItemsRepository', () {
    test('searchItems() regresa el SearchResultEntity correctamente', () async {
      final apiSearchResult = ApiSearchResultModel(
        siteId: 'MLA',
        query: 'test',
        paging: ApiPagingModel(
          total: 1,
          offset: 0,
          limit: 50,
          primaryResults: 1,
        ),
        results: [
          ApiItemModel(
            id: 'MLA123',
            title: 'Item test',
            price: 100,
            thumbnailUrl: 'http://example.com/img.jpg',
            availableQuantity: 5,
          ),
        ],
      );

      when(() => mockClient.searchItems('MLA', 'test'))
          .thenAnswer((_) async => apiSearchResult);

      final result = await repository.searchItems('test');
      expect(result.siteId, 'MLA');
      expect(result.results.first.id, 'MLA123');
    });

    test('searchItems() lanza excepción con DioException', () async {
      when(() => mockClient.searchItems('MLA', 'test'))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(
        () async => repository.searchItems('test'),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'Error en la comunicación con la API',
          contains('Error en la comunicación con la API'),
        )),
      );
    });

    test('getItemDetail() regresa un ItemEntity correctamente', () async {
      final apiItem = ApiItemModel(
        id: 'MLA999',
        title: 'Detalle test',
        price: 500,
        thumbnailUrl: 'http://example.com/img2.jpg',
        availableQuantity: 3,
      );

      when(() => mockClient.getItemById('MLA999'))
          .thenAnswer((_) async => apiItem);

      final item = await repository.getItemDetail('MLA999');
      expect(item, isA<ItemEntity>());
      expect(item.id, 'MLA999');
      expect(item.price, 500);
    });

    test('getItemDetail() lanza excepción con DioException', () async {
      when(() => mockClient.getItemById('MLA999'))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      expect(
        () async => repository.getItemDetail('MLA999'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'Error en la comunicación con la API',
            contains('Error en la comunicación con la API'),
          ),
        ),
      );
    });
  });
}
