import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';
import 'package:quotes/utils/screen_utils.dart';
import 'settings_screen.dart';
import 'authors_screen.dart';
import 'categores_screen.dart';
import 'quotes_screen.dart';
import 'quote_screen.dart';
import '../utils/routes.dart';
import '../widgets/home_card_item_widget.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rate Us'),
          content: Text(
              'if you like this app please take a moment to rate it. It would\'t take more than a minute. \n Enjoy!'),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("RATE IT"),
              onPressed: () {
                Navigator.of(context).pop();
                LaunchReview.launch();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtils.setScreenAwareConstant(context);
    print('Device width:${ScreenUtil.screenWidth}'); //Device width
    print('Device height:${ScreenUtil.screenHeight}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes Screen'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Settings',
            icon: Icon(Icons.settings),
            onPressed: () {
              AppRoutes.push(context, SettingsScreen());
            },
          )
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  HomeCardItemWidget(
                    icon: Icons.format_quote,
                    title: QUOTES.toUpperCase(),
                    onTap: () {
                      AppRoutes.push(
                          context,
                          QuotesScreen(
                            type: ALL_GUOTES,
                            title: QUOTES,
                          ));
                    },
                  ),
                  HomeCardItemWidget(
                    icon: Icons.people,
                    title: 'AUTHORS',
                    onTap: () {
                      AppRoutes.push(context, AuthorsScreen());
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  HomeCardItemWidget(
                    icon: Icons.favorite,
                    title: MY_FAVORITES.toUpperCase(),
                    onTap: () {
                      AppRoutes.push(
                          context,
                          QuotesScreen(
                            type: FAVORITES_GUOTES,
                            title: MY_FAVORITES,
                          ));
                    },
                  ),
                  HomeCardItemWidget(
                    icon: Icons.category,
                    title: 'CATEGORIES',
                    onTap: () {
                      AppRoutes.push(context, CategoresScreen());
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  HomeCardItemWidget(
                    icon: Icons.view_day,
                    title: 'QUOTE OF THE DAY',
                    onTap: () {
                      AppRoutes.push(context, QuoteScreen(quoteOfTheDay: true));
                    },
                  ),
                  HomeCardItemWidget(
                    icon: Icons.thumb_up,
                    title: 'RATE US',
                    onTap: () {
                      _showDialog(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
