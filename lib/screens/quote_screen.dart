import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/utils/screen_utils.dart';
import 'package:share/share.dart';

import '../widgets/quote_widget.dart';
import '../database/database_helper.dart';
import '../models/quote.dart';
import '../utils/functions.dart';
import '../utils/constants.dart';

class QuoteScreen extends StatefulWidget {
  QuoteScreen(
      {this.currentQuote,
      this.quotes,
      this.index = 0,
      this.quoteOfTheDay = false});
  final List<Quote> quotes;
  final Quote currentQuote;
  final int index;
  final bool quoteOfTheDay;
  @override
  _QuoteScreenState createState() => _QuoteScreenState(initialIndex: index);
}

class _QuoteScreenState extends State<QuoteScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _QuoteScreenState({this.initialIndex})
      : _pageController = PageController(initialPage: initialIndex);

  final int initialIndex;
  final PageController _pageController;
  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  Quote currentQuote;

  init() async {
    if (!widget.quoteOfTheDay) {
      setState(() {
        currentQuote = widget.currentQuote;
      });
    } else {
      final id = await getIntFromSharedPref(ID);
      final quote = await DatabaseHelper.internal().getQuote(id);
      setState(() {
        currentQuote = quote;
      });
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _setFavorite(BuildContext context) {
    setState(() {
      currentQuote.fav = currentQuote.fav == 0 ? 1 : 0;
      DatabaseHelper.internal().updateQuote(currentQuote);
    });
    final msg = currentQuote.fav == 1
        ? 'Quote has been added to favorite'
        : 'Quote has been remove from favorite';
    final snackBar = SnackBar(content: Text(msg));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _copy(BuildContext context) {
    Clipboard.setData(new ClipboardData(
        text: '${currentQuote.quote}\n- ${currentQuote.authorName}'));

    final snackBar =
        SnackBar(content: Text('The Quote has been copied to clipboard'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils.setScreenAwareConstant(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Quote'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Copy',
            icon: Icon(Icons.content_copy),
            onPressed: () {
              _copy(context);
            },
          ),
          IconButton(
            tooltip: 'Favorite',
            icon: Icon(
                currentQuote.fav == 0 ? Icons.favorite_border : Icons.favorite),
            onPressed: () {
              _setFavorite(context);
            },
          ),
          IconButton(
            tooltip: 'Share',
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(
                  '${currentQuote.quote}\n- ${currentQuote.authorName}');
            },
          )
        ],
      ),
      body: widget.quoteOfTheDay
          ? QuoteWidget(quote: currentQuote)
          : Column(
              children: <Widget>[
                Flexible(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.quotes.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentQuote = widget.quotes[index];
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          QuoteWidget(quote: currentQuote),
                          Container(
                            height: ScreenUtil.getInstance().setHeight(50),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 0.0,
                                  bottom: 0.0,
                                  child: Visibility(
                                    visible: index > 0,
                                    child: FlatButton(
                                      child: Icon(Icons.arrow_back),
                                      onPressed: () {
                                        _pageController.previousPage(
                                            duration: _duration, curve: _curve);
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0.0,
                                  bottom: 0.0,
                                  child: Visibility(
                                    visible: index < widget.quotes.length - 1,
                                    child: FlatButton(
                                      child: Icon(Icons.arrow_forward),
                                      onPressed: () {
                                        _pageController.nextPage(
                                            duration: _duration, curve: _curve);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
