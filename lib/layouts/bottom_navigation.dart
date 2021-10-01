import 'package:flutter/material.dart';
import 'package:restaurant/layouts/CommandePage.dart';
import 'package:restaurant/pages/profil.dart';
import 'package:restaurant/pages/table.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: currentIndex,
      onTap: onTapItem,
    );
  }

  void onTapItem(int index) {
    setState(() {
      currentIndex = index;
      switch (currentIndex) {
        case 1:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TablePage()));
          break;
        case 2:
          toCommandePage(context);
          break;
        case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profil()));
          break;
        default:
      }
    });
  }

  set setCurrentIndex(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }

  void toCommandePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CommandePage()));
  }
}
