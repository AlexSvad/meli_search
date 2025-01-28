import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/domain/entities/item_entity.dart';
import 'package:meli_search/app/domain/entities/search_paging_entity.dart';
import 'package:meli_search/app/domain/entities/search_result_entity.dart';

void main() {
  group('SearchResultEntity', () {
    test('props y comparación de instancias', () {
      const paging = SearchPagingEntity(
        total: 100,
        offset: 0,
        limit: 50,
        primaryResults: 10,
      );
      const items = [
        ItemEntity(
          id: 'MLA123',
          title: 'Test item',
          price: 9.99,
          thumbnailUrl: 'urlTest',
          availableQuantity: 2,
        ),
      ];

      const result1 = SearchResultEntity(
        siteId: 'MLA',
        query: 'iphone',
        paging: paging,
        results: items,
      );
      const result2 = SearchResultEntity(
        siteId: 'MLA',
        query: 'iphone',
        paging: paging,
        results: items,
      );
      const result3 = SearchResultEntity(
        siteId: 'MLB',
        query: 'android',
        paging: paging,
        results: items,
      );

      expect(result1, equals(result2));
      expect(result1, isNot(equals(result3)));
      expect(result1.siteId, 'MLA');
      expect(result1.query, 'iphone');
      expect(result1.paging, paging);
      expect(result1.results, items);
    });
  });
}
