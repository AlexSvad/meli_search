import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/api_item_model.dart';
import '../models/api_multi_get_response_model.dart';
import '../models/search_result_model.dart';

part 'mercado_libre_service.g.dart';

const _baseUrl = 'https://api.mercadolibre.com';

@RestApi(baseUrl: _baseUrl)
abstract class MercadoLibreClient {
  factory MercadoLibreClient(Dio dio, {String baseUrl}) = _MercadoLibreClient;

  @GET('/sites/{site}/search')
  Future<ApiSearchResultModel> searchItems(
    @Path('site') String siteId,
    @Query('q') String query,
  );

  @GET('/items')
  Future<List<ApiMultiGetResponseModel>> getItemsByIds(
    @Query('ids') String itemIds,
  );

  @GET('/items/{id}')
  Future<ApiItemModel> getItemById(@Path('id') String id);
}
