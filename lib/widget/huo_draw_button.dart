import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';

//领取按钮的样式
Widget huoMaButton(
    String text, Color textColor, double textSize, GestureTapCallback ok) {
//  Function() ok;
  return Container(
    height: 30,
    width: 52,
    child: MaterialButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        ok;
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: textColor),
      ),
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: textColor)),
  );
}
