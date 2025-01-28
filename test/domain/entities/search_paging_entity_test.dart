import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/domain/entities/search_paging_entity.dart';

void main() {
  group('SearchPagingEntity', () {
    test('props y comparación de instancias', () {
      const paging1 = SearchPagingEntity(
        total: 100,
        offset: 0,
        limit: 50,
        primaryResults: 10,
      );
      const paging2 = SearchPagingEntity(
        total: 100,
        offset: 0,
        limit: 50,
        primaryResults: 10,
      );
      const paging3 = SearchPagingEntity(
        total: 300,
        offset: 10,
        limit: 20,
        primaryResults: 2,
      );

      expect(paging1, equals(paging2));
      expect(paging1, isNot(equals(paging3)));
      expect(paging1.total, 100);
      expect(paging1.offset, 0);
      expect(paging1.limit, 50);
      expect(paging1.primaryResults, 10);
    });
  });
}
