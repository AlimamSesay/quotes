import 'package:flutter/material.dart';
import 'package:quotes/models/quote.dart';
import 'quote_widget.dart';

class QuotePageWidget extends StatelessWidget {
  QuotePageWidget({@required this.initialIndex, @required this.quotes})
      : pageController = PageController(initialPage: initialIndex);

  final int initialIndex;
  final PageController pageController;
  final List<Quote> quotes;

  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    print(pageController);
    return Column(
      children: <Widget>[
        Flexible(
          child: PageView.builder(
            controller: pageController,
            itemCount: quotes.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  QuoteWidget(quote: quotes[index]),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Visibility(
                        visible: index > 0,
                        child: FlatButton(
                          child: Text('Prev'),
                          onPressed: () {
                            pageController.previousPage(
                                duration: _duration, curve: _curve);
                          },
                        ),
                      ),
                      Visibility(
                        visible: index < quotes.length - 1,
                        child: FlatButton(
                          child: Text('Next'),
                          onPressed: () {
                            pageController.nextPage(
                                duration: _duration, curve: _curve);
                          },
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
