import 'package:egg_note_bloc/models/items.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/bloc.dart';
import 'package:egg_note_bloc/view/dashboard/bloc/event.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  int itemPicked = 0;
  int grainPrices = 0;
  int rackPrices = 0;
  final _controller_amount = TextEditingController();

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  void getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    grainPrices = prefs.getInt("grain_price") ?? 2500;
    rackPrices = prefs.getInt("rack_price") ?? 45000;
  }

  void changePickedItem(index) {
    itemPicked = index;
  }

  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Wrap(
            children: [
              Center(
                child: Text("Tambah Penjualan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Butir",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => changePickedItem(0));
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: itemPicked == 0
                                  ? Colors.greenAccent
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            LineIcons.egg,
                            size: 48,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Rak"),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => changePickedItem(1));
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: itemPicked == 1
                                  ? Colors.greenAccent
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            LineIcons.database,
                            size: 48,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                controller: _controller_amount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Masukan jumlah',
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Jumlah",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 2.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final items = Items(
                        amount: int.parse(_controller_amount.text),
                        pickedItem: itemPicked,
                        grain: grainPrices,
                        rack: rackPrices);
                    context.read<ItemsBloc>().add(AddItems(items));
                  },
                  child: const Text('Tambahkan'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
