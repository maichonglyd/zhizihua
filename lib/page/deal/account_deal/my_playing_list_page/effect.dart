import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_shop_list_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<PlayingListState> buildEffect() {
  return combineEffects(<Object, Effect<PlayingListState>>{
    PlayingListAction.action: _onAction,
    PlayingListAction.gotoShopList: _gotoShopList,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<PlayingListState> ctx) {}
void _init(Action action, Context<PlayingListState> ctx) {
  DealService.getPlayingGames().then((data) {
    if (data.code == 200) {
      ctx.dispatch(PlayingListActionCreator.playedGames(data.data.list));
    }
  });
}

void _gotoShopList(Action action, Context<PlayingListState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DealShopListPage.pageName,
      arguments: action.payload);
}
