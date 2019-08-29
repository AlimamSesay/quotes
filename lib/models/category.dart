class Category {
  String name;
  String fileName;
  int count;

  Category();

  Category.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    fileName = map["file_name"];
    count = map["count"];
  }
}
