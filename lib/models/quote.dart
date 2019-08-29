final String tableCategory = 'category';
final String columnId = '_id';
final String columnAuthorName = 'author_name';
final String columnQuote = 'qte';
final String columnFileCategory = 'category_name';
final String columnFileName = 'file_name';
final String columnFav = 'fav';

class Quote {
  int id;
  String authorName;
  String quote;
  String category;
  String fileName;
  int fav;

  Quote();

  Quote.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    authorName = map[columnAuthorName];
    quote = map[columnQuote];
    category = map[columnFileCategory];
    fileName = map[columnFileName];
    fav = map[columnFav];
  }
}
