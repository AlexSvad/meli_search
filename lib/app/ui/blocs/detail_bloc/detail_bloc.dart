import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/items_repository.dart';
import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({required this.repository}) : super(const DetailState()) {
    on<LoadItemDetail>(_onLoadItemDetail);
  }
  final ItemsRepository repository;

  Future<void> _onLoadItemDetail(
    LoadItemDetail event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(status: DetailStatus.loading));
    try {
      final item = await repository.getItemDetail(event.itemId);
      emit(state.copyWith(status: DetailStatus.success, item: item));
    } catch (e) {
      emit(
        state.copyWith(
          status: DetailStatus.failure,
          errorMessage: 'Ocurrió un error al cargar el detalle',
        ),
      );
    }
  }
}
