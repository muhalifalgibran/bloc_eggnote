import 'package:egg_note_bloc/entities/item_entities.dart';
import 'package:egg_note_bloc/models/items.dart';

abstract class ItemRepository {
  Future<void> addItem(Items item);
  Stream<List<Items>> itemsList();
}
