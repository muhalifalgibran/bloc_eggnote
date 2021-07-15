import 'package:egg_note_bloc/models/adjustment.dart';
import 'package:equatable/equatable.dart';

abstract class AdjustmentState extends Equatable {
  const AdjustmentState();

  @override
  List<Object?> get props => [];
}

class AdjLoaded extends AdjustmentState {
  final Adjustment adjustment;
  const AdjLoaded(this.adjustment);

  @override
  List<Object?> get props => [adjustment];

  @override
  String toString() {
    return "adjustment: $adjustment";
  }
}

class AdjEdited extends AdjustmentState {
  final bool isFocus;
  const AdjEdited(this.isFocus);

  @override
  List<Object?> get props => [isFocus];

  @override
  String toString() {
    return "adjustment focus is: $isFocus";
  }
}

class AdjLoading extends AdjustmentState {}
