import 'package:flutter/material.dart';
import 'package:restaurant/Acceuil.dart';
import 'package:restaurant/layouts/components.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:restaurant/pages/welcome.dart';
import 'layouts/bezierContainer.dart';

class LoginPage extends StatelessWidget {
  //const LoginPage({ Key? key }) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.height * .4,
              child: BezierContainer(),
            ),
            Container(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appTitle(),
                SizedBox(height: 50,),
                formInput("Nom d'utilisateur:"),
                SizedBox(height:20),
                formInput("Mot de passe:", isPassword: true),
                SizedBox(height: 20,),
                InkWell(
                  child: submitButton(context),
                  onTap: () {

                    Personnel personnel = new Personnel(id: 1, idPoste: 1, nom: "Tuo",
                      prenom: "Adama", dateNaissance: "1998-06-28");

                    //Navigator.push(context, MaterialPageRoute(builder: (context) => App(personnel)));
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Acceuil(personnel)));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome(personnel: personnel,)));
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  }
                ),
              ],
          ),
            ),]
        ),
      ),
    );
  }
}