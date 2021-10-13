import 'package:flutter/material.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/pages/detail.dart';
import 'package:restaurant/pages/login_page.dart';
import 'package:restaurant/models/panier.dart';
import 'package:restaurant/pages/table.dart';
import 'package:restaurant/pages/welcome.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

Panier panier = new Panier();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // 05 56 27 14 23
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: Personnel(),
      child: ScopedModel<Panier>(
        model: panier,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mon restaurant',

          initialRoute: "/",
          
          routes: {
            "/": (context) => LoginPage(),
            "/home": (context) => Welcome(),
          },
        ),
      ),
    );
  }
}
