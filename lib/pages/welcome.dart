import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/home.dart';
import 'package:restaurant/layouts/CommandePage.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/pages/profil.dart';
import 'package:restaurant/pages/table.dart';
import 'package:scoped_model/scoped_model.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<Widget> screens = [];
  int currentIndex = 0;
  late Personnel personnel;

  @override
  void initState() {
    personnel = ScopedModel.of<Personnel>(context);
    screens = [Acceuil(personnel), TablePage(), CommandePage(), Profil()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(animated: true);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.av_timer),
              label: 'table',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.av_timer),
              label: 'cmd',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profils',
            ),
          ],
          onTap: onTap,
          currentIndex: currentIndex,
        ),
        body: screens[currentIndex],
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
