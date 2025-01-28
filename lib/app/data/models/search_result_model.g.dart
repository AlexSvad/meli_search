// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiSearchResultModel _$ApiSearchResultModelFromJson(
        Map<String, dynamic> json) =>
    ApiSearchResultModel(
      siteId: json['site_id'] as String,
      query: json['query'] as String,
      paging: ApiPagingModel.fromJson(json['paging'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => ApiItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiSearchResultModelToJson(
        ApiSearchResultModel instance) =>
    <String, dynamic>{
      'site_id': instance.siteId,
      'query': instance.query,
      'paging': instance.paging.toJson(),
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

ApiPagingModel _$ApiPagingModelFromJson(Map<String, dynamic> json) =>
    ApiPagingModel(
      total: (json['total'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      primaryResults: (json['primary_results'] as num).toInt(),
    );

Map<String, dynamic> _$ApiPagingModelToJson(ApiPagingModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'offset': instance.offset,
      'limit': instance.limit,
      'primary_results': instance.primaryResults,
    };
