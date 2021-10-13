import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant/app/api_request.dart';
import 'package:restaurant/layouts/components.dart';
import 'package:restaurant/models/personnel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../layouts/bezierContainer.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isCorrect = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Stack(children: [
          Positioned(
            top: -MediaQuery.of(context).size.height * .15,
            right: -MediaQuery.of(context).size.height * .4,
            child: BezierContainer(),
          ),
          Container(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  appTitle(),
                  SizedBox(
                    height: 30,
                  ),
                  if (!isCorrect)
                    Container(
                      child: Text(
                        'Identifiant incorrect',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  formInput("Nom d'utilisateur:",
                      controller: usernameController),
                  SizedBox(height: 20),
                  formInput("Mot de passe:",
                      isPassword: true, controller: passwordController),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(child: submitButton(context), onTap: onLogin),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void onLogin() async {
    http.Response response = await ApiRequest.postRequest("/login", params: {
      "email": usernameController.text,
      "password": passwordController.text
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      ApiRequest.token = data['token']!;

      ScopedModel.of<Personnel>(context)
          .setPerson(Personnel.fromJson(data['personnel']));
      Navigator.pushNamed(context, "/home");
    
    } else {
      print(response.body);

      setState(() {
        isCorrect = false;
      });
    }
  }
}
