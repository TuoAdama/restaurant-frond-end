import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant/data/utilisies.dart';
import 'package:restaurant/layouts/ItemCategoryList.dart';
import 'package:restaurant/models/Category.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/models/plat.dart';

class App extends StatefulWidget {
  final Personnel personnel;

  const App(this.personnel, {Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  GlobalKey formKey = GlobalKey();

  List<Category> categories = Utilisies.categories;
  List<Plat> plats = [];

  final String host = "http://10.0.2.2:8000";

  @override
  void initState() {
    // fetchCategories().then((value) => {
    //       setState(() {
    //         categories = value;
    //       })
    //     });

    // fetchPlats().then((value) => {
    //       setState(() {
    //         plats = value;
    //       })
    //     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Menus',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: main());
  }

  Widget main() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 2,
        )),
        child: ListView(
          children: [
            // searchField(),
            // SizedBox(
            //   height: 25,
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 12),
            //   child: Text(
            //     "Catégories",
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
            //   ),
            // ),
            // SizedBox(height: 20,),
            catogeryList(),
            ItemCategoryList(categories: categories,
              onSelected: (Category cat){}
            )
            // SizedBox(height: 20,),
            // Container(
            //   margin: EdgeInsets.only(left: 12),
            //   child: Text(
            //     "Tout",
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
            //   ),
            // ),
            //platsList(),
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return TextFormField(
      decoration:
          InputDecoration(icon: Icon(Icons.search), hintText: "Recherche"),
    );
  }

  Widget catogeryList() {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return categoryItem(categories[index]);
        },
      ),
    );
  }

  Widget categoryItem(Category category) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5.0)
          ],
          color: Colors.white),
      child: Column(
        children: [
          Container(
            width: 75,
            height: 45,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                    AssetImage('assets/img_1.png'),
                        //NetworkImage(Utilisies.host+"${category.avatar}"),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 7.0,
          ),
          Text(
            category.libelle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Future<List<Category>> fetchCategories() async {
    final String url = "$host/api/categorie";

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Recupération des données...');
        List<dynamic> results = jsonDecode(response.body);
        print(results);

        List<Category> categories = results.map((category) {
          return Category.formJson(category);
        }).toList();

        return categories;
      }
    } catch (e) {
      print(e);
    }

    return <Category>[];
  }

  Future<List<Plat>> fetchPlats() async {
    print("Récuperation de la liste des plats...");
    try {
      http.Response response = await http.get(Uri.parse("$host/api/plat"));
      if (response.statusCode == 200) {
        List<dynamic> results = jsonDecode(response.body);
        print(results);
        return results.map((e) {
          return Plat.fromJson(e);
        }).toList();
      }
    } catch (e) {
      print("Message d'erreur : $e");
    }
    return <Plat>[];
  }

  Widget platsList() {
    print(plats);

    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        shrinkWrap: true,
        itemCount: plats.length,
        itemBuilder: (context, index) {
          print(plats[index]);
          return platItem(plats[index]);
        });
  }

  Widget platItem(Plat plat) {
    return Container(
      child: Text(plat.name),
    );
  }
}
