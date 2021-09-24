import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/layouts/bottom_bar.dart';
import 'package:restaurant/layouts/cookie_page.dart';
import 'package:restaurant/models/commande.dart';
import 'package:restaurant/models/plat.dart';

class CookieDetail extends StatefulWidget {
  final Plat plat;
  final CookiePage cookiePage;
  int quantite = 1;

  CookieDetail({required this.plat, required this.cookiePage});

  @override
  _CookieDetailState createState() => _CookieDetailState();
}

class _CookieDetailState extends State<CookieDetail> {
  Commande? commande;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF545D68),
          ),
          onPressed: () {
            Navigator.of(context).pop(this.commande);
          },
        ),
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
            onPressed: () {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.fastfood),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
      body: ListView(
        padding: EdgeInsets.only(bottom: 30),
        children: [
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              widget.plat.name,
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                color: Color(0XFFF17532),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Hero(
              tag: widget.plat.imagePath,
              child: Image.asset(
                widget.plat.imagePath,
                height: 150,
                width: 100,
                fit: BoxFit.contain,
              )),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              "${widget.plat.price} FCFA",
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0XFFF17532),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(
                'Ceci est une description ! Ceci est une description !',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Color(0XFFB4B8B9),
                ),
              ),
            ),
          ),
          Row(
            children: [
              quantiteButton(Icons.remove, () {
                setState(() {
                  if (widget.quantite > 1) {
                    widget.quantite--;
                  }
                });
              }),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Text(widget.quantite.toString().padLeft(2, "0")),
              ),
              quantiteButton(Icons.add, () {
                setState(() {
                  widget.quantite++;
                });
              }),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: InkWell(
              onTap: _onCommande,
              child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0XFFF17532),
                  ),
                  child: Center(
                    child: Text(
                      'Ajouter à la commande',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  SizedBox quantiteButton(IconData icon, Function press) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        onPressed: () => press(),
        child: Icon(icon),
      ),
    );
  }

  void _showSnackBar(String msg, {Color color = Colors.black}){
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: Text(msg),
      backgroundColor: color,
    ));
  }

  void _onCommande(){
    Commande commande = new Commande(widget.plat, widget.quantite);

    bool cmdExist = widget.cookiePage.commandes
        .where((element) => element == commande)
        .length > 0;
    if(cmdExist){
      _showSnackBar("Plat déjà ajouté", color: Colors.red);
      return;
    }

    Commande cmd = widget.cookiePage.commandes
        .firstWhere((element) =>
    element.plat == widget.plat);

    if(cmd != null){
      cmd.quantite = widget.quantite;
      _showSnackBar("Quantité modifiée", color: Colors.green);
      return;
    }

    widget.cookiePage.commandes.add(commande);
  }
}
