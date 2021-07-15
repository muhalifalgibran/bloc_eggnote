import 'package:egg_note_bloc/models/adjustment.dart';
import 'package:equatable/equatable.dart';

abstract class AdjustmentEvent extends Equatable {
  const AdjustmentEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AdjEventLoad extends AdjustmentEvent {}

class EnterAdjustment extends AdjustmentEvent {}

class AdjEventEdited extends AdjustmentEvent {
  final Adjustment adj;
  const AdjEventEdited(this.adj);

  @override
  // TODO: implement props
  List<Object?> get props => [adj];

  @override
  String toString() {
    // TODO: implement toString
    return 'Event edited: $adj';
  }
}

class AdjEventUpdated extends AdjustmentEvent {
  final Adjustment adjustment;
  const AdjEventUpdated(this.adjustment);

  @override
  List<Object?> get props => [adjustment];
}

class AdjEditMode extends AdjustmentEvent {
  final bool isFocus;
  const AdjEditMode(this.isFocus);

  @override
  List<Object?> get props => [isFocus];

  @override
  String toString() {
    return "adjustment focus is: $isFocus";
  }
}
