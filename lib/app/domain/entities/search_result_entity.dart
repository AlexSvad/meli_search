import 'item_entity.dart';
import 'search_paging_entity.dart';

class SearchResultEntity {
  const SearchResultEntity({
    required this.siteId,
    required this.query,
    required this.paging,
    required this.results,
  });
  final String siteId;
  final String query;
  final SearchPagingEntity paging;
  final List<ItemEntity> results;
}
