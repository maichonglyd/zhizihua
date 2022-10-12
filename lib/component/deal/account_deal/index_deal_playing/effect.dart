import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_shop_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_playing_list_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<DealPlayingState> buildEffect() {
  return combineEffects(<Object, Effect<DealPlayingState>>{
    DealPlayingAction.action: _onAction,
    DealPlayingAction.gotoAllPlayingPage: _gotoAllPlayingPage,
    DealPlayingAction.gotoDealShopList: _gotoDealShopList,
  });
}

void _onAction(Action action, Context<DealPlayingState> ctx) {}

void _gotoAllPlayingPage(Action action, Context<DealPlayingState> ctx) {
  AppUtil.gotoPageByName(ctx.context, PlayingListPage.pageName);
}

void _gotoDealShopList(Action action, Context<DealPlayingState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DealShopListPage.pageName,
      arguments: action.payload);
}
