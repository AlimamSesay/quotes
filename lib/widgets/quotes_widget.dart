import 'package:flutter/material.dart';
import '../models/quote.dart';

class QuotesWidget extends StatelessWidget {
  QuotesWidget({@required this.quote, @required this.onTap});

  final Quote quote;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: onTap,
          child: Column(
            children: <Widget>[
              Text(quote.category,
                  style: TextStyle(backgroundColor: Colors.green)),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        AssetImage('assets/authors/${quote.fileName}.jpg'),
                    backgroundColor: Colors.transparent,
                  ),
                  Divider(
                    indent: 10.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(quote.quote.length < 30
                          ? quote.quote
                          : '${quote.quote.substring(0, 30)}...'),
                      Text(quote.authorName)
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
