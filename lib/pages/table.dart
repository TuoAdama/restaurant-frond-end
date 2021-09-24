import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant/data/utilisies.dart';
import 'package:restaurant/models/commande.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/models/commande_item.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/models/satut.dart';
import 'package:scoped_model/scoped_model.dart';

class TablePage extends StatefulWidget {
  TablePage({Key? key}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  List<dynamic> commandes = <CommandeItem>[];

  @override
  void initState() {
    fecth_commandes().then((value) {
      setState(() {
        commandes = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          setState(() {
            print(commandes);
          });
        },
      ),
      appBar: AppBar(
        elevation: 0.0,
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
          commandes.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: commandes.length,
                      itemBuilder: (ctx, index) => cart(commandes[index])),
                )
              : CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget cart(CommandeItem item) {
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
                        onPressed: () {},
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
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          hintText: 'recherche',
          focusColor: Colors.black,
        ),
      ),
    );
  }

  Future<List<CommandeItem>> fecth_commandes() async {
    final personnel = ScopedModel.of<Personnel>(context);
    print(personnel.id);

    http.Response response = await http.get(
        Uri.parse(Utilisies.host + "api/commande/personnel/${personnel.id}"));

    if (response.statusCode != 200) {
      print("Statut code: ${response.statusCode}");
      return [];
    }

    return data(jsonDecode(response.body));
  }

  List<CommandeItem> data(List<dynamic> results) {
    return results.map((element) {
      return CommandeItem.toJson(element);
    }).toList();
  }
}
