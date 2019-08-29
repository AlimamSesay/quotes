import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCardItemWidget extends StatelessWidget {
  HomeCardItemWidget(
      {@required this.title, @required this.onTap, @required this.icon});

  final String title;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Container(
              width: ScreenUtil.getInstance().setWidth(150),
              height: ScreenUtil.getInstance().setHeight(150),
              child: Icon(
                icon,
                size: 100.0,
              ),
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
