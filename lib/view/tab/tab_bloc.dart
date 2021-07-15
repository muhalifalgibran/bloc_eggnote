import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:egg_note_bloc/models/apptab.dart';
import 'package:egg_note_bloc/view/tab/tab_event.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.dashboard);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
