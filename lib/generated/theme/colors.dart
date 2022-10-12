import 'package:flutter/material.dart';
import 'utils.dart';


enum AppColors {
  textSubColor,
  textSubColor2,
  checkFailColor,
  textSubColor3,
  themeColor,
  lineColor,
  sellOKColor,
  checkingColor,
  textColor,
  translucentThemeColor,
  hintTextColor,
  checkOkColor,
}

class AppColor {
  Color value(Object appColor) {
    switch (appColor) {
      case AppColors.textSubColor:
        return textSubColor;
      case AppColors.textSubColor2:
        return textSubColor2;
      case AppColors.checkFailColor:
        return checkFailColor;
      case AppColors.textSubColor3:
        return textSubColor3;
      case AppColors.themeColor:
        return themeColor;
      case AppColors.lineColor:
        return lineColor;
      case AppColors.sellOKColor:
        return sellOKColor;
      case AppColors.checkingColor:
        return checkingColor;
      case AppColors.textColor:
        return textColor;
      case AppColors.translucentThemeColor:
        return translucentThemeColor;
      case AppColors.hintTextColor:
        return hintTextColor;
      case AppColors.checkOkColor:
        return checkOkColor;
    }
  }
    Color textSubColor = Color(0xff666666);
    Color textSubColor2 = Color(0xff999999);
    Color checkFailColor = Color(0xFFFF2A2A);
    Color textSubColor3 = Color(0xffcccccc);
    Color themeColor = Color(0xff19C5FE);
    Color lineColor = Color(0xffEEEEEE);
    Color bgColor = Color(0xfff8f8f7);
    Color sellOKColor = Color(0xFF999999);
    Color checkingColor = Color(0xFFF6B345);
    Color textColor = Color(0xff333333);
    Color translucentThemeColor = Color(0x88f35a58);
    Color hintTextColor = Color(0xffbbbbbb);
    Color checkOkColor = Color(0xFF008FFF);
    Color groupColor = Color(0xfff8f8f8);

  Color vipTextColor = Color(0xffF4D2A4);


}

/// 主题颜色
class RedColor extends AppColor {
}
/// 主题颜色
class OrangeColor extends RedColor {
    Color checkFailColor = Color(0xFFFF2A2A);
    Color sellOKColor = Color(0xFF999999);
}
