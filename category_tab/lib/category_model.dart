import 'package:category_tab/data_model.dart';

class Category {
  List<Data> data;
  int id;
  String name;

  Category({this.data, this.id, this.name});
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    data = json['data'];
  }
}
