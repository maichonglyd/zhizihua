import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';

class IntegralShopItemState implements Cloneable<IntegralShopItemState> {
  Goods goods;
  String buttonText;
  Color buttonColor;

  @override
  IntegralShopItemState clone() {
    return IntegralShopItemState()
      ..goods = goods
      ..buttonText = buttonText
      ..buttonColor = buttonColor;
  }
}

IntegralShopItemState initState(
  Goods goods,
) {
  String buttonText = getText(name: 'textExchange');
  Color buttonColor = AppTheme.colors.themeColor;

  if (goods.remainCnt <= 0) {
    buttonText = getText(name: 'textExchangeGone');
    buttonColor = AppTheme.colors.translucentThemeColor;
  }

  return IntegralShopItemState()
    ..goods = goods
    ..buttonText = buttonText
    ..buttonColor = buttonColor;
}
