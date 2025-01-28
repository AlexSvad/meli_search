import 'package:equatable/equatable.dart';

import '../../../domain/entities/item_entity.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.query = '',
    this.results = const [],
    this.errorMessage,
  });
  final SearchStatus status;
  final String query;
  final List<ItemEntity> results;
  final String? errorMessage;

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    List<ItemEntity>? results,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      results: results ?? this.results,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, query, results, errorMessage];
}
