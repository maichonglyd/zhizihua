import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/base/BaseState.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/goods_details_data.dart'
    as goods_details_data;
import 'package:flutter_huoshu_app/model/user/goods_list_data.dart';

class IntegralShopDetailsState extends BaseState
    implements Cloneable<IntegralShopDetailsState> {
  Goods goods;
  goods_details_data.Data goodsDetails;
  String buttonText = getText(name: 'textExchangeNow');
  Color buttonColor = AppTheme.colors.themeColor;
  String typeText = getText(name: 'textVirtualGoods');
  String myintegral = "0";

  @override
  IntegralShopDetailsState clone() {
    return IntegralShopDetailsState()
      ..loadStatus = loadStatus
      ..goods = goods
      ..buttonColor = buttonColor
      ..buttonText = buttonText
      ..typeText = typeText
      ..goodsDetails = goodsDetails
      ..myintegral = myintegral;
  }
}

IntegralShopDetailsState initState(Map<String, dynamic> map) {
  Goods goods = map['goods'];
  String buttonText = getText(name: 'textExchange');
  Color buttonColor = AppTheme.colors.themeColor;

  if (goods.remainCnt <= 0) {
    buttonText = getText(name: 'textExchangeGone');
    buttonColor = AppTheme.colors.translucentThemeColor;
  }
  return IntegralShopDetailsState()
    ..goods = goods
    ..buttonText = buttonText
    ..buttonColor = buttonColor;
}
