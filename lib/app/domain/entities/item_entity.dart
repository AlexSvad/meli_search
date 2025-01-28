import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  const ItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnailUrl,
    required this.availableQuantity,
  });

  final String id;
  final String title;
  final double price;
  final String thumbnailUrl;
  final int availableQuantity;

  @override
  List<Object> get props => [
        id,
        title,
        price,
        thumbnailUrl,
        availableQuantity,
      ];
}
