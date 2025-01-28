class ItemEntity {
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
}
