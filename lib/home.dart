import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant/app/api_request.dart';
import 'package:restaurant/layouts/ItemCategoryList.dart';
import 'package:restaurant/models/Category.dart';
import 'package:restaurant/models/commande.dart';
import 'package:restaurant/models/panier.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/models/plat.dart';
import 'package:restaurant/layouts/components.dart';
import 'package:restaurant/pages/table.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class Acceuil extends StatefulWidget {
  final Personnel personnel;

  Acceuil(this.personnel, {Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Acceuil> {
  GlobalKey formKey = GlobalKey();

  List<Category> categories = <Category>[];
  List<Plat> plats = <Plat>[];
  late List<Plat> filtrePlats;

  TextEditingController searchController = TextEditingController();

  int it = 0;
  bool isFiltre = true;

  GlobalKey<ItemCategoryListState> keyCatList =
      GlobalKey<ItemCategoryListState>();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Personnel personnel = widget.personnel;

    return ScopedModel<Personnel>(
        model: personnel,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            centerTitle: true,
            title: Text(
              'Menus',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68)),
            ),
          ),
          body: main(),
          //body: widget(child: main()))),
        ));
  }

  Widget main() {
    isFiltre = true;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: TextFormField(
                onChanged: onSearch,
                controller: searchController,
                decoration: InputDecoration(
                    icon: Icon(Icons.search), hintText: "Recherche"),
              ),
            ),
          ),
          categories.isNotEmpty
              ? Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
                    child: Container(
                        child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.all(8.0),
                                child: Text(
                                  'Categories',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              isFiltre
                                  ? TextButton(
                                      onPressed: () {
                                        setState(() {
                                          filtrePlats = plats;
                                        });
                                        keyCatList.currentState!.initialIndex =
                                            -1;
                                        searchController.clear();
                                      },
                                      child: Text("Tout afficher"))
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Material(
                              color: Colors.white,
                              child: ItemCategoryList(
                                  key: keyCatList,
                                  categories: categories,
                                  onSelected: (Category cat) {
                                    setState(() {
                                      filtrePlats = plats
                                          .where((element) =>
                                              element.category == cat.libelle)
                                          .toList();
                                    });
                                  })),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            child: Text(
                              'Tout',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SliverGrid.count(
                          crossAxisCount: 2,
                          children: _buildPlatItem(filtrePlats),
                        )
                      ],
                    )),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }

  List<Widget> _buildPlatItem(List<Plat> plats) {
    final panier = ScopedModel.of<Panier>(context);

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
                              image:
                                  NetworkImage(ApiRequest.asset(plat.imagePath)),
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
                          Iterable<Commande> iterable = panier.commandes
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
    final panier = ScopedModel.of<Panier>(context);
    bool cmdExist = panier.commandes.contains(cmd);

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
                          image:
                              NetworkImage(ApiRequest.asset(cmd.plat.imagePath)),
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
                        panier..add(cmd);
                      } else {
                        print('Contient d??j??');
                      }
                      Navigator.pop(context, [cmdExist]);
                    },
                    child: Text(cmdExist ? 'Modifier' : 'Ajouter au panier'))
              ],
            );
          });
        }).then((value) {
      String msg = "";
      if (value) {
        msg = "commande modifi??e avec succ??s";
      } else {
        msg = "commande ajout??e avec succ??s";
      }
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text(msg),
        backgroundColor:
            !value[1] ? Colors.green.shade300 : Colors.cyan.shade200,
      ));
    }).whenComplete(() => print("ok"));
  }

  void tablePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TablePage()));
  }

  List<Plat> onChangedCategorie(String libelle) {
    return plats.where((element) => element.category == libelle).toList();
  }

  void onSearch(String search) {
    if (search.isNotEmpty) {
      setState(() {
        filtrePlats = plats
            .where((element) => element.name.startsWith(search.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        filtrePlats = plats;
      });
    }
  }

  void initData() async {
    await this.getCategories().then((value) {
      categories = value;
    });

    await this.getPlats().then((value) {
      setState(() {
        plats = value;
        filtrePlats = value;
      });
    });
  }

  Future<void> onRefresh() async {
    this.keyCatList.currentState!.initialIndex = -1;
    Future.delayed(Duration(seconds: 10));

    await this.getCategories().then((value) {
      categories = value;
    });

    

    await this.getPlats().then((value) {
      setState(() {
        plats = value;
        filtrePlats = value;
      });
    });
  }

  Future<List<Category>> getCategories() async {
    http.Response response = await ApiRequest.getRequest("/categorie");
    
    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      return data.map((e) => Category.formJson(e)).toList();
    }
    throw Exception("[class: Accueil, methode: getCategorie()]");
  }

  Future<List<Plat>> getPlats() async {
    http.Response response = await ApiRequest.getRequest("/plat");

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Plat.fromJson(e)).toList();
    }

    throw Exception("[class: Accueil, methode: getPlats()]");
  }
}
