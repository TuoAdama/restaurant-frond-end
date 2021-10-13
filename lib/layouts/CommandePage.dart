import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/app/api_request.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/models/commande.dart';
import 'package:restaurant/layouts/components.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/models/panier.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:scoped_model/scoped_model.dart';

class CommandePage extends StatefulWidget {
  CommandePage({Key? key}) : super(key: key);

  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  int total = 0;
  bool launch = false;
  bool response = true;
  TextStyle _style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  void initState() {
    this.total = this.updteTotale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<Panier>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Commandess'),
          automaticallyImplyLeading: false,
        ),
        body: model.commandes.isNotEmpty
            ? listeCommandes(panier.commandes)
            : Center(
                child: Text(
                  'Aucune commande',
                  style: _style,
                ),
              ),
      );
    });
  }

  Widget commandeItem(Commande cmd) {
    final panier = ScopedModel.of<Panier>(context);

    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 75.0,
              child: Image(
                image: NetworkImage(ApiRequest.asset(cmd.plat.imagePath)),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(cmd.plat.name),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    operationButton(Icons.remove, () {
                      if (cmd.quantite > 1) {
                        setState(() {
                          cmd.quantite--;
                          this.total = this.updteTotale();
                        });
                      }
                    }),
                    Text(cmd.quantite.toString().padLeft(2, '0')),
                    operationButton(Icons.add, () {
                      setState(() {
                        cmd.quantite++;
                        this.total = this.updteTotale();
                      });
                    }),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text('${cmd.plat.price} FCFA'),
                InkWell(
                  child: Icon(Icons.delete),
                  onTap: () {
                    setState(() {
                      panier.delete(cmd);
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void valideCommande() {
    TextEditingController _numController = TextEditingController();
    this.launch = false;
    this.response = true;
    final _formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) => AlertDialog(
                    title: Text('Numéro de table'),
                    content: !launch
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: _numController,
                                  decoration: InputDecoration(
                                    hintText: 'Numéro de table',
                                  ),
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return 'Entrer le num de table';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              !response
                                  ? SizedBox(
                                      height: 13,
                                      child: Text("num table n'existe pas",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.red,
                                          )))
                                  : SizedBox(
                                      height: 0,
                                    )
                            ],
                          )
                        : Container(
                            child: LinearProgressIndicator(),
                            width: 10,
                            height: 10),
                    actions: [
                      TextButton(
                          onPressed: () {
                            _numController.clear();
                            Navigator.pop(context);
                          },
                          child: Text('annuler')),
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                launch = true;
                              });
                              response =
                                  await checkNumTable(_numController.text);
                              setState(() {
                                launch = false;
                              });
                              if (!response) {
                                setState(() {
                                  launch = false;
                                });
                              } else {
                                bool isDone = await sendCommande(
                                    numTable: _numController.text);
                                if (isDone) {
                                  Navigator.pop(context);
                                }
                              }
                            }
                          },
                          child: Text('envoyer')),
                    ],
                  ));
        });
  }

  Future<bool> checkNumTable(String value) async {
    http.Response response =
        await ApiRequest.getRequest("/tableclient/$value");
    return response.statusCode == 200;
  }

  Widget listeCommandes(List<Commande> commandes) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: commandes.length,
            itemBuilder: (context, index) {
              return commandeItem(commandes[index]);
            },
          ),
        ),
        Divider(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: _style,
              ),
              Text(
                '$total FCFA',
                style: _style,
              )
            ],
          ),
        ),
        Center(
          child: ElevatedButton(
              onPressed: valideCommande, child: Text('Valider la commande')),
        )
      ],
    );
  }

  Future<bool> sendCommande({
    required String numTable,
  }) async {
    final panier = ScopedModel.of<Panier>(context).commandes;
    final personnel = ScopedModel.of<Personnel>(context);

    final data = {
      'num_table': numTable,
      'personnel_id': personnel.id,
      'commandes': encodeToJson(panier),
    };

    print(jsonEncode(data));

    http.Response res = await ApiRequest.postRequest("/commande/save", params: data);

    print(res.statusCode);

    if (res.statusCode == 201) {
      ScopedModel.of<Panier>(context).clear();
      return true;
    }
    return false;
  }

  int updteTotale() {
    int total = 0;
    final panier = ScopedModel.of<Panier>(context);
    panier.commandes.forEach((element) {
      total += element.quantite * int.parse(element.plat.price);
    });

    return total;
  }

  List encodeToJson(List<Commande> commandes) {
    return commandes.map((e) => e.toJson()).toList();
  }
}
