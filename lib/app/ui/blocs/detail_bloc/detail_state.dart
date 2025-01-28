import 'package:equatable/equatable.dart';

import '../../../domain/entities/item_entity.dart';

enum DetailStatus { initial, loading, success, failure }

class DetailState extends Equatable {
  const DetailState({
    this.status = DetailStatus.initial,
    this.item,
    this.errorMessage,
  });
  final DetailStatus status;
  final ItemEntity? item;
  final String? errorMessage;

  DetailState copyWith({
    DetailStatus? status,
    ItemEntity? item,
    String? errorMessage,
  }) {
    return DetailState(
      status: status ?? this.status,
      item: item ?? this.item,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, item, errorMessage];
}
