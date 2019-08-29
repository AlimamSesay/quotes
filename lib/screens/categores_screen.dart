import 'package:flutter/material.dart';
import 'package:quotes/screens/quotes_screen.dart';
import 'package:quotes/utils/constants.dart';
import 'package:quotes/utils/routes.dart';
import '../models/category.dart';
import '../database/database_helper.dart';
import '../widgets/categorie_widget.dart';

class CategoresScreen extends StatefulWidget {
  @override
  _CategoresScreenState createState() => _CategoresScreenState();
}

class _CategoresScreenState extends State<CategoresScreen> {
  Future<List<Category>> categories;
  @override
  void initState() {
    super.initState();
    categories = DatabaseHelper.internal().getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categores'),
      ),
      body: FutureBuilder(
        future: categories,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data
                    .map<Widget>((Category category) => CategorieWidget(
                          name: category.name,
                          number: category.count,
                          fileName:
                              'assets/categories/${category.fileName}.jpg',
                          onTap: () {
                            AppRoutes.push(
                                context,
                                QuotesScreen(
                                  type: QUOTES_BY_CATEGORY,
                                  category: category.name,
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
