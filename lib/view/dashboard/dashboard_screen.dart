import 'package:egg_note_bloc/implRepositories/firebase_item_repository.dart';
import 'package:egg_note_bloc/models/items.dart';
import 'package:egg_note_bloc/res/res_color.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/bloc.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/state.dart';
import 'package:egg_note_bloc/view/dashboard/dialog/add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:money_formatter/money_formatter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() {
    return _DashboardScreenState();
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddDialog();
              });
        },
        child: Icon(LineIcons.egg),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: ResColor.appBackground,
            child: BlocBuilder<ItemsBloc, ItemsState>(
              builder: (context, state) {
                if (state is ItemsLoading) {
                  return ListTileShimmer();
                } else if (state is ItemsLoaded) {
                  final items = state.items;
                  double harga = 0;
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        if (item.pickedItem == 0) {
                          harga = item.amount * double.parse("${item.grain}.0");
                        } else {
                          harga = item.amount * double.parse("${item.rack}.0");
                        }
                        final fmf = MoneyFormatter(amount: harga);
                        return new Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                item.pickedItem == 0
                                    ? Icon(LineIcons.egg, size: 48.0)
                                    : Icon(LineIcons.database, size: 48.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Jumlah: "),
                                        Text(item.amount.toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Rp: "),
                                        Text(fmf.output.nonSymbol.toString()),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Container();
                }
              },
            ),
          )),
    );
  }
}
