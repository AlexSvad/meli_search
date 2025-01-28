import '../../domain/entities/search_paging_entity.dart';
import '../models/search_result_model.dart';

class SearchPagingMapper {
  static SearchPagingEntity fromModel(ApiPagingModel model) {
    return SearchPagingEntity(
      total: model.total,
      offset: model.offset,
      limit: model.limit,
      primaryResults: model.primaryResults,
    );
  }
}
