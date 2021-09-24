import 'package:flutter/material.dart';
import 'package:restaurant/layouts/cookie_detail.dart';
import 'package:restaurant/models/commande.dart';
import 'package:restaurant/models/plat.dart';

class CookiePage extends StatelessWidget {
  CookiePage({Key? key, required this.plats}) : super(key: key);

  List<Commande> commandes = <Commande>[];
  final List plats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.only(right: 15.0),
            width: MediaQuery.of(context).size.width - 30.00,
            height: MediaQuery.of(context).size.height - 50.0,
            //child: _allPlat(context),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
              ),
              primary: false,
              itemCount: plats.length,
              itemBuilder: (context, index) {
                return _buildCard(
                    plat: plats[index],
                    added: true,
                    isFavorite: false,
                    context: context);
              },
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Widget _buildCard({plat: Plat, added: bool, isFavorite: bool, context}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () async {
          Commande? commande = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            return CookieDetail(
              plat: plat,
              cookiePage: this,
            );
          }));

          if (commande == null) {
            print("Plat non commandé");
          } else {
            print(commande.toString());
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5.0)
              ],
              color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: plat.name,
                child: Container(
                  height: 75.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(plat.imagePath),
                          fit: BoxFit.contain)),
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                plat.price,
                style: TextStyle(
                    color: Color(0XFFCC8053),
                    fontFamily: 'Varela',
                    fontSize: 14.0),
              ),
              Text(
                plat.name,
                style: TextStyle(
                    color: Color(0XFF575E67),
                    fontFamily: 'Varela',
                    fontSize: 14.0),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  color: Color(0xFFEBEBEB),
                  height: 1.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: TextButton(
                  child: Text(
                    'commander',
                    style: TextStyle(
                        fontFamily: 'Varela',
                        color: Color(0XFFD17E50),
                        fontSize: 16.0),
                  ),
                  onPressed: () {
                    bool exist = commandes
                            .where((element) => element.plat == plat)
                            .length > 0;

                    if (!exist) {
                      commandes.add(new Commande(plat, 1));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Plat déjà ajouté !"),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Commande> get getCommandes => this.commandes;

  void set setCommandes(List<Commande> commandes) {
    this.commandes = commandes;
  }
}
