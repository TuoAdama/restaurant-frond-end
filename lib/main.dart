import 'package:flutter/material.dart';
import 'package:restaurant/loginPage.dart';
import 'package:restaurant/models/panier.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

Panier panier =  new Panier();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // 05 56 27 14 23
  @override
  Widget build(BuildContext context) {
    return ScopedModel<Panier>(model: panier, child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mon restaurant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}