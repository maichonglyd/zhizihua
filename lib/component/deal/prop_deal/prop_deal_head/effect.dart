import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_buy_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_sell_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_buy_record/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_sell_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<PropDealHeadState> buildEffect() {
  return combineEffects(<Object, Effect<PropDealHeadState>>{
    PropDealHeadAction.action: _onAction,
    PropDealHeadAction.gotoLogin: _gotoLogin,
    PropDealHeadAction.gotoMyBuyPage: _gotoMyBuyPage,
    PropDealHeadAction.gotoMySellPage: _gotoMySellPage,
  });
}

void _onAction(Action action, Context<PropDealHeadState> ctx) {}
void _gotoLogin(Action action, Context<PropDealHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
}

void _gotoMyBuyPage(Action action, Context<PropDealHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealBuyRecordPage.pageName);
}

void _gotoMySellPage(Action action, Context<PropDealHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PropDealSellRecordPage.pageName);
}
