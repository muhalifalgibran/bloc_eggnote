import 'package:egg_note_bloc/models/adjustment.dart';
import 'package:egg_note_bloc/view/adjustment/bloc/event.dart';
import 'package:egg_note_bloc/view/adjustment/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc.dart';

class AdjustmentScreen extends StatefulWidget {
  const AdjustmentScreen({Key? key}) : super(key: key);

  @override
  State<AdjustmentScreen> createState() {
    return _AdjustmentScreenState();
  }
}

class _AdjustmentScreenState extends State<AdjustmentScreen> {
  bool isNotStateFocus = true;

  final _controller_grain = TextEditingController();
  final _controller_rack = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catat Telur"),
        actions: [
          GestureDetector(
              child: Icon(LineIcons.edit),
              onTap: () {
                print(isNotStateFocus);
                // return context
                //     .read<AdjustmentBloc>()
                //     .add(AdjEditMode(!isNotStateFocus));
                setState(() {
                  isNotStateFocus = !isNotStateFocus;
                });
              }),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<AdjustmentBloc, AdjustmentState>(
            builder: (context, state) {
              if (state is AdjLoading) {
                return ListTileShimmer();
              } else if (state is AdjLoaded) {
                _controller_grain.text = state.adjustment.grain.toString();
                _controller_rack.text = state.adjustment.rack.toString();
                return Column(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          // readOnly: state.isFocus ? true : state.isFocus,
                          readOnly: isNotStateFocus,
                          controller: _controller_grain,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Butir',
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: "Harga per-butir",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14.0,
                        ),
                        TextFormField(
                          controller: _controller_rack,
                          // readOnly: state.isFocus ? true : state.isFocus,
                          readOnly: isNotStateFocus,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Masukan jumlah',
                            labelStyle: TextStyle(color: Colors.black),
                            labelText: "Rak",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black12, width: 2.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: !isNotStateFocus,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt("grain_prices",
                              int.parse(_controller_grain.text));
                          prefs.setInt(
                              "rack_prices", int.parse(_controller_rack.text));
                          final Adjustment prices = Adjustment(
                              grain: int.parse(_controller_grain.text),
                              rack: int.parse(_controller_rack.text));

                          context
                              .read<AdjustmentBloc>()
                              .add(AdjEventEdited(prices));
                        },
                        child: Text('Simpan'),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
