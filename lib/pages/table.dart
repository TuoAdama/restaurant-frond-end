import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant/app/api_request.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/models/commande_item.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/models/satut.dart';
import 'package:restaurant/pages/detail.dart';
import 'package:scoped_model/scoped_model.dart';

class TablePage extends StatefulWidget {
  TablePage({Key? key}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  List<CommandeItem> commandes = <CommandeItem>[];
  List<CommandeItem> filtre = <CommandeItem>[];
  TextEditingController fieldController = TextEditingController();

  @override
  void initState() {
    fecthCommandes().then((value) {
      setState(() {
        commandes = value;
        filtre = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          await fecthCommandes();
        },
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Etat des commandes"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 13,
          ),
          search(),
          SizedBox(
            height: 12,
          ),
          commandes.isNotEmpty ? allCart() : CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget allCart() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
            itemCount: filtre.length,
            itemBuilder: (ctx, index) => cart(filtre[index])),
      ),
    );
  }

  Widget cart(CommandeItem item) {
    final personnel = ScopedModel.of<Personnel>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: 200,
      height: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(item.numTable), Text(item.createAt)],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                libelle(label: 'Quantite', result: item.total.toString()),
                libelle(label: 'Total', result: "10 000 FCFA"),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black, spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        numTable: item.numTable,
                                        idPersonnel: personnel.id!,
                                      )));
                        },
                        child: Text("Details"),
                      ),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
                Text(
                  item.statut,
                  style: TextStyle(
                      color: item.statut == Statut.PRET
                          ? Colors.green[600]
                          : Colors.red,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget libelle({required String label, required String result}) {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: '$label : ',
          style: TextStyle(fontSize: 16, color: Colors.black87)),
      TextSpan(
          text: result,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
    ]));
  }

  Widget search() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: fieldController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          hintText: 'numero de table',
          focusColor: Colors.black,
        ),
        onChanged: onSearch,
      ),
    );
  }

  Future<List<CommandeItem>> fecthCommandes() async {
    final personnel = ScopedModel.of<Personnel>(context);
    debugPrint("Recupération des commandes effectuées par ${personnel.nom} ${personnel.prenom}");

    http.Response response = await ApiRequest.getRequest("commande/personnel/${personnel.id}");

    if (response.statusCode != 200) {
      print("Statut code: ${response.statusCode}");
      return [];
    }

    print("resultat: ${response.body}");
    print(response.statusCode);
    return jsonToPlat(jsonDecode(response.body));
  }

  List<CommandeItem> jsonToPlat(List<dynamic> results) {
    return results.map((element) {
      return CommandeItem.toJson(element);
    }).toList();
  }

  List<CommandeItem> filtreData(String value) {
    return this
        .commandes
        .where((element) => element.numTable.contains(value))
        .toList();
  }

  Future<void> refresh() async {
    fecthCommandes().then((value) {
      setState(() {
        commandes = value;
        filtre = value;
      });

      if (fieldController.text.isNotEmpty) {
        onSearch(fieldController.text);
      }
    });
  }

  void onSearch(String search) {
    if (search.isNotEmpty) {
      final data = filtreData(search);
      setState(() {
        filtre = data;
      });
      filtre.forEach((element) {
        print(element.numTable);
      });
    } else {
      setState(() {
        filtre = this.commandes;
      });
    }
  }
}
