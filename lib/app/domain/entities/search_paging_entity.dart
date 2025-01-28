import 'package:equatable/equatable.dart';

class SearchPagingEntity extends Equatable {
  const SearchPagingEntity({
    required this.total,
    required this.offset,
    required this.limit,
    required this.primaryResults,
  });

  final int total;
  final int offset;
  final int limit;
  final int primaryResults;

  @override
  List<Object> get props => [
        total,
        offset,
        limit,
        primaryResults,
      ];
}
