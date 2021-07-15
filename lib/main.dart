import 'package:egg_note_bloc/implRepositories/firebase_adjustment_repository.dart';
import 'package:egg_note_bloc/implRepositories/firebase_item_repository.dart';
import 'package:egg_note_bloc/view/adjustment/adjusment_screen.dart';
import 'package:egg_note_bloc/view/adjustment/bloc/bloc.dart';
import 'package:egg_note_bloc/view/adjustment/bloc/event.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/bloc.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/event.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/state.dart';
import 'package:egg_note_bloc/view/dashboard/dashboard_screen.dart';
import 'package:egg_note_bloc/view/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemsBloc>(
          create: (context) {
            return ItemsBloc(
              itemRepository: FirebaseItemRepository(),
            )..add(LoadItems());
          },
        ),
        BlocProvider<AdjustmentBloc>(
          create: (context) {
            return AdjustmentBloc(
              adjustmentRepository: FirebaseAdjustmentRepository(),
            )..add(AdjEventLoad());
          },
        ),
      ],
      child: MaterialApp(
          title: 'Flutter BLOC',
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeScreen()),
    );
  }
}
