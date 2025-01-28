import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/models/api_item_model.dart';

void main() {
  group('ApiItemModel', () {
    test('fromJson / toJson funcionan correctamente', () {
      final json = {
        'id': 'MLA123',
        'title': 'Test Title',
        'price': 199.99,
        'thumbnail': 'thumb_url',
        'available_quantity': 5,
      };

      final model = ApiItemModel.fromJson(json);

      expect(model.id, 'MLA123');
      expect(model.title, 'Test Title');
      expect(model.price, 199.99);
      expect(model.thumbnailUrl, 'thumb_url');
      expect(model.availableQuantity, 5);

      final map = model.toJson();
      expect(map, json);
    });
  });
}
