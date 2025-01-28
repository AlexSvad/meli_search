import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:meli_search/app/data/models/api_item_model.dart';
import 'package:meli_search/app/data/models/api_multi_get_response_model.dart';
import 'package:meli_search/app/data/models/search_result_model.dart';
import 'package:meli_search/app/data/services/mercado_libre_service.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late MercadoLibreClient client;

  const _baseUrl = 'https://api.mercadolibre.com';

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    client = MercadoLibreClient(dio, baseUrl: _baseUrl);
  });

  group('MercadoLibreClient', () {
    test('searchItems retorna ApiSearchResultModel correctamente', () async {
      const siteId = 'MLA';
      const query = 'iphone';

      final mockResponse = {
        'site_id': siteId,
        'query': query,
        'paging': {
          'total': 100,
          'offset': 0,
          'limit': 50,
          'primary_results': 10,
        },
        'results': [
          {
            'id': 'MLA123',
            'title': 'iPhone X',
            'price': 999.99,
            'thumbnail': 'http://example.com/x.jpg',
            'available_quantity': 3,
          },
        ],
      };

      dioAdapter.onGet(
        '/sites/$siteId/search',
        queryParameters: {'q': query},
        (request) => request.reply(200, mockResponse),
      );

      final result = await client.searchItems(siteId, query);

      expect(result, isA<ApiSearchResultModel>());
      expect(result.siteId, siteId);
      expect(result.query, query);
      expect(result.paging.total, 100);
      expect(result.results, isNotEmpty);
      expect(result.results.first.id, 'MLA123');
    });

    test('getItemsByIds retorna List<ApiMultiGetResponseModel> correctamente',
        () async {
      const itemIds = 'MLA123,MLA456';
      final mockResponse = [
        {
          'code': 200,
          'body': {
            'id': 'MLA123',
            'title': 'Fake Item 1',
            'price': 500,
            'thumbnail': 'http://example.com/1.jpg',
            'available_quantity': 2,
          }
        },
        {
          'code': 200,
          'body': {
            'id': 'MLA456',
            'title': 'Fake Item 2',
            'price': 250,
            'thumbnail': 'http://example.com/2.jpg',
            'available_quantity': 1,
          }
        },
      ];

      dioAdapter.onGet(
        '/items',
        queryParameters: {'ids': itemIds},
        (request) => request.reply(200, mockResponse),
      );

      final result = await client.getItemsByIds(itemIds);

      expect(result, isA<List<ApiMultiGetResponseModel>>());
      expect(result.length, 2);
      expect(result.first.code, 200);
      expect(result.first.body, isA<ApiItemModel>());
      expect(result.first.body.id, 'MLA123');
      expect(result.last.body.title, 'Fake Item 2');
    });

    test('getItemById retorna ApiItemModel correctamente', () async {
      const itemId = 'MLA999';
      final mockResponse = {
        'id': itemId,
        'title': 'Test Single Item',
        'price': 1999.99,
        'thumbnail': 'http://example.com/single.jpg',
        'available_quantity': 5,
      };

      dioAdapter.onGet(
        '/items/$itemId',
        (request) => request.reply(200, mockResponse),
      );

      final result = await client.getItemById(itemId);

      expect(result, isA<ApiItemModel>());
      expect(result.id, itemId);
      expect(result.price, 1999.99);
    });

    test('searchItems lanza DioException al recibir 404', () async {
      const siteId = 'MLA';
      const query = 'ipad';

      dioAdapter.onGet(
        '/sites/$siteId/search',
        queryParameters: {'q': query},
        (request) => request.reply(404, {'message': 'Not found'}),
      );

      expect(
        () => client.searchItems(siteId, query),
        throwsA(isA<DioException>()),
      );
    });
  });
}
