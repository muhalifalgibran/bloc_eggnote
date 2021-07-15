import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:egg_note_bloc/models/adjustment.dart';
import 'package:egg_note_bloc/models/apptab.dart';
import 'package:egg_note_bloc/res/res_color.dart';
import 'package:egg_note_bloc/view/adjustment/adjusment_screen.dart';
import 'package:egg_note_bloc/view/dashboard/dashboard_screen.dart';
import 'package:egg_note_bloc/view/tab/tab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[DashboardScreen(), AdjustmentScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ResColor.appBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey,
              hoverColor: Colors.grey,
              gap: 8,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  backgroundColor: Colors.lightGreen,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.adjust,
                  backgroundColor: Colors.yellow[100],
                  text: 'Pengaturan',
                ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                // behavior.changeMenu(index);
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
