import 'package:flutter/material.dart';
import 'package:quotes/screens/quotes_screen.dart';
import 'package:quotes/utils/routes.dart';
import '../widgets/categorie_widget.dart';
import '../database/database_helper.dart';
import '../models/author.dart';
import '../utils/constants.dart';

class AuthorsScreen extends StatefulWidget {
  @override
  _AuthorsScreenState createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  Future<List<Author>> authors;

  @override
  void initState() {
    super.initState();
    authors = DatabaseHelper.internal().getAllAuthors('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authors'),
      ),
      body: FutureBuilder(
        future: authors,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data
                    .map<Widget>((Author author) => CategorieWidget(
                          name: author.name,
                          number: author.count,
                          fileName: 'assets/authors/${author.fileName}.jpg',
                          onTap: () {
                            AppRoutes.push(
                                context,
                                QuotesScreen(
                                  type: QUOTES_BY_AUTHOR,
                                  author: author.name,
                                  title: QUOTES,
                                ));
                          },
                        ))
                    .toList());
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
