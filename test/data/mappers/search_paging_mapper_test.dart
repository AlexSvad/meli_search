import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/mappers/search_paging_mapper.dart';
import 'package:meli_search/app/data/models/search_result_model.dart';
import 'package:meli_search/app/domain/entities/search_paging_entity.dart';

void main() {
  group('SearchPagingMapper', () {
    test('fromModel mapea correctamente un ApiPagingModel a SearchPagingEntity',
        () {
      final apiPaging = ApiPagingModel(
        total: 100,
        offset: 10,
        limit: 50,
        primaryResults: 5,
      );

      final entity = SearchPagingMapper.fromModel(apiPaging);

      expect(entity, isA<SearchPagingEntity>());
      expect(entity.total, 100);
      expect(entity.offset, 10);
      expect(entity.limit, 50);
      expect(entity.primaryResults, 5);
    });
  });
}
