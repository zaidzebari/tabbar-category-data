import 'dart:convert';

import 'package:category_tab/base_api.dart';
import 'package:http/http.dart' as http;

//
class CategoryService extends BaseApi {
  Future<http.Response> getcategory() async {
    return await api.httpGet('category', null);
  }

  Future<http.Response> getdata(int id) async {
    return await api.httpGet('category/$id/get', null);
  }
}
