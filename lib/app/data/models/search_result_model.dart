import 'package:json_annotation/json_annotation.dart';

import 'api_item_model.dart';

part 'search_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiSearchResultModel {
  ApiSearchResultModel({
    required this.siteId,
    required this.query,
    required this.paging,
    required this.results,
  });

  factory ApiSearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$ApiSearchResultModelFromJson(json);

  @JsonKey(name: 'site_id')
  final String siteId;
  final String query;
  final ApiPagingModel paging;
  final List<ApiItemModel> results;

  Map<String, dynamic> toJson() => _$ApiSearchResultModelToJson(this);
}

@JsonSerializable()
class ApiPagingModel {
  ApiPagingModel({
    required this.total,
    required this.offset,
    required this.limit,
    required this.primaryResults,
  });

  factory ApiPagingModel.fromJson(Map<String, dynamic> json) =>
      _$ApiPagingModelFromJson(json);

  final int total;
  final int offset;
  final int limit;
  @JsonKey(name: 'primary_results')
  final int primaryResults;

  Map<String, dynamic> toJson() => _$ApiPagingModelToJson(this);
}
