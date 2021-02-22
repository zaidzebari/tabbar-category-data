import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

//test api if it is work like before i did
class Api {
  static final _api = Api._internal();
  factory Api() {
    return _api;
  }
  Api._internal();
  String token;
  String baseUrl = '192.168.112.1';
  String path = '/mobile and web test/laravel/category_tab/public/api';

  Future<http.Response> httpGet(
      String endPath, Map<String, String> query) async {
    print('the full path for is : ');
    Uri uri = Uri.http(baseUrl, '$path/$endPath');
    if (query != null) {
      uri = Uri.http(baseUrl, '$path/$endPath', query);
    }
    print(uri.queryParameters.toString());
    return http.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
  }

  Future<http.Response> httpPost(String endPath, Object body) async {
    try {
      // print('token in api file is $token');
      print('the full path for is : ');
      // print('$baseUrl$path/$endPath');
      Uri uri = Uri.http(baseUrl, '$path/$endPath');
      print(uri.host);
      return http.post(uri, body: body, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'Application/json',
      });
    } catch (e) {
      print(e);
      return null;
    }
  }
}

