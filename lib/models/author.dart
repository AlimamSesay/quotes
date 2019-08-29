class Author {
  String name;
  String fileName;
  int count;

  Author();

  Author.fromMap(Map<String, dynamic> map) {
    name = map["name"];
    fileName = map["file_name"];
    count = map["count"];
  }
}
