import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

import 'action.dart';
import 'state.dart';

Reducer<GiftDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<GiftDetailsState>>{
      GiftDetailsAction.action: _onAction,
      GiftDetailsAction.updateData: _updateData,
    },
  );
}

GiftDetailsState _onAction(GiftDetailsState state, Action action) {
  final GiftDetailsState newState = state.clone();
  return newState;
}

GiftDetailsState _updateData(GiftDetailsState state, Action action) {
  final GiftDetailsState newState = state.clone();
  newState.gift = action.payload;
  Gift gift = newState.gift;
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

  bool copy = gift.giftCode != null && gift.giftCode.isNotEmpty;
  if (copy) {
    buttonText = getText(name: 'textCopy');
  } else {}
  if (!copy && gift.remainCnt == 0) {
    buttonText = getText(name: 'textHasReceived');
    buttonColor = AppTheme.colors.translucentThemeColor;
  }
  newState.buttonColor = buttonColor;
  newState.buttonText = buttonText;
  newState.typeText = typeText;

  return newState;
}
