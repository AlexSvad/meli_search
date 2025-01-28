import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/items_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.repository}) : super(const SearchState()) {
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: _debounce(const Duration(milliseconds: 300)),
    );

    on<SearchSubmitted>(_onSearchSubmitted);
  }
  final ItemsRepository repository;

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(
        state.copyWith(
          query: '',
          results: [],
          status: SearchStatus.initial,
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(status: SearchStatus.loading, query: query));
      final result = await repository.searchItems(query);
      emit(
        state.copyWith(
          status: SearchStatus.success,
          results: result.results,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: 'Ocurrió un error en la búsqueda',
        ),
      );
    }
  }

  Future<void> _onSearchSubmitted(
    SearchSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) return;

    try {
      emit(state.copyWith(status: SearchStatus.loading, query: query));
      final result = await repository.searchItems(query);
      emit(
        state.copyWith(
          status: SearchStatus.success,
          results: result.results,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: 'Ocurrió un error en la búsqueda',
        ),
      );
    }
  }

  EventTransformer<E> _debounce<E>(Duration duration) {
    return (events, mapper) {
      final controller = StreamController<E>();
      Timer? debounceTimer;
      late StreamSubscription<E> subscription;

      subscription = events.listen(
        (event) {
          debounceTimer?.cancel();
          debounceTimer = Timer(duration, () {
            controller.add(event);
          });
        },
        onError: controller.addError,
        onDone: () {
          debounceTimer?.cancel();
          controller.close();
        },
        cancelOnError: false,
      );

      controller.onCancel = () {
        subscription.cancel();
        debounceTimer?.cancel();
      };

      return controller.stream.asyncExpand(mapper);
    };
  }
}
