import '../../domain/entities/search_result_entity.dart';
import '../models/search_result_model.dart';
import 'item_mapper.dart';
import 'search_paging_mapper.dart';

class SearchResultMapper {
  static SearchResultEntity fromModel(ApiSearchResultModel model) {
    return SearchResultEntity(
      siteId: model.siteId,
      query: model.query,
      paging: SearchPagingMapper.fromModel(model.paging),
      results: model.results.map(ItemMapper.fromModel).toList(),
    );
  }
}
