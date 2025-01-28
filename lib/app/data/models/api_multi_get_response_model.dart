import 'package:json_annotation/json_annotation.dart';

import 'api_item_model.dart';

part 'api_multi_get_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiMultiGetResponseModel {
  ApiMultiGetResponseModel({
    required this.code,
    required this.body,
  });

  factory ApiMultiGetResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ApiMultiGetResponseModelFromJson(json);

  final int code;
  final ApiItemModel body;

  Map<String, dynamic> toJson() => _$ApiMultiGetResponseModelToJson(this);
}
