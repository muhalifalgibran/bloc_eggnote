import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note_bloc/entities/item_entities.dart';
import 'package:egg_note_bloc/models/items.dart';
import 'package:egg_note_bloc/repositories/item_repository.dart';

class FirebaseItemRepository implements ItemRepository {
  final itemCollection = FirebaseFirestore.instance.collection('items');

  @override
  Future<void> addItem(Items item) {
    return itemCollection.add(item.toEntity().toDocument());
  }

  @override
  Stream<List<Items>> itemsList() {
    return itemCollection.snapshots().map((event) {
      return event.docs.map((e) {
        return Items.fromEntitiy(ItemEntity.fromSnapshot(e));
      }).toList();
    });
  }
}
