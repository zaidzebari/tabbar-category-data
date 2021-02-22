import 'dart:convert';

import 'package:category_tab/base_provider.dart';
import 'package:category_tab/category_model.dart';
import 'package:category_tab/data_model.dart';
import 'package:category_tab/service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends BaseProvider {
  CategoryService _categoryService = CategoryService();

  List<Category> _categoryModel = [];
  List<Data> _data = [];
  List<Category> get categoryModel => _categoryModel;

  Future<void> getcategory() async {
    var response = await _categoryService.getcategory();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print('the category is ');
      print(body);
      body.forEach((course) {
        _categoryModel.add(Category.fromJson(course));
      });
      // _categoryModel.forEach((element) {
      //   print("${element.name} : ${element.id}");
      // });
      notifyListeners();
    }
  }

  Future<void> getData(int id, int index) async {
    print('we will add category to this index : $index');
    var response = await _categoryService.getdata(id);
    print(response.statusCode);
    if (response.statusCode == 200) {
      _data = [];
      var body = jsonDecode(response.body);
      print('the the data of category is  ');
      print(body);
      body.forEach((course) {
        _data.add(Data.fromJson(course));
      });
      _categoryModel[index].data = _data;
      // _categoryModel.forEach((element) {
      //   print("${element.name} : ${element.id}");
      // });
      notifyListeners();
    }
  }
}
