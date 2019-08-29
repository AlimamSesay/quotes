import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotes/utils/screen_utils.dart';
import '../models/quote.dart';

class QuoteWidget extends StatelessWidget {
  QuoteWidget({@required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    ScreenUtils.setScreenAwareConstant(context);
    return Column(
      children: <Widget>[
        Container(
          padding: ScreenUtils.spacingAllMedium,
          width: ScreenUtil.getInstance().setWidth(200),
          height: ScreenUtil.getInstance().setHeight(200),
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage('assets/authors/${quote.fileName}.jpg'),
            backgroundColor: Colors.transparent,
          ),
        ),
        Divider(
          height: ScreenUtil.getInstance().setHeight(20),
        ),
        Padding(
          padding: ScreenUtils.spacingAllMedium,
          child: Text(
            quote.quote,
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20)),
          ),
        ),
        Divider(
          height: 10.0,
        ),
        Text(quote.authorName),
      ],
    );
  }
}
