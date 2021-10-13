import 'package:flutter/material.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/pages/table.dart';
import 'package:scoped_model/scoped_model.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personnel = ScopedModel.of<Personnel>(context);

    TextStyle profileStyle =
        TextStyle(fontSize: 45, fontWeight: FontWeight.w600);
    final titleStyle = TextStyle(fontWeight: FontWeight.w500);

    return Scaffold(

      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Profile', style: profileStyle),
            ),
            ListTile(
              title: Text("${personnel.prenom} ${personnel.nom}"),
              leading: CircleAvatar(
                child: Icon(
                  Icons.account_box,
                  color: Colors.white,
                ),
              ),
              subtitle: Text("tuoadama17@gmail.com"),
            ),
            Expanded(
              child: ListView(
                children: [
                  Divider(),
                  ListTile(
                    title: Text(
                      "Mes commandes",
                      style: titleStyle,
                    ),
                    subtitle: Text("Toutes les commandes"),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TablePage()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Mes Bilan",
                      style: titleStyle,
                    ),
                    subtitle: Text("Bilan de la journée"),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 30,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Options",
                      style: titleStyle,
                    ),
                    subtitle: Text("plus"),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 30,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Se deconnecter"),
                    trailing: Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.red,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return alertDialogWidget(context);
                          });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget alertDialogWidget(context) {
    return AlertDialog(
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Voulez-vous vraiment vous deconner ?"),
            Container(
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Annuler")),
                  TextButton(onPressed: () {
                    
                  }, child: Text("Confirmer")),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
