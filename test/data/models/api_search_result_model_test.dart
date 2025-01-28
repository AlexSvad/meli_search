import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/models/api_item_model.dart';
import 'package:meli_search/app/data/models/search_result_model.dart';

void main() {
  group('ApiSearchResultModel', () {
    test('fromJson / toJson funcionan correctamente', () {
      final json = {
        'site_id': 'MLA',
        'query': 'iphone',
        'paging': {
          'total': 200,
          'offset': 0,
          'limit': 50,
          'primary_results': 5,
        },
        'results': [
          {
            'id': 'MLA123',
            'title': 'iPhone X',
            'price': 999.99,
            'thumbnail': 'http://example.com/x.jpg',
            'available_quantity': 3,
          },
          {
            'id': 'MLA456',
            'title': 'iPhone 11',
            'price': 1299.99,
            'thumbnail': 'http://example.com/11.jpg',
            'available_quantity': 1,
          },
        ],
      };

      final model = ApiSearchResultModel.fromJson(json);

      expect(model.siteId, 'MLA');
      expect(model.query, 'iphone');
      expect(model.paging.total, 200);
      expect(model.paging.primaryResults, 5);
      expect(model.results, isA<List<ApiItemModel>>());
      expect(model.results.length, 2);
      expect(model.results.first.id, 'MLA123');

      final toJsonResult = model.toJson();
      expect(toJsonResult, json);
    });
  });
}
