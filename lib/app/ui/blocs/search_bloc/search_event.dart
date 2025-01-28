import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  const SearchQueryChanged(this.query);
  final String query;

  @override
  List<Object> get props => [query];
}

class SearchSubmitted extends SearchEvent {
  const SearchSubmitted(this.query);
  final String query;

  @override
  List<Object> get props => [query];
}
