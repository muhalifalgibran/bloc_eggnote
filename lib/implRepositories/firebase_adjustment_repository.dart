import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egg_note_bloc/entities/adjustment_entities.dart';
import 'package:egg_note_bloc/models/adjustment.dart';
import 'package:egg_note_bloc/repositories/adjustment_repository.dart';

class FirebaseAdjustmentRepository implements AdjustmentRepository {
  final prices = FirebaseFirestore.instance.collection('prices');

  @override
  Future<void> addAdjustment(Adjustment adj) {
    return prices.add(adj.toEntity().toDocument());
  }

  @override
  Stream<Adjustment> getPrices() {
    var pr = prices
        .orderBy("addTime", descending: true)
        .limit(1)
        .snapshots()
        .map((event) {
      return Adjustment.fromEntity(
          AdjustmentEntity.fromSnapshot(event.docs.single));
    });
    return pr;
  }
}
