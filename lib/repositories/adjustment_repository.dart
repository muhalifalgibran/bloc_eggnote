import 'package:egg_note_bloc/models/adjustment.dart';

abstract class AdjustmentRepository {
  Future<void> addAdjustment(Adjustment adj);
  Stream<Adjustment> getPrices();
}
