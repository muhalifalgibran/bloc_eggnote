import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:egg_note_bloc/models/adjustment.dart';
import 'package:egg_note_bloc/repositories/adjustment_repository.dart';
import 'package:egg_note_bloc/view/adjustment/bloc/event.dart';
import 'package:egg_note_bloc/view/adjustment/bloc/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdjustmentBloc extends Bloc<AdjustmentEvent, AdjustmentState> {
  StreamSubscription? _adjustmentSubscribtion;
  final AdjustmentRepository _adjustmentRepo;

  bool isFocus = true;

  AdjustmentBloc({required AdjustmentRepository adjustmentRepository})
      : _adjustmentRepo = adjustmentRepository,
        super(AdjLoading());

  @override
  Stream<AdjustmentState> mapEventToState(AdjustmentEvent event) async* {
    if (event is AdjEventEdited) {
      yield* _mapAdjustmentEditedToState(event);
    } else if (event is AdjEventLoad) {
      yield* _mapAdjustmentLoadedToState();
    } else if (event is AdjEventUpdated) {
      yield* _mapAdjustmentToState(event);
    } else if (event is AdjEditMode) {
      yield AdjEdited(event.isFocus);
    }
  }

  Stream<AdjustmentState> _mapAdjustmentEditedToState(
      AdjEventEdited event) async* {
    _adjustmentRepo.addAdjustment(event.adj);
  }

  Stream<AdjustmentState> _mapAdjustmentLoadedToState() async* {
    _adjustmentSubscribtion?.cancel();
    _adjustmentSubscribtion = _adjustmentRepo.getPrices().listen((event) {
      return add(AdjEventUpdated(event));
    });
  }

  Stream<AdjustmentState> _mapAdjustmentToState(AdjEventUpdated event) async* {
    yield AdjLoaded(event.adjustment);
  }

  @override
  Future<void> close() {
    _adjustmentSubscribtion?.cancel();
    return super.close();
  }
}
