import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/mine/mine_fragment/action.dart';
import 'package:flutter_huoshu_app/page/download/download_manage/page.dart';
import 'package:flutter_huoshu_app/page/gift/my_gift/page.dart';
import 'package:flutter_huoshu_app/page/mine/integral_shop/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'action.dart';
import 'state.dart';

Effect<MineTopTabState> buildEffect() {
  return combineEffects(<Object, Effect<MineTopTabState>>{
    MineTopTabAction.action: _onAction,
    MineTopTabAction.gotoMyGift: _gotoMyGift,
    MineTopTabAction.gotoIntegralShop: _gotoIntegralShop,
    MineTopTabAction.gotoRecharge: _gotoRecharge,
    MineTopTabAction.gotoDownload: _gotoDownload,
  });
}

void _onAction(Action action, Context<MineTopTabState> ctx) {}
void _gotoMyGift(Action action, Context<MineTopTabState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MyGiftPage.pageName, arguments: null);
}

void _gotoIntegralShop(Action action, Context<MineTopTabState> ctx) {
  AppUtil.gotoPageByName(ctx.context, IntegralShopPage.pageName,
      arguments: null);
}

void _gotoRecharge(Action action, Context<MineTopTabState> ctx) {
  AppUtil.gotoPageByName(ctx.context, MyWalletPage.pageName).then((result) {
    ctx.broadcast(MineFragmentActionCreator.getUserInfo());
  });
}

void _gotoDownload(Action action, Context<MineTopTabState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DownLoadManagePage.pageName,
      arguments: null);
}
