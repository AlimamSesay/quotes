import 'package:flutter/material.dart';
import 'package:quotes/utils/routes.dart';
import '../widgets/quotes_widget.dart';
import '../database/database_helper.dart';
import '../models/quote.dart';
import '../utils/constants.dart';
import '../screens/quote_screen.dart';

class QuotesScreen extends StatefulWidget {
  QuotesScreen(
      {@required this.type, @required this.title, this.author, this.category});
  final String type;
  final String title;
  final String author;
  final String category;
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  List<Quote> quotes;
  bool loaded = false;
  String msg = 'Loading...';
  initQuotes() async {
    switch (widget.type) {
      case ALL_GUOTES:
        var qts = await DatabaseHelper.internal().getAllQuotes();
        setState(() {
          quotes = qts;
          loaded = true;
        });
        break;
      case FAVORITES_GUOTES:
        var qts = await DatabaseHelper.internal().getFavorites();
        setState(() {
          if (qts.length == 0) {
            msg = 'No Favorites Quotes Found';
            return;
          }
          quotes = qts;
          loaded = true;
        });
        break;
      case QUOTES_BY_AUTHOR:
        var qts =
            await DatabaseHelper.internal().getQuotesByAuthor(widget.author);
        setState(() {
          quotes = qts;
          loaded = true;
        });
        break;
      case QUOTES_BY_CATEGORY:
        var qts = await DatabaseHelper.internal()
            .getQuotesByCategory(widget.category);
        setState(() {
          quotes = qts;
          loaded = true;
        });
        break;
      default:
    }
  }

  @override
  void initState() {
    initQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: loaded
            ? ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (BuildContext context, int index) {
                  print('ListView.builder');
                  print(index);
                  return QuotesWidget(
                    quote: quotes[index],
                    onTap: () {
                      AppRoutes.push(
                          context,
                          QuoteScreen(
                            currentQuote: quotes[index],
                            quotes: quotes,
                            index: index,
                          ));
                    },
                  );
                },
              )
            : Container(
                child: Text(msg),
              ));
  }
}

/*
ListView(
          children: quotes
              .map<Widget>((Quote quote) => QuotesWidget(
                    quote: quote,
                    onTap: () {
                      AppRoutes.push(
                          context,
                          QuoteScreen(
                            currentQuote: quote,
                            quotes: quotes,
                          ));
                    },
                  ))
              .toList()),
              */
