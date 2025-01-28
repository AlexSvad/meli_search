import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/mappers/search_result_mapper.dart';
import 'package:meli_search/app/data/models/api_item_model.dart';
import 'package:meli_search/app/data/models/search_result_model.dart';
import 'package:meli_search/app/domain/entities/search_result_entity.dart';

void main() {
  group('SearchResultMapper', () {
    test(
        'fromModel mapea correctamente un ApiSearchResultModel a SearchResultEntity',
        () {
      final apiResult = ApiSearchResultModel(
        siteId: 'MLA',
        query: 'iphone',
        paging: ApiPagingModel(
          total: 200,
          offset: 0,
          limit: 50,
          primaryResults: 10,
        ),
        results: [
          ApiItemModel(
            id: 'MLA123',
            title: 'iPhone X',
            price: 999.99,
            thumbnailUrl: 'urlX',
            availableQuantity: 5,
          ),
          ApiItemModel(
            id: 'MLA456',
            title: 'iPhone 11',
            price: 1299.99,
            thumbnailUrl: 'url11',
            availableQuantity: 3,
          ),
        ],
      );

      final entity = SearchResultMapper.fromModel(apiResult);

      expect(entity, isA<SearchResultEntity>());
      expect(entity.siteId, 'MLA');
      expect(entity.query, 'iphone');
      expect(entity.paging.total, 200);
      expect(entity.results.length, 2);
      expect(entity.results[0].id, 'MLA123');
      expect(entity.results[1].title, 'iPhone 11');
    });
  });
}
