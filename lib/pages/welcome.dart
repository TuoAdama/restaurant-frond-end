import 'package:flutter/material.dart';
import 'package:restaurant/Acceuil.dart';
import 'package:restaurant/data/utilisies.dart';
import 'package:restaurant/layouts/CommandePage.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/pages/profil.dart';
import 'package:restaurant/pages/table.dart';
import 'package:scoped_model/scoped_model.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key, required this.personnel}) : super(key: key);
  final Personnel personnel;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final plats = Utilisies.plats;
  final categories = Utilisies.categories;

  //final personnel = Personnel(id: 1, nom: "nom", prenom: "prenom", dateNaissance: "dateNaissance", idPoste: 1);

  List<Widget> screens = [];
  int currentIndex = 0;

  @override
  void initState() {
    screens = [Acceuil(widget.personnel), TablePage(), CommandePage(), Profil()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<Personnel>(
      model: widget.personnel,
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
