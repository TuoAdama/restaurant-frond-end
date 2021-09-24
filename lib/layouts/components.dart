import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget formInput(String label, {bool isPassword = false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true,
          ),
        )
      ],
    ),
  );
}

Widget submitButton(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(vertical: 15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xfffbb448), Color(0xfff7892b)])),
    child: Text(
      'Se connecter',
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget appTitle() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'Mon',
        style: TextStyle(color: Colors.black, fontSize: 45),
        children: [
          TextSpan(
            text: ' Restaurant',
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10),
            ),
          )
        ]),
  );
}

Widget backButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: Icon(Icons.keyboard_arrow_left),
          ),
          Text(
            'Retour',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}

Widget operationButton(IconData icon, Function press) {
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.3),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 1.0)
        ],
      ),
      child: InkWell(
        onTap: () {
          press();
        },
        child: Icon(
          icon,
          size: 25,
        ),
      ));
}