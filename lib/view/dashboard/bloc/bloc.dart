import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:egg_note_bloc/models/items.dart';
import 'package:egg_note_bloc/repositories/item_repository.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/event.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemRepository _itemRepository;
  StreamSubscription? _itemsSubscribtion;

  // ItemsBloc({required this.itemsRepository}) : super(LoadItems());
  ItemsBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(ItemsLoading());

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    if (event is LoadItems) {
      print("A");
      yield* _mapItemsLoadedToState(event);
    } else if (event is AddItems) {
      print("B");
      yield* _mapItemsAddedToState(event);
    } else if (event is ItemsUpdated) {
      print("C");
      yield* _mapItemsUpdateToState(event);
    }
  }

  Stream<ItemsState> _mapItemsLoadedToState(ItemsEvent event) async* {
    _itemsSubscribtion?.cancel();
    _itemsSubscribtion = _itemRepository.itemsList().listen((items) {
      return add(ItemsUpdated(items));
    });
  }

  Stream<ItemsState> _mapItemsAddedToState(AddItems event) async* {
    _itemRepository.addItem(event.items);
  }

  Stream<ItemsState> _mapItemsUpdateToState(ItemsUpdated event) async* {
    yield ItemsLoaded(event.items);
  }

  @override
  Future<void> close() {
    _itemsSubscribtion?.cancel();
    return super.close();
  }
}
