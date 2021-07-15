import 'package:egg_note_bloc/models/items.dart';
import 'package:equatable/equatable.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class ItemsLoading extends ItemsState {}

class ItemsLoaded extends ItemsState {
  final List<Items> items;

  const ItemsLoaded([this.items = const []]);

  @override
  List<Object> get props => [items];

  @override
  String toString() {
    return 'ItemsLoadSuccess {items : $items}';
  }
}

class ItemsNotLoading extends ItemsState {}

class ItemsLoadFailure extends ItemsState {}
