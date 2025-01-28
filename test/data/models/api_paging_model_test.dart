import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/models/search_result_model.dart';

void main() {
  group('ApiPagingModel', () {
    test('fromJson / toJson funcionan correctamente', () {
      final json = {
        'total': 100,
        'offset': 0,
        'limit': 50,
        'primary_results': 10,
      };

      final model = ApiPagingModel.fromJson(json);

      expect(model.total, 100);
      expect(model.offset, 0);
      expect(model.limit, 50);
      expect(model.primaryResults, 10);

      final toJsonResult = model.toJson();
      expect(toJsonResult, json);
    });
  });
}
