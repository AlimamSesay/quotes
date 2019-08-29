import 'package:flutter/material.dart';

class CategorieWidget extends StatelessWidget {
  CategorieWidget(
      {@required this.name,
      @required this.number,
      @required this.onTap,
      @required this.fileName});

  final String name;
  final int number;
  final String fileName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(fileName),
              backgroundColor: Colors.transparent,
            ),
            Text(name),
            Text(number.toString()),
          ],
        ),
      ),
    );
  }
}
