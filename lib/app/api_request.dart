import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiRequest {
  static String host = "10.0.3.2";
  static String port = '8000';
  static String url = "http://${ApiRequest.host}:${ApiRequest.port}/api";
  static String token = "";

  static void getPlat() async {
    await http.get(Uri.parse(ApiRequest.url), headers: ApiRequest.getHeaders());
  }

  static Future<http.Response> getRequest(String path) async {
    return await http.get(ApiRequest._pathContruct(path), headers: ApiRequest.getHeaders());
  }

  static Future<http.Response> postRequest(String path,
      {Map<String, dynamic> params = const {}}) async {
    
    debugPrint("url : ${ApiRequest._pathContruct(path).toString()}");
    debugPrint("params: ${jsonEncode(params)}");
    
    return await http.post(ApiRequest._pathContruct(path),
                            headers: ApiRequest.getHeaders(),
                            body: jsonEncode(params));
  }

  static Uri _pathContruct(String path) {
    if (!path.startsWith("/")) {
      path = "/$path";
    }
    return Uri.parse('${ApiRequest.url}$path');
  }

  static Map<String, String> getHeaders(){
    return <String, String> {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${ApiRequest.token}',
    };
  }

  static String asset(String path){
    return "http://${ApiRequest.host}:${ApiRequest.port}/storage/$path";
  }
}
