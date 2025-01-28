// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiItemModel _$ApiItemModelFromJson(Map<String, dynamic> json) => ApiItemModel(
      id: json['id'] as String,
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      thumbnailUrl: json['thumbnail'] as String?,
      availableQuantity: (json['available_quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ApiItemModelToJson(ApiItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'thumbnail': instance.thumbnailUrl,
      'available_quantity': instance.availableQuantity,
    };
