import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class LoadItemDetail extends DetailEvent {
  const LoadItemDetail(this.itemId);
  final String itemId;

  @override
  List<Object> get props => [itemId];
}
