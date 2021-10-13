import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/app/api_request.dart';
import 'package:restaurant/models/commande.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/models/plat.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.numTable, required this.idPersonnel})
      : super(key: key);

  String numTable;
  int idPersonnel;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List platCommandes = <Commande>[];

  @override
  void initState() {
    gettableCmd().then((value) {
      setState(() {
        platCommandes = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.numTable),
        centerTitle: true,
      ),
      body: platCommandes.isNotEmpty
          ? allItem()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget platItem(Commande commande) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          ApiRequest.asset(commande.plat.imagePath)),
                      fit: BoxFit.contain)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(commande.plat.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(commande.plat.category),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Quantite: ${commande.quantite}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget allItem() {
    return ListView.builder(
      itemCount: this.platCommandes.length,
      itemBuilder: (context, index) {
        return platItem(this.platCommandes[index]);
      },
    );
  }

  Future<List<Commande>> gettableCmd() async {
    var results = <Commande>[];

    http.Response response = await ApiRequest.getRequest(
        "commande/table=${widget.numTable}/personnel=${widget.idPersonnel}");

    if (response.statusCode == 200) {
      final commandes = jsonDecode(response.body);
      final platCommandes = commandes['plat_commandes'] as List;
      results = platCommandes
          .map((commandeItem) => jsonToCommande(commandeItem))
          .toList();
    }

    return results;
  }

  dynamic appropriateValue(dynamic value, String name) {
    return value is Map ? value[name] : value[0][name];
  }
}

Commande jsonToCommande(Map<dynamic, dynamic> commande) {
  final plat = new Plat(
      category: commande['plat']['categorie']['libelle'],
      name: commande['plat']['libelle'],
      price: commande['plat']['prix'].toString(),
      imagePath: commande['plat']['images'][0]['chemin'],
      id: commande['plat']['id']);
  return Commande(plat, commande['quantite']);
}
