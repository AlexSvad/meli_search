import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meli_search/app/data/repositories/items_repository.dart';
import 'package:meli_search/app/domain/entities/item_entity.dart';
import 'package:meli_search/app/domain/entities/search_paging_entity.dart';
import 'package:meli_search/app/domain/entities/search_result_entity.dart';
import 'package:meli_search/app/ui/blocs/search_bloc/search_bloc.dart';
import 'package:meli_search/app/ui/blocs/search_bloc/search_event.dart';
import 'package:meli_search/app/ui/blocs/search_bloc/search_state.dart';
import 'package:mocktail/mocktail.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  group('SearchBloc', () {
    late MockItemsRepository mockRepository;
    late SearchBloc searchBloc;

    const testItems = [
      ItemEntity(
        id: 'id-123',
        title: 'Item de prueba',
        price: 100.0,
        thumbnailUrl: 'http://example.com/img.jpg',
        availableQuantity: 10,
      ),
    ];

    const searchResult = SearchResultEntity(
      siteId: 'MLA',
      query: 'test',
      paging: SearchPagingEntity(
        total: 1,
        offset: 0,
        limit: 1,
        primaryResults: 1,
      ),
      results: testItems,
    );

    setUpAll(() {
      registerFallbackValue(const SearchQueryChanged(''));
      registerFallbackValue(const SearchSubmitted(''));
    });

    setUp(() {
      mockRepository = MockItemsRepository();
      searchBloc = SearchBloc(repository: mockRepository);
    });

    tearDown(() {
      searchBloc.close();
    });

    test('initial state is SearchState.initial', () {
      expect(searchBloc.state, const SearchState());
    });

    blocTest<SearchBloc, SearchState>(
      'emite [loading, success] cuando SearchQueryChanged con query válido',
      build: () {
        when(() => mockRepository.searchItems(any()))
            .thenAnswer((_) async => searchResult);
        return searchBloc;
      },
      act: (bloc) async {
        bloc.add(const SearchQueryChanged('test'));
        await Future<void>.delayed(const Duration(milliseconds: 350));
      },
      expect: () => <SearchState>[
        const SearchState(status: SearchStatus.loading, query: 'test'),
        const SearchState(
          status: SearchStatus.success,
          query: 'test',
          results: testItems,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emite [loading, failure] cuando SearchQueryChanged lanza excepción',
      build: () {
        when(() => mockRepository.searchItems(any()))
            .thenThrow(Exception('Error de búsqueda'));
        return searchBloc;
      },
      act: (bloc) async {
        bloc.add(const SearchQueryChanged('test'));
        await Future<void>.delayed(const Duration(milliseconds: 350));
      },
      expect: () => <SearchState>[
        const SearchState(status: SearchStatus.loading, query: 'test'),
        const SearchState(
          status: SearchStatus.failure,
          query: 'test',
          errorMessage: 'Ocurrió un error en la búsqueda',
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emite nada y resetea estado si query es vacío',
      build: () => searchBloc,
      act: (bloc) async {
        bloc.add(const SearchQueryChanged('   '));
        await Future<void>.delayed(const Duration(milliseconds: 350));
      },
      expect: () => <SearchState>[
        const SearchState(
          status: SearchStatus.initial,
          query: '',
          results: [],
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emite [loading, success] cuando SearchSubmitted con query válido',
      build: () {
        when(() => mockRepository.searchItems(any()))
            .thenAnswer((_) async => searchResult);
        return SearchBloc(repository: mockRepository);
      },
      act: (bloc) async {
        bloc.add(const SearchSubmitted('producto'));
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      expect: () => <SearchState>[
        const SearchState(status: SearchStatus.loading, query: 'producto'),
        const SearchState(
          status: SearchStatus.success,
          query: 'producto',
          results: testItems,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'no emite nada si SearchSubmitted con query vacío',
      build: () => SearchBloc(repository: mockRepository),
      act: (bloc) async {
        bloc.add(const SearchSubmitted('   '));
        await Future<void>.delayed(const Duration(milliseconds: 50));
      },
      expect: () => <SearchState>[],
    );

    blocTest<SearchBloc, SearchState>(
      'debounce cancela primer query si se emite un segundo query en menos de 300ms',
      build: () {
        when(() => mockRepository.searchItems(any()))
            .thenAnswer((invocation) async {
          final query = invocation.positionalArguments.first as String;

          return SearchResultEntity(
            siteId: 'MLA',
            query: query,
            paging: const SearchPagingEntity(
              total: 1,
              offset: 0,
              limit: 1,
              primaryResults: 1,
            ),
            results: const [
              ItemEntity(
                id: 'id-123',
                title: 'Item de prueba',
                price: 100.0,
                thumbnailUrl: 'http://example.com/img.jpg',
                availableQuantity: 10,
              ),
            ],
          );
        });
        return SearchBloc(repository: mockRepository);
      },
      act: (bloc) async {
        bloc.add(const SearchQueryChanged('A'));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(const SearchQueryChanged('B'));
        await Future.delayed(const Duration(milliseconds: 350));
      },
      expect: () => <SearchState>[
        const SearchState(status: SearchStatus.loading, query: 'B'),
        const SearchState(
          status: SearchStatus.success,
          query: 'B',
          results: [
            ItemEntity(
              id: 'id-123',
              title: 'Item de prueba',
              price: 100.0,
              thumbnailUrl: 'http://example.com/img.jpg',
              availableQuantity: 10,
            ),
          ],
        ),
      ],
    );

    test('SearchEvent props (abstract) se usan al comparar subclases', () {
      const event1 = SearchQueryChanged('x');
      const event2 = SearchQueryChanged('x');
      expect(event1, equals(event2));

      const submitted1 = SearchSubmitted('y');
      const submitted2 = SearchSubmitted('y');
      expect(submitted1, equals(submitted2));
    });
  });
}
