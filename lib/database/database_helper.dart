import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/author.dart';
import '../models/category.dart';
import '../models/quote.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();
  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "quotes.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "quotes.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    var db = await openDatabase(path);
    return db;
  }

  Future<Quote> getQuote(int id) async {
    final sql =
        'SELECT quote._id, quote.author_name, quote.qte, quote.category_name, author.file_name,fav FROM quote,author WHERE author.name = quote.author_name AND _id = $id';
    var d = await db;
    final data = await d.rawQuery(sql);
    final quote = Quote.fromMap(data[0]);
    return quote;
  }

  Future<List<Author>> getAllAuthors(String value) async {
    final sql =
        '''SELECT name,file_name, COUNT(author_name ) AS count FROM author LEFT JOIN quote ON name = author_name WHERE name LIKE '%$value%'  GROUP BY name ORDER BY  name ASC''';
    var d = await db;
    final data = await d.rawQuery(sql);
    List<Author> authors = List();
    for (final node in data) {
      final author = Author.fromMap(node);
      authors.add(author);
    }
    return authors;
  }

  Future<List<Category>> getAllCategories() async {
    final sql =
        'SELECT name, file_name, COUNT(author_name ) AS count FROM category LEFT JOIN quote ON name = category_name  GROUP BY name ORDER BY  name ASC';
    var d = await db;
    final data = await d.rawQuery(sql);
    List<Category> categories = List();
    for (final node in data) {
      final categore = Category.fromMap(node);
      categories.add(categore);
    }
    return categories;
  }

  Future<List<Quote>> getAllQuotes() async {
    final sql =
        'SELECT quote._id, quote.author_name, quote.qte, quote.category_name,fav, author.file_name  FROM quote,author where author.name = quote.author_name ORDER BY quote.qte';
    var d = await db;
    final data = await d.rawQuery(sql);
    List<Quote> quotes = List();
    for (final node in data) {
      final quote = Quote.fromMap(node);
      quotes.add(quote);
    }
    return quotes;
  }

  Future<List<Quote>> getFavorites() async {
    final sql =
        "SELECT quote._id, quote.author_name, quote.qte, quote.category_name,fav, author.file_name  FROM quote,author where author.name = quote.author_name AND fav ='1'  ORDER BY name";
    var d = await db;
    final data = await d.rawQuery(sql);
    List<Quote> quotes = List();
    for (final node in data) {
      final quote = Quote.fromMap(node);
      quotes.add(quote);
    }
    return quotes;
  }

  Future<List<Quote>> getQuotesByCategory(String value) async {
    final sql =
        'SELECT quote._id, quote.author_name, quote.qte, quote.category_name,fav, author.file_name  FROM quote,author where author.name = quote.author_name AND category_name = \'$value\' ORDER BY quote.qte';
    var d = await db;
    final data = await d.rawQuery(sql);
    List<Quote> quotes = List();
    for (final node in data) {
      final quote = Quote.fromMap(node);
      quotes.add(quote);
    }
    return quotes;
  }

  Future<List<Quote>> getQuotesByAuthor(String value) async {
    final sql =
        'SELECT quote._id, quote.author_name, quote.qte, quote.category_name,fav, author.file_name  FROM quote,author where author.name = quote.author_name AND name= \'$value\' ORDER BY author_name';
    var d = await db;
    final data = await d.rawQuery(sql);
    List<Quote> quotes = List();
    for (final node in data) {
      final quote = Quote.fromMap(node);
      quotes.add(quote);
    }
    return quotes;
  }

  Future<bool> updateQuote(Quote quote) async {
    final sql =
        'UPDATE quote SET fav = ${quote.fav} where quote._id = ${quote.id}';
    var d = await db;
    final res = await d.rawQuery(sql);
    print('Update result');
    print(res);
    // return res > 0 ? true : false;
    return true;
  }
}
