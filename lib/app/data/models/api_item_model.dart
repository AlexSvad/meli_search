import 'package:json_annotation/json_annotation.dart';

part 'api_item_model.g.dart';

@JsonSerializable()
class ApiItemModel {
  ApiItemModel({
    required this.id,
    this.title,
    this.price,
    this.thumbnailUrl,
    this.availableQuantity,
  });

  factory ApiItemModel.fromJson(Map<String, dynamic> json) =>
      _$ApiItemModelFromJson(json);
  final String id;
  final String? title;
  final double? price;
  @JsonKey(name: 'thumbnail')
  final String? thumbnailUrl;
  @JsonKey(name: 'available_quantity')
  final int? availableQuantity;

  Map<String, dynamic> toJson() => _$ApiItemModelToJson(this);
}
