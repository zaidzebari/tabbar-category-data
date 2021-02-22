class Data {
  int id;
  String name;

  Data({this.id, this.name});
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
