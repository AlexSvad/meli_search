import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/models/api_item_model.dart';
import 'package:meli_search/app/data/models/api_multi_get_response_model.dart';

void main() {
  group('ApiMultiGetResponseModel', () {
    test('fromJson / toJson funcionan correctamente', () {
      final json = {
        'code': 200,
        'body': {
          'id': 'MLA123',
          'title': 'Item Test',
          'price': 999.99,
          'thumbnail': 'http://example.com/thumb.jpg',
          'available_quantity': 2,
        },
      };

      final model = ApiMultiGetResponseModel.fromJson(json);

      expect(model.code, 200);
      expect(model.body, isA<ApiItemModel>());
      expect(model.body.id, 'MLA123');
      expect(model.body.title, 'Item Test');
      expect(model.body.price, 999.99);
      expect(model.body.thumbnailUrl, 'http://example.com/thumb.jpg');
      expect(model.body.availableQuantity, 2);

      final toJsonResult = model.toJson();
      expect(toJsonResult, json);
    });
  });
}
