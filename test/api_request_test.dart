import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/app/api_request.dart';
import 'package:http/http.dart' as http;

void main() {

  ApiRequest.host = "localhost";
  http.Response response;

  test('test getRequest methode', () async {
    String email = "tuoadama17@gmail.com";
    String password = "tuoadama";

    response = await ApiRequest.postRequest("/login",
        params: {"email": email, "password": password});

    expect(200, response.statusCode);
  });


  test("categories", () async {
    response = await ApiRequest.getRequest("/categorie");

    if(response.statusCode  == 200){
      print(response.body);
    }else{
      print(response.statusCode);
    }

  });
}
