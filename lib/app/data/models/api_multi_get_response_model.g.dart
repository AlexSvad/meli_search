// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_multi_get_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiMultiGetResponseModel _$ApiMultiGetResponseModelFromJson(
        Map<String, dynamic> json) =>
    ApiMultiGetResponseModel(
      code: (json['code'] as num).toInt(),
      body: ApiItemModel.fromJson(json['body'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiMultiGetResponseModelToJson(
        ApiMultiGetResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'body': instance.body.toJson(),
    };
