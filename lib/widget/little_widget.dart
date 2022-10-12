import 'package:flutter/material.dart';

const rankViewMargin = EdgeInsets.all(0);

Widget buildRankView(
  int index, {
  double iconWidth = 22,
  double iconHeight = 28,
  Color textColor = Colors.red,
  double textSize = 15,
  EdgeInsetsGeometry margin = rankViewMargin,
}) {
  Widget contentWidget = Container();
  if (3 > index) {
    String icon;
    switch (index) {
      case 0:
        icon = "images/icon_gold.png";
        break;
      case 1:
        icon = "images/icon_silver.png";
        break;
      case 2:
        icon = "images/icon_bronze.png";
        break;
    }
    contentWidget = Image.asset(
      icon,
      fit: BoxFit.fill,
    );
  } else {
    contentWidget = Text(
      (index + 1).toString(),
      style: TextStyle(color: textColor, fontSize: textSize),
    );
  }
  return contentWidget = Container(
    width: iconWidth,
    height: iconHeight,
    margin: margin,
    alignment: Alignment.center,
    child: contentWidget,
  );
}
