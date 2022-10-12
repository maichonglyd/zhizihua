import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/gift/my_gift_item/component.dart'
    as my_gift;
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

class GiftDetailsState implements Cloneable<GiftDetailsState> {
  Gift gift;

  String buttonText = getText(name: 'textReceive');
  Color buttonColor = AppTheme.colors.themeColor;
  String typeText = getText(name: 'textVirtualGoods');

  @override
  GiftDetailsState clone() {
    return GiftDetailsState()
      ..gift = gift
      ..buttonColor = buttonColor
      ..buttonText = buttonText
      ..typeText = typeText;
    ;
  }
}

GiftDetailsState initState(Gift gift) {
  String buttonText = getText(name: 'textReceive');
  Color buttonColor = AppTheme.colors.themeColor;
  String typeText = getText(name: 'textVirtualGoods');

  switch (gift.giftType) {
    case 1:
      typeText = getText(name: 'textNormalGift');
      break;
    case 2:
      typeText = getText(name: 'textPointsExchangeGift', args: [gift.condition]);
      buttonText = getText(name: 'textExchange');
      break;
    case 3:
      typeText = getText(name: 'textGroupGift');
      break;
    case 4:
      typeText = getText(name: 'textRechargeGift', args: [gift.condition]);
      buttonText = getText(name: 'textExchange');
      break;
  }

  bool copy = gift.giftCode.isNotEmpty;
  if (copy) {
    buttonText = getText(name: 'textCopy');
  } else {}
  if (!copy && gift.remainCnt == 0) {
    buttonText = getText(name: 'textHasReceived');
    buttonColor = AppTheme.colors.translucentThemeColor;
  }

  return GiftDetailsState()
    ..gift = gift
    ..buttonColor = buttonColor
    ..buttonText = buttonText
    ..typeText = typeText;
}
