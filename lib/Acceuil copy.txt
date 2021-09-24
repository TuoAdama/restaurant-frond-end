import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant/data/utilisies.dart';
import 'package:restaurant/layouts/CommandePage.dart';
import 'package:restaurant/layouts/ItemCategoryList.dart';
import 'package:restaurant/layouts/bottom_navigation.dart';
import 'package:restaurant/models/Category.dart';
import 'package:restaurant/models/commande.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/models/plat.dart';
import 'package:restaurant/layouts/components.dart';

class Acceuil extends StatefulWidget {
  final Personnel personnel;

  const Acceuil(this.personnel, {Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Acceuil> {
  GlobalKey formKey = GlobalKey();

  List<Category> categories = Utilisies.categories;
  List<Plat> plats = Utilisies.plats;
  List<Commande> commandes = [];

  int it = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    plats = Utilisies.plats;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
          title: Text(
            'Menus',
            style: TextStyle(
                fontFamily: 'Varela', fontSize: 20.0, color: Color(0xFF545D68)),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.fastfood,
                color: Color(0xFF545D68),
              ),
              onPressed: changePage,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          pressItem: changePage,
        ),
        body: main());
  }

  Widget main() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.search), hintText: "Recherche"),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
            child: Container(
                child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Material(
                      color: Colors.white,
                      child: ItemCategoryList(
                          categories: categories,
                          onSelected: (Category cat) {})),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      'Tout',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverGrid.count(
                  crossAxisCount: 2,
                  children: _buildPlatItem(plats),
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPlatItem(List<Plat> plats) {
    return plats
        .map((plat) => Padding(
              padding:
                  EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2), blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 75.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  Utilisies.host + "storage/${plat.imagePath}"),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      plat.name,
                      style: TextStyle(
                          color: Color(0XFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${plat.price} FCFA',
                          style: TextStyle(
                              color: Color(0XFFCC8053),
                              fontFamily: 'Varela',
                              fontSize: 14.0),
                        ),
                        operationButton(Icons.add, () {
                          Iterable<Commande> iterable = commandes
                              .where((element) => element.plat == plat);
                          if (iterable.length > 0) {
                            showModal(iterable.first);
                          } else {
                            showModal(new Commande(plat, 1));
                          }
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }

  void showModal(Commande cmd) {
    bool cmdExist = commandes.contains(cmd);

    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(12),
                  height: 100.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              Utilisies.host + "storage/${cmd.plat.imagePath}"),
                          fit: BoxFit.contain)),
                ),
                Text(cmd.plat.name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    operationButton(Icons.remove, () {
                      print("moins");
                      setState(() {
                        if (cmd.quantite > 1) {
                          cmd.quantite--;
                        }
                      });
                    }),
                    SizedBox(
                      width: 12,
                    ),
                    Text(cmd.quantite.toString()),
                    SizedBox(
                      width: 12,
                    ),
                    operationButton(Icons.add, () {
                      print("plus");
                      setState(() {
                        cmd.quantite++;
                      });
                    })
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (!cmdExist) {
                        commandes.add(cmd);
                      } else {
                        print('Contient déjà');
                      }
                      Navigator.pop(context, [commandes, cmdExist]);
                    },
                    child: Text(cmdExist ? 'Modifier' : 'Ajouter au panier'))
              ],
            );
          });
        }).then((value) {
      String msg = "";
      if (value[1]) {
        msg = "commande modifiée avec succès";
      } else {
        msg = "commande ajoutée avec succès";
      }
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text(msg),
        backgroundColor:
            !value[1] ? Colors.green.shade300 : Colors.cyan.shade200,
      ));
    }).whenComplete(() => print("ok"));
  }

  void changePage() async{
    commandes = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommandePage(
                            commandes: commandes,
                            personnel: widget.personnel)));
  }
}
