import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/mappers/item_mapper.dart';
import 'package:meli_search/app/data/models/api_item_model.dart';
import 'package:meli_search/app/domain/entities/item_entity.dart';

void main() {
  group('ItemMapper', () {
    test('fromModel mapea correctamente ApiItemModel a ItemEntity', () {
      final apiModel = ApiItemModel(
        id: 'MLA123',
        title: 'Test Item',
        price: 999.99,
        thumbnailUrl: 'url',
        availableQuantity: 10,
      );

      final itemEntity = ItemMapper.fromModel(apiModel);

      expect(itemEntity, isA<ItemEntity>());
      expect(itemEntity.id, 'MLA123');
      expect(itemEntity.title, 'Test Item');
      expect(itemEntity.price, 999.99);
      expect(itemEntity.thumbnailUrl, 'url');
      expect(itemEntity.availableQuantity, 10);
    });
  });
}
