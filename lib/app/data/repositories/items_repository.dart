import 'package:dio/dio.dart';

import '../../domain/entities/item_entity.dart';
import '../../domain/entities/search_result_entity.dart';
import '../mappers/item_mapper.dart';
import '../mappers/search_result_mapper.dart';
import '../models/api_item_model.dart';
import '../models/search_result_model.dart';
import '../services/mercado_libre_service.dart';

class ItemsRepository {
  ItemsRepository({required MercadoLibreClient client}) : _client = client;
  final MercadoLibreClient _client;

  Future<SearchResultEntity> searchItems(String query) async {
    try {
      final ApiSearchResultModel apiResult = await _client.searchItems(
        'MLA',
        query,
      );
      return SearchResultMapper.fromModel(apiResult);
    } on DioException catch (e) {
      throw Exception('Error en la comunicación con la API: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  Future<ItemEntity> getItemDetail(String itemId) async {
    try {
      final ApiItemModel apiItem = await _client.getItemById(itemId);
      return ItemMapper.fromModel(apiItem);
    } on DioException catch (e) {
      throw Exception('Error en la comunicación con la API: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
