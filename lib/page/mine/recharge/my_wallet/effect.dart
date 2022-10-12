import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_expense_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_income_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_recharge/page.dart';
import 'action.dart';
import 'state.dart';

Effect<MyWalletState> buildEffect() {
  return combineEffects(<Object, Effect<MyWalletState>>{
    MyWalletAction.action: _onAction,
    MyWalletAction.gotoExpensePage: _gotoExpensePage,
    MyWalletAction.gotoIncomePage: _gotoIncomePage,
    MyWalletAction.gotoRecharge: _gotoRecharge,
    MyWalletAction.getUserInfo: _getUserInfo,
    Lifecycle.initState: _initState,
  });
}

void _onAction(Action action, Context<MyWalletState> ctx) {}
void _gotoExpensePage(Action action, Context<MyWalletState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PtbExpensePage.pageName, arguments: null);
}

void _gotoIncomePage(Action action, Context<MyWalletState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PtzIncomePage.pageName, arguments: null);
}

void _gotoRecharge(Action action, Context<MyWalletState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PtzRechargePage.pageName, arguments: null)
      .then((value) {
    ctx.dispatch(MyWalletActionCreator.getUserInfo());
  });
}

void _getUserInfo(Action action, Context<MyWalletState> ctx) {
  UserService.getUserInfo().then((UserInfo userInfo) {
    ctx.dispatch(MyWalletActionCreator.updateUserInfo(userInfo));
  });
}

void _initState(Action action, Context<MyWalletState> ctx) {
  print("MineFragmentState _initState");
  ctx.dispatch(MyWalletActionCreator.getUserInfo());
}
