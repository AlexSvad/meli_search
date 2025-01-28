import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/domain/entities/item_entity.dart';

void main() {
  group('ItemEntity', () {
    test('constructor asigna campos correctamente', () {
      const item = ItemEntity(
        id: 'MLA999',
        title: 'Test Item',
        price: 999.99,
        thumbnailUrl: 'http://example.com/image.jpg',
        availableQuantity: 5,
      );

      expect(item.id, 'MLA999');
      expect(item.title, 'Test Item');
      expect(item.price, 999.99);
      expect(item.thumbnailUrl, 'http://example.com/image.jpg');
      expect(item.availableQuantity, 5);
    });

    test(
        'compara igualdad si todos los campos coinciden (si == está definido por Equatable)',
        () {
      const item1 = ItemEntity(
        id: 'MLA999',
        title: 'Test Item',
        price: 999.99,
        thumbnailUrl: 'http://example.com/image.jpg',
        availableQuantity: 5,
      );
      const item2 = ItemEntity(
        id: 'MLA999',
        title: 'Test Item',
        price: 999.99,
        thumbnailUrl: 'http://example.com/image.jpg',
        availableQuantity: 5,
      );

      expect(item1, equals(item2));
    });
  });
}
