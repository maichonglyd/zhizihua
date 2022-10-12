import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/integral_record/page.dart'
    hide SingleTickerProviderStfState;
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'action.dart';
import 'state.dart';
import 'page.dart';

Effect<IntegralShopState> buildEffect() {
  return combineEffects(<Object, Effect<IntegralShopState>>{
    IntegralShopAction.gotoRecord: _gotoRecord,
    IntegralShopAction.gotoInvite: _gotoInvite,
    Lifecycle.initState: _init,
    IntegralShopAction.onUpdateIntegral: _onUpdateIntegral,
    IntegralShopAction.gotoExchangeRecord: _gotoExchangeRecord,
  });
}

void _onUpdateIntegral(Action action, Context<IntegralShopState> ctx) {
  UserService.getUserInfo().then((UserInfo userInfo) {
    ctx.dispatch(IntegralShopActionCreator.updateIntegral(
        userInfo.data.myIntegral.toInt()));
  });
}

void _gotoInvite(Action action, Context<IntegralShopState> ctx) {
  AppUtil.gotoPageByName(ctx.context, InvitePage.pageName, arguments: null);
}

void _init(Action action, Context<IntegralShopState> ctx) {
  TickerProvider tickerProvider = ctx.stfState as SingleTickerProviderStfState;
  TabController tabController =
      new TabController(initialIndex: 0, length: 2, vsync: tickerProvider);
  ctx.dispatch(IntegralShopActionCreator.onCreateController(tabController));
  UserService.getUserInfo().then((data) {
    ctx.dispatch(IntegralShopActionCreator.onAction());
  });

  ctx.dispatch(IntegralShopActionCreator.onUpdateIntegral());
}

void _gotoRecord(Action action, Context<IntegralShopState> ctx) {
  AppUtil.gotoPageByName(ctx.context, IntegralRecordPage.pageName,
      arguments: null);
}

void _gotoExchangeRecord(Action action, Context<IntegralShopState> ctx) {
  AppUtil.gotoPageByName(ctx.context, ExchangeRecordPage.pageName,
      arguments: null);
}
