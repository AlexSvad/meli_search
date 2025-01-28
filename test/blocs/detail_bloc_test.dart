import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/repositories/items_repository.dart';
import 'package:meli_search/app/domain/entities/item_entity.dart';
import 'package:meli_search/app/ui/blocs/detail_bloc/detail_bloc.dart';
import 'package:meli_search/app/ui/blocs/detail_bloc/detail_event.dart';
import 'package:meli_search/app/ui/blocs/detail_bloc/detail_state.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  group('DetailBloc', () {
    late MockItemsRepository mockRepository;
    late DetailBloc detailBloc;

    const testItem = ItemEntity(
      id: 'MLA123',
      title: 'Item de prueba',
      price: 999.99,
      thumbnailUrl: 'http://example.com/img.jpg',
      availableQuantity: 5,
    );

    setUp(() {
      mockRepository = MockItemsRepository();
      detailBloc = DetailBloc(repository: mockRepository);
    });

    tearDown(() {
      detailBloc.close();
    });

    test('initial state is DetailState.initial', () {
      expect(detailBloc.state, const DetailState());
    });

    blocTest<DetailBloc, DetailState>(
      'emite [loading, success] cuando LoadItemDetail es exitoso',
      build: () {
        when(() => mockRepository.getItemDetail(any()))
            .thenAnswer((_) async => testItem);
        return detailBloc;
      },
      act: (bloc) => bloc.add(const LoadItemDetail('MLA123')),
      expect: () => <DetailState>[
        const DetailState(status: DetailStatus.loading),
        const DetailState(status: DetailStatus.success, item: testItem),
      ],
    );

    blocTest<DetailBloc, DetailState>(
      'emite [loading, failure] cuando LoadItemDetail lanza excepción',
      build: () {
        when(() => mockRepository.getItemDetail(any()))
            .thenThrow(Exception('Error al cargar detalle'));
        return detailBloc;
      },
      act: (bloc) => bloc.add(const LoadItemDetail('MLA123')),
      expect: () => <DetailState>[
        const DetailState(status: DetailStatus.loading),
        const DetailState(
          status: DetailStatus.failure,
          errorMessage: 'Ocurrió un error al cargar el detalle',
        ),
      ],
    );
  });
}
