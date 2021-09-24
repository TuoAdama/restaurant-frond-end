import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key, required this.pressItem}) : super(key: key);

  final Function pressItem;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: 'Calls',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'panier',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.av_timer),
          label: 'commandes',
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTapItem,
      selectedItemColor: Color(0XFFCC8053),
    );
  }

  void onTapItem(int index) {
    setState(() {
      currentIndex = index;
      switch (currentIndex) {
        case 1:
          break;
        case 2:
          widget.pressItem();
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
}
