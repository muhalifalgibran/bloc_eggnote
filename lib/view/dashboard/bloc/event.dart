import 'package:egg_note_bloc/models/items.dart';
import 'package:equatable/equatable.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object?> get props => [];
}

class LoadItems extends ItemsEvent {}

class UpdateItems extends ItemsEvent {
  final Items updateItems;

  const UpdateItems(this.updateItems);

  @override
  List<Object?> get props => [updateItems];

  @override
  String toString() {
    // TODO: implement toString
    return 'updateitems { updateItem: $updateItems }';
  }
}

class ClearCompleted extends ItemsEvent {}

class ToggleAll extends ItemsEvent {}

class AddItems extends ItemsEvent {
  final Items items;
  const AddItems(this.items);

  @override
  List<Object?> get props => [items];

  @override
  String toString() {
    // TODO: implement toString
    return 'Items added {items: $items}';
  }
}

class ItemsUpdated extends ItemsEvent {
  final List<Items> items;
  const ItemsUpdated(this.items);

  @override
  List<Object?> get props => [items];
}
