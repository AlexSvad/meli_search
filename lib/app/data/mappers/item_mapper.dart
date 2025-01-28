import '../../domain/entities/item_entity.dart';
import '../models/api_item_model.dart';

class ItemMapper {
  static ItemEntity fromModel(ApiItemModel model) {
    return ItemEntity(
      id: model.id,
      title: model.title ?? 'Sin título',
      price: model.price ?? 0.0,
      thumbnailUrl: model.thumbnailUrl ?? '',
      availableQuantity: model.availableQuantity ?? 0,
    );
  }
}
