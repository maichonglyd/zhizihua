import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_buy_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_sell_list_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/action.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<IndexDealHeadState> buildEffect() {
  return combineEffects(<Object, Effect<IndexDealHeadState>>{
    IndexDealHeadAction.action: _onAction,
    IndexDealHeadAction.gotoLogin: _gotoLogin,
    IndexDealHeadAction.gotoMyBuyPage: _gotoMyBuyPage,
    IndexDealHeadAction.gotoMySellPage: _gotoMySellPage,
  });
}

void _onAction(Action action, Context<IndexDealHeadState> ctx) {}
void _gotoLogin(Action action, Context<IndexDealHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
}

void _gotoMyBuyPage(Action action, Context<IndexDealHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MyBuyListPage.pageName);
}

void _gotoMySellPage(Action action, Context<IndexDealHeadState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MySellListPage.pageName,
      arguments: {"index": action.payload});
}
